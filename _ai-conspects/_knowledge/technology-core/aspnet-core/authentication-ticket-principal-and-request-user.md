# AuthenticationTicket, ClaimsPrincipal, and the request user

Knowledge ID: `aspnet-core.authentication-ticket-principal-and-request-user`

Topic: `aspnet-core`

An `AuthenticationTicket` packages one successful authentication result:

```text
AuthenticationTicket
├── ClaimsPrincipal
├── AuthenticationProperties
└── authentication scheme name
```

```csharp
var ticket = new AuthenticationTicket(
    principal,
    properties,
    "Cookies");
```

The scheme is part of the result because the same principal shape could have been produced by `Cookies`, `Bearer`, `oidc`, or another registered scheme. The principal contains identities and claims; the properties contain operation/session state such as issue and expiry times, persistence, refresh permission, items, parameters, redirect state, and stored tokens.

## Getting the result explicitly

Manual authentication exposes all three layers:

```csharp
var result = await HttpContext.AuthenticateAsync("Cookies");

if (result.Succeeded)
{
    ClaimsPrincipal? principal = result.Principal;
    AuthenticationProperties? properties = result.Properties;
    AuthenticationTicket? ticket = result.Ticket;
}
```

`ticket.Principal`, `ticket.Properties`, and `ticket.AuthenticationScheme` are the corresponding ticket members. Claims can be read through the principal:

```csharp
string? userId = ticket.Principal.FindFirst("sub")?.Value;
bool? authenticated = ticket.Principal.Identity?.IsAuthenticated;
```

## Cookie restoration versus bearer reconstruction

Cookie authentication commonly follows this lifecycle:

```text
SignInAsync(principal, properties)
-> create AuthenticationTicket
-> protect the ticket, or store it and protect a key
-> later read the cookie
-> unprotect it, or retrieve it through ITicketStore
-> validate ticket and principal
-> AuthenticateResult.Success(ticket)
```

JWT bearer authentication follows a different lifecycle:

```text
read incoming bearer token
-> validate token
-> create ClaimsPrincipal
-> create AuthenticationProperties
-> create AuthenticationTicket
-> AuthenticateResult.Success(ticket)
```

The bearer ticket is normally an in-memory, per-request framework object. The next request must send the JWT again; the JWT is the persistent credential, not the ticket. A successful result can flow into `HttpContext.User`, `IAuthenticateResultFeature`, and then authorization.

## `HttpContext.User` is a principal, not a ticket

```csharp
ClaimsPrincipal user = context.User;
```

A `ClaimsPrincipal` is a container that can hold more than one `ClaimsIdentity`. `User.Identity` exposes its selected/primary identity, while `User.Identities` exposes the complete set. Important access paths include:

```csharp
context.User.Identity
context.User.Identities
context.User.Claims
context.User.FindFirst("sub")
context.User.HasClaim(...)
context.User.IsInRole("Admin")
```

Each `ClaimsIdentity` carries its own claims plus `AuthenticationType`, `NameClaimType`, and `RoleClaimType`. Its `IsAuthenticated` is normally true when the identity has a non-empty authentication type:

```csharp
var authenticated = new ClaimsIdentity(claims, "Cookies");
var unauthenticated = new ClaimsIdentity(claims);
```

`ClaimsPrincipal.Claims` exposes claims across the contained identities. When a policy authenticates more than one scheme, the request principal can contain both identities:

```csharp
[Authorize(AuthenticationSchemes = "Cookies,Bearer")]
```

```text
HttpContext.User
└── ClaimsPrincipal
    ├── ClaimsIdentity(authentication type: Cookies)
    └── ClaimsIdentity(authentication type: Bearer)
```

This is why request identity, ticket identity, and scheme selection must not be collapsed into one object: the ticket is an authentication result package, while `HttpContext.User` is the principal used by the current request.

## What should be recallable

- Which three values make up an `AuthenticationTicket`?
- What does `AuthenticateAsync` expose on a successful result?
- Why is a cookie ticket persisted/restored while a bearer ticket is normally reconstructed per request?
- How is `HttpContext.User` different from an authentication ticket?
- What determines `ClaimsIdentity.IsAuthenticated` in the captured model?
- Why can one `ClaimsPrincipal` contain several identities?

## Related knowledge

- `aspnet-core.authentication-properties-operation-and-session-state`
- `aspnet-core.cookie-authentication-ticket-and-principal-lifecycle`
- `aspnet-core.authentication-schemes-oidc-events-and-tickets`

## Sources

- Workspace: `_ai-conspects/authenticaiton ticket, properties, context.User (claimsprincipal)/`
- Authoritative processed source: `regions/full-source-near-literal-v003.md`, S-023–S-030 and S-036–S-043
- Original SVG: `source/source-complete-v002.svg`
