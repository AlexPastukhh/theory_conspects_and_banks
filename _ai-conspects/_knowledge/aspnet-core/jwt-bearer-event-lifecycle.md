# JWT bearer event lifecycle

Knowledge ID: `aspnet-core.jwt-bearer-event-lifecycle`

Topic: `aspnet-core`

JWT bearer events occur at different stages of token discovery, validation failure, successful validation, challenge, and authorization failure. Choosing the right hook prevents token-transport code, business validation, and response writing from collapsing into one callback. Their contexts expose `HttpContext`, request/response, scheme and handler options, plus a principal where the stage has produced one.

## Locate a token with `OnMessageReceived`

`OnMessageReceived` runs while the handler is locating a token. A controlled nonstandard source can be supported by setting `context.Token`. A common case is a SignalR/WebSocket connection whose access token must be supplied in the query string; restrict that exception to the endpoint that requires it:

```csharp
options.Events.OnMessageReceived = context =>
{
    var accessToken = context.Request.Query["access_token"];
    var path = context.HttpContext.Request.Path;

    if (!StringValues.IsNullOrEmpty(accessToken) &&
        path.StartsWithSegments("/hubs/chat"))
    {
        context.Token = accessToken;
    }

    return Task.CompletedTask;
};
```

Query-string tokens can appear in logs or other URL surfaces. Do not enable this source globally, and do not put database-heavy authorization decisions in token discovery.

For a browser WebSocket that cannot set an `Authorization` header, use `wss://` and, where the design permits, issue a short-lived or one-time connection token rather than exposing a long-lived access token. Never put a refresh token in the WebSocket URL, and redact query strings from access/proxy logs. Restrict extraction to the exact upgrade path (for example `/ws`), while retaining ordinary signature, issuer, audience, and lifetime validation after discovery.

## Apply business checks with `OnTokenValidated`

`OnTokenValidated` runs only after configured signature, issuer, audience, lifetime, and token-structure checks have succeeded and a principal exists. It is the place for application-specific account, tenant, token-version, or other trusted-state checks that are not established by cryptographic validation:

```csharp
options.Events.OnTokenValidated = async context =>
{
    var tenant = context.Principal!
        .FindFirstValue("tenant");

    if (!await tenantRegistry.IsEnabledAsync(tenant))
        context.Fail("Tenant is disabled.");
};
```

“Token validated” means the configured token-validation rules succeeded; it does not prove every business rule is satisfied. This hook can also add trusted application claims after those checks.

## Separate processing failure, challenge, and forbid

`OnAuthenticationFailed` runs when authentication processing fails, such as for an expired token, invalid signature, wrong issuer/audience, malformed token, or a custom validation exception. Use it for structured logging, metrics, and safe diagnostic correlation. It may own a sanitized custom failure response when the application deliberately assigns that responsibility, but must not leak raw exception details or compete with a later challenge writer.

`OnChallenge` runs when the authentication system produces a `401` challenge. If the event owns the entire response, call `HandleResponse()` before writing it so the default bearer challenge does not also modify the response:

```csharp
options.Events.OnChallenge = async context =>
{
    context.HandleResponse();
    context.Response.StatusCode =
        StatusCodes.Status401Unauthorized;

    await problemDetails.TryWriteAsync(
        new ProblemDetailsContext
        {
            HttpContext = context.HttpContext,
            ProblemDetails =
            {
                Status = StatusCodes.Status401Unauthorized,
                Title = "Authentication required"
            }
        });
};
```

`OnForbidden` runs for `403`: an acceptable principal exists, but authorization failed.

```csharp
options.Events.OnForbidden = async context =>
{
    context.Response.StatusCode =
        StatusCodes.Status403Forbidden;

    await problemDetails.TryWriteAsync(
        new ProblemDetailsContext
        {
            HttpContext = context.HttpContext,
            ProblemDetails =
            {
                Status = StatusCodes.Status403Forbidden,
                Title = "Access denied"
            }
        });
};
```

Keep the outcomes distinct:

```text
OnAuthenticationFailed
    token/authentication processing failed

OnChallenge
    the endpoint requires authentication and no acceptable principal exists

OnForbidden
    an acceptable principal exists but lacks authorization
```

Only one component should own the status and body. Set the status before writing, do not write twice, and keep resource-authorization decisions in policies or authorization handlers.

## Related knowledge

- `aspnet-core.cookie-auth-api-challenge-responses`
- `aspnet-core.endpoint-metadata-and-mvc-action-descriptors`

## What should be recallable

- Why must query-string token extraction be limited to a known endpoint?
- What has already succeeded when `OnTokenValidated` runs?
- How do authentication failure, challenge, and forbid differ?
- Why must a custom bearer challenge call `HandleResponse()`?
- Which component should own a Problem Details body?

## Sources

- Workspace: `_ai-conspects/AUTH EVENTS/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R02-R03
- Original SVG: `source/AUTH EVENTS.svg`
- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, section 21
- Original SVG: `source/websockets.svg`
