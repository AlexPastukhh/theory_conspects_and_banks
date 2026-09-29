# Middleware ordering, short-circuiting, and JSON responses

Knowledge ID: `aspnet-core.middleware-ordering-short-circuit-and-json`

Topic: `aspnet-core`

Middleware is an ordered `HttpContext` pipeline. Code before `await next(context)` runs on the inbound path; code after it runs as downstream work unwinds. Omitting `next` intentionally short-circuits the remaining pipeline.

The component can be written inline with `app.Use`, as a reusable conventional class exposing `Invoke`/`InvokeAsync`, or behind an extension method that hides registration details without changing its position in the pipeline.

```csharp
public sealed class RequestTimingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<RequestTimingMiddleware> _logger;

    public RequestTimingMiddleware(
        RequestDelegate next,
        ILogger<RequestTimingMiddleware> logger)
        => (_next, _logger) = (next, logger);

    public async Task InvokeAsync(HttpContext context)
    {
        var stopwatch = Stopwatch.StartNew();
        await _next(context);
        stopwatch.Stop();

        if (!context.Response.HasStarted)
            context.Response.Headers["X-Elapsed-ms"] =
                stopwatch.ElapsedMilliseconds.ToString();

        _logger.LogInformation("Elapsed: {ElapsedMs} ms", stopwatch.ElapsedMilliseconds);
    }
}
```

Post-next status/header changes are only safe while the response has not started. A downstream endpoint may already have committed headers, so timing headers should be planned around that boundary rather than appended blindly afterward.

## Lifetime and registration

Conventional middleware is normally constructed once. Constructor injection therefore fits singleton-safe dependencies, not per-request scoped services. Resolve scoped dependencies as `InvokeAsync` parameters, through `HttpContext.RequestServices`, or use the `IMiddleware`/factory model when per-request construction is required. Registration extension methods can keep startup readable without changing runtime order.

Exception handling must be early enough to wrap the components whose failures it owns. Routing-aware middleware reads endpoint metadata only after routing. Middleware is lower-level than MVC filters and works directly with `HttpContext`.

## Terminal JSON response

`WriteAsJsonAsync` writes JSON outside controllers, for example from a maintenance, authorization, validation, rate-limit, fallback, or error path:

```csharp
if (maintenanceMode)
{
    context.Response.StatusCode = StatusCodes.Status503ServiceUnavailable;
    await context.Response.WriteAsJsonAsync(new
    {
        error = "Service is temporarily unavailable"
    }, context.RequestAborted);
    return;
}

await _next(context);
```

Set status and headers before writing. Use a deliberate response DTO/problem shape rather than leaking a domain object. Do not write twice: after a body has started, later middleware generally cannot replace it with a clean JSON error.

A branch selects a nested pipeline and may still invoke that branch's next component. A terminal short-circuit writes/owns the response and returns. Keep asynchronous work awaited, avoid `.Result`/`.Wait()`, propagate cancellation, log around `next` when diagnosing order, and extract complex business logic into services.

## What should be recallable

- Pre-next/post-next flow and registration-order effects.
- Conventional-middleware scoped-service lifetime trap.
- Branching versus terminal short-circuiting.
- Status/headers before `WriteAsJsonAsync` and the response-started boundary.
- Exception placement and async/debugging rules.

## Sources

- Workspace: `_ai-conspects/middleware-writeasjson/`
- Authoritative processed source: `regions/R01R02R03-middleware-writeasjson-final.md`, R01-R03
- Original SVG: `source/middleware-writeasjson.svg`
- Workspace: `_ai-conspects/filters/`
- Authoritative processed source: `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-121-S-126, S-128-S-131
- Original SVG: `source/filters.svg`
