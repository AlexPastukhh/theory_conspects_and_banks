# ASP.NET Core authentication schemes, OIDC events, and tickets

Knowledge ID: `aspnet-core.authentication-schemes-oidc-events-and-tickets`

Topic: `aspnet-core`

ASP.NET Core authentication delegates to named handlers. `Authenticate` reads/validates credentials and returns a principal; `Challenge` starts or reports authentication; `SignIn` creates local sign-in state when the scheme supports it; `SignOut` removes local state and may initiate remote sign-out. Defaults and explicit scheme names decide which handler runs.

With several identity entrances, select the scheme intentionally per endpoint or policy. The framework otherwise has to infer which handler authenticates, challenges, and signs in. A Windows-only endpoint can require `Negotiate`, while an external-client endpoint can require cookies, bearer, or OIDC through an explicit policy. A convenient default can hide mistakes by filling `HttpContext.User` from the wrong source.

```csharp
[Authorize(AuthenticationSchemes = NegotiateDefaults.AuthenticationScheme)]
public IActionResult EmployeeOnly() => Ok();

[Authorize(AuthenticationSchemes = CookieAuthenticationDefaults.AuthenticationScheme)]
public IActionResult ClientArea() => Ok();
```

For repeated rules, name policies such as `EmployeePolicy` and `ClientPolicy` so endpoint code does not scatter scheme strings.

Challenge behavior is part of that contract:

```text
Negotiate challenge -> browser may send domain credentials or show a prompt
cookie challenge    -> usually redirects to a login page
bearer challenge    -> normally returns 401 + WWW-Authenticate: Bearer
```

Wrong selection can therefore produce an HTML login response for an API, a cookie redirect for a Windows-only route, or an unwanted Windows credential prompt. Policies centralize both the allowed identity source and the claims/groups required after authentication.

The common web OIDC arrangement uses a cookie scheme for the local session and an OpenID Connect scheme for remote challenge/callback work:

```csharp
services.AddAuthentication(options =>
{
    options.DefaultScheme = "app";
    options.DefaultChallengeScheme = "oidc";
})
.AddCookie("app")
.AddOpenIdConnect("oidc", options =>
{
    options.ResponseType = "code";
    options.UsePkce = true;
    options.SaveTokens = false;
});
```

The cookie contains or references an authentication ticket: principal, authentication properties, and scheme. The ticket is protected with Data Protection. Persist the key ring across restarts and instances or valid sessions become unreadable.

OIDC events occur at distinct trust stages: redirect to the identity provider, redirect for sign-out, inbound message receipt, authorization-code receipt, token-endpoint response, token validation, UserInfo response, final ticket creation, and remote failure. Redirect events may adjust the outbound protocol message. The authorization-code event may take over redemption. Token-validation and ticket events can normalize or add claims and reject sign-in. Remote-failure handling distinguishes provider, correlation/state, token-endpoint, and token-validation failures without leaking secrets.

`AuthenticationProperties` carries ticket/session state and can hold saved token values. Keep token material out of the cookie when size/exposure calls for a server-side store.

## Sources

- Workspace: `_ai-conspects/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 4-6 and 12
- Original SVG: `source/OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg`
- Workspace: `_ai-conspects/windows-auth/`
- Authoritative processed source: `regions/R03-dual-scheme-windows-auth-and-cookies.md`
- Original SVG: `source/windows-auth.svg`
