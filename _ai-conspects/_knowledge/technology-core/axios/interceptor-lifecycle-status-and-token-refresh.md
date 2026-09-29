# Axios interceptor lifecycle, status policy, and token refresh

Knowledge ID: `axios.interceptor-lifecycle-status-and-token-refresh`

Topic: `axios`

## Interceptors are registrations with a lifecycle

`interceptors.request.use` and `interceptors.response.use` install handlers and return numeric IDs. Retain those IDs whenever registration can happen more than once.

`eject(id)` removes the matching interceptor. Repeated registration without ejection can duplicate auth headers, logging, retries, or transformations. The source calls out tests, hot reload, and React StrictMode development behavior as common places where this appears.

Ejection prevents future executions; it does not cancel an interceptor that is already participating in an in-flight request.

## React and test ownership

When an interceptor depends on component-provided state, register it inside an effect and eject the captured ID during cleanup:

```ts
useEffect(() => {
  const id = api.interceptors.request.use(config => {
    config.headers.Authorization = `Bearer ${token}`;
    return config;
  });

  return () => api.interceptors.request.eject(id);
}, [token]);
```

Include relevant dependencies such as the current token. If component lifecycle is unnecessary, one stable application-owned interceptor is often simpler.

Tests should register in setup and eject in teardown rather than sharing interceptor state across unrelated cases. Assertions should inspect the effective request config rather than relying only on handler invocation counts.

## Request and response pipeline behavior

Request interceptors can attach bearer tokens, correlation IDs, locale or tenant headers, and structured request logging. They must return the config or a promise of the config; rejecting stops the request.

A response interceptor's fulfilled handler receives responses considered successful by `validateStatus`. Its rejected handler receives Axios errors and can map or retry them.

Return the response to preserve the success chain. If an error remains unhandled, use `return Promise.reject(error)` rather than swallowing it by returning `undefined`.

## `validateStatus` controls the response branch

By default, 2xx statuses resolve while most non-2xx statuses reject.

A custom policy such as:

```ts
status < 500
```

makes 4xx responses flow through the fulfilled branch. Interceptors do not independently reclassify HTTP success; they follow the promise outcome created by `validateStatus`.

The adapter first produces a response, `validateStatus` determines fulfilled versus rejected handling, and response interceptors follow that decision. Central error code therefore must be reviewed whenever the status policy changes.

## Central error handling

Network errors must be handled separately from errors that contain a server response. Read `error.response?.status` only when a response exists.

Preserve the original error cause and request config when diagnostics require them. Do not accidentally turn a rejected pipeline into a fulfilled `undefined` result.

## Refresh-token retry

A refresh flow should handle only the intended authentication status, commonly 401.

Mark the original request config with a private retry flag so the same request cannot enter an infinite refresh loop. Refresh through a separate client or endpoint that does not itself enter the same interceptor loop. After refresh, update the original Authorization header and resend the original config.

A representative flow is:

```ts
let refreshPromise: Promise<string> | null = null;

api.interceptors.response.use(
  response => response,
  async (error: AxiosError) => {
    const original = error.config as
      (InternalAxiosRequestConfig & { _retry?: boolean }) | undefined;

    if (error.response?.status !== 401 || !original || original._retry) {
      return Promise.reject(error);
    }

    original._retry = true;
    refreshPromise ??= refreshAccessToken().finally(() => {
      refreshPromise = null;
    });

    const token = await refreshPromise;
    original.headers.Authorization = `Bearer ${token}`;
    return api.request(original);
  }
);
```

## Concurrent 401s should share one refresh

Use one shared refresh promise so parallel failed requests wait for the same refresh operation.

- Clear the shared promise in `finally`.
- Store the new token before retrying waiting requests.
- If refresh fails, reject all waiting requests and perform the application's logout or session-expiry flow.

Refresh retry logic must not blindly replay non-idempotent operations when server processing may already have happened. Retries should preserve cancellation and avoid an interceptor loop on the refresh endpoint.

## What should be recallable

- What does `use` return, and why must the ID sometimes be retained?
- What does `eject` change, and what does it not change for an in-flight request?
- Why can React effects, hot reload, StrictMode, or tests create duplicate interceptor registrations?
- What must request interceptors return?
- How should fulfilled and rejected response handlers preserve the promise chain?
- How does `validateStatus` change which interceptor branch receives a response?
- Why must central error handling distinguish network failures from server responses?
- How does a private retry flag prevent an infinite refresh loop?
- Why should the refresh endpoint avoid the same interceptor loop?
- How does a shared refresh promise protect parallel 401 handling?
- Why are blind retries dangerous for non-idempotent operations?

## Related knowledge

- `axios.payload-transforms-and-interceptor-boundaries`
- `axios.adapters-progress-and-streaming`
- `axios.typed-client-boundaries`

## Sources

- Workspace: `_ai-conspects/axios/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, `validateStatus`/interceptor-routing material in R02 and R03 plus R05-R06
- Original SVG identity recorded by Stage0: `source/axios.svg` (not physically present under the workspace `source/` directory on the current branch)
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 request/response interceptors and single-flight 401 refresh/retry boundaries
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
