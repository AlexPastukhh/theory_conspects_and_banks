# Reverse-proxy central routing and policy

Knowledge ID: `architecture.reverse-proxy-central-routing-and-policy`

Topic: `architecture`

## S-031 — Do you need a separate reverse-proxy application?

**Known limits:** none

### Near-literal normalized transcript

Usually, yes. A reverse proxy is typically a separate server/application in front of the ASP.NET Core backend.

With YARP, create an ASP.NET Core application, add YARP, configure routes/clusters, and call `MapReverseProxy()`.

```text
Browser -> reverse proxy app -> backend app
```

Examples:

- YARP;
- Nginx;
- IIS;
- Apache;
- cloud load balancers;
- CDNs.

YARP is the .NET option for building the proxy yourself; existing infrastructure can be used instead.

### Study meaning

A reverse proxy must run as a reachable process, but it does not need to be custom code.

### Recall questions

1. Write the architecture.
2. Name six proxy products/services.
3. When is YARP useful?
4. Can Nginx or IIS be used instead?

## S-046 — Centralizing cross-cutting concerns

**Known limits:** none

### Near-literal normalized transcript

With several services, a reverse proxy can centralize:

- TLS certificates;
- public hostnames and port bindings;
- authentication or authorization policy at the edge;
- request routing;
- compression and caching;
- rate limiting, access control, and header transforms.

### Study meaning

The proxy can be a shared policy and traffic-management layer.

### Recall questions

1. Name six centralized concerns.
2. Which affect security?
3. Which affect traffic shape?

## S-047 — Configure shared edge concerns once

**Known limits:** none

### Near-literal normalized transcript

Instead of configuring inside every service:

- certificate binding;
- public host;
- path routing;
- shared security policy;

configure much of it once in the reverse-proxy layer.

### Study meaning

Centralization reduces duplicated infrastructure configuration.

### Recall questions

1. What four settings are listed?
2. Where are they centralized?
3. Why may service-specific authorization still remain in services?

## S-048 — Practical multi-service public routing example

**Known limits:** none

### Near-literal normalized transcript

```text
Public Internet
  -> proxy on api.example.com
      -> /users/*   -> Users service
      -> /orders/*  -> Orders service
      -> /catalog/* -> Catalog service
```

Internal addresses:

```text
http://users-service:5001
http://orders-service:5002
http://catalog-service:5003
```

Only the proxy is public.

### Study meaning

Public paths remain stable while service names and ports remain private.

### Recall questions

1. What public host is shown?
2. Map each path to a service.
3. List the three internal addresses.
4. Which component is public?

## S-049 — What central routing can match

**Known limits:** none

### Near-literal normalized transcript

The reverse proxy chooses a backend based on:

- host name;
- path;
- sometimes headers or other match rules.

YARP routes match incoming requests and send them to a selected cluster and destination.

### Study meaning

Routing is request classification plus destination selection.

### Recall questions

1. What three match inputs are named?
2. What YARP object is selected?
3. What is the difference between cluster and destination?

## S-050 — Host-based routing

**Known limits:** none

### Near-literal normalized transcript

```text
api.example.com   -> API backend
admin.example.com -> Admin backend
shop.example.com  -> Shop backend
```

The client sees public domains; the proxy maps each host to the correct backend.

### Study meaning

Host routing separates public applications by hostname.

### Recall questions

1. Map the three hostnames.
2. Who performs the mapping?
3. What does the client see?

## S-051 — Path-based routing

**Known limits:** none

### Near-literal normalized transcript

```text
example.com/api/*     -> ASP.NET Core API
example.com/images/*  -> image service
example.com/reports/* -> reporting service
```

The proxy acts as a traffic director and chooses where to send each request.

### Study meaning

One public domain can represent several services.

### Recall questions

1. Map the three paths.
2. What decision does the proxy make?
3. How does path routing differ from host routing?

## S-052 — Why central routing is useful

**Known limits:** none

### Near-literal normalized transcript

Without central routing, clients need to know multiple internal backend URLs.

With a reverse proxy:

- clients use one public entry point;
- the proxy hides internal topology;
- backends can move or split without changing the public API shape as much.

### Study meaning

A stable public contract reduces coupling to infrastructure.

### Recall questions

1. What problem exists without central routing?
2. Name the three benefits.
3. What backend changes can remain hidden?

## What should be recallable

- Why is a reverse proxy normally a separate reachable process?
- Which edge concerns can be centralized without erasing service-specific policy?
- How do host/path/header matching, clusters, and destinations route traffic?
- Why does one stable public entry point reduce coupling to backend topology?

## Related knowledge

- `aspnet-core.yarp-routes-clusters-and-destinations`
- `architecture.reverse-proxy-edge-tls-isolation-and-offload`

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R05-yarp-and-forwarded-headers.md`, S-031; `regions-v003/R07-central-infrastructure-and-routing.md`, S-046–S-052
- Original SVG: `source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`).
