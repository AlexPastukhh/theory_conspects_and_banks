# MVC action constraints: selection and validation boundary

Knowledge ID: `aspnet-core.mvc-action-constraints-selection-and-validation-boundary`

Topic: `aspnet-core`

An MVC `IActionConstraint` answers one narrow question while MVC selects among action candidates:

```text
Does this action remain a candidate for this request?
```

Returning `false` removes the candidate. It does not naturally create a detailed `400` response, and if no candidate remains the result is an action-selection failure. Use a filter, middleware, or selected endpoint when malformed client input must produce an explicit validation contract.

## Separate developer configuration from request data

Attribute constants are developer input. Validate them when the attribute/factory is constructed or discovered:

- reject blank header, query, or route keys;
- reject invalid configured media types with a clear argument error;
- parse immutable constants once and retain immutable/thread-safe state.

Request headers, query values, and route values are client input. Matching must be non-throwing: use `TryParse`, compare safely, and return `false` for malformed or nonmatching data. Never let malformed client input crash action selection.

Constraints run on the selection path, so keep them deterministic and inexpensive. Avoid I/O, database access, request-body parsing, side effects, and mutable shared request state.

## Factory and reuse model

An attribute can implement `IActionConstraintFactory` and create a runtime constraint containing the normalized settings:

```csharp
[AttributeUsage(AttributeTargets.Method,
    AllowMultiple = true, Inherited = true)]
public sealed class RequestMatchesAttribute
    : Attribute, IActionConstraintFactory
{
    public int Order { get; set; }
    public bool IsReusable => true;

    public IActionConstraint CreateInstance(IServiceProvider services)
        => new RequestMatchesConstraint(/* immutable settings */);
}
```

`IsReusable = true` is appropriate only when both the factory configuration and runtime constraint are immutable and thread-safe. A constraint that owns scoped dependencies or request-specific mutable state must not make that promise.

## Compose method, route, query, and header rules

A generalized matcher can evaluate configured rules in a predictable order:

```text
HTTP method
-> route key/value
-> query-key presence or exact value
-> header media type
-> accept only if every configured rule passes
```

For a media-type header rule:

1. require the configured header;
2. parse it with `MediaTypeHeaderValue.TryParse`;
3. extract the concrete media type;
4. compare it case-insensitively with the configured concrete types;
5. return `false`, not an exception, for malformed client syntax.

This mechanism is useful for specialized candidate selection. For ordinary request `Content-Type` selection, prefer the built-in `[Consumes]` constraint; it also keeps API metadata aligned with framework behavior. Remember that `[Consumes]` only constrains action eligibility—a compatible input formatter is still required to deserialize the body.

## Keep the attribute API understandable

One attribute with several similar string-heavy constructor overloads quickly becomes ambiguous. Purpose-specific attributes such as `RequireQuery`, `RequireRouteValue`, or `RequireRequestMediaType` often communicate intent better while sharing an internal constraint implementation.

## What should be recallable

- What does returning `false` from an action constraint mean?
- Why is candidate selection not the same as returning a detailed validation response?
- Which configuration errors should fail fast, and which request errors should return `false`?
- Why should action constraints avoid I/O and body parsing?
- When is `IsReusable = true` safe?
- How can method, route, query, and header rules be composed deterministically?
- Why should ordinary Content-Type selection use `[Consumes]`?
- When are purpose-specific attributes clearer than overloaded constructors?

## Related knowledge

- `aspnet-core.media-type-formatters-and-406-415`
- `aspnet-core.custom-route-constraints`
- `aspnet-core.mvc-filter-activation-di-and-factories`

## Sources

- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, sections 9-10
- Exact native text: `11-exact-canvas-text-transcript-v002.md`, R07-R08
- Screenshot evidence: `12-screenshot-evidence-cards-v002.md`, R07-R08 cards
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
