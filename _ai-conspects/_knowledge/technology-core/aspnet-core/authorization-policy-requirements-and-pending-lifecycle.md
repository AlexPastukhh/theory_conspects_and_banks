# Authorization policy requirements and the PendingRequirements lifecycle

Knowledge ID: `aspnet-core.authorization-policy-requirements-and-pending-lifecycle`

Topic: `aspnet-core`

ASP.NET Core authorization is a policy engine: authentication establishes the user and claims, then authorization evaluates requirements. A policy succeeds only when every requirement succeeds. If one requirement is left pending, the final result is still failure.

```csharp
builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("CanDeleteOrder", policy =>
    {
        policy.RequireAuthenticatedUser();
        policy.RequireRole("Admin");
        policy.AddRequirements(new PermissionRequirement("Orders.Delete"));
    });
});
```

The policy contributes multiple requirements. They are combined with AND semantics: an authenticated user is not enough, the role must be present, and the custom permission must be satisfied too. A single requirement can be satisfied by more than one handler and is therefore an OR-style alternative within that requirement.

```csharp
public sealed class PermissionRequirement : IAuthorizationRequirement { }

public sealed class PermissionHandler : AuthorizationHandler<PermissionRequirement>
{
    protected override Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        PermissionRequirement requirement)
    {
        if (context.User.HasClaim("permission", "Orders.Delete"))
        {
            context.Succeed(requirement);
        }

        return Task.CompletedTask;
    }
}
```

`AuthorizationHandlerContext.Requirements` contains the full set of requirements for the current evaluation. `PendingRequirements` starts as the current requirement set and shrinks as handlers call `Succeed(requirement)`. That mutation is exactly why code that iterates the pending set should snapshot it with `.ToList()`: `Succeed` changes the collection while the loop is running.

```csharp
foreach (var requirement in context.PendingRequirements.ToList())
{
    if (requirement is PermissionRequirement p &&
        context.User.HasClaim("permission", "Orders.Delete"))
    {
        context.Succeed(requirement);
    }
}
```

This is the core model behind policy evaluation:

```text
authentication establishes the principal
-> policy contributes requirements
-> pending requirements are evaluated
-> successful handler calls remove matched requirements
-> remaining pending requirements => authorization failed
-> explicit Fail() is a veto, not the default path for ordinary unsatisfied checks
```

## Resource-based authorization and `context.Resource`

A requirement can be a marker while the handler inspects the actual resource being accessed. This is resource-based authorization: the user is checked against the concrete thing, not just against generic claims or roles.

```csharp
public sealed class CanEditProductRequirement : IAuthorizationRequirement { }

public sealed class CanEditProductHandler : AuthorizationHandler<CanEditProductRequirement>
{
    protected override Task HandleRequirementAsync(
        AuthorizationHandlerContext context,
        CanEditProductRequirement requirement)
    {
        var product = (Product)context.Resource!;

        if (context.User.IsInRole("Admin") ||
            product.OwnerId == context.User.FindFirst("sub")?.Value)
        {
            context.Succeed(requirement);
        }

        return Task.CompletedTask;
    }
}
```

Here the requirement is small and reusable, while the decision depends on the actual product instance. The pattern is useful when the authorization policy depends on the entity being edited, deleted, or read, not just on a static claim or role.

## FallbackPolicy, `[Authorize]`, and `[AllowAnonymous]`

Authorization can be configured in a secure-by-default style:

```csharp
builder.Services.AddAuthorization(options =>
{
    options.FallbackPolicy = new AuthorizationPolicyBuilder()
        .RequireAuthenticatedUser()
        .Build();
});
```

That means most endpoints require authentication unless something else says otherwise. Public endpoints use `[AllowAnonymous]` as the explicit escape hatch, while protected endpoints can still use `[Authorize]` or an explicit policy.

```csharp
[AllowAnonymous]
[HttpGet("/login")]
public IActionResult Login() => View();

[Authorize]
[HttpGet("/me")]
public IActionResult Me() => Ok("private");
```

The important distinction is: a policy is AND across requirements, but a single requirement can be satisfied by any handler that calls `Succeed(requirement)`.

## `IAuthorizationRequirementData` and endpoint metadata

The framework also reads authorization requirement metadata from endpoint metadata. `IAuthorizationRequirementData` is an endpoint metadata contract that can contribute requirements. `AuthorizationMiddleware` reads the ordered metadata and combines it into the effective authorization policy.

```csharp
var requirementData = endpoint?.Metadata
    .GetOrderedMetadata<IAuthorizationRequirementData>()
    ?? Array.Empty<IAuthorizationRequirementData>();
```

Conceptually, the middleware builds a combined policy from the endpoint metadata and any configured policy. This allows attributes or endpoint conventions to contribute requirements without hard-coding all policy logic into the action itself.

This is why a custom attribute like `MinimumAgeAttribute : Attribute, IAuthorizationRequirementData` can participate in the same framework pipeline as other policy requirements.

## What should be recallable

- Why a policy succeeds only when every requirement succeeds.
- Why `PendingRequirements` is the live state and `Succeed(requirement)` removes one exact requirement.
- Why `PendingRequirements.ToList()` is required when iterating it.
- Why a single requirement can be satisfied by multiple handlers while the policy itself stays an AND across requirements.
- When resource-based authorization is needed and why `context.Resource` matters.
- Why `AllowAnonymous` is the explicit opt-out in a secure-by-default fallback policy.
- How `IAuthorizationRequirementData` and `AuthorizationMiddleware` combine endpoint metadata into an effective policy.

## Related knowledge

- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`
- `aspnet-core.cookie-auth-api-challenge-responses`
- `aspnet-core.authentication-schemes-oidc-events-and-tickets`

## Sources

- Workspace: `_ai-conspects/AUTHORIZATION/`
- Authoritative processed source: `10-full-combined-final-transcript.md`
- Source identity review: `00-source-check-and-boundary-review.md`
- Original SVG: `source/AUTHORIZATION.svg`
