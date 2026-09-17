# ASP.NET Core Basic authentication handler and clients

Knowledge ID: `aspnet-core.basic-authentication-handler-and-clients`

Topic: `aspnet-core`

## Handler flow

A custom `AuthenticationHandler` implements one registered Basic scheme:

```text
read Authorization
-> recognize Basic scheme
-> decode and parse credentials
-> validate through a dedicated service/store
-> create only required claims
-> build ClaimsPrincipal and ticket
-> AuthenticateResult.Success(ticket)
```

Missing credentials can return `AuthenticateResult.NoResult()`. Malformed or invalid credentials return `Fail(...)`. Keep credential lookup outside the handler rather than hard-coding users, and never log raw authorization headers or passwords.

Challenge is a separate response contract: return `401 Unauthorized` with a standards-compatible `WWW-Authenticate: Basic` header and optional `realm`. A successfully authenticated user who lacks authorization is a separate `403 Forbidden` case.

Register the authentication scheme and attach authorization metadata with `[Authorize]` or endpoint `RequireAuthorization`. The handler establishes identity; endpoint authorization then evaluates it.

## Client choices

An explicit .NET client header makes each request's credential transport visible:

```csharp
string raw = Convert.ToBase64String(
    Encoding.UTF8.GetBytes($"{username}:{password}"));

request.Headers.Authorization =
    new AuthenticationHeaderValue("Basic", raw);
```

Handler credential support can instead participate in client-specific challenge, retry, caching, or preauthentication behavior. Choose it only when that behavior is understood. `curl` and PowerShell expose convenience switches for Basic credentials, but the wire contract remains the same `Authorization` header.

Because the credential is replayable and trivially recoverable from Base64, every client/server example requires HTTPS.

## What should be recallable

- Which handler stages turn an Authorization header into an authenticated principal?
- When should the handler return `NoResult`, `Fail`, or `Success`?
- How do authentication challenge 401 and authorization failure 403 differ?
- Why should credential validation live behind a service/store?
- How do explicit headers differ from credential-aware handler behavior?

## Sources

- Workspace: `_ai-conspects/basic auth/`
- Authoritative processed source: `regions/R01R02R03-basic-authentication-final.md`, R02–R03 and operational conclusions
- Original SVG: `source/basic auth.svg`
