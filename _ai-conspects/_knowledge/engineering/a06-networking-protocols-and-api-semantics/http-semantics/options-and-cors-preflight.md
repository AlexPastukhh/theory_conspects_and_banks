# OPTIONS and browser CORS preflight

Knowledge ID: `http.options-and-cors-preflight`

Topic: `http`

## Core model

`OPTIONS` asks which communication options are available for a resource. A client can send it explicitly, and a browser uses it automatically for a CORS preflight when a cross-origin request is not a CORS simple request.

Typical preflight triggers include non-simple methods such as `PUT`, `PATCH`, or `DELETE`, non-safelisted request headers such as `Authorization` or custom `X-...` fields, and non-safelisted `Content-Type` values such as `application/json`.

```http
OPTIONS /api/orders/42 HTTP/1.1
Origin: https://app.example
Access-Control-Request-Method: PATCH
Access-Control-Request-Headers: content-type, if-match
```

The response states the cross-origin policy the browser should apply:

```http
HTTP/1.1 204 No Content
Access-Control-Allow-Origin: https://app.example
Access-Control-Allow-Methods: GET, PATCH, OPTIONS
Access-Control-Allow-Headers: content-type, if-match
Access-Control-Max-Age: 600
Vary: Origin
```

The browser evaluates this response before sending the actual request. A failed required preflight prevents that non-simple request; failure while reading an actual response is different because the server may already have processed the request. Fetch commonly exposes either case as a rejected promise with a network-style `TypeError`, not as a normal application `4xx`/`5xx` response that script can inspect.

`Access-Control-Max-Age` lets the browser reuse a successful preflight decision for a limited time. Treat that cache as constrained by the browser, origin, method, and requested-header shape rather than as a global permission cache.

## OPTIONS capability versus CORS permission

A normal, non-CORS `OPTIONS` response can advertise supported methods:

```http
Allow: GET, HEAD, POST, OPTIONS
```

`Allow` describes method support. `Access-Control-Allow-Methods` participates in browser cross-origin authorization. They are related but do not answer the same question.

## What should be recallable

- What does the `OPTIONS` method ask a resource?
- When does a browser generate a CORS preflight?
- What do `Access-Control-Request-Method` and `Access-Control-Request-Headers` describe?
- What must the browser learn from the preflight response before sending the actual request?
- How do `Allow` and `Access-Control-Allow-Methods` differ?

## Related knowledge

- `http.browser-header-controls-and-cors-visibility` — which response headers cross-origin JavaScript may read after a request.
- `http.vary-origin-cache-variants` — how origin-dependent CORS responses interact with shared caches.

## Sources

- Workspace: `_ai-conspects/options requ/`
- Processed source: `01-final-transcript.md`, R01 — OPTIONS and CORS preflight
- Original SVG: `source/options requ.svg`
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R01R02-origin-preflight-aspnet-usecases.md` and `regions/R03R04R05-policy-builder-headers-middleware.md`, R01, R04 and R05
- Original SVG: `source/CORS.svg`
