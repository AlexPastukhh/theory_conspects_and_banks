# Distributed cache storage, expiration, and invalidation

Knowledge ID: `aspnet-core.distributed-cache-storage-and-invalidation`

Topic: `aspnet-core`

`IDistributedCache` is a provider-neutral, byte-oriented cache contract. Multiple application instances can share entries when they use the same backend, but this adds provider, network, and serialization work that an in-process cache does not have.

```text
IMemoryCache
    one process
    fastest access
    cleared by process restart
    not shared across replicas

IDistributedCache
    out-of-process provider
    network and serialization cost
    shared by replicas using that provider
    survives one application-process restart
```

## Contract and payload ownership

The core asynchronous operations are:

```csharp
Task<byte[]?> GetAsync(
    string key,
    CancellationToken cancellationToken = default);

Task SetAsync(
    string key,
    byte[] value,
    DistributedCacheEntryOptions options,
    CancellationToken cancellationToken = default);

Task RefreshAsync(
    string key,
    CancellationToken cancellationToken = default);

Task RemoveAsync(
    string key,
    CancellationToken cancellationToken = default);
```

Synchronous equivalents also exist. A miss returns `null`; the interface does not deserialize an application object. `Refresh` renews sliding expiration without returning the cached payload, while `Remove` invalidates one exact key.

String helpers encode and decode UTF-8 strings, but object serialization remains an application concern:

```csharp
var json = JsonSerializer.Serialize(value);

await cache.SetStringAsync(
    key,
    json,
    options,
    cancellationToken);

var cached = await cache.GetStringAsync(
    key,
    cancellationToken);

var result = cached is null
    ? default
    : JsonSerializer.Deserialize<T>(cached);
```

`GetStringAsync` and `SetStringAsync` therefore do not remove schema-compatibility or payload-version decisions.

## Expiration and provider registration

An absolute expiration places a hard upper bound on an entry's lifetime. Sliding expiration can extend its lifetime when it is refreshed or accessed according to provider behavior.

```csharp
var options = new DistributedCacheEntryOptions
{
    AbsoluteExpirationRelativeToNow =
        TimeSpan.FromMinutes(10),
    SlidingExpiration =
        TimeSpan.FromMinutes(2)
};
```

Typical backends include Redis and the SQL Server distributed-cache provider. A Redis-backed implementation can be registered behind the abstraction:

```csharp
builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration =
        builder.Configuration
            .GetConnectionString("Redis");

    options.InstanceName = "myapp:";
});
```

Consumers normally depend on `IDistributedCache`, not the concrete provider.

## Keys and invalidation

Keys encode a stable namespace and a payload or logical-group version:

```text
product:42:v3
catalog:page:4:v2
tenant:17:user:99:v1
```

The abstraction has no portable tag-delete operation. A version suffix or catalog-version token can invalidate a logical group by making old keys unreachable; provider-specific facilities are another deliberate option.

Invalidate after the durable mutation succeeds:

```csharp
await repository.UpdateAsync(
    product,
    cancellationToken);

await cache.RemoveAsync(
    $"product:{product.Id}:v3",
    cancellationToken);
```

Invalidation is part of the write policy, not proof that the cache is authoritative.

## Failure boundary

The durable database or other source remains the system of record. Callers must tolerate:

```text
cache miss
provider timeout
eviction
stale data
serialization failure
schema or version mismatch
```

A cache hit is an optimization path. The application still owns fallback behavior and the acceptable staleness contract.

## What should be recallable

- How do `IDistributedCache` and `IMemoryCache` differ at the process/provider boundary?
- What do get, set, refresh, and remove own?
- Why do string helpers not eliminate serialization and schema-version concerns?
- How do absolute and sliding expiration differ?
- Why are namespaces and payload versions part of key design?
- Which strategies can replace a portable tag-delete operation?
- Why is the cache not the system of record?

## Related knowledge

- `dotnet.per-key-async-single-flight` — coordinating one process while it fills a missing entry.
- `redis.expiring-counters-portability-and-distributed-throttling` — when Redis-specific commands exceed the portable cache contract.

## Sources

- Workspace: `_ai-conspects/idistributedcache/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R01
- Identical regional copy: `regions/R01R02R03-idistributedcache-corrected-final-v002.md`, R01
- Original SVG: `source/idistributedcache.svg`
