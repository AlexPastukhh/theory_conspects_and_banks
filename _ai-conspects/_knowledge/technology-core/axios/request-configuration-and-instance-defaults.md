# Axios request configuration and instance defaults

Knowledge ID: `axios.request-configuration-and-instance-defaults`

Topic: `axios`

## The request is built from configuration layers

Axios builds a request from a configuration object. Instance defaults, method helpers, and per-request options are merged into the final config that reaches the selected adapter.

A dedicated instance is the normal place for shared transport policy:

```ts
const api = axios.create({
  baseURL: "https://api.example.com",
  timeout: 5_000,
  headers: { Accept: "application/json" }
});

const response = await api.get<User[]>("/users", {
  params: { page: 2, limit: 20 },
  signal: controller.signal
});
```

Using instance defaults reduces duplication and avoids mutating global `axios.defaults` across unrelated APIs.

## Address and method

- `url` identifies the resource unless a wrapper method supplies it.
- `method` defaults to GET.
- Helpers such as `axios.get` and `axios.post` are convenience wrappers around request configuration.
- `baseURL` is prepended to relative URLs and fits naturally on a dedicated instance.
- `allowAbsoluteUrls` controls whether an absolute request URL can replace the configured base URL.

## Headers, authentication, credentials, and XSRF

`headers` carries request headers such as Accept, Content-Type, correlation IDs, or Authorization.

The `auth` option is specifically for HTTP Basic authentication. It sets the Authorization header and can overwrite a custom Authorization value. Bearer tokens therefore belong in `headers` or in a request interceptor rather than in `auth`.

In browser requests, `withCredentials` enables cross-site cookies or credentials only when the server's CORS policy also permits them. A browser CORS failure is a security-policy failure, not an ordinary Axios response error returned by the server.

For browser XSRF integration, `xsrfCookieName` and `xsrfHeaderName` configure the cookie-to-header names Axios uses.

## Query values and request bodies

`params` represents URL query values; it is not the request body. `paramsSerializer` controls how arrays, nested objects, and backend-specific query formats become the query string.

`data` is the request body for body-bearing methods such as POST, PUT, PATCH, and DELETE. Ordinary JavaScript objects are serialized as JSON unless the body type or headers require another representation.

## Timing, response representation, and cancellation

- `timeout` aborts the Axios request after the configured duration; `0` means no Axios timeout.
- `responseType` selects a representation such as `json`, `text`, `blob`, or `arraybuffer`.
- `signal` is the modern AbortController-based cancellation mechanism.
- Transport configuration should describe transport concerns; domain validation still belongs at an application boundary.

## What should be recallable

- How do instance defaults, helpers, and per-request options contribute to the final Axios config?
- Why is `axios.create` preferable to mutating global defaults for unrelated APIs?
- What are the roles of `url`, `method`, `baseURL`, and `allowAbsoluteUrls`?
- Why is `auth` different from a bearer Authorization header?
- What does `withCredentials` require from browser CORS policy?
- What is the difference between `params` and `data`?
- What do `timeout`, `responseType`, and `signal` control?
- What do `xsrfCookieName` and `xsrfHeaderName` configure?
- Why should domain validation not be treated as transport configuration?

## Related knowledge

- `axios.files-and-query-serialization`
- `axios.payload-transforms-and-interceptor-boundaries`
- `axios.adapters-progress-and-streaming`
- `axios.interceptor-lifecycle-status-and-token-refresh`

## Sources

- Workspace: `_ai-conspects/axios/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R01 and the XSRF option notes in R02
- Original SVG identity recorded by Stage0: `source/axios.svg` (not physically present under the workspace `source/` directory on the current branch)
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 Axios/Fetch comparison, base URL, query, headers, timeout, cancellation, and representation claims
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
