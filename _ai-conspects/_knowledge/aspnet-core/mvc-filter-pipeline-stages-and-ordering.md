# MVC filter pipeline stages and ordering

Knowledge ID: `aspnet-core.mvc-filter-pipeline-stages-and-ordering`

Topic: `aspnet-core`

MVC filters run inside a selected MVC endpoint, after the broader middleware and routing pipeline. Their stages expose progressively richer framework state:

```text
middleware inbound
routing / endpoint selection
MVC endpoint:
    authorization filters
    resource filters (before)
    model binding and validation
    action filters (before)
    action method
    action filters (after)
    exception filters for eligible failures
    result filters (before)
    result execution / formatters / serialization
    result filters (after)
    resource filters (after)
middleware unwind
```

Non-MVC requests do not run global MVC filters. Endpoint filters are the related around-delegate mechanism for Minimal APIs, not another MVC action-filter stage.

## Stage responsibilities

- Authorization filters run first and can challenge, forbid, return unauthorized, or otherwise short-circuit. They have `AuthorizationFilterContext` with `HttpContext`, `ActionDescriptor`, and `RouteData`, but no bound action arguments. Ordinary denial should set a result rather than throw.
- Resource filters surround model binding, action execution, and result execution. Their before path is the earliest MVC point that can prevent model binding.
- Action filters run after binding and surround the action. They can inspect `ActionArguments`, `ModelState`, the controller, result, and exception state.
- Exception filters translate eligible action/result-stage exceptions. They do not catch arbitrary middleware, routing, or authorization-filter failures.
- Result filters surround execution of the `IActionResult`, including formatting, serialization, and response writing.

A representative authorization filter short-circuits explicitly:

```csharp
public sealed class RequireAdminFilter : IAsyncAuthorizationFilter
{
    public Task OnAuthorizationAsync(AuthorizationFilterContext context)
    {
        var user = context.HttpContext.User;

        if (!user.Identity?.IsAuthenticated ?? true)
            context.Result = new UnauthorizedResult();
        else if (!user.IsInRole("Admin"))
            context.Result = new ForbidResult();

        return Task.CompletedTask;
    }
}
```

## Sync, async, and around-delegate flow

Synchronous interfaces expose paired before/after callbacks such as `IActionFilter.OnActionExecuting` and `OnActionExecuted`. Use them only for synchronous work; do not block an asynchronous operation with `.Result` or `.Wait()` inside the filter.

Async interfaces expose an around delegate:

```csharp
public async Task OnActionExecutionAsync(
    ActionExecutingContext context,
    ActionExecutionDelegate next)
{
    // before the action
    var executed = await next();
    // after the action; inspect executed.Result / executed.Exception
}
```

Not calling `next()` short-circuits the wrapped remainder. Code after `await next()` runs while the pipeline unwinds.

## Ordering is stage, scope, and order

Filter order is not one flat number:

1. the filter stage fixes the broad position;
2. scope nests global, controller, then action filters on the inbound path;
3. within the relevant stage/scope, lower `Order` values run earlier.

Before callbacks run outer-to-inner; after callbacks unwind inner-to-outer. Thus filters with orders `-10`, `0`, and `10` enter in that order and exit in reverse order. Unspecified order is normally the default value `0`.

`IOrderedFilter` supplies a class-level order:

```csharp
public sealed class TimingFilter : IActionFilter, IOrderedFilter
{
    public int Order { get; set; } = -10;
    public void OnActionExecuting(ActionExecutingContext context) { }
    public void OnActionExecuted(ActionExecutedContext context) { }
}
```

`TypeFilterAttribute` and `ServiceFilterAttribute` also expose `Order`. Prefer the wrapper's order when each application needs a different position; implement `IOrderedFilter` when the type needs a stable default or is registered without an ordering wrapper.

## Endpoint filters

An endpoint filter surrounds a supported endpoint delegate and can inspect `HttpContext`, arguments, and endpoint metadata, short-circuit, or transform the returned value:

```csharp
public sealed class LogEndpointFilter : IEndpointFilter
{
    public async ValueTask<object?> InvokeAsync(
        EndpointFilterInvocationContext context,
        EndpointFilterDelegate next)
    {
        var name = context.HttpContext.GetEndpoint()?.DisplayName;
        Console.WriteLine($"before endpoint {name}");
        var result = await next(context);
        Console.WriteLine($"after endpoint {name}");
        return result;
    }
}

app.MapGet("/hi", () => "hello")
   .AddEndpointFilter<LogEndpointFilter>();
```

## What should be recallable

- Where every MVC filter stage sits and which state it can see.
- Why authorization denial should be a result rather than an exception.
- How synchronous callbacks differ from an async around delegate.
- How stage, scope, and `Order` combine, including reverse unwind.
- Why endpoint filters belong to Minimal API execution rather than the MVC action-filter pipeline.

## Related knowledge

- `aspnet-core.mvc-resource-action-and-result-filter-mechanics`
- `aspnet-core.mvc-filter-activation-di-and-factories`
- `aspnet-core.mvc-exception-filters-and-error-results`

## Sources

- Workspace: `_ai-conspects/filters/`
- Authoritative processed sources: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-005, S-007, S-010-S-012, S-015, S-017, S-019, S-026, S-027, S-034, S-037, S-041-S-043; `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-094-S-095, S-116-S-120, S-131; and matching native code in `NATIVE_CANVAS_TEXT.md`
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 1-4
- Original SVG: `source/filters.svg`
