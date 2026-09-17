# ASP.NET Core rate-limiter policies and endpoint middleware

Knowledge ID: `aspnet-core.rate-limiter-policies-and-endpoint-middleware`

Topic: `aspnet-core`

Register policies with `AddRateLimiter` and place `UseRateLimiter` after routing and before mapped endpoints when endpoint metadata selects policies. `RequireRateLimiting`/`EnableRateLimiting` can apply a named policy at route, controller, or action scope; `DisableRateLimiting` exempts an endpoint. A rejection callback without a global or endpoint policy enforces nothing.

Algorithms answer different questions:

- fixed window caps requests in a time bucket and can burst at boundaries;
- token bucket refills permits gradually and supports bounded bursts;
- concurrency limiting caps simultaneous in-flight work and releases permits on completion, but by itself does not stop a client from submitting a large queued volume;
- chained limiters require the request to pass every component.

Global and endpoint-specific policies may coexist. Partition keys determine which callers share state, so normalize trusted identifiers and bound cardinality. The partition callback is synchronous and should use cheap request metadata. Do not perform Redis/network I/O there; it undermines the limiter fast path. Reading/parsing the body there introduces buffering/lifecycle problems and is also the wrong place for authentication-sensitive failure counting.

```csharp
builder.Services.AddRateLimiter(options =>
{
    options.AddFixedWindowLimiter("login", limiter =>
    {
        limiter.PermitLimit = 10;
        limiter.Window = TimeSpan.FromMinutes(1);
    });
    options.OnRejected = async (context, token) =>
    {
        context.HttpContext.Response.StatusCode = StatusCodes.Status429TooManyRequests;
        await context.HttpContext.Response.WriteAsync("Too many requests", token);
    };
});

app.UseRouting();
app.UseRateLimiter();
app.MapPost("/login", Login).RequireRateLimiting("login");
```

Built-in limiter state is process-local. With several application instances, effective aggregate capacity grows unless a shared upstream/distributed layer coordinates it.

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R02, R03 and R08
- Original SVG: `source/source-complete-v002.svg`
