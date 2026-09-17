# Rate-limit responses and Retry-After

Knowledge ID: `http.rate-limit-responses-and-retry-after`

Topic: `http`

`429 Too Many Requests` is the normal HTTP response when a request exceeds an applicable limit. A lock response can use another status such as `423 Locked`, but `429` is normally clearer for temporary retry behavior. `Retry-After` is advisory scheduling metadata, not enforcement: a client may ignore it, clocks and queues move, and another limiter may still reject the later request.

The header can carry a delay in seconds or an HTTP date. Server implementations should derive it from limiter metadata when available and omit it or use an intentional fallback when it is not. A concurrency limiter, for example, cannot always predict when a permit will be released.

In ASP.NET Core, `RateLimitLease.IsAcquired` always tells whether the lease succeeded. Limiter-specific values such as `RetryAfter`, remaining permits, configured limit/reset time, or rejection reason are optional metadata. Use `TryGetMetadata`; the rejection path must work even when no value exists. `OnRejected` can copy metadata to the response and format its status/header/body, but it does not create or enforce a policy.

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R01
- Original SVG: `source/source-complete-v002.svg`
