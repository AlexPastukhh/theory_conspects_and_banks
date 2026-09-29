# SocketsHttpHandler connection pooling, proxies, and primary-handler ownership

Knowledge ID: `dotnet.sockets-http-handler-connection-pooling-and-proxies`

Topic: `dotnet`

`HttpClient` delegates transport behavior to its primary handler. In modern .NET, the default primary handler used by `HttpClientFactory` is normally `SocketsHttpHandler`. Configure that actual handler explicitly for transport-specific behavior instead of assuming that every factory or target-framework version exposes the same effective handler shape:

```csharp
builder.Services
    .AddHttpClient("api")
    .ConfigurePrimaryHttpMessageHandler(() =>
        new SocketsHttpHandler
        {
            ConnectTimeout = TimeSpan.FromSeconds(5),
            PooledConnectionLifetime = TimeSpan.FromMinutes(10),
            PooledConnectionIdleTimeout = TimeSpan.FromMinutes(2),
            MaxConnectionsPerServer = 20,
        });
```

Older examples may construct the compatible `HttpClientHandler` shape:

```csharp
new HttpClientHandler
{
    UseCookies = false,
    AllowAutoRedirect = false,
    UseDefaultCredentials = false,
};
```

Properties that belong to the actual transport should be configured on the primary handler the application really installs.

## Proxy selection and credentials

`UseProxy = false` bypasses proxy resolution and is useful for known direct service traffic. With `UseProxy = true`, an explicit `Proxy` selects that proxy; when `Proxy` is null, system/default proxy configuration may apply:

```csharp
new SocketsHttpHandler
{
    UseProxy = true,
    Proxy = new WebProxy("http://proxy.example:8080"),
};
```

Credentials for the destination server and credentials for the default/system proxy are separate concerns. `DefaultProxyCredentials` authenticates to that proxy. Proxy auto-detection can also add latency, so disable proxy use when deployment policy requires direct connections.

## Connection and pool time boundaries

- `ConnectTimeout` limits connection establishment. It is not an overall request timeout.
- `PooledConnectionLifetime` replaces connections after a maximum age. Periodic replacement lets a long-lived client reconnect when DNS or service endpoints change.
- `PooledConnectionIdleTimeout` removes connections that have remained unused. Tune it against traffic shape, setup cost, and server idle policy.
- `MaxConnectionsPerServer` limits concurrent connections to a server endpoint; it is not a universal request-admission limit.

With HTTP/1.1, an active request commonly occupies one connection, so the connection limit can resemble a concurrency limit. HTTP/2 can multiplex many requests on one connection. An application-level concurrency gate and a connection-pool limit therefore solve different problems and may both be required.

## Configuration follows client ownership

A stateless direct-service client can disable cookies and proxies and periodically recycle pooled connections:

```csharp
new SocketsHttpHandler
{
    UseCookies = false,
    UseProxy = false,
    ConnectTimeout = TimeSpan.FromSeconds(5),
    PooledConnectionLifetime = TimeSpan.FromMinutes(5),
};
```

Other clients may deliberately require a proxy, one logical cookie session, Windows integrated credentials, or large-upload settings. Those are different ownership and failure models, not one universal handler preset.

## Forward proxies on outbound HttpClient transport

## S-020 — HttpClient primary-handler proxy is a forward proxy

**Known limits:** none

### Near-literal normalized transcript

```text
ASP.NET Core app -> forward proxy -> destination API
```

The ASP.NET Core application is acting as a client. `UseProxy` and `Proxy` belong on the primary HTTP message handler because that handler opens the outbound connection and the proxy affects that path.

### Study meaning

Proxy policy belongs to the outbound transport layer.

### Recall questions

1. What role does ASP.NET Core play?
2. Why is proxy configuration placed on the primary handler?
3. What path is affected?


---

## S-021 — Named HttpClient with explicit WebProxy

**Known limits:** none

### Near-literal normalized transcript

```csharp
using System.Net;

builder.Services.AddHttpClient("through-proxy")
    .ConfigurePrimaryHttpMessageHandler(() => new SocketsHttpHandler
    {
        UseProxy = true,
        Proxy = new WebProxy("http://proxy.company.local:8080")
    });
```

All requests from this named client go through the forward proxy.

### Study meaning

One named HttpClient receives an explicit proxy handler.

### Recall questions

1. What client name is used?
2. What handler type is configured?
3. What two properties enable proxying?
4. What proxy URI is used?


---

## S-032 — Forward proxy requires a running proxy server

**Known limits:** none

### Near-literal normalized transcript

A forward proxy is a real server that accepts outbound requests and forwards them.

In .NET, configure:

- `UseProxy = true`;
- `Proxy = new WebProxy(...)`;
- or the system/default proxy when `Proxy` is `null`.

```text
Your ASP.NET Core app -> forward proxy server -> target API
```

### Study meaning

`WebProxy` points to a proxy; it does not create one.

### Recall questions

1. Does WebProxy start a proxy server?
2. What two explicit properties are named?
3. What can be used when Proxy is null?


---

## S-033 — Explicit SocketsHttpHandler forward-proxy example

**Known limits:** none

### Near-literal normalized transcript

```csharp
using System.Net;

var handler = new SocketsHttpHandler
{
    UseProxy = true,
    Proxy = new WebProxy("http://proxy.company.local:8080")
};

var client = new HttpClient(handler);
```

If `Proxy` is not set explicitly, .NET may use a system/default proxy based on environment variables or OS proxy settings.

### Study meaning

Proxy behavior is attached to the handler used by the HttpClient.

### Recall questions

1. What proxy URI is configured?
2. What constructor argument creates the HttpClient?
3. What two sources can provide default proxy settings?

## Related knowledge

- `dotnet.sockets-http-handler-cookies-and-credentials`
- `dotnet.sockets-http-handler-response-upload-and-tls-options`

## What should be recallable

- Why should transport-specific settings be applied to the actual primary handler?
- How do `UseProxy`, `Proxy`, and `DefaultProxyCredentials` differ?
- Which phase does `ConnectTimeout` bound?
- Why can `PooledConnectionLifetime` help with DNS changes?
- How does idle timeout differ from maximum connection age?
- Why is `MaxConnectionsPerServer` not an application request limiter under HTTP/2?

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R04-httpclient-forward-proxy.md`, S-020, S-021, S-032, and S-033
- Original SVG: `_ai-conspects/proxy, server, vite dev server proxy/source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`)

- Workspace: `_ai-conspects/primary httphandler optoins, socket/`
- Authoritative processed source: `regions/R01R02R03R04R05-primary-httphandler-options-socket-corrected-final-v002.md`, sections 1, 6, 7, 10, 12, and related checklist claims
- Original SVG: `source/primary httphandler optoins, socket.svg`
