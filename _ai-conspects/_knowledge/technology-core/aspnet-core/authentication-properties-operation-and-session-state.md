# AuthenticationProperties operation and session state

Knowledge ID: `aspnet-core.authentication-properties-operation-and-session-state`

Topic: `aspnet-core`

`AuthenticationProperties` carries state for an authentication operation or for a ticket-backed session. The meaning of a property still depends on the handler that consumes it; placing a value in the bag does not make every handler act on it.

## Persistent items and transient parameters

`Items` is string key/value state intended to travel with a ticket:

```csharp
var properties = new AuthenticationProperties();
properties.Items["tenant"] = "acme";
properties.Items["login_reason"] = "checkout";

await HttpContext.SignInAsync("Cookies", principal, properties);
```

Cookie authentication can serialize these items into its protected ticket and restore them on later requests. A JWT bearer result normally keeps them only for the current authentication result unless custom code persists them elsewhere.

`Parameters` is operation-time input. A challenge can pass a handler-specific value:

```csharp
var properties = new AuthenticationProperties();
properties.Parameters["prompt"] = "login";

await HttpContext.ChallengeAsync("oidc", properties);
```

Only a handler or event that knows the key gives it meaning. Custom bearer event code can explicitly read one:

```csharp
options.Events.OnChallenge = context =>
{
    string? value =
        context.Properties.GetParameter<string>("some_key");

    return Task.CompletedTask;
};
```

This is the practical distinction:

```text
Items      -> string state that may persist with a ticket
Parameters -> transient input to the current authentication operation
```

## Stored tokens and `SaveToken`

Token helpers store named values in the properties state, conceptually under their special token keys:

```csharp
properties.StoreTokens(new[]
{
    new AuthenticationToken
    {
        Name = "access_token",
        Value = accessToken
    },
    new AuthenticationToken
    {
        Name = "refresh_token",
        Value = refreshToken
    }
});

string? access = properties.GetTokenValue("access_token");
properties.UpdateTokenValue("access_token", replacement);
```

For JWT bearer authentication, `options.SaveToken = true` copies the successfully validated incoming bearer token into result properties under `access_token`:

```csharp
var result = await HttpContext.AuthenticateAsync("Bearer");
var token = result.Properties?.GetTokenValue("access_token");
```

With `SaveToken = false`, validation can still succeed; the raw token is simply not retained there.

## Redirect, persistence, lifetime, and refresh

`RedirectUri` tells a redirect-capable handler where to go after its operation completes:

```csharp
await HttpContext.ChallengeAsync(
    "oidc",
    new AuthenticationProperties
    {
        RedirectUri = "/dashboard"
    });
```

It is meaningful in remote-login and cookie redirect flows. A normal bearer challenge instead returns `401 Unauthorized` with `WWW-Authenticate: Bearer`; assigning `RedirectUri` does not turn the bearer handler into a login redirect handler.

```csharp
await HttpContext.ChallengeAsync(
    "Bearer",
    new AuthenticationProperties
    {
        RedirectUri = "/login"
    });
// Normal bearer behavior is still a challenge response, not a redirect.
```

For a cookie sign-in, the main lifetime properties compose like this:

```csharp
var now = DateTimeOffset.UtcNow;

var properties = new AuthenticationProperties
{
    IsPersistent = true,
    IssuedUtc = now,
    ExpiresUtc = now.AddHours(8),
    AllowRefresh = true
};

await HttpContext.SignInAsync("Cookies", principal, properties);
```

- `IsPersistent` asks for a cookie that can survive browser close; a session cookie normally ends with the browser session.
- `IssuedUtc` records when the ticket/session was issued. A cookie handler can fill it when absent, and sliding-expiration calculations use it.
- `ExpiresUtc` records ticket/session expiry. An expired cookie ticket fails authentication.
- `AllowRefresh` says whether handler/session renewal is permitted and can matter for cookie refresh and sliding expiration.

For JWT bearer authentication, validated token times are reflected into the per-request result:

```text
token.ValidFrom -> AuthenticationProperties.IssuedUtc
token.ValidTo   -> AuthenticationProperties.ExpiresUtc
```

That does not create a server-side session. Ordinary bearer validation does not renew, rewrite, or issue a token, so `IsPersistent`, redirect behavior, and `AllowRefresh` normally have no practical bearer-session effect.

## What should be recallable

- How do `Items` and `Parameters` differ in lifetime and value shape?
- Why does an arbitrary parameter have no effect until a handler or event reads it?
- What does JWT bearer `SaveToken` change, and what does it not change?
- Which handlers normally use `RedirectUri`?
- How do `IsPersistent`, `IssuedUtc`, `ExpiresUtc`, and `AllowRefresh` participate in a cookie session?
- Why do JWT-derived issue/expiry properties not imply a refreshable server session?

## Related knowledge

- `aspnet-core.authentication-ticket-principal-and-request-user`
- `aspnet-core.authentication-schemes-oidc-events-and-tickets`
- `aspnet-core.cookie-authentication-ticket-and-principal-lifecycle`

## Sources

- Workspace: `_ai-conspects/authenticaiton ticket, properties, context.User (claimsprincipal)/`
- Authoritative processed source: `regions/full-source-near-literal-v003.md`, S-001–S-022 and S-031–S-035
- Original SVG: `source/source-complete-v002.svg`
