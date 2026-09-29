# Forwarded headers and client-IP trust

Knowledge ID: `aspnet-core.forwarded-headers-and-client-ip-trust`

Topic: `aspnet-core`

Behind a reverse proxy or CDN, `HttpContext.Connection.RemoteIpAddress` initially identifies the immediate network peer. That may be Nginx, IIS, Cloudflare, Azure Front Door, or another proxy—not the end user.

Forwarded headers can restore original request context, but they are also client-controlled text unless the application accepts them only from trusted infrastructure.

## Configure the trust boundary before reading client context

```csharp
builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.ForwardedHeaders =
        ForwardedHeaders.XForwardedFor |
        ForwardedHeaders.XForwardedProto;

    // Configure KnownProxies / KnownIPNetworks for the deployment.
});

var app = builder.Build();
app.UseForwardedHeaders();
```

Run forwarded-header processing before components that depend on client IP or original scheme. Restrict `KnownProxies` and `KnownIPNetworks` to the actual proxy path; trusting arbitrary senders allows spoofed `X-Forwarded-For` or scheme values to become application context.

After correct processing, `RemoteIpAddress` is more likely to represent the original client. Its reliability still depends on the complete proxy chain and deployment configuration.

## Optional downstream IP signals

Some external verification APIs accept an optional end-user address—for example reCAPTCHA's `remoteip`. Send it only when the application can establish that `RemoteIpAddress` is the real client address. A proxy address weakens the signal, and an untrusted forwarded value is worse.

```text
reliable trusted proxy chain -> optional client IP may add risk context
unknown or misconfigured chain -> omit the optional value
```

An optional signal is not worth fabricating confidence. Authentication, authorization, throttling, auditing, and abuse decisions should also avoid treating IP as a stable identity.

## Source-preserving proxy trust mechanics

## S-025 — Backend forwarded-headers configuration

**Known limits:** none

### Near-literal normalized transcript

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.Configure<ForwardedHeadersOptions>(options =>
{
    options.ForwardedHeaders =
        ForwardedHeaders.XForwardedFor |
        ForwardedHeaders.XForwardedProto;

    options.KnownProxies.Add(
        IPAddress.Parse("10.0.0.100"));
});
```

### Study meaning

The backend enables selected headers and trusts one exact reverse-proxy IP.

### Recall questions

1. Which two forwarded headers are enabled?
2. What IP is trusted?
3. Why is explicit trust required?


---

## S-026 — UseForwardedHeaders middleware order

**Known limits:** none

### Near-literal normalized transcript

```csharp
var app = builder.Build();

app.UseForwardedHeaders();

app.MapControllers();

app.Run();
```

`UseForwardedHeaders` should run before middleware that depends on original request data.

By default, loopback proxies are trusted; other proxies should be added to `KnownProxies` or `KnownNetworks`.

### Study meaning

Order matters because redirects, URL generation, auth, and logging should observe restored values.

### Recall questions

1. Where is UseForwardedHeaders placed?
2. Which proxies are trusted by default?
3. Where are remote proxies configured?


---

## S-027 — Final distinctions among proxy concepts

**Known limits:** none

### Near-literal normalized transcript

- **Forward proxy:** for outbound calls when network policy requires proxying; not React calling the backend.
- **Reverse proxy:** in front of the ASP.NET Core application; common in production.
- `UseForwardedHeaders`: restores original client-facing request values when the proxy is trusted and middleware runs early.
- `KnownProxies`: trust exact proxy IPs.
- `KnownIPNetworks`: trust a subnet or range.

### Study meaning

Each concept belongs to a different direction or trust decision.

### Recall questions

1. When is a forward proxy relevant?
2. Where is a reverse proxy placed?
3. What two conditions make forwarded headers safe?
4. How do exact IP and network trust differ?


---

## S-028 — Will application code look normal behind a proxy?

**Known limits:** none

### Near-literal normalized transcript

With correct forwarded-header configuration, application code can often keep using:

- `Request.Scheme`;
- `Request.Host`;
- `HttpContext.Connection.RemoteIpAddress`.

Practical result:

- most code stays unchanged;
- without correct setup, redirects, absolute URLs, callback URLs, and client-IP logging can be wrong.

### Study meaning

The proxy-facing request is normalized before business middleware executes.

### Recall questions

1. Which three properties are listed?
2. What four behaviors can be wrong?
3. Why must restoration occur early?


---

## S-029 — Loopback versus non-loopback proxies

**Known limits:** none

### Near-literal normalized transcript

Loopback means the proxy is on the same machine, using:

- `127.0.0.1`;
- `::1`;
- `localhost`.

Only loopback proxies or networks are trusted by default. A proxy on another private-network address must be added to `KnownProxies` or `KnownIPNetworks`.

### Study meaning

Do not trust spoofable forwarded headers from arbitrary remote clients.

### Recall questions

1. Name the three loopback forms.
2. Why does local proxying often work by default?
3. What changes for a remote proxy?


---

## S-030 — KnownProxies versus KnownIPNetworks

**Known limits:** none

### Near-literal normalized transcript

Use `KnownProxies` for specific proxy IPs, such as:

```text
10.0.0.100
```

Use `KnownIPNetworks` for a whole trusted subnet or range, such as:

```text
10.0.1.0/24
```

The older `KnownNetworks` name is obsolete in favor of `KnownIPNetworks`.

### Study meaning

Use exact trust for fixed proxies and network trust for managed fleets.

### Recall questions

1. What exact IP is shown?
2. What subnet is shown?
3. When is each option appropriate?
4. What old API name is mentioned?


---

## What should be recallable

- Why can `RemoteIpAddress` contain a proxy address?
- What do `X-Forwarded-For` and `X-Forwarded-Proto` restore?
- Why must known proxies/networks be restricted?
- Where must `UseForwardedHeaders` run relative to IP/scheme consumers?
- When should an optional downstream `remoteip` value be omitted?
- Why is client IP useful context but not identity?

## Related knowledge

- `security.recaptcha-server-verification-and-risk-policy`
- `aspnet-core.link-generator-and-public-origin`
- `aspnet-core.middleware-ordering-short-circuit-and-json`

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R05-yarp-and-forwarded-headers.md`, S-025 through S-030
- Original SVG: `_ai-conspects/proxy, server, vite dev server proxy/source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`)

- Workspace: `_ai-conspects/google recapcha and recapchas/`
- Authoritative processed source: `03-source-preserving-transcript-v003.md`, S-054-S-058
- Semantic reconciliation: `04-full-svg-semantic-transcript-v002.md`, R04
- Original SVG: `source/source-complete-v002.svg`
