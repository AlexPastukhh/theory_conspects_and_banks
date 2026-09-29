# HybridCache multi-instance L1/L2 coherence

Knowledge ID: `dotnet.hybridcache-multi-instance-l1-l2-coherence`

Topic: `dotnet`

## L1 is process-local while L2 is shared

In a multi-server application, HybridCache can combine:

- **L1** — in-memory cache inside one server process; very fast but local;
- **L2** — distributed cache such as Redis; shared across servers.

This difference creates a coherence boundary.

Removing a key or tag can clear the shared distributed entry and the local L1 entry on the server that performs the invalidation, but another server may still have an old value in its own RAM until that local entry expires.

Shared-storage correctness does not imply immediate process-local-memory coherence.

## Two servers can hold independent L1 copies

The source uses Server A and Server B behind a load balancer with:

```text
key: product:123
L1 TTL: 5 minutes
initial database Price: 10
```

First request to A:

```text
A L1 miss
-> Redis miss
-> DB returns 10
-> A stores L1(A) = 10
-> Redis L2 = 10
```

Next request to B:

```text
B L1 miss
-> Redis hit = 10
-> B stores L1(B) = 10
```

Both processes now hold their own L1 copy of `10`.

## Invalidation on A does not erase B's RAM

The database price changes to `12`, then invalidation runs on Server A:

```csharp
await hybridCache.RemoveAsync("product:123");
// or RemoveByTagAsync("products")
```

After that operation:

```text
database = 12
L1(A)    = cleared
Redis L2 = cleared
L1(B)    = still 10 until its local TTL ends
```

A later request routed to A misses both cache layers, loads `12` from the database, and returns the fresh value.

A request routed to B can still hit `L1(B)` and return stale `10` without consulting Redis.

The missing capability is a cross-node invalidation signal that tells other processes to delete their local copies.

## L1 TTL is a consistency-versus-performance control

One mitigation is a short L1 lifetime for freshness-sensitive data.

The source gives an example:

```text
L1 TTL: 5 seconds
L2 TTL: 5 minutes
```

This preserves fast local hits while limiting the cross-node stale window to about five seconds.

For data such as catalog browsing, product lists, or news feeds, a 30–60 second stale window may be acceptable, allowing a longer L1 TTL.

The TTL policy should match the business cost of staleness rather than using one duration for every data type.

## Immediate coherence needs signaling or no local copy

Another strategy is broadcast invalidation through Redis pub/sub or a message bus:

```text
product:123 evicted
-> publish "invalidate product:123"
-> every server receives the message
-> each server removes its own L1 copy
```

This can make the stale window close to zero, but it adds infrastructure and operational complexity.

For selected consistency-sensitive data, another strategy is to avoid L1 and rely on the shared L2 layer. Every node then consults the shared cache state rather than bypassing it with a local hit.

That trades RAM speed for stronger cross-node consistency.

## The rule applies beyond HybridCache

The source compares this behavior with Output Cache.

If an output-cache store is local memory, evicting an entry on Server A does not clear Server B's local output cache. A distributed output-cache store changes the shared-storage part of the model, but any process-local cache still needs expiry, broadcast invalidation, or deliberate avoidance.

General rule:

```text
anything cached in process RAM is per server

invalidation on one server does not guarantee
other servers discard their RAM copy
```

The three controls named by the source are:

- short local TTL;
- broadcast invalidation;
- avoid local caching for that data.

## What should be recallable

- What is the difference between HybridCache L1 and L2?
- Why can clearing Redis fail to remove a stale response path on another server?
- How do A and B each obtain their first `product:123 = 10` value?
- After the database changes to `12` and A invalidates, what are the states of L1(A), Redis, and L1(B)?
- Why can B return `10` without checking Redis?
- What does a 5-second L1 / 5-minute L2 policy control?
- When might 30–60 seconds of staleness be acceptable?
- How does pub/sub invalidation reduce the stale window?
- What additional cost comes with broadcast invalidation?
- Why does disabling local caching strengthen multi-node consistency?
- How does the same principle apply to an in-memory Output Cache?
- What are the three source-listed strategies for limiting stale per-server RAM data?

## Related knowledge

- `dotnet.hybridcache-key-tag-invalidation`
- `dotnet.hybridcache-local-cache-flags`
- `aspnet-core.distributed-cache-storage-and-invalidation`
- `aspnet-core.output-cache-safety-value-and-locking`
- `aspnet-core.response-and-output-caching-policies`

## Sources

- Workspace: `_ai-conspects/hybrydcache/`
- Authoritative processed source: `04-stage4-corrected-source-preserving-transcript.md`, R02 S-005 and S-009 through S-017
- Current source of truth: `CURRENT_SOURCE_OF_TRUTH.md`
- Exact source: `source/hybrydcache.svg`, present on the current branch
