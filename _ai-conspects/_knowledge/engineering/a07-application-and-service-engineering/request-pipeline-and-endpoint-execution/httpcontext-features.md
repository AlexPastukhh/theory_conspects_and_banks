# HttpContext.Features and typed capability contracts

Knowledge ID: `aspnet-core.httpcontext-features`

Topic: `aspnet-core`

## Core model

`HttpContext.Features` is a per-request `IFeatureCollection`: a typed collection of interfaces that represent capabilities and shared infrastructure data for the current request.

Features may be populated by the server, framework, or middleware and read or replaced by later components. They let components cooperate without hard-coding concrete implementations.

```csharp
var feature = context.Features.Get<IMyFeature>();

context.Features.Set<IMyFeature>(
    new MyFeature { CorrelationId = "abc123" });
```

`Get<T>()` retrieves a feature through its interface contract; `Set<T>()` publishes or replaces the implementation for that contract.

## Custom typed feature

```csharp
public interface IRequestAuditFeature
{
    string CorrelationId { get; }
    DateTime StartedUtc { get; }
}

public sealed class RequestAuditFeature : IRequestAuditFeature
{
    public string CorrelationId { get; init; } = "";
    public DateTime StartedUtc { get; init; }
}
```

A typed feature is useful when several middleware or endpoint components depend on a reusable contract rather than a magic key convention.

## Framework and server capabilities

Features can represent routing and selected endpoints, request/response body capabilities, connection information, TLS or client certificates, WebSockets, and protocol-specific capabilities.

`context.GetEndpoint()` is a higher-level convenience API over routing-populated features. It becomes useful after routing for endpoint-aware logging, policies, or metric labels.

Most application code should prefer higher-level `HttpContext` APIs such as `Request`, `Response`, `Connection`, and `GetEndpoint()` over direct access to low-level transport features.

## Items boundary

Use `Features` for a typed infrastructure capability or middleware/framework contract. Use `Items` when application-specific request data only needs simple key/value storage.

## What should be recallable

- What is `IFeatureCollection`, and who populates it?
- How do `Features.Get<T>()` and `Features.Set<T>()` express a typed contract?
- When is a custom feature preferable to `HttpContext.Items`?
- What categories of routing, server, or transport capability can features expose?
- Why does ordinary application code often use higher-level `HttpContext` APIs instead?

## Related knowledge

- `aspnet-core.httpcontext-items` — application-level request scratch data.
- `aspnet-core.exception-handler-features` — framework-published exception information.

## Sources

- Workspace: `_ai-conspects/httpcontext items and features/`
- Processed source: `FINAL_TRANSCRIPT.md`, S-005–S-007, S-011–S-012, S-016–S-017, S-020–S-021, S-023, and S-025–S-026
- Original SVG: `source/httpcontext items and features.svg`
