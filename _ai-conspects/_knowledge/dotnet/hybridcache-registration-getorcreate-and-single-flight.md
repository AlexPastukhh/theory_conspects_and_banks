# HybridCache registration, GetOrCreateAsync, and single-flight

Knowledge ID: `dotnet.hybridcache-registration-getorcreate-and-single-flight`

Topic: `dotnet`

## HybridCache coordinates a local and distributed cache

The source setup uses `Microsoft.Extensions.Caching.Hybrid` together with a Redis-backed distributed cache.

Representative packages:

- Redis provider: `Microsoft.Extensions.Caching.StackExchangeRedis`
- HybridCache: `Microsoft.Extensions.Caching.Hybrid`

The Redis connection string is named `Redis` and the example value is:

```json
{
  "ConnectionStrings": {
    "Redis": "localhost:6379"
  }
}
```

A representative application registration is:

```csharp
using Microsoft.Extensions.Caching.Hybrid;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();

builder.Services.AddStackExchangeRedisCache(o =>
{
    o.Configuration =
        builder.Configuration.GetConnectionString("Redis");
    o.InstanceName = "myapp:";
});

builder.Services.AddHybridCache();

var app = builder.Build();

app.MapControllers();
app.Run();
```

Redis acts as the distributed L2 provider. `AddHybridCache()` registers the orchestration service that can combine process-local L1 caching with the shared distributed layer.

`InstanceName = "myapp:"` prefixes Redis keys for this application instance namespace.

## `GetOrCreateAsync` owns the cache-miss factory flow

A representative controller injects `HybridCache`, builds a stable key such as:

```text
product:{id}
```

and calls `GetOrCreateAsync`.

```csharp
[HttpGet("{id:int}")]
public Task<ProductDto> Get(
    int id,
    CancellationToken ct)
{
    var key = $"product:{id}";

    return _cache.GetOrCreateAsync(
        key,
        async token =>
        {
            await Task.Delay(200, token);

            return new ProductDto(
                id,
                $"Product {id}",
                DateTime.UtcNow);
        },
        cancellationToken: ct);
}
```

The factory runs when the cached value is absent. The request cancellation token is propagated into the cache operation, and the factory receives a token for the expensive load.

## Cache misses are protected by single-flight behavior

`HybridCache.GetOrCreateAsync` provides stampede protection, also described as single-flight, for a given key.

If 200 requests arrive concurrently for the same missing `product:123` key:

```text
request #1
    -> runs the factory / DB call

requests #2..#200
    -> wait for the same in-flight result

factory completes
    -> callers receive the resulting cached value
```

The purpose is to prevent many identical concurrent misses from creating a backing-service load spike.

The single-flight boundary is the cache key. Different keys represent different cache operations rather than one global lock.

## What should be recallable

- Which package provides HybridCache?
- Which package provides the Redis distributed-cache provider in the example?
- What does `AddHybridCache()` register?
- Which layer does Redis represent in this setup?
- Why is `InstanceName = "myapp:"` useful?
- What key shape is used for the product example?
- When does the `GetOrCreateAsync` factory execute?
- How is cancellation propagated through the controller and factory?
- What does single-flight protect against?
- For 200 simultaneous misses on one key, how many factories should perform the expensive load?
- Why do different cache keys not share one single-flight operation?

## Related knowledge

- `dotnet.hybridcache-key-tag-invalidation`
- `dotnet.hybridcache-multi-instance-l1-l2-coherence`
- `dotnet.per-key-async-single-flight`
- `aspnet-core.distributed-cache-storage-and-invalidation`
- `aspnet-core.imemorycache-expiration-invalidation-and-stampede`

## Sources

- Workspace: `_ai-conspects/hybrydcache/`
- Authoritative processed source: `04-stage4-corrected-source-preserving-transcript.md`, R01 S-001 through S-004
- Current source of truth: `CURRENT_SOURCE_OF_TRUTH.md`
- Exact source: `source/hybrydcache.svg`, present on the current branch
