# Fetch RequestInit and Request browser controls

Knowledge ID: `javascript.fetch-requestinit-and-request-object`

Topic: `javascript`

`RequestInit` is configuration data; `Request` is a constructed request object. Fetch accepts either a URL plus init or a `Request`, and a second init can override corresponding settings from that request:

```ts
const init: RequestInit = {
  method: "GET",
  cache: "no-cache",
  credentials: "include",
};

const request = new Request("/api/items", init);

await fetch("/api/items", init);
await fetch(request);
```

A `Request` exposes the effective `url`, `method`, `headers`, `credentials`, `mode`, `cache`, `redirect`, `referrer`, `referrerPolicy`, `signal`, `body`, and `bodyUsed` state.

## Method, headers, and body

Common methods are GET, POST, PUT, PATCH, DELETE, HEAD, and OPTIONS. A request body is normal for mutation methods; browser Fetch does not support GET or HEAD bodies as an ordinary pattern.

Headers can be supplied as an object, pairs, or a `Headers` instance. Some request headers remain browser-controlled and cannot be set freely. JSON bodies require explicit serialization and a suitable content type:

```ts
await fetch("/api/items", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ name: "book" }),
});
```

Supported body shapes include strings, Blob, ArrayBuffer/typed arrays, FormData, URLSearchParams, and—where streaming upload is supported—a ReadableStream.

## Credentials and mode

Credentials policy is explicit:

```text
omit         -> never include credentials
same-origin  -> include only for same-origin requests
include      -> include for permitted cross-origin requests too
```

Cross-origin credentials still require compatible server CORS policy, and cookie rules such as `SameSite` and `Secure` still apply.

`mode: "cors"` is normal for a cross-origin API participating in CORS. `same-origin` rejects cross-origin use. `no-cors` can produce a restricted opaque response; it does not bypass CORS and normally prevents application code from reading useful status, headers, or body data.

## Browser cache mode

The Fetch `cache` option controls browser request-cache behavior; it is not a direct spelling of a `Cache-Control` header:

```text
default        normal browser HTTP-cache rules
no-store       neither use a stored response nor store this response
reload         bypass existing cache, fetch, then allow cache update
no-cache       revalidate before reusing a cached response
force-cache    prefer a cached response, including stale when permitted
only-if-cached require cache reuse under the browser's restrictions
```

`no-cache` does not mean “never store.” Browsers can automatically send validators such as `If-None-Match` or `If-Modified-Since`; a `304 Not Modified` lets the stored body be reused.

## Remaining transport controls

- `redirect` commonly uses `follow`, `error`, or `manual`; `follow` is the normal default.
- `signal` connects Fetch to `AbortSignal` cancellation.
- `integrity` asks the browser to compare received bytes with an expected cryptographic digest. The bytes must be received before the digest can be verified; mismatch rejects the fetch.
- `priority` is a relative scheduling hint, not a guarantee.
- `keepalive: true` allows a small request such as telemetry to continue briefly during page unload, subject to browser limits. It is not server connection-persistence configuration.
- a streaming request body may require `duplex: "half"`; ordinary strings, JSON, blobs, and forms do not.

## Referrer policy

`referrer` supplies the associated referrer where browser policy permits. `referrerPolicy` controls how much source URL information can be sent. Under the common `strict-origin-when-cross-origin` policy:

```text
same origin       -> origin, path, and query may be sent
cross origin      -> origin only
HTTPS to HTTP     -> omit referrer
```

The downgrade rule reduces leakage of paths and query strings to a less secure destination. Most applications leave the concrete referrer browser-managed and choose an explicit policy only for a real privacy or integration requirement.

## What should be recallable

- How `RequestInit`, `Request`, and a second init relate.
- Which methods, headers, and body representations Fetch supports.
- How credentials, CORS mode, and cookie policy compose.
- Why `no-cors` is not a CORS bypass.
- The distinctions among browser cache modes, especially `no-store` and `no-cache`.
- What redirect, signal, integrity, priority, keepalive, and duplex control—and what they do not guarantee.
- How `strict-origin-when-cross-origin` changes the referrer across origin and downgrade boundaries.

## Related knowledge

- `http.browser-header-controls-and-cors-visibility`
- `http.cache-validation-headers`
- `javascript.readable-stream-producers-backpressure-and-cancellation`

## Sources

- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed sources: `01-final-transcript.md` and identical regional transcript, R03–R04
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
