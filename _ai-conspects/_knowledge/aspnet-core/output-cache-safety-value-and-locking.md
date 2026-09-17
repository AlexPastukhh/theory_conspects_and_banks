# Output Cache safety, value, and locking decisions

Knowledge ID: `aspnet-core.output-cache-safety-value-and-locking`

Topic: `aspnet-core`

Output caching starts with two separate gates:

```text
1. Is this response safe to reuse for another matching request?
2. Will reuse happen often enough to justify caching it?
```

Reject full-response caching when output depends on the current user, session, tenant, role, claims, account/security state, or unsafe cookie state. Commands and side effects do not become cacheable merely because they are exposed through HTTP; POST/PUT/PATCH/DELETE and command-like GETs are stop signs.

Safe candidates include anonymous public listings, documentation, stable search results, and mostly static pages. Safety alone is insufficient: a cache entry used only once consumes storage and policy complexity without avoiding work.

## Value and freshness gates

Reuse depends on cache-key shape. Hot common URLs and query combinations are strong candidates; request IDs, timestamps, random values, and highly unique searches create cold one-off variants. Include every real representation dimension, but recognize that high cardinality can erase hit rate.

Endpoint cost changes the payoff. Database/external calls, aggregation, report/view rendering, and expensive serialization make even a short reusable TTL valuable. A cheap endpoint may be faster to regenerate than to coordinate and store. Large responses save costly work but consume more cache capacity and eviction bandwidth.

TTL is a staleness contract. A 30-second entry says that a client may receive data up to roughly 30 seconds old. Payment, inventory, order, account, and security state may require current data; public catalog data may tolerate bounded staleness.

Account for existing layers:

```text
browser / CDN / reverse proxy -> edge or client reuse
ResponseCachingMiddleware     -> HTTP response-cache semantics in the app
Output Cache                -> generated HTTP output in the app
distributed/data cache      -> reusable application data
database/provider cache     -> lower-level query/data work
```

If a CDN absorbs nearly all requests for the same public representation, another origin output layer can be redundant. Output Cache can still help CDN misses, internal/private traffic that bypasses the edge, responses the CDN will not store, and application-specific policy/tag/invalidation decisions.

## Locking and stampede trade-off

On a missing or expired hot key, locking/coalescing lets one request generate the response while peers wait for the result:

```text
concurrent misses -> one generator -> cached result -> waiting requests continue
```

This helps when regeneration is expensive, duplicate work is wasteful, the same key is hot, and the generator normally completes quickly and reliably. It can hurt cheap/cold/unique endpoints by adding coordination.

The failure case is important:

```text
entry expires -> burst arrives -> one slow/failing generator holds progress
-> waiters queue -> latency and availability degrade
```

Short TTLs create more lock windows. Slow databases/APIs make the lock holder slower. Choose locking from observed key hotness, generation cost, latency reliability, and failure behavior rather than treating it as a universal win.

Cache the reusable 200 representation, not a transient bodyless 304 as content. A validator checked against cached output proves whether that cached representation matches the request validator; it does not query current database state. Force endpoint execution when current backing state must be consulted.

## Related knowledge

- `aspnet-core.response-and-output-caching-policies`
- `aspnet-core.output-cache-admission-and-policy-lifecycle`
- `http.cache-validation-headers`

## Sources

- Workspace: `_ai-conspects/outputcache-layers-to-use-or-not-locking-outputcache-vs-cdn/`
- Authoritative processed source: `regions/R01R02R03R04-outputcache-safety-benefit-locking-cdn-final.md`, R01-R04
- Original SVG: `source/outputcache-layers-to-use-or-not-locking-outputcache-vs-cdn.svg`
- Workspace: `_ai-conspects/cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS/`
- Authoritative processed source: `regions/R01R07-cache-control-response-caching-etag-full-coverage-v001.md`, R06 and R07
- Original SVG: `source/source-complete-v001.svg`
