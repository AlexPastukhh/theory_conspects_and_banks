# Reverse-proxy edge TLS, isolation, and offload

Knowledge ID: `architecture.reverse-proxy-edge-tls-isolation-and-offload`

Topic: `architecture`

## S-034 — Load balancing as a reverse-proxy benefit

**Known limits:** none

### Near-literal normalized transcript

Load balancing distributes incoming traffic across multiple backend servers so one instance is not overloaded.

It improves performance and reliability.

It matters when multiple instances are needed for availability or load. It matters less with one small internal instance and no scaling requirement.

### Study meaning

Load balancing needs multiple viable destinations or failover capacity to provide value.

### Recall questions

1. What does load balancing distribute?
2. What two qualities can improve?
3. When does it matter less?

## S-035 — TLS termination at the edge

**Known limits:** none

### Near-literal normalized transcript

TLS termination means the reverse proxy handles HTTPS handshake and decryption at the edge.

Example:

- Nginx listens on `443`;
- presents the public certificate;
- decrypts traffic;
- forwards HTTP or re-encrypted HTTPS to Kestrel on an internal port.

Without correct forwarded headers, the application may think the request was HTTP and generate wrong redirects.

### Study meaning

The proxy becomes the public TLS endpoint and must preserve original scheme information.

### Recall questions

1. What public port is shown?
2. What TLS tasks does the proxy perform?
3. Why can redirects become wrong?

## S-036 — Protecting backends from direct internet exposure

**Known limits:** none

### Near-literal normalized transcript

Only Nginx or IIS may have a public IP.

Kestrel can listen on `localhost` or a private subnet and be unreachable directly from the internet.

This reduces exposed surface area and centralizes public-edge hardening.

### Study meaning

Backends stay private while the edge owns public exposure.

### Recall questions

1. Which components receive the public IP?
2. Where can Kestrel listen?
3. What security benefit follows?

## S-037 — Central host and path routing examples

**Known limits:** none

### Near-literal normalized transcript

A reverse proxy can route by host, path, or headers.

Examples:

- `api.example.com` -> ASP.NET Core API;
- `admin.example.com` -> admin application;
- `/images/*` -> static/image service;
- `/api/*` -> ASP.NET Core;
- `/reports/*` -> reporting service.

This provides one public entry point for several backends.

### Study meaning

Public routing rules hide backend topology.

### Recall questions

1. Name the host-based examples.
2. Name the path-based examples.
3. What one-entry-point benefit is stated?

## S-038 — Compression, caching, and edge optimization

**Known limits:** none

### Near-literal normalized transcript

A reverse proxy can offload work before a request reaches the application:

- serving static assets;
- compressing responses;
- caching public responses;
- terminating TLS at the edge.

Edge optimization means doing work at the outer edge of deployment, close to clients, rather than inside every backend instance.

### Study meaning

Offload centralizes repeated shared work.

### Recall questions

1. Name four edge tasks.
2. What does edge mean?
3. Can ASP.NET Core also compress responses itself?

## S-039 — When a reverse proxy is or is not needed

**Known limits:** none

### Near-literal normalized transcript

A proxy may be unnecessary when:

- there is one small internal app;
- there is no multi-app routing;
- there is no edge caching need;
- Kestrel and ASP.NET Core middleware are enough.

It becomes more useful with:

- many backends behind one domain;
- public internet traffic;
- heavy static/public traffic;
- multiple app instances;
- centralized TLS, compression, and caching.

### Study meaning

A reverse proxy is a trade-off, not a requirement for every deployment.

### Recall questions

1. List four cases where it may be unnecessary.
2. List five cases where it becomes useful.
3. Why can direct Kestrel be sufficient?

## S-040 — Easier infrastructure management

**Known limits:** none

### Near-literal normalized transcript

The “one front door” benefit centralizes:

- certificates;
- host bindings;
- routing rules;
- external exposure.

Examples:

- renew one public TLS setup;
- expose one domain while moving/scaling backends;
- move `/api` from one server to a cluster without changing client URLs;
- keep backends private while the proxy remains public.

### Study meaning

Public configuration becomes independent from backend placement.

### Recall questions

1. What four concerns are centralized?
2. How can `/api` move without changing clients?
3. What remains public?

## S-041 — Without a reverse proxy

**Known limits:** none

### Near-literal normalized transcript

```text
Browser --HTTPS--> Kestrel/ASP.NET Core
```

- Kestrel owns public port `443`;
- Kestrel has the certificate;
- Kestrel performs TLS handshake and decryption;
- the application receives HTTPS directly.

This is simpler and fine for local development, small internal apps, and simple one-server deployments with no special edge needs.

### Study meaning

Direct HTTPS is a valid design when centralized edge features are unnecessary.

### Recall questions

1. Who owns port 443?
2. Who stores the certificate?
3. Name three suitable situations.

## S-042 — With a reverse proxy

**Known limits:** none

### Near-literal normalized transcript

```text
Browser --HTTPS--> Reverse proxy --HTTP or HTTPS--> Kestrel/ASP.NET Core
```

- the reverse proxy owns the public certificate and `443`;
- performs the TLS handshake;
- decrypts the request;
- forwards to Kestrel;
- if the internal hop is HTTP, forwarded headers are needed so the app still knows the original scheme was HTTPS.

### Study meaning

The internal scheme can differ from the client-facing scheme.

### Recall questions

1. Write the common flow.
2. Who owns the public certificate?
3. What misunderstanding occurs without forwarded headers?

## S-043 — Exact benefits in the TLS scenario

**Known limits:** none

### Near-literal normalized transcript

Main benefits:

- one front door handles certificates for many backend apps;
- backends stay on private/internal ports or networks;
- TLS work is centralized at the edge;
- backend instances can be swapped, scaled, or moved without changing the public endpoint.

### Study meaning

Even one backend can benefit; the value grows with more backends.

### Recall questions

1. Name the four benefits.
2. Which apply with one backend?
3. Which decouples public URL from backend placement?

## S-044 — Reverse-proxy resource offload

**Known limits:** none

### Near-literal normalized transcript

A reverse proxy can use its own CPU and memory for:

- response compression;
- caching public responses;
- serving static files;
- TLS termination.

Backend application instances then do less of that work.

### Study meaning

Offload moves shared edge work away from each application instance.

### Recall questions

1. Which four tasks are offloaded?
2. What backend resources are saved?
3. Why is public-response caching suitable at the edge?

## S-045 — Meaning of edge optimizations

**Known limits:** none

### Near-literal normalized transcript

Edge optimizations do work close to the client before requests hit application instances.

Examples:

- compress a public JSON response at the proxy;
- cache a public product page at proxy/CDN;
- terminate TLS at the proxy;
- serve static images, CSS, or JavaScript from the proxy layer.

### Study meaning

The edge is a client-nearest proxy/CDN/load-balancer layer.

### Recall questions

1. Define edge optimization.
2. Name four examples.
3. Which can avoid a backend request entirely?

## S-053 — Benefits with one backend

**Known limits:** none

### Near-literal normalized transcript

Even with one backend:

1. Certificate management can stay at the proxy layer.
2. The backend can listen only on loopback or a private subnet.
3. The proxy can perform TLS handshake and decryption.
4. The proxy provides one stable public edge for future backend instances or services.

### Study meaning

Microservices are not required for central TLS, backend isolation, offload, or a stable edge.

### Recall questions

1. Name the four benefits.
2. Which is primarily security-related?
3. Which prepares for future growth?

## S-054 — TLS termination is not only for microservices

**Known limits:** none

### Near-literal normalized transcript

No.

- with one backend, TLS termination is useful for certificate centralization, backend isolation, and offload;
- with many backends or microservices, infrastructure-management value becomes larger because certificates and policies do not need per-service configuration.

Microservices increase the value but are not required.

### Study meaning

TLS termination solves an edge-management problem rather than a specifically microservice problem.

### Recall questions

1. Does TLS termination require microservices?
2. Which benefits apply with one backend?
3. Why does value grow with many services?

## What should be recallable

- When do load balancing and a reverse proxy add value, and when is direct Kestrel sufficient?
- How do TLS termination, forwarded scheme, backend isolation, and a stable public endpoint interact?
- Which compression, caching, static-file, and TLS work can move to the edge?
- Why do these benefits apply even with one backend?

## Related knowledge

- `architecture.forward-and-reverse-proxy-roles`
- `architecture.reverse-proxy-central-routing-and-policy`
- `aspnet-core.forwarded-headers-and-client-ip-trust`

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R06-reverse-proxy-benefits-tls-offload-and-isolation.md`, S-034–S-045 and S-053–S-054
- Original SVG: `source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`).
