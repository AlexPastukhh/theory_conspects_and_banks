# Per-key async single-flight with gates and shared tasks

Knowledge ID: `dotnet.per-key-async-single-flight`

Topic: `dotnet`

Single-flight coordinates concurrent callers so one process performs one in-flight computation for a key and the other callers await or observe that work. It is useful when a cache API has no atomic `GetOrCreate` operation.

## Per-key gate and the second check

The cache-fill sequence is:

```text
fast cache check
-> find or create the per-key gate
-> wait for the gate
-> check the cache again
-> run and store the factory result only on a miss
-> release the gate
```

The second check is essential: another caller may have populated the cache while this caller was waiting.

```csharp
private static readonly ConcurrentDictionary<string, SemaphoreSlim>
    Gates = new();

public static async Task<T> GetOrAddAsync<T>(
    this IDistributedCache cache,
    string key,
    Func<CancellationToken, Task<T>> factory,
    DistributedCacheEntryOptions options,
    CancellationToken cancellationToken = default)
{
    var json = await cache.GetStringAsync(
        key,
        cancellationToken);

    if (json is not null)
        return JsonSerializer.Deserialize<T>(json)!;

    var gate = Gates.GetOrAdd(
        key,
        static _ => new SemaphoreSlim(1, 1));

    await gate.WaitAsync(cancellationToken);

    try
    {
        json = await cache.GetStringAsync(
            key,
            cancellationToken);

        if (json is not null)
            return JsonSerializer.Deserialize<T>(json)!;

        var value = await factory(cancellationToken);

        await cache.SetStringAsync(
            key,
            JsonSerializer.Serialize(value),
            options,
            cancellationToken);

        return value;
    }
    finally
    {
        gate.Release();
    }
}
```

## Gate-map lifecycle race

Retaining one semaphore for every distinct key can grow the dictionary without a bound. Removing a gate as soon as it appears idle is not automatically safe.

This heuristic is racy:

```csharp
gate.Release();

if (gate.CurrentCount == 1)
    Gates.TryRemove(key, out _);
```

`CurrentCount` is not an atomic lifecycle reference count:

```text
A releases the old gate
A observes CurrentCount == 1
B already holds a reference to the old gate
A removes the dictionary entry
C arrives and creates a new gate
B and C can now use different gates for the same key
```

The second cache check can still prevent duplicate work after the normal success path. It cannot prove uniqueness when the factory throws, serialization or the cache write fails, provider visibility is delayed, or no value was stored. Consequently:

```text
gate removed != cache populated
apparently idle != no waiter or future owner
```

Safer choices include a bounded or evicting holder for gates, an explicitly reference-counted holder whose acquisition/removal is atomic, accepting retention for a bounded keyspace, or representing the in-flight computation directly as a shared task.

## `Lazy<Task<T>>` as the in-flight value

A dictionary of shared tasks expresses the ownership rule directly:

```text
one caller creates the task for a key
all concurrent callers await the same task
the completed or failed in-flight entry is removed
the successful durable result remains in the cache
```

```csharp
private static readonly ConcurrentDictionary<string, Lazy<Task<object>>>
    InFlight = new();

public static async Task<T> GetOrAddSingleFlightAsync<T>(
    IDistributedCache cache,
    string key,
    Func<CancellationToken, Task<T>> factory,
    DistributedCacheEntryOptions options,
    CancellationToken cancellationToken)
{
    var cached = await cache.GetStringAsync(
        key,
        cancellationToken);

    if (cached is not null)
        return JsonSerializer.Deserialize<T>(cached)!;

    Lazy<Task<object>> lazy = InFlight.GetOrAdd(
        key,
        _ => new Lazy<Task<object>>(
            async () =>
            {
                var second = await cache.GetStringAsync(
                    key,
                    cancellationToken);

                if (second is not null)
                    return JsonSerializer.Deserialize<T>(second)!;

                var value = await factory(cancellationToken);

                await cache.SetStringAsync(
                    key,
                    JsonSerializer.Serialize(value),
                    options,
                    cancellationToken);

                return value!;
            },
            LazyThreadSafetyMode.ExecutionAndPublication));

    try
    {
        return (T)await lazy.Value;
    }
    finally
    {
        InFlight.TryRemove(
            new KeyValuePair<string, Lazy<Task<object>>>(
                key,
                lazy));
    }
}
```

`ExecutionAndPublication` makes one lazy task the published computation. Compare-and-remove prevents an older caller from deleting a newer entry that now occupies the same key.

## Failure and cancellation policy

Awaiters of one task share its result and exception. The implementation must also decide:

```text
Does one caller's cancellation cancel the shared factory?
Should the shared work use a service-lifetime token instead?
When is a failed task removed?
May a later cache miss retry?
```

The representative code captures the caller token that created the lazy task. That makes the cancellation decision visible; it is not a universal policy. Removing a completed or failed in-flight entry commonly permits a later miss to retry.

## Process boundary

Both the semaphore dictionary and shared-task dictionary coordinate only callers in one process. Every application replica has its own map. A provider-backed distributed lock can coordinate replicas, but lease expiration, process failure, or network partition can still permit repeated work. Prefer an idempotent factory when possible and design the system to tolerate duplicate computation.

## What should be recallable

- Why must a gated cache fill check the cache a second time?
- How can `CurrentCount`-based cleanup produce two gates for one key?
- Why does successful gate cleanup not prove a value was stored?
- What ownership rule does `Lazy<Task<T>>` encode?
- Why use compare-and-remove for an in-flight entry?
- Which result, exception, and cancellation decisions are shared by task awaiters?
- Which guarantees stop at the process boundary?

## Related knowledge

- `aspnet-core.distributed-cache-storage-and-invalidation`
- `aspnet-core.imemorycache-expiration-invalidation-and-stampede`
- `redis.cache-stampede-and-token-owned-locks`

## Sources

- Workspace: `_ai-conspects/idistributedcache/`
- Authoritative processed source: `02-corrected-semantic-transcript-v002.md`, R02 and R03
- Identical regional copy: `regions/R01R02R03-idistributedcache-corrected-final-v002.md`, R02 and R03
- Original SVG: `source/idistributedcache.svg`
- Additional provenance: `_ai-conspects/creating base32 secret/`, `regions/full-semantic-transcript-v001.md`, section 8 (compare-and-remove pattern for in-flight lazy cleanup)
