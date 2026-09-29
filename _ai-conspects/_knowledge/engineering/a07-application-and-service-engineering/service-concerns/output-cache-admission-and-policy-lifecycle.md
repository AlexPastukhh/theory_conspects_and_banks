# Output Cache admission and policy lifecycle

Knowledge ID: `aspnet-core.output-cache-admission-and-policy-lifecycle`

Topic: `aspnet-core`

## Callback order and available facts

An `IOutputCachePolicy` participates in three stages:

```csharp
ValueTask CacheRequestAsync(OutputCacheContext context, CancellationToken token);
ValueTask ServeFromCacheAsync(OutputCacheContext context, CancellationToken token);
ValueTask ServeResponseAsync(OutputCacheContext context, CancellationToken token);
```

1. `CacheRequestAsync` runs before lookup and knows request facts such as method, auth, headers, and path. Set initial enablement, lookup/storage/locking permissions, variation, tags, and default expiration here.
2. If lookup is allowed and a candidate exists, `ServeFromCacheAsync` decides whether that hit is acceptable. An administrator or an explicit `no-cache`/`max-age=0` request can force a fresh path. The callback does not run on a miss, disabled lookup, or fully disabled output caching.
3. If the endpoint produces a fresh response, `ServeResponseAsync` sees status, headers, body metadata, and `Set-Cookie` before the final storage decision.

General lookup rejection cannot wait for the hit callback: setting `AllowCacheLookup=false` before lookup means there is no candidate and therefore no hit callback.

## Read/write combinations

```text
lookup yes, storage yes -> normal read-through/write-through
lookup yes, storage no  -> reuse old entry, do not write replacement
lookup no, storage yes  -> bypass old entry, generate and store fresh
disabled                -> neither lookup nor storage
```

“Force fresh” means reject/bypass a candidate and separately choose whether/how long to store the replacement. Rejecting a hit does not define replacement expiration.

## Response-aware safety

A custom policy replacing defaults must restore the defenses it needs. Final admission commonly rejects 4xx/5xx, `Set-Cookie`, personalized/authenticated output, oversized bodies, and accidental redirects. `Content-Length` or equivalent metadata can reject large responses before storage. Redirect caching is an explicit business choice.

Different response outcomes can receive different policies:

```text
success      -> longer TTL
not found    -> short TTL when negative caching is intended
server error -> no storage
```

`ResponseExpirationTimeSpan` can set a request default and later a response-derived store lifetime. Hit-specific freshness and new-response storage lifetime solve different problems. Examples include admin-forced refresh, status-based TTLs, and caching only hot products to avoid filling the store with cold entries.

The fresh-response callback may still run even when storage is ultimately disabled; its purpose is to make that final admission decision. Assign intended tags in the builder or request phase rather than depending on late, implementation-sensitive mutation.

## Builder versus custom policy

Use the fluent builder for declarative expiration, variation, tags, locking, and request predicates. Use a custom policy for imperative lifecycle decisions, independent flag manipulation, and response-aware admission that the builder cannot express clearly.

## What should be recallable

- Which facts and decisions belong in each policy callback?
- Why can lookup rejection not be deferred to a callback that requires a hit?
- What do the four lookup/storage combinations mean?
- Which default safety checks must a replacing policy reproduce?
- Why are candidate-hit freshness and replacement TTL independent?
- When is a custom policy justified over the fluent builder?

## Sources

- Workspace: `_ai-conspects/outputcache, response cache comparison/`
- Authoritative processed source: `regions/R04-response-aware-safety-dynamic-expiration.md` and `regions/R05-policy-lifecycle-callback-timing-flags.md`, with lifecycle definitions from R01/R03
- Original SVG: `source/outputcache, response cache comparison.svg`
