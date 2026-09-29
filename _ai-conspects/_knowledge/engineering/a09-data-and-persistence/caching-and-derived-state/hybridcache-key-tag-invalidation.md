# HybridCache key and tag invalidation

Knowledge ID: `dotnet.hybridcache-key-tag-invalidation`

Topic: `dotnet`

## Invalidate cache state after the source data changes

The source update flow changes the database first and then removes cache entries affected by that change.

Representative service logic:

```csharp
public async Task UpdateProductAsync(
    int id,
    ProductUpdate dto,
    CancellationToken ct)
{
    await UpdateDbAsync(id, dto, ct);

    await _cache.RemoveAsync(
        $"product:{id}",
        ct);

    await _cache.RemoveAsync(
        new[]
        {
            "products:list",
            $"products:category:{dto.Category}"
        },
        ct);
}
```

The individual product key and related aggregate/list keys are distinct cached representations of the same underlying data. Updating only the database without invalidating those dependent representations can leave stale cached results.

The normal ordering shown by the source is:

```text
update source data
-> invalidate affected cache entries
```

## `RemoveAsync` invalidates by key

`HybridCache.RemoveAsync(key)` removes a cached entry by its key.

For the application instance executing the removal, the source describes removal as affecting both primary/local L1 state and the secondary/distributed L2 entry.

A multi-instance caveat remains: removing the shared L2 entry and the current node's L1 does not automatically erase a different server process's already-populated L1 entry. That coherence problem is a separate model.

## Tags group entries for logical invalidation

Tags are attached when an entry is created:

```csharp
var product = await _cache.GetOrCreateAsync(
    key: $"product:{id}",
    factory: async ct =>
        await LoadFromDbAsync(id, ct),
    options: new HybridCacheEntryOptions
    {
        Expiration = TimeSpan.FromMinutes(5)
    },
    tags: new[]
    {
        "products",
        $"category:{categoryId}"
    },
    cancellationToken: ct);
```

Later, a whole category can be invalidated without the caller enumerating every product key:

```csharp
await _cache.RemoveByTagAsync(
    $"category:{categoryId}",
    ct);
```

A broad `products` tag and a narrower category tag support invalidation at different logical scopes.

## Tag bookkeeping is internal to HybridCache

Conceptually, the cache maintains:

```text
normal cache entry
    product:123

plus tag association/versioning metadata
    products
    category:42
```

`RemoveByTagAsync(tag)` uses that bookkeeping to invalidate entries associated with the tag.

The source intentionally describes the implementation conceptually: it may use indexing or versioning internally. The durable caller contract is that tags are assigned at cache-write time and consumed later by the tag invalidation API.

## What should be recallable

- Why should source-data mutation generally precede cache invalidation?
- Which individual and aggregate keys are removed in the product-update example?
- What does `RemoveAsync(key)` invalidate on the current instance?
- Why is multi-instance L1 coherence still a separate concern?
- When are tags attached to an entry?
- How can every product in one category be invalidated?
- Why can both broad and narrow tags be useful?
- Why does the caller not need to maintain a list of every key associated with a tag?
- What implementation detail about tag bookkeeping remains intentionally conceptual?

## Related knowledge

- `dotnet.hybridcache-registration-getorcreate-and-single-flight`
- `dotnet.hybridcache-multi-instance-l1-l2-coherence`
- `dotnet.hybridcache-local-cache-flags`
- `aspnet-core.distributed-cache-storage-and-invalidation`
- `aspnet-core.output-cache-admission-and-policy-lifecycle`

## Sources

- Workspace: `_ai-conspects/hybrydcache/`
- Authoritative processed source: `04-stage4-corrected-source-preserving-transcript.md`, R02 S-006 through S-008 and R03 S-018/S-019
- Current source of truth: `CURRENT_SOURCE_OF_TRUTH.md`
- Exact source: `source/hybrydcache.svg`, present on the current branch
- Crop note: S-007 has a cropped private helper edge, while the invalidation code itself is readable; S-008 continues the class across screenshots
