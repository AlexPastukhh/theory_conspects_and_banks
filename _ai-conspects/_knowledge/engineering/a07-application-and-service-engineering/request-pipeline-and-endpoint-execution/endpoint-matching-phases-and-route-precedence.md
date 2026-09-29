# Endpoint matching phases and route precedence

Knowledge ID: `aspnet-core.endpoint-matching-phases-and-route-precedence`

Topic: `aspnet-core`

## Matching is candidate filtering before dispatch

An incoming request is evaluated against the application's endpoint collection before any controller action or Minimal API handler executes. The source describes that collection as including controller actions, Minimal API delegates, static-file endpoints, and other registered endpoints.

The source's plain-language sequence and the technical correction combine into this lifecycle:

1. Compare the request path with route templates and collect matching shapes.
2. Remove candidates whose route constraints fail.
3. Apply matcher policies, including HTTP-method policy.
4. Use the endpoint selector to choose the highest-priority remaining endpoint.
5. Dispatch only the selected endpoint; model binding, filters, and handler/action logic occur afterward.

If no candidate survives matching, the request reaches a 404 outcome or another applicable middleware path.

The screenshots illustrate template and constraint filtering with patterns such as:

```text
/api/products/{id}
/blog/{*slug}
/{id:int}
minlength(3)
regex
```

A failed constraint is a non-match, not execution of that endpoint with an error.

## Priority is explicit order plus template precedence

Endpoint routing does not sequentially probe arbitrary registrations until one succeeds. Candidates are prioritized by route endpoint `Order` and then route-template precedence. If the best remaining candidates still have equal priority, the match is ambiguous.

Template precedence normally handles common cases. A literal segment is more specific than a parameter segment:

```csharp
app.MapGet("/search/popular", () => "popular");
app.MapGet("/search/{term}", term => $"search {term}");
```

`/search/popular` selects the literal route even if registration order is reversed. Route specificity—not registration order—explains the result.

The source also shows the equivalent controller example:

```csharp
[HttpGet("search/{term}", Order = 2)]
public IActionResult General(string term) => Ok($"General: {term}");

[HttpGet("search/popular", Order = 1)]
public IActionResult Popular() => Ok("Popular");
```

The observed outcomes are correct:

```text
/search/popular        -> Popular
/search/anything-else  -> General
```

However, explicit order is redundant in this example because literal precedence already separates the candidates. The example must not be used as proof that `Order` is necessary.

## Declaration and registration order boundaries

The order of action-method declarations inside a controller class does not decide endpoint selection. Likewise, Minimal API registration order must not be used as a general “general endpoint goes last” guarantee.

The source's own correction is:

```text
do not rely on registration order
literal/specific route wins through precedence
```

Official routing documentation also states that endpoint matching has no general processing-order guarantee. Conventional controller route mapping has a documented order-assignment exception, but that is not an arbitrary-registration tiebreak contract for endpoint routing.

## Prefer unambiguous route design

When endpoint meanings differ, express that distinction in route shape:

```text
/search/by-id/{id:int}
/search/by-name/{name}
```

Or make candidate sets disjoint with constraints:

```text
/search/{id:int}
/search/{name:alpha}
```

These designs remove ambiguity and usually remove the need for explicit order. The source reserves `Order` for rare, edge, transitional, or framework-integration cases rather than ordinary API design.

## What should be recallable

- What stages narrow candidates before an endpoint executes?
- When do model binding, filters, and action/handler logic occur relative to selection?
- How do `Order` and template precedence prioritize matching endpoints?
- Why does `/search/popular` beat `/search/{term}` regardless of registration order?
- Why are action declaration order and arbitrary Minimal API registration order unsafe contracts?
- What route-design alternatives normally eliminate explicit order?

## Related knowledge

- `aspnet-core.route-parameters-catch-all-and-inline-constraints`
- `aspnet-core.custom-route-constraints`
- `aspnet-core.explicit-route-order-overrides-and-non-fallback-boundary`

## Sources

- Workspace: `_ai-conspects/routing-route-params-tech-info-custom-constraints-router-matching/`
- Authoritative processed source: `regions/RTR03-matching-precedence-order-and-overlaps-v001.md`, S-006 through S-014 and native labels T-001, T-019 through T-023
- Authoritative technical correction: `02-technical-corrections-routing-order-and-fallback-v001.md`, C-001 and C-002
- Original SVG: `assets/raw/full.svg` (SHA-256 `ff42eda1c222260754fb8b0dceab59f3464458683626d4df14e2239e04ab5b18`; Git blob `817b5f15682925438fc9078ae4b309b37c07d579`)
