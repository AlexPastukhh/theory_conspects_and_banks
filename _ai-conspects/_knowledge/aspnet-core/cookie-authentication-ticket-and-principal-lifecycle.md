# Cookie authentication ticket and principal lifecycle

Knowledge ID: `aspnet-core.cookie-authentication-ticket-and-principal-lifecycle`

Topic: `aspnet-core`

## From cookie to authorization

Cookie authentication establishes identity before authorization evaluates it:

```text
read cookie
-> recover protected ticket, or retrieve it by ITicketStore key
-> reconstruct ClaimsPrincipal
-> populate HttpContext.User
-> evaluate endpoint policy, role, or claim requirements
```

`[Authorize]` consumes this authentication result; it does not create claims or populate `HttpContext.User`. Authentication and authorization are separate stages.

A login builds the required claims and `ClaimsIdentity`, calls `SignInAsync`, and accepts a return URL only when it is local. Logout calls `SignOutAsync`; unsafe login/logout actions can also require antiforgery. Multiple schemes may coexist, with policies selecting cookie authentication for browser endpoints and bearer authentication for other APIs.

HttpOnly cookie transport reduces direct JavaScript credential theft, but the browser attaches the cookie automatically, so unsafe requests still need an antiforgery strategy. Same-site deployments are the simple case; genuinely cross-site SPA/API deployments also need deliberate CORS, credential mode, and cookie configuration.

Order the conventional pipeline as routing, cookie policy when used, authentication, authorization, then endpoints.

## Persistence, expiry, and routes

`AuthenticationProperties.IsPersistent` controls browser persistence. A non-persistent sign-in normally emits a session cookie without `Expires`; a persistent sign-in emits expiry/max-age behavior. `ExpiresUtc` can set a sign-in-specific expiry, while `ExpireTimeSpan` supplies handler ticket lifetime. `SlidingExpiration` can reissue a ticket after sufficient progress through its lifetime; it is not simply the browser's `Max-Age` attribute.

Developer tools do not expose a special visual “authentication cookie” type. A self-contained auth cookie is often a long opaque protected ticket, while an `ITicketStore` or session cookie is commonly a shorter opaque key. Name, value, and size are conventions rather than proof of server semantics.

`LoginPath`, `LogoutPath`, `AccessDeniedPath`, and `ReturnUrlParameter` are handler routing conventions. Challenge normally redirects an unauthenticated user to the login path; forbid normally redirects an authenticated but unauthorized user to the access-denied path. A configured path that has no endpoint yields a 404. Create the endpoint, configure a real path, or override events to return 401/403 for API requests.

## Ticket protection and validity

Without a session store, sign-in creates an `AuthenticationTicket`; `TicketDataFormat` serializes and protects it with Data Protection; the cookie carries the protected value. Later, authentication unprotects and deserializes it, checks lifetime and handler rules, and reconstructs the principal.

Cryptographic validity is necessary but not sufficient for business validity. A ticket may unprotect successfully yet be rejected because it expired, scheme/application identity changed, key material is incompatible, application-level principal validation fails, or renewal rules reject it.

The default `TicketDataFormat` supplies serialization, protection/integrity, key rotation, and ticket-expiration support. Keep it unless interoperability, migration, custom serialization, or intentionally shared tickets require another format. Multi-server applications must configure compatible Data Protection keys and application name. Advanced `Forward*` options route among schemes and normally remain unset in a simple cookie application.

`AddCookie` also centralizes the cookie name and attributes, claims issuer, redirect paths, authentication events, expiry/sliding rules, and forwarding configuration. These handler options are distinct from a global Cookie Policy that can adjust cookie writes later in the response pipeline.

## `ITicketStore`

With `ITicketStore`, the browser cookie contains an opaque key while claims and authentication properties live server-side. This supports smaller cookies, large claim sets, immediate server-side revocation, and avoiding the full protected identity payload in the browser.

A distributed implementation shares its cache, protects serialized ticket bytes at rest, selects a TTL from ticket expiry or a fallback, and implements:

```text
StoreAsync    -> create key and save ticket
RenewAsync    -> update ticket under the same key
RetrieveAsync -> load, unprotect, and deserialize
RemoveAsync   -> delete on logout or revocation
```

A server-side `ITicketStore` does not remove these lifecycle requirements: align stored-ticket expiry with ticket expiration and sliding renewal, and persist/share the Data Protection key ring across application restarts and instances so existing protected tickets remain usable.

Treat corrupt or unprotectable entries as missing so authentication is required again.

The lifecycle is login/store/key-cookie → request/retrieve/principal → renewal/update same key → logout/remove. Without a store, renewal emits a new protected ticket in the cookie; with a store, it updates server state while the browser retains the session-key cookie.

## Principal validation and claim refresh

`OnValidatePrincipal` runs after a candidate principal has been reconstructed. It makes application-level trust decisions: whether the account still exists or is disabled, security version or roles changed, and whether to reject or renew the cookie. Authorization happens later.

Rejecting an invalid principal is a complete authentication decision: call `RejectPrincipal()` and sign out when the cookie should be removed. To refresh valid but stale claims, call `ReplacePrincipal(newPrincipal)` and set `ShouldRenew = true`; replacement affects the current request, while renewal persists it for later requests.

A database lookup on every authenticated request can be expensive. Alternatives include a security-stamp/version claim, periodic revalidation, cached user snapshots, refresh on explicit account changes, or the ASP.NET Core Identity validator pattern.

Changing database claims does not mutate an issued ticket. Reliable update paths are:

1. Rebuild the principal and call `SignInAsync` when the current operation changed identity data.
2. During `OnValidatePrincipal`, call `ReplacePrincipal(newPrincipal)` and set `ShouldRenew = true`.
3. Reject the principal and require login when seamless refresh is undesirable.

Do not rely on mutating the existing `ClaimsIdentity` in place. `ReplacePrincipal` updates the current request; `ShouldRenew` persists the replacement for future requests. This mechanism does not require `ITicketStore`; the store only changes where the renewed ticket lives. Use `IClaimsTransformation` when added claims are needed only for the current request and need not enter the ticket.

## What should be recallable

- Which component establishes `HttpContext.User`, and what does `[Authorize]` do afterward?
- How do `IsPersistent`, `ExpiresUtc`, `ExpireTimeSpan`, and `SlidingExpiration` differ?
- What do cookie authentication route options do, and why can a configured path produce 404?
- Why is cryptographic validity not the same as business validity?
- How does `ITicketStore` change the cookie and renewal lifecycle?
- How should stale persisted claims be replaced and renewed?

## Sources

- Workspace: `_ai-conspects/cookie auth, antiforgery/`
- Authoritative processed source: `regions/R02-cookie-authentication-basics-and-browser-semantics.md`, `regions/R03-spa-antiforgery-and-cookie-policy.md`, `regions/R04-cookie-options-domain-path-prefixes-and-format.md`, and `regions/R05-ticket-store-principal-validation-and-claims-renewal.md`
- Original SVG: `source/cookie auth, antiforgery.svg`
- Workspace: `_ai-conspects/AUTH EVENTS/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R01
- Original SVG: `source/AUTH EVENTS.svg`
- Workspace: `_ai-conspects/options pattern/`
- Authoritative processed source: `regions/OPT05-di-aware-options-postconfigure-cookie-auth.md`, cookie ticket-store expiry and shared Data Protection boundary
- Original SVG: `source/options pattern.svg`
