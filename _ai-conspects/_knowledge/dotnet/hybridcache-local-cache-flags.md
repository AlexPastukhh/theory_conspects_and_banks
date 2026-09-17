# HybridCache local-cache read/write flags

Knowledge ID: `dotnet.hybridcache-local-cache-flags`

Topic: `dotnet`

## Local L1 behavior can be controlled per cache operation

`HybridCacheEntryOptions.Flags` can change how a specific call interacts with the process-local L1 cache.

This lets consistency-sensitive data use a different local-cache policy without removing L1 from every cache entry in the application.

## Disable both local read and local write

The source uses:

```csharp
var opts = new HybridCacheEntryOptions
{
    Expiration = TimeSpan.FromMinutes(5),
    Flags = HybridCacheEntryFlags.DisableLocalCache
};

var value = await hybridCache.GetOrCreateAsync(
    key: $"user:{userId}:permissions",
    factory: ct =>
        LoadPermissionsAsync(userId, ct),
    options: opts,
    cancellationToken: ct);
```

`DisableLocalCache` disables both L1 reads and L1 writes for the operation.

The example uses user permissions, where stale process-local state can be more problematic than for ordinary catalog data.

`Expiration` still represents the configured cache lifetime for the remaining cache behavior, including the distributed/overall lifetime shown by the source example.

## Read and write can be controlled separately

The source also shows:

```csharp
var optsNoL1Read = new HybridCacheEntryOptions
{
    Expiration = TimeSpan.FromMinutes(5),
    Flags = HybridCacheEntryFlags.DisableLocalCacheRead
};

var optsNoL1Write = new HybridCacheEntryOptions
{
    Expiration = TimeSpan.FromMinutes(5),
    Flags = HybridCacheEntryFlags.DisableLocalCacheWrite
};
```

`DisableLocalCacheRead` prevents reading a value from L1.

`DisableLocalCacheWrite` prevents populating L1 with the resulting value.

These one-way controls are more precise than `DisableLocalCache`.

A useful asymmetric case is:

```text
bypass possibly stale L1 read
-> obtain value through shared/factory path
-> allow a fresh value to be written to L1
```

The inverse can also be chosen when reading an existing local value is acceptable but new local copies should not be created.

## Flags are part of the coherence policy

Local-cache flags are not merely performance switches. They define whether a request may use or create process-local state and therefore directly affect multi-instance freshness behavior.

Use them together with TTL and invalidation strategy based on how much staleness the data can tolerate.

## What should be recallable

- Which option property controls HybridCache local-cache behavior?
- What does `DisableLocalCache` disable?
- Why are permissions a plausible candidate for bypassing L1?
- What does `DisableLocalCacheRead` prevent?
- What does `DisableLocalCacheWrite` prevent?
- Why are separate read/write flags more precise than disabling L1 completely?
- When is bypassing an old L1 read but allowing a fresh L1 write useful?
- How do local-cache flags relate to cross-node consistency rather than only performance?

## Related knowledge

- `dotnet.hybridcache-multi-instance-l1-l2-coherence`
- `dotnet.hybridcache-key-tag-invalidation`
- `dotnet.hybridcache-registration-getorcreate-and-single-flight`

## Sources

- Workspace: `_ai-conspects/hybrydcache/`
- Authoritative processed source: `04-stage4-corrected-source-preserving-transcript.md`, R03 S-020/S-021
- Current source of truth: `CURRENT_SOURCE_OF_TRUTH.md`
- Exact source: `source/hybrydcache.svg`, present on the current branch
