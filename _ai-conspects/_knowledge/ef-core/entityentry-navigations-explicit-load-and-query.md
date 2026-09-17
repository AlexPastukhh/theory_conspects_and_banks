# EntityEntry navigations, explicit load, and Query()

Knowledge ID: `ef-core.entityentry-navigations-explicit-load-and-query`

Topic: `ef-core`

Navigation state/control objects sit on `EntityEntry`:

```text
NavigationEntry / ReferenceEntry / CollectionEntry = navigation state/control objects
```

`entry.References` enumerates reference navigation entries. `entry.Collections` enumerates collection navigation entries. `entry.Navigations` covers navigation entries more generally. These are useful for generic audit code, debugging, loading/checking navigation state, and generic admin tools.

```csharp
foreach (var navigation in entry.Navigations)
{
    Console.WriteLine($"{navigation.Metadata.Name}: {navigation.IsLoaded}");
}
```

## `Reference(...)`, `Collection(...)`, and `Navigation(...)`

Use `Reference(...)` for a single related entity:

```csharp
await context.Entry(post)
    .Reference(p => p.Blog)
    .LoadAsync();
```

Use `Collection(...)` for a collection navigation:

```csharp
await context.Entry(blog)
    .Collection(b => b.Posts)
    .LoadAsync();
```

```csharp
var collection = context.Entry(blog).Collection(b => b.Posts);

Console.WriteLine(collection.IsLoaded);
await collection.LoadAsync();
Console.WriteLine(collection.IsLoaded);
```

`Navigation(...)` can be used when code wants to address a navigation in a more generic way.

Typical tasks: explicit loading, checking `IsLoaded`, querying related data before load, generic traversal/diagnostics.

## `Query()` for related data

`Query()` exists on navigation entry APIs and gives an `IQueryable` for related data. Use it when you want filtering, counting, projection, or existence checks without blindly loading an entire navigation.

Collection:

```csharp
var query = context.Entry(blog)
    .Collection(b => b.Posts)
    .Query();

var recentPosts = await query
    .Where(p => p.CreatedAt >= cutoff)
    .ToListAsync();
```

Count without loading the whole collection:

```csharp
var count = await context.Entry(blog)
    .Collection(b => b.Posts)
    .Query()
    .CountAsync();
```

Reference navigation also has `Query()`:

```csharp
var exists = await context.Entry(post)
    .Reference(p => p.Blog)
    .Query()
    .AnyAsync();
```

That produces a query for the related single entity, effectively an `IQueryable<Blog>`.

`Find(key)` first checks the context's identity map. If the root is already tracked, it returns that instance without a database query; calling `Find` again when the root is already in hand is redundant. Explicit `Load` can fetch only the missing navigation. Several explicitly loaded collections normally mean several queries, which can be useful in a warm unit-of-work but should be compared with eager loading or projection for a fresh read path.

## What should be recallable

- The difference between `References`, `Collections`, and `Navigations`.
- How to explicitly load a reference vs a collection, and what `IsLoaded` reports.
- What `Query()` returns and why you would count/filter/project instead of `Load`.
- That reference `Query()` is still an `IQueryable` over the related entity.

## Related knowledge

- `ef-core.entityentry-state-values-and-property-control` - scalar `Property` / values / `Metadata`
- `ef-core.lazy-loading-and-query-shaping` - automatic navigation I/O vs explicit `Load` / `Query`
- `ef-core.changetracker-detection-cascade-and-save-lifecycle` - `LazyLoadingEnabled` as a tracker toggle

## Sources

- Workspace: `_ai-conspects/changetracker/`
- Authoritative processed source: `regions/R02-entityentry-properties-methods-query-and-values.md` sections 5-7; `regions/R03-trackgraph-nodestate-and-member-api.md` navigation inspection
- Quality / coverage: `04-stage4-final-coverage-audit.md`
- Original SVG: `source/changetracker.svg` (Git blob SHA: `50d75c751eb9f20252807b6433d90f496b91f960`)
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr01-tracking-query-materialization-v002.md`, "Find, tracked roots, and explicit loading"; `transcripts/fr07-query-shape-row-count-v002.md`, "Loading choices"
