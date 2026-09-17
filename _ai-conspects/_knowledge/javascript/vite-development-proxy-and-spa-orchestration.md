# Vite development proxy and ASP.NET SPA orchestration

Knowledge ID: `javascript.vite-development-proxy-and-spa-orchestration`

Topic: `javascript`

## S-001 — Vite dev proxy: same-origin browser request and server-to-server forwarding

**Known limits:** none

### Near-literal normalized transcript

More precisely:

- the frontend application is loaded from the frontend development-server origin;
- when React code executes `fetch("/api/...")`, the browser sends that request to the same frontend origin;
- the frontend development server receives the request and, for configured proxy paths, forwards it to the ASP.NET Core backend;
- that forwarding step is server-to-server, so browser CORS rules are no longer involved in that second hop.

### Study meaning

The browser sees a same-origin request to Vite. Vite becomes the HTTP client for the backend hop.

### Recall questions

1. Which origin receives the browser's initial `/api/...` request?
2. Which component forwards the request to ASP.NET Core?
3. Why do browser CORS rules not apply to the Vite-to-backend hop?

## S-002 — Vite forwarding flow and the browser's role

**Known limits:** none

### Near-literal normalized transcript

That forwarding step is server-to-server, so the browser's CORS rules are no longer involved in that hop.

```text
Browser
  -> frontend dev-server origin (/api/...)
  -> frontend dev-server proxy
  -> ASP.NET Core backend
  -> frontend dev server
  -> browser
```

Important nuance:

> The browser is involved in the first request to the frontend dev server, but it is not involved in the forwarding from the dev server to the backend.

### Study meaning

The proxy changes who performs the cross-origin backend request: the development server, not browser JavaScript.

### Recall questions

1. Write the complete request/response flow.
2. At which hop does the browser stop participating?
3. Who receives the backend response before the browser?

## S-003 — Vite proxy versus direct cross-origin request

**Known limits:** none

### Near-literal normalized transcript

That is why the Vite development proxy avoids CORS.

Without proxy:

```text
Browser JS -> backend origin directly
```

The browser sees a different origin, so CORS applies.

With proxy:

```text
Browser JS -> frontend origin
frontend server -> backend origin
```

The browser sees a same-origin request, so there is no browser CORS problem for the first hop.

### Study meaning

The proxy does not disable CORS on the backend; it avoids a browser cross-origin request by introducing a same-origin entry point.

### Recall questions

1. What request shape triggers browser CORS enforcement?
2. What request shape does the Vite proxy present to the browser?
3. Does the proxy remove cross-origin networking or move it server-side?

## S-004 — Why SpaProxyServerUrl exists

**Known limits:** none

### Near-literal normalized transcript

Question shown:

> Why do we need to add `SpaProxyServerUrl` in the ASP.NET Core project?

### Study meaning

This introduces the configuration question answered by S-005 and S-006.

### Recall questions

1. What configuration property is being questioned?
2. Which project contains this setting?

## S-005 — SpaProxyServerUrl identifies the frontend development server

**Known limits:** none

### Near-literal normalized transcript

`SpaProxyServerUrl` tells the ASP.NET Core backend project where the frontend development server is expected to be running in development.

### Study meaning

It is local-development orchestration metadata, not the Vite proxy route table itself.

### Recall questions

1. What server URL does SpaProxyServerUrl describe?
2. Is it a production reverse-proxy route definition?

## S-006 — What ASP.NET Core uses SpaProxyServerUrl for

**Known limits:** none

### Near-literal normalized transcript

`SpaProxyServerUrl` exists in the backend project because the backend coordinates the local development experience. It needs to know:

- which frontend URL to probe, such as `https://localhost:5173`;
- where to redirect the browser;
- which development server it should expect or start in development.

### Study meaning

The .NET workflow can wait for or redirect to Vite using this URL. Vite's own `server.proxy` still controls `/api` forwarding.

### Recall questions

1. What example frontend URL is shown?
2. What three coordination tasks use SpaProxyServerUrl?
3. Which Vite setting separately controls API forwarding?

## S-007 — What “frontend dev server forwards fetch calls” means

**Known limits:** none

### Near-literal normalized transcript

When a React project uses Vite, the frontend development server is usually the Vite dev server.

So this statement:

> the frontend dev server accepts `fetch("/api/...")` calls and forwards them to ASP.NET Core

means:

> Vite receives that request on the frontend origin and proxies it to the ASP.NET Core backend, when `server.proxy` is configured.

### Study meaning

The frontend server is the Vite process listening on the frontend origin, not React code itself.

### Recall questions

1. What process normally acts as the frontend dev server?
2. What must be configured for `/api` forwarding?
3. Does React itself forward the request?

## What should be recallable

- Which origin receives a browser `/api` request and which process performs the backend hop?
- Why does the Vite proxy avoid a browser CORS request without disabling backend CORS?
- How do `SpaProxyServerUrl` and Vite `server.proxy` solve different development concerns?

## Related knowledge

- `aspnet-core.cors-middleware-preflight`

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R01-vite-development-proxy-spaproxyserverurl-and-cors.md`, S-001–S-007
- Original SVG: `source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`).
