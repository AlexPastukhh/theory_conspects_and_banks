# Fetch response contract and wrapper policy

Knowledge ID: `javascript.fetch-response-contract-and-wrapper-policy`

Topic: `javascript`

Browser `fetch` is a low-level HTTP primitive. It resolves to a `Response` when response headers are available; the body may still be arriving. Unlike Axios' default status policy, an HTTP `404` or `500` normally still fulfills the Fetch promise. Fetch rejects mainly for network-level failures, cancellation, and policy failures, so application code must classify HTTP status explicitly:

```text
Fetch                           Axios
browser-native primitive        library wrapper
explicit response.json()        commonly exposes parsed JSON as response.data
4xx/5xx normally fulfill        non-2xx rejects by default
wrapper supplies shared policy  baseURL/params/interceptors/timeout are built in
response.body is accessible     progress/streaming depend on platform and adapter
```

```ts
const response = await fetch("/users");

if (!response.ok) {
  throw new Error(
    `HTTP ${response.status}: ${await response.text()}`
  );
}

const users = await response.json() as User[];
```

`response.json()`, `text()`, and `blob()` consume and materialize their corresponding whole-body representation. Use `response.body` when progressive processing is required.

## A wrapper supplies application policy

Fetch has no built-in base URL or interceptor pipeline. Ordinary application code can provide shared addressing, headers, credentials, parsing, and error normalization while preserving an escape hatch to the original `Response`:

```ts
const BASE_URL = "https://api.example.com";

async function apiFetch(path: string, init: RequestInit = {}) {
  const headers = new Headers(init.headers);

  if (token) {
    headers.set("Authorization", `Bearer ${token}`);
  }

  return fetch(`${BASE_URL}${path}`, {
    ...init,
    headers,
    credentials: "include",
  });
}

async function apiFetchJson<T>(path: string, init?: RequestInit) {
  const response = await apiFetch(path, init);
  if (!response.ok) {
    throw new Error(`HTTP ${response.status}: ${await response.text()}`);
  }
  return response.json() as Promise<T>;
}
```

A production wrapper can parse problem details, attach correlation metadata, and offer JSON/text/blob helpers. It should not hide the raw response needed for streaming, headers, downloads, status-specific behavior, or non-JSON content.

Fetch query parameters are built with URL APIs:

```ts
const params = new URLSearchParams({ term: "router", page: "2" });
const response = await apiFetch(`/search?${params}`);
```

Arrays and nested objects still require a client/server convention such as repeated keys, bracket notation, comma-separated values, or a custom serializer.

## Refresh, cancellation, and timeout ownership

A 401 refresh flow needs one shared in-flight refresh promise, a per-request retry guard, a new Authorization value on retry, and a defined failure/logout outcome. Parallel 401 responses should wait for the same refresh instead of starting a refresh storm. Fetch and Axios differ in where this logic lives—a wrapper versus commonly an interceptor—but the concurrency and replay boundaries are the same.

Fetch accepts `AbortSignal` but has no standalone `timeout` option. A wrapper can combine `AbortController` with a timer and must always clear that timer:

```ts
async function fetchWithTimeout(
  input: RequestInfo | URL,
  timeoutMs: number,
  init: RequestInit = {},
) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);

  try {
    return await fetch(input, { ...init, signal: controller.signal });
  } finally {
    clearTimeout(timer);
  }
}
```

If the caller already supplies a signal, compose or deliberately propagate both cancellation sources rather than silently replacing one.

## Progress, files, and runtime data

Download progress can be calculated while reading `response.body` chunks. `response.blob()` is convenient when full Blob materialization is acceptable. Classic Fetch upload progress is less direct; depending on runtime support and compatibility needs, use a streaming request body, XHR, or another transport.

Type assertions such as `await response.json() as User` do not validate untrusted JSON. Use a runtime schema validator when the server response shape must be enforced.

## What should be recallable

- Why Fetch fulfills for ordinary HTTP error statuses and where status policy belongs.
- Which response helpers materialize a whole representation and when `response.body` is needed.
- What policy belongs in a Fetch wrapper and why the raw `Response` must remain accessible.
- How Fetch and Axios differ in built-in conveniences without changing refresh concurrency rules.
- How timeout-driven abort composes with caller cancellation.
- Why TypeScript assertions do not validate runtime response data.

## Sources

- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed sources: `01-final-transcript.md` and identical regional transcript, R01; R02 response-completion/full-body boundaries; R04 production-wrapper checklist
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
