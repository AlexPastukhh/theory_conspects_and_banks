# Cookie authentication event lifecycle

Knowledge ID: `aspnet-core.cookie-authentication-event-lifecycle`

Topic: `aspnet-core`

## Inline callbacks and scoped event classes

Cookie authentication events can be configured inline for small local behavior:

```csharp
options.Events.OnSigningIn = context =>
{
    return Task.CompletedTask;
};
```

When event logic needs dependency injection, database access, reusable services, or focused tests, register a scoped `CookieAuthenticationEvents` implementation and select it through `EventsType`:

```csharp
builder.Services.AddScoped<CustomCookieEvents>();

builder.Services
    .AddAuthentication()
    .AddCookie(options =>
    {
        options.EventsType = typeof(CustomCookieEvents);
    });
```

The event phase determines what can still be changed safely.

Cookie event contexts expose `HttpContext`, handler options and scheme information, plus the principal or authentication properties at phases where those values exist. The available state is phase-specific; a later callback should not be treated as if it can still change an earlier handler result.

## Before and after issuing the cookie

`OnSigningIn` receives `CookieSigningInContext` before the authentication ticket is written. It can inspect or change the principal, authentication properties, operation-specific cookie options, and `HttpContext`. Typical changes include claims, session-versus-persistent behavior, `IssuedUtc`/`ExpiresUtc`, and cookie flags for this sign-in operation:

```csharp
options.Events.OnSigningIn = context =>
{
    var identity = (ClaimsIdentity)context.Principal!.Identity!;
    identity.AddClaim(new Claim("tenant", "northwind"));

    context.Properties.IsPersistent = true;
    context.Properties.ExpiresUtc =
        DateTimeOffset.UtcNow.AddHours(8);

    return Task.CompletedTask;
};
```

These changes affect the cookie being issued now; they do not rewrite cookies that were issued earlier.

`OnSignedIn` receives `CookieSignedInContext` after sign-in has completed. It is appropriate for audit records, telemetry, a last-login update, or other post-login side effects. It is too late to rely on this hook for changing the ticket that was already created; principal and property changes belong in `OnSigningIn`.

## Sign-out and sliding renewal

`OnSigningOut` runs before sign-out completes. It can audit logout, revoke a server-side session, delete refresh/session records, or clean up per-session resources. Make the work idempotent because sign-out may be requested more than once.

`OnCheckSlidingExpiration` participates in the handler's renewal decision when sliding expiration is enabled:

```csharp
options.SlidingExpiration = true;

options.Events.OnCheckSlidingExpiration = context =>
{
    if (context.Principal.HasClaim("session_fixed", "true"))
        context.ShouldRenew = false;

    return Task.CompletedTask;
};
```

Sliding expiration extends an active session; it does not prove that the account is still active and is not a revocation mechanism.

## Neighboring event responsibilities

`OnValidatePrincipal` is the incoming-ticket hook for account revocation, security-version checks, principal replacement, and persisted claim renewal. Its detailed lifecycle belongs with ticket/principal validation rather than cookie issuance.

The redirect events are page-oriented handler hooks:

```text
OnRedirectToLogin
OnRedirectToAccessDenied
OnRedirectToLogout
OnRedirectToReturnUrl
```

An API can turn challenge/forbid redirects into one owned `401`/`403` Problem Details response. Response classification and single-writer ownership belong to the API challenge-response unit.

## Related knowledge

- `aspnet-core.cookie-authentication-ticket-and-principal-lifecycle`
- `aspnet-core.cookie-auth-api-challenge-responses`

## What should be recallable

- When is an inline callback sufficient, and when is a scoped `EventsType` useful?
- Why can `OnSigningIn` alter the new ticket while `OnSignedIn` cannot?
- Which sign-out work must be idempotent?
- What decision can `OnCheckSlidingExpiration` change, and what can it not replace?
- Why does incoming principal validation form a separate lifecycle concern?

## Sources

- Workspace: `_ai-conspects/AUTH EVENTS/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R01
- Original SVG: `source/AUTH EVENTS.svg`
