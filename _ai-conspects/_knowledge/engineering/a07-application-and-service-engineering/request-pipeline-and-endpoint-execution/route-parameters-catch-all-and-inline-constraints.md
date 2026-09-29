# Route parameters, catch-all paths, and inline constraints

Knowledge ID: `aspnet-core.route-parameters-catch-all-and-inline-constraints`

Topic: `aspnet-core`

## Required parameters

A required parameter such as `{id}` matches one URL segment and binds that segment to a route value. If the segment is absent, the route does not match; if no other endpoint matches, the result is 404.

```csharp
app.MapGet("/products/{id}", (int id) => $"Product {id}");
```

The source contrasts:

```text
/products/5  -> matches, id = 5
/products    -> does not match
```

## Optional parameters

A trailing `?` makes a route segment optional. When it is absent, the handler observes the CLR default for the parameter shape. The source uses a nullable integer and then supplies an application default:

```csharp
app.MapGet("/items/{page?}", (int? page) => page ?? 1);
```

```text
/items    -> page = null, returns 1
/items/2  -> page = 2
```

This lets related URL forms such as `/articles` and `/articles/3` share one route.

## Catch-all parameters

A catch-all such as `{*slug}` captures the remaining path, including embedded slashes, into one value. It must be the final segment in the route template.

```csharp
app.MapGet("/blog/{*slug}", (string slug) => $"slug: '{slug}'");
```

The source gives both an empty and a multi-segment capture:

```text
/blog                  -> slug == ""
/blog/2025/02/my-post  -> slug == "2025/02/my-post"
```

If an empty capture should not be accepted, the source says to add a constraint or handle the empty case in code.

## Inline constraints narrow candidates

A route constraint restricts which values a parameter can match. Failure means that candidate is treated as not matching, so routing can continue with other candidates.

Multiple constraints are chained in one parameter:

```text
{param:constraint1:constraint2}
```

For example:

```csharp
app.MapGet("/orders/{id:int:min(1)}", (int id) => $"order {id}");
```

This route accepts integers greater than or equal to `1`. The source motivates constraints as a way to reduce false matches, disambiguate routes, and filter candidates before action execution.

## Selection guide

```text
exactly one segment required       -> {id}
one segment may be absent          -> {page?}
remaining path, including slashes  -> {*slug}
candidate value must have a shape  -> {id:int:min(1)}
```

Custom domain-specific matching belongs to a registered `IRouteConstraint`, not an ever-growing inline template.

## What should be recallable

- What match failure follows from a missing required segment?
- What value shape does an absent optional segment produce in the source example?
- What does a catch-all capture, where must it appear, and how can it capture zero segments?
- How are inline constraints chained, and what happens when one fails?
- What does `{id:int:min(1)}` accept?

## Related knowledge

- `aspnet-core.custom-route-constraints`
- `aspnet-core.endpoint-matching-phases-and-route-precedence`

## Sources

- Workspace: `_ai-conspects/routing-route-params-tech-info-custom-constraints-router-matching/`
- Authoritative processed source: `regions/RTR01-route-parameters-and-built-in-constraints-v001.md`, S-001 through S-004
- Original SVG: `assets/raw/full.svg` (SHA-256 `ff42eda1c222260754fb8b0dceab59f3464458683626d4df14e2239e04ab5b18`; Git blob `817b5f15682925438fc9078ae4b309b37c07d579`)
