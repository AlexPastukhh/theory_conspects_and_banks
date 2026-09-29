# Explicit route order: overrides and the non-fallback boundary

Knowledge ID: `aspnet-core.explicit-route-order-overrides-and-non-fallback-boundary`

Topic: `aspnet-core`

## Explicit order resolves selection before execution

When two candidates otherwise overlap, explicit route order can select one before dispatch. Lower values have higher priority in the source examples.

The lifecycle boundary is crucial:

```text
candidate matching and ordering
-> one endpoint selected
-> authorization / filters / action or handler execution
-> response
```

Once execution-side behavior begins, returning 404, throwing, or failing authorization does not restart routing with the next order value. A lower-priority endpoint is not automatically a runtime fallback.

## Transitional legacy selection

The source presents two identical templates during a migration:

```csharp
// NEW behavior (preferred)
[HttpGet("search/{query}", Order = 1)]
public IActionResult NewSearch(string query) => NewLogic(query);

// OLD behavior (fallback / legacy)
[HttpGet("search/{query}", Order = 2)]
public IActionResult LegacySearch(string query) => OldLogic(query);
```

Both routes temporarily exist, but only the higher-priority new endpoint is selected for the shared template. The legacy route is later removed.

The word “fallback” here must mean a transitional lower-priority registration, not automatic retry after `NewSearch` starts or fails. If callers must still reach old behavior, there must be a distinct selection condition or explicit dispatch policy.

## Overriding a framework-generated route

Explicit order is also useful when a framework or library generates an overlapping route that application code cannot redesign:

```csharp
// Application override
[HttpGet("search/{term}", Order = 1)]
public IActionResult Override(string term) => Ok("override");

// Library route (lower priority)
[HttpGet("search/{term}", Order = 100)]
public IActionResult LibraryRoute(string term) => Ok("library");
```

The lower order value lets the application endpoint win the ambiguity during matching. This is a narrow integration override, matching the source's recommendation to reserve `Order` for exceptional cases.

## Why handler-level feature checks are not fallback routing

The source card proposes:

```csharp
[HttpGet("search/{term}", Order = 1)]
public IActionResult FeatureSearch(string term)
{
    if (!FeatureEnabled())
        return NotFound();

    return FeatureLogic(term);
}

[HttpGet("search/{term}", Order = 2)]
public IActionResult DefaultSearch(string term)
{
    return DefaultLogic(term);
}
```

Its claim that `DefaultSearch` is a guaranteed fallback is incorrect as written. `FeatureSearch` wins selection before `FeatureEnabled()` runs. Returning `NotFound()` ends that selected execution path; routing does not retry `DefaultSearch`.

Conditional endpoint choice must participate before final endpoint selection through an appropriate matching policy, or one selected endpoint must explicitly dispatch between feature and default behavior. That correction is about lifecycle placement, not merely changing order numbers.

## Why authorization failure is not public-route fallback

The source also proposes identical templates with different authorization metadata:

```csharp
[Authorize(Roles = "Admin")]
[HttpGet("search/{term}", Order = 1)]
public IActionResult AdminSearch(string term) => Ok("admin");

[HttpGet("search/{term}", Order = 2)]
public IActionResult PublicSearch(string term) => Ok("public");
```

The first endpoint wins routing. Authorization then evaluates the already selected endpoint. A challenge or rejection does not cause the router to select `PublicSearch`.

Consequently, the public endpoint is not an authorization fallback for the same request path in this design. Public/admin behavior needs distinct route-selection conditions or one endpoint whose authorization and dispatch semantics are explicit.

## Decision rules

Use explicit order only when:

- overlapping candidates must coexist temporarily during a controlled migration;
- an application must override an otherwise unmodifiable framework/library endpoint;
- selection genuinely cannot be made unambiguous with semantic route shapes or constraints.

Do not use explicit order to simulate:

- feature fallback after a handler has begun;
- authorization fallback after a selected endpoint is rejected;
- exception or 404 retry into another endpoint;
- ordinary API distinctions that belong in the route template.

## What should be recallable

- At what lifecycle stage does explicit route order act?
- How does the legacy/new identical-template example select a winner, and what does “fallback” not mean there?
- Why is framework-generated-route override a valid narrow use?
- Why does returning 404 from the feature endpoint not invoke the default endpoint?
- Why does authorization failure on the admin endpoint not reroute to the public endpoint?
- Which design alternatives should be preferred before explicit order?

## Related knowledge

- `aspnet-core.endpoint-matching-phases-and-route-precedence`
- `aspnet-core.custom-route-constraints`
- `aspnet-core.authorization-middleware-policy-evaluator-and-result-handler`

## Sources

- Workspace: `_ai-conspects/routing-route-params-tech-info-custom-constraints-router-matching/`
- Authoritative processed source: `regions/RTR03-matching-precedence-order-and-overlaps-v001.md`, S-015 through S-018
- Authoritative technical correction: `02-technical-corrections-routing-order-and-fallback-v001.md`, C-003 through C-005
- Original SVG: `assets/raw/full.svg` (SHA-256 `ff42eda1c222260754fb8b0dceab59f3464458683626d4df14e2239e04ab5b18`; Git blob `817b5f15682925438fc9078ae4b309b37c07d579`)
