# Windows Authentication with Negotiate and hosting

Knowledge ID: `aspnet-core.windows-authentication-negotiate-hosting`

Topic: `aspnet-core`

Windows Authentication requires the host/server and application layers to agree:

```text
IIS / IIS Express / Kestrel integration accepts Windows authentication
-> ASP.NET Core handler creates/reads the principal
-> authorization requires the intended identity
```

For IIS/IIS Express, enable Windows Authentication. Disable Anonymous where the entire app must require Windows identity, or keep it only where endpoints deliberately allow anonymous access. If Windows Authentication is disabled, the application cannot synthesize a Windows principal; if Anonymous is permitted and no authorization rule challenges, a request may reach the endpoint without one.

Typical Negotiate registration and middleware order:

```csharp
builder.Services
    .AddAuthentication(NegotiateDefaults.AuthenticationScheme)
    .AddNegotiate();

builder.Services.AddAuthorization();

var app = builder.Build();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
```

Registration makes the handler available. Authentication populates `HttpContext.User`; authorization enforces `[Authorize]`, policies, or `RequireAuthorization`. Authentication must run before authorization. A handler's presence alone does not force an endpoint to challenge.

Controllers and minimal APIs express the same boundary:

```csharp
[Authorize]
[HttpGet("whoami")]
public IActionResult WhoAmI() => Ok(new
{
    name = User.Identity?.Name,
    authenticated = User.Identity?.IsAuthenticated,
    authenticationType = User.Identity?.AuthenticationType,
    claims = User.Claims.Select(c => new { c.Type, c.Value })
});
```

```csharp
app.MapGet("/whoami", (ClaimsPrincipal user) => user.Identity?.Name)
   .RequireAuthorization();
```

Use a protected diagnostic route during setup to verify the actual `DOMAIN\\user`, authentication type, and claim/group shape. Local launch-profile/IIS Express settings and production IIS site/app-pool/domain configuration are separate; local success does not prove production Kerberos/SPN readiness.

First check host auth switches, Anonymous behavior, `AddNegotiate`, middleware order, endpoint authorization, and the diagnostic identity. If those are correct but prompts, loops, or NTLM fallback remain, continue with domain, browser, app-pool identity, DNS, SPN, and proxy diagnostics rather than changing controller code blindly.

## What should be recallable

- Which responsibilities belong to hosting and which to ASP.NET Core?
- What happens when Windows Authentication is disabled or Anonymous remains allowed?
- What does each registration/middleware/authorization step contribute?
- Why does registering a handler not automatically protect an endpoint?
- Which identity fields should a protected diagnostic endpoint inspect?
- Why can IIS Express success differ from production Kerberos behavior?

## Related knowledge

- `security.windows-integrated-authentication-and-domain-infrastructure` — AD, Kerberos/NTLM, SPNs, and deployment diagnosis.
- `aspnet-core.authentication-schemes-oidc-events-and-tickets` — explicit scheme and challenge selection.

## Sources

- Workspace: `_ai-conspects/windows-auth/`
- Authoritative processed source: `regions/R02-aspnet-core-iis-negotiate-basic-implementation.md`
- Original SVG: `source/windows-auth.svg`
