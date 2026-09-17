# IMemoryCache expiration, invalidation, and stampede control

Knowledge ID: `aspnet-core.imemorycache-expiration-invalidation-and-stampede`

Topic: `aspnet-core`

Register `IMemoryCache` with `AddMemoryCache()` and inject it into services. Common extension APIs include `Get`, `Set`, `TryGetValue`, `GetOrCreate`, `GetOrCreateAsync`, and `Remove`.

```text
stable key -> lookup -> miss -> load source -> store with options -> return
```

Keys encode every input affecting the result and use separate namespaces for item, list, category, and other shapes.

## Expiration and size

Sliding expiration extends on access; absolute expiration is a hard upper bound. Combining them lets hot values survive while ensuring no permanently hot entry lives forever.

`MemoryCacheEntryOptions` configures sliding/absolute expiry, priority, size, callbacks, and expiration tokens. A global `SizeLimit` uses application-defined units; it does not automatically mean bytes. Every entry in a size-limited cache must set `Size`; eviction considers expiration, priority, and recency.

Cache entries do not observe arbitrary database changes automatically.

## Invalidation after durable change

Remove exact item/list keys only after the source-of-truth update commits:

```text
write -> confirm/commit -> invalidate
```

Invalidating first lets a concurrent request repopulate old data.

`IMemoryCache` has no built-in wildcard delete or first-class tag invalidation API, so group invalidation needs an explicit strategy.

For groups:

- explicit key registries give precise removal but need synchronized membership/cleanup;
- versioned keys (`category:{id}:v{version}:page:{page}`) invalidate in O(1) by bumping version, leaving old entries unreachable until expiry;
- manual tag maps support overlapping groups but require thread safety and bounded cleanup;
- shared expiration tokens expire a managed in-process group;
- short TTL alone is acceptable only when bounded staleness is acceptable.

A local version/tag/token is not visible to another server process. Use distributed version state or invalidation events when nodes must agree.

## `GetOrCreate` is not single-flight

Multiple callers can observe one miss and execute the factory concurrently. Cheap idempotent factories may tolerate this; expensive/rate-limited dependencies may suffer a stampede.

A per-key gate uses double-checking:

```text
fast cache check
-> acquire key gate
-> check cache again
-> one caller loads/stores
-> release
```

The second check matters because another waiter may already have populated the entry. Gate maps also need lifecycle management: early semaphore removal races, while retaining every key leaks memory. Keyed-lock libraries, `Lazy<Task<T>>`, bounded maps, or cached/pooled gates can own this complexity. Decide whether failures propagate, retry, or receive brief negative caching; never cache failures indefinitely by accident.

## Process boundary

`IMemoryCache` is per process. Values, versions, locks, pressure, and eviction are node-local; restart clears them. Local single-flight does not stop another instance from rebuilding. Use distributed cache/invalidation and, when required, distributed coordination or backend coalescing.

## What should be recallable

- Why combine sliding and absolute expiration?
- What does SizeLimit measure, and what must each entry supply?
- Why invalidate after commit rather than before it?
- What trade-offs distinguish exact keys, versions, tags, and tokens?
- Why can `GetOrCreateAsync` run the factory more than once?
- Which race/leak risks belong to per-key gates?
- Which guarantees stop at the process boundary?

## Sources

- Workspace: `_ai-conspects/manual account lockout,ratelimiter middleware, idatabase vs idist cache/`
- Authoritative processed source: `regions/R01R09-full-svg-reconciliation-v002.md`, R09
- Original SVG: `source/source-complete-v002.svg`

- Workspace: `_ai-conspects/imemorycache/`
- Authoritative processed source: `regions/R01R02R03-imemorycache-final.md`, sections 1-8
- Original SVG: `source/imemorycache.svg`

