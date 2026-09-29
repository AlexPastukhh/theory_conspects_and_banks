# YARP routes, clusters, and destinations

Knowledge ID: `aspnet-core.yarp-routes-clusters-and-destinations`

Topic: `aspnet-core`

## S-022 — YARP as the minimal ASP.NET Core reverse proxy

**Known limits:** none

### Near-literal normalized transcript

The simplest reverse-proxy implementation in ASP.NET Core is YARP.

Minimal setup:

- add the YARP package;
- call `AddReverseProxy()`;
- load routes and clusters from configuration;
- call `MapReverseProxy()`.

### Study meaning

YARP turns an ASP.NET Core application into the proxy process.

### Recall questions

1. What library is used?
2. Which setup calls are named?
3. Do proxied routes require manual forwarding controllers?

## S-023 — Minimal YARP Program.cs

**Known limits:** none

### Near-literal normalized transcript

```csharp
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddReverseProxy()
    .LoadFromConfig(builder.Configuration.GetSection("ReverseProxy"));

var app = builder.Build();

app.MapReverseProxy();

app.Run();
```

### Study meaning

Service registration loads configuration; endpoint mapping activates proxy routes.

### Recall questions

1. What configuration section is loaded?
2. What maps the proxy endpoints?
3. What starts the app?

## S-024 — YARP route, cluster, and destination JSON

**Known limits:** none

### Near-literal normalized transcript

```json
{
  "ReverseProxy": {
    "Routes": {
      "api-route": {
        "ClusterId": "backend",
        "Match": {
          "Path": "/api/{**catch-all}"
        }
      }
    },
    "Clusters": {
      "backend": {
        "Destinations": {
          "d1": {
            "Address": "https://localhost:7143/"
          }
        }
      }
    }
  }
}
```

### Study meaning

A route matches the incoming path and selects a cluster; the cluster contains a backend destination.

### Recall questions

1. What path pattern is matched?
2. What cluster is selected?
3. What destination ID and address are shown?
4. What does the catch-all capture?

## What should be recallable

- Which service-registration and endpoint-mapping calls activate YARP?
- How does an incoming route select a cluster and backend destination?
- What does the catch-all path example forward?

## Related knowledge

- `architecture.forward-and-reverse-proxy-roles`
- `architecture.reverse-proxy-central-routing-and-policy`

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R05-yarp-and-forwarded-headers.md`, S-022–S-024
- Original SVG: `source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`).
