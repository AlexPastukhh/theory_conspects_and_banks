# Polly rate limiter strategies and partitions

Knowledge ID: `dotnet.polly-rate-limiter-strategies-and-partitions`

Topic: `dotnet`

## Rate limiting is lease acquisition

Polly's rate-limiter strategy integrates with `System.Threading.RateLimiting`. Before the protected callback runs, the strategy acquires a lease. Acquisition can succeed immediately, wait according to limiter/queue policy, or fail; the outcome is not merely a boolean counter check.

The underlying limiter can be a concurrency, fixed-window, sliding-window, token-bucket, or custom implementation. Each has its own replenishment and queue semantics; wrapping it in a Polly strategy does not erase those semantics.

## Partition by the resource whose quota is independent

`RateLimitPartition<TKey>` selects a limiter from a key such as tenant, API key, host, endpoint class, or operation type:

```text
request/context metadata
-> partition key
-> limiter for that key
-> acquire lease
-> run or reject/wait
```

Partitioning lets different tenants/resources receive separate limiter behavior instead of all requests sharing one global bucket. The selected key therefore defines the isolation boundary.

Conditional limiting can select a limiter, a no-op/unlimited partition, or another pipeline before execution. Tests should verify both selection and acquisition outcomes, not only that the callback eventually ran.

## What should be recallable

- What a rate-limit lease represents.
- Why the underlying limiter type still determines queue/replenishment behavior.
- Which domain boundary should become a partition key.
- How the partition key defines the isolation boundary.
- How conditional rate limiting can be driven by request/context metadata.

## Sources

- Workspace: `_ai-conspects/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling/`
- Authoritative processed source: `regions/R03-pipeline-execute-provider-ratelimiter-partitions.md`, rate limiter, partition, conditional selection, and testing portions
- Original SVG: `source/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling.svg`
