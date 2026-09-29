# Custom route constraints and endpoint matching

Knowledge ID: `aspnet-core.custom-route-constraints`

Topic: `aspnet-core`

## Core model

A route constraint participates in endpoint matching by deciding whether a route value satisfies a rule. A custom `IRouteConstraint` can represent a domain-specific matcher when built-in constraints such as `int`, `guid`, `alpha`, or `datetime` are insufficient.

```csharp
public sealed class EvenIntRouteConstraint : IRouteConstraint
{
    public bool Match(
        HttpContext? httpContext,
        IRouter? route,
        string routeKey,
        RouteValueDictionary values,
        RouteDirection routeDirection)
    {
        if (!values.TryGetValue(routeKey, out var raw) || raw is null)
            return false;

        if (raw is int number)
            return number % 2 == 0;

        return int.TryParse(raw.ToString(), out var parsed)
            && parsed % 2 == 0;
    }
}
```

Register the symbolic constraint name:

```csharp
builder.Services.Configure<RouteOptions>(options =>
{
    options.ConstraintMap["even"] = typeof(EvenIntRouteConstraint);
});
```

Use it in a route:

```csharp
app.MapGet("/numbers/{n:even}", (int n) => $"Even: {n}");
```

The routing workspace shows the equivalent dictionary `Add` form and a second inline-use example:

```csharp
services.Configure<RouteOptions>(opts =>
{
    opts.ConstraintMap.Add("even", typeof(EvenNumberConstraint));
});

app.MapGet("/nums/{id:even}", (int id) => $"even {id}");
```

When the constraint returns `false`, routing continues searching for another endpoint and otherwise produces 404.

## Matching boundary

A constraint is not input validation or authorization. If a value belongs to the selected endpoint but violates a business rule, match the endpoint and return an appropriate validation response instead.

Constraints should be deterministic, inexpensive, and free of database access or side effects. Prefer built-in constraints where possible.

When an identifier type is already known, express it in the route (`{clientId:guid}`, `{id:int}`). This narrows endpoint matching, avoids otherwise ambiguous candidates, and documents the path contract; it does not replace later business validation or authorization.

## What should be recallable

- What question does an `IRouteConstraint` answer?
- How is a custom symbolic name registered and used in a route template?
- What happens when `Match` returns `false`?
- Why is a route constraint not input validation or authorization?
- What operational properties should a matcher have?

## Sources

- Workspace: `_ai-conspects/routing-route-params-tech-info-custom-constraints-router-matching/`
- Authoritative processed source: `regions/RTR02-custom-irouteconstraint-v001.md`, S-005 and native labels T-002 through T-018
- Original SVG: `assets/raw/full.svg` (SHA-256 `ff42eda1c222260754fb8b0dceab59f3464458683626d4df14e2239e04ab5b18`; Git blob `817b5f15682925438fc9078ae4b309b37c07d579`)

- Workspace: `_ai-conspects/CUSTOM ROUTE CONSTRAINT/`
- Processed source: `regions/R01-final-coverage-transcript.md`, complete region
- Original SVG: `source/CUSTOM ROUTE CONSTRAINT.svg`
- Workspace: `_ai-conspects/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED/`
- Authoritative processed source: `01-final-transcript.md`, R01 and R03 (typed identifier constraints and route-design checklist)
- Original SVG: `source/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg`
