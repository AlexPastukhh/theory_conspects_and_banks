# ASP.NET Core claims transformation lifecycle

Knowledge ID: `aspnet-core.claims-transformation-lifecycle`

Topic: `aspnet-core`

`IClaimsTransformation` enriches an authenticated `ClaimsPrincipal` with application-wide claims before controllers, Razor Pages, policies, and other consumers use it.

Good cross-cutting uses include loading application roles/permissions, adding tenant membership, normalizing provider-specific names (`sub`, name identifier, `preferred_username`, `upn`) into stable application claims, and creating aliases for legacy authorization checks. A single endpoint lookup or resource-specific authorization decision belongs elsewhere.

## Contract and registration

```csharp
public interface IClaimsTransformation
{
    Task<ClaimsPrincipal> TransformAsync(ClaimsPrincipal principal);
}
```

Register an implementation in DI, commonly transient. After successful authentication, check `principal.Identity?.IsAuthenticated`, then add or replace claims deliberately. Never append the same claim blindly.

```csharp
if (!identity.HasClaim(c => c.Type == "tenant_id"))
    identity.AddClaim(new Claim("tenant_id", tenantId));
```

## Repetition and persistence boundary

`TransformAsync` can run more than once in one request: an explicit `AuthenticateAsync`, another scheme, or a different principal instance may invoke it again. The framework can reuse transformation for the same principal instance, but correctness and expensive work must not depend on that.

A marker claim can make work idempotent for the reused principal:

```text
if app:claims_transformed=true -> return principal
otherwise load/add claims -> add marker -> return principal
```

That marker is not cross-request persistence. A cookie or JWT parsed on the next request can create a fresh principal and the added claims disappear.

For cookie authentication, persist expensive enrichment by replacing the principal during validation and renewing the ticket:

```csharp
context.ReplacePrincipal(newPrincipal);
context.ShouldRenew = true;
```

Large cookies are paid on every request. Other alternatives include a reliable cache or persisted authorization data. Use resource-based authorization when access depends on the particular resource; use an endpoint service lookup for local data.

## What should be recallable

- Which enrichment/normalization tasks fit claims transformation?
- Why must a transformer check authentication and be idempotent?
- Which events can cause multiple executions in one request?
- Why does a marker claim not persist enrichment across requests?
- How can cookie validation persist a replacement principal?
- When should resource-based authorization or a local lookup be used instead?

## Sources

- Workspace: `_ai-conspects/claimstransformation/`
- Authoritative processed source: `regions/R01R02R03-claims-transformation-final.md`, R01–R03
- Original SVG: `source/claimstransformation.svg`
