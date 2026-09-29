# HttpContext.Items and collision-safe request data

Knowledge ID: `aspnet-core.httpcontext-items`

Topic: `aspnet-core`

## Core model

`HttpContext.Items` is an `IDictionary<object, object?>` used as an application-level scratchpad for the current request. Middleware, endpoints, and controllers handling that request can exchange simple application data through it.

Typical values include a correlation ID, resolved tenant, loaded entity, request flag, timing value, or enriched user profile. The data is request-specific and does not require a formal capability contract.

```csharp
ctx.Items[HttpContextItemKeys.CorrelationId] = "abc";

var correlationId =
    ctx.Items[HttpContextItemKeys.CorrelationId]?.ToString();
```

## Collision-safe keys

String keys compare by value. Two unrelated components using a key such as `"CorrelationId"` can overwrite or read each other's value.

Use a shared static object when key identity must be collision-safe:

```csharp
public static class HttpContextItemKeys
{
    public static readonly object CorrelationId = new();
}
```

An object key compares by reference identity. Other code cannot recreate the same key accidentally; consumers must reference the exact shared field.

## Middleware-to-endpoint flow

Middleware can calculate a value once and make it available to later components:

```csharp
app.Use(async (ctx, next) =>
{
    var startedAt = DateTime.UtcNow;
    ctx.Items["RequestStartedAtUtc"] = startedAt;

    await next();

    var elapsed = DateTime.UtcNow - startedAt;
    ctx.Response.Headers["X-Elapsed-Ms"] =
        ((int)elapsed.TotalMilliseconds).ToString();
});
```

Use `Items` when simple request-scoped key/value storage is enough. Prefer a feature when multiple components should share a stable typed interface representing a capability or infrastructure contract.

## What should be recallable

- What is the declared shape and request-level purpose of `HttpContext.Items`?
- Why can string keys collide across middleware or libraries?
- Why is a shared static `new object()` key collision-safe?
- Which application-data examples fit `Items`?
- When should a typed feature be preferred instead?

## Related knowledge

- `aspnet-core.httpcontext-features` — typed request capabilities and extensibility contracts.

## Sources

- Workspace: `_ai-conspects/httpcontext items and features/`
- Processed source: `FINAL_TRANSCRIPT.md`, S-001–S-003, S-008–S-009, S-014, S-016, S-019, S-022, S-024, and S-027
- Original SVG: `source/httpcontext items and features.svg`
