# MVC filters versus middleware: selection and lifetimes

Knowledge ID: `aspnet-core.mvc-filters-vs-middleware-selection-and-lifetimes`

Topic: `aspnet-core`

Middleware wraps the broad HTTP request pipeline. MVC filters run later, only for MVC/filter-aware endpoint execution, but expose stage-specific framework context. Choose the earliest layer that both covers the required requests and owns the required information.

| Need | Better boundary |
|---|---|
| Static files, health checks, pre-routing policy, CORS, compression, global logging, correlation, rate limiting, catch-all errors | middleware |
| All MVC actions plus action/controller metadata or scoped MVC services | global MVC filter |
| Selected controller/actions with DI | `TypeFilter`, `ServiceFilter`, or factory attribute |
| Bound arguments or `ModelState` | action filter |
| Skip expensive model binding | resource filter |
| Transform an `IActionResult` before writing | result filter |
| Known controller exception mapping | exception filter plus global middleware safety net |
| Minimal API argument/result policy | endpoint filter |

## Context and coverage

Middleware sees `HttpContext` and runs for every applicable request through its position. Filters additionally see action descriptors, controller instances, route/action metadata, `ActionArguments`, `ModelState`, and MVC results according to their stage. This is why global filters remain useful even when global middleware already exists.

Middleware can emulate per-action policy by inspecting endpoint metadata, but then it must recreate the classification and result policy manually. Before routing, `HttpContext.GetEndpoint()` is null; placement after routing is required when metadata drives the decision.

Filters do not run for unmatched routes, static files, or other non-MVC responses. Conversely, middleware does not naturally possess true MVC `ActionContext`, bound arguments, or validation state, and does not directly return a `ViewResult` through MVC.

## DI lifetime boundary

Conventional middleware is normally created when the pipeline is built. Constructor injection should therefore be limited to singleton-safe dependencies. Resolve scoped work per request through `Invoke`/`InvokeAsync` parameters or `HttpContext.RequestServices`:

```csharp
public sealed class MyMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<MyMiddleware> _log;

    public MyMiddleware(RequestDelegate next, ILogger<MyMiddleware> log)
        => (_next, _log) = (next, log);

    public async Task InvokeAsync(
        HttpContext context,
        IMyScopedService scoped)
    {
        await scoped.DoWorkAsync();
        await _next(context);
    }
}
```

Capturing a scoped service in a conventional middleware constructor can make it outlive the request scope. When a genuinely separate lifetime is required, resolve `IServiceScopeFactory`, create a scope, use services only while it is alive, and dispose the scope. Do not create an extra scope merely to access the request's existing scoped service.

The current request provider is also available directly:

```csharp
var scoped = context.RequestServices
    .GetRequiredService<IMyScopedService>();
```

For deliberately separate work:

```csharp
using var scope = context.RequestServices
    .GetRequiredService<IServiceScopeFactory>()
    .CreateScope();

var service = scope.ServiceProvider
    .GetRequiredService<ISomething>();
```

DI-created filters can safely receive scoped constructor dependencies because MVC resolves them within the request/filter activation boundary.

## Ordering models differ

Middleware ordering is registration order: inbound calls go forward through `next`, then unwind in reverse. Filter ordering combines fixed stage, application scope (global/controller/action), and `Order`/`IOrderedFilter`. “Runs before” is incomplete unless the relevant pipeline and nesting level are named.

## Practical selection examples

- IP blocking before routing, maintenance-mode short-circuiting, global URL logs, CORS, and compression belong in middleware.
- Wrapping controller return values, inspecting/modifying action arguments, MVC `ProblemDetails` based on action metadata, model-aware caching, and per-action auditing belong in filters.
- Cache before JSON binding uses a resource filter; validate the bound DTO with an action filter.
- Catch failures from every downstream component with exception middleware; map one controller's domain failure with an exception filter.

## What should be recallable

- The coverage/context tradeoff between middleware and filters.
- A decision rule for global filters, selected filter attributes, and endpoint filters.
- Why conventional middleware must not constructor-capture scoped services.
- When request services versus a newly created service scope is appropriate.
- When endpoint metadata is available to middleware.
- How middleware order differs from filter stage/scope/order.

## Related knowledge

- `aspnet-core.middleware-ordering-short-circuit-and-json`
- `aspnet-core.di-scope-lifetime-and-disposal`
- `aspnet-core.mvc-filter-pipeline-stages-and-ordering`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

## Sources

- Workspace: `_ai-conspects/filters/`
- Authoritative processed sources: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-008, S-016-S-017, S-021-S-023, S-028-S-033, S-035-S-036, S-038, S-045, S-052-S-060, S-064, S-069-S-071, S-075, S-077, S-080, S-082-S-083, S-085, S-090-S-092; `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-113, S-119, S-121-S-131
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 1 and 5-10
- Original SVG: `source/filters.svg`
