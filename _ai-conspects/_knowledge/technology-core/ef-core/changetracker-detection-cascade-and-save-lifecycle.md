# ChangeTracker detection, cascade timing, and save lifecycle

Knowledge ID: `ef-core.changetracker-detection-cascade-and-save-lifecycle`

Topic: `ef-core`

`DbContext.ChangeTracker` is EF Core's in-memory state manager for entities tracked by the current `DbContext`. Tracked entities drive INSERT / UPDATE / DELETE decisions during `SaveChanges`. Tracked state is per `EntityEntry`: `Detached`, `Unchanged`, `Added`, `Modified`, `Deleted`.

`ChangeTracker.Entries()` returns `EntityEntry` objects. Typed scanning is the usual way to inspect a subset:

```csharp
var allEntries = context.ChangeTracker.Entries();

var changedOrders = context.ChangeTracker
    .Entries<Order>()
    .Where(e => e.State == EntityState.Modified);
```

`Entries()` is the scanner. The detailed `EntityEntry` surface lives on those returned objects.

## `HasChanges()`

`HasChanges()` asks whether the `DbContext` currently knows about tracked changes that would matter to `SaveChanges()` - a quick "do I need to save anything at all?"

```csharp
using var context = new AppDbContext();

var user = await context.Users.FindAsync(1);
user.Name = "New name";

if (context.ChangeTracker.HasChanges())
{
    await context.SaveChangesAsync();
}
```

Typical uses: avoid unnecessary `SaveChanges()`, log whether anything changed, skip audit work if nothing changed.

```csharp
public async Task UpdateUserNameAsync(int id, string newName)
{
    using var context = new AppDbContext();

    var user = await context.Users.FindAsync(id);
    if (user is null) return;

    user.Name = newName;

    if (!context.ChangeTracker.HasChanges())
        return;

    await context.SaveChangesAsync();
}
```

`HasChanges()` depends on change detection being up to date. If automatic detection is disabled, call `DetectChanges()` first.

## `DetectChanges()`

`DetectChanges()` forces EF Core to compare current values with original values and update entity/property states. It is in-memory only: it compares tracked entities to stored original values/snapshots. It does not require a database roundtrip.

```csharp
var user = await context.Users.FindAsync(1);
user.Name = "Changed manually";

context.ChangeTracker.DetectChanges();

bool changed = context.ChangeTracker.HasChanges();
```

It is useful when automatic detection is disabled, when inspecting tracked states, when running custom audit logic, when reading `DebugView`, and in large-batch scenarios that need manual control.

```csharp
var order = await context.Orders.FindAsync(10);
order.Status = "Shipped";

context.ChangeTracker.DetectChanges();

foreach (var entry in context.ChangeTracker.Entries())
{
    Console.WriteLine($"{entry.Entity.GetType().Name}: {entry.State}");
}
```

For normal tracked entities, EF Core uses snapshot change tracking: when an entity is first tracked, EF stores a snapshot of its property values, and later `DetectChanges()` compares current values to that snapshot.

`DetectChanges()` only helps for tracked entities. If an entity came from `AsNoTracking()`, EF did not create tracking/snapshot data. In disconnected scenarios where code later calls `Attach()` or `Update()`, EF may not know original database values unless you query them or explicitly set `IsModified` / `OriginalValues`.

```text
queried with normal tracking -> EF has original values -> DetectChanges can compare
queried with AsNoTracking -> no snapshot -> no automatic comparison
detached DTO later attached -> may need explicit state/original-value decisions
```

## `AutoDetectChangesEnabled`

`AutoDetectChangesEnabled = false` does not stop tracking. It only stops automatic calls to `DetectChanges()` that EF Core normally performs before operations such as `SaveChanges()` or when returning change-tracking information.

If disabled, detect changes manually:

```csharp
context.ChangeTracker.DetectChanges();
```

or for one entity:

```csharp
context.Entry(entity).DetectChanges();
```

This still works when the entity is already tracked and EF has the original snapshot from when it was queried.

Usually you should not disable it. Change detection is not a bottleneck for most apps. Disabling automatic detection is mainly for cases where profiling shows repeated detection is expensive because the context tracks many entities.

Automatic detection is not only before `SaveChanges()`. EF can also run it for `ChangeTracker.Entries()`, `Entries<TEntity>()`, `HasChanges()`, and `CascadeChanges()`. That is why disabling it can help in hot paths that repeatedly inspect many tracked entities.

A shape that is safe because `Entries<TEntity>()` already triggered detection, and no later state-changing operations require a second full scan before `base.SaveChangesAsync`:

```csharp
public override async Task<int> SaveChangesAsync(CancellationToken ct = default)
{
    foreach (var entry in ChangeTracker.Entries<PostTag>())
    {
        if (entry.State == EntityState.Added)
        {
            entry.Entity.TaggedBy = "system";
            entry.Entity.TaggedOn = DateTime.UtcNow;
        }
    }

    try
    {
        ChangeTracker.AutoDetectChangesEnabled = false;
        return await base.SaveChangesAsync(ct);
    }
    finally
    {
        ChangeTracker.AutoDetectChangesEnabled = true;
    }
}
```

Large batch insert/update:

```csharp
context.ChangeTracker.AutoDetectChangesEnabled = false;
try
{
    // bulk work

    context.ChangeTracker.DetectChanges();
    await context.SaveChangesAsync();
}
finally
{
    context.ChangeTracker.AutoDetectChangesEnabled = true;
}
```

Another valid batch case: disable detection while calling `Add` in a loop (EF already knows `Added`), then re-enable and save. Repeated scans over a huge tracked graph can get expensive. When changes go through EF APIs such as `Entry(...).Property(...).CurrentValue` or `Add`, EF may already know enough about those changes immediately. For normal application code, leave automatic detection alone.

## `Clear()`

`Clear()` detaches all currently tracked entities from the context in one shot. It does not save anything; it just stops tracking.

Use it when reusing the same `DbContext` instance but removing tracked state: long-running contexts that accumulated too many tracked entities, batch processing in chunks, tests, avoiding stale tracked entities in a reused context scope.

```csharp
int page = 0;
const int pageSize = 500;

while (true)
{
    var items = await context.Orders
        .OrderBy(o => o.Id)
        .Skip(page * pageSize)
        .Take(pageSize)
        .ToListAsync();

    if (items.Count == 0)
        break;

    foreach (var item in items)
    {
        item.Status = "Processed";
    }

    await context.SaveChangesAsync();
    context.ChangeTracker.Clear();

    page++;
}
```

Dangerous if pending changes were expected to remain tracked:

```csharp
context.ChangeTracker.Clear();
await context.SaveChangesAsync(); // nothing to save now
```

## `QueryTrackingBehavior`

`QueryTrackingBehavior` controls the default tracking behavior for LINQ queries from this context: `TrackAll`, `NoTracking`, `NoTrackingWithIdentityResolution`. Use a context-wide default instead of adding `.AsNoTracking()` everywhere.

```csharp
context.ChangeTracker.QueryTrackingBehavior = QueryTrackingBehavior.NoTracking;

var readonlyUsers = await context.Users.ToListAsync(); // not tracked

var trackedUser = await context.Users
    .AsTracking()
    .FirstAsync(u => u.Id == 1);
```

Typical uses: read-heavy contexts, query services, reporting endpoints, reducing accidental tracking.

It is only the default for queries. It does not stop explicit tracking APIs such as `Add`, `Attach`, `Update`.

## `DebugView`

`DebugView` is a debugging representation of the current tracked graph and states. Use it to inspect why something is `Modified` or not, what is tracked, foreign-key values, current/original values, and navigation relationships. There are typically short and long views.

```csharp
context.ChangeTracker.DetectChanges();

Console.WriteLine(context.ChangeTracker.DebugView.ShortView);
Console.WriteLine(context.ChangeTracker.DebugView.LongView);
```

When `SaveChanges()` behaves unexpectedly, print the long view.

## Cascade and orphan timing

`DeleteOrphansTiming` controls when EF marks required dependents as `Deleted` after they become orphans due to relationship changes. Default behavior: marking orphans as `Deleted` happens as soon as the relationship change is detected, but it can be delayed until `SaveChanges()`.

```csharp
parent.Children.Remove(child);
```

If `child` is required to have a parent, removing it can make it an orphan. Timing choices:

```text
immediately when change detection sees it
later at SaveChanges
never automatically, in which case you may need CascadeChanges() yourself
```

Delaying orphan deletion matters when you remove a child from one parent only because you are about to attach it to another parent in the same unit of work: it avoids EF marking it `Deleted` too early during that temporary in-between state.

```text
orphan = dependent entity no longer connected to required parent
DeleteOrphansTiming = when EF turns that orphan into Deleted state
```

`CascadeDeleteTiming` is similar but the trigger is principal deletion, not a severed required relationship:

```csharp
var blog = await context.Blogs
    .Include(b => b.Posts)
    .SingleAsync(b => b.Id == 1);

context.Remove(blog);
// required dependent posts may be marked Deleted now or later,
// depending on CascadeDeleteTiming
```

Common timing values: `Immediate`, `OnSaveChanges`, `Never`.

`Immediate` is the default behavior in modern EF Core: delete parent -> children become `Deleted` now; sever required relationship -> orphan becomes `Deleted` now.

`OnSaveChanges` keeps the in-memory graph more intact during business logic; EF computes cascade/orphan deletes at save time. Useful when temporarily re-parenting an entity before save.

`Never` means EF will not automatically apply those client-side cascade/orphan deletions. To still process them, call `CascadeChanges()`.

```text
DetectChanges() = notice relationship/property changes in tracked entities
CascadeChanges() = apply cascade-delete/orphan-delete consequences immediately
```

When timings are `Never`, `DetectChanges()` by itself is not enough to perform cascade/orphan delete transitions. `CascadeChanges()` forces cascading deletion of dependents and usually calls `DetectChanges()` internally first.

## `AcceptAllChanges()` and `acceptAllChangesOnSuccess`

`AcceptAllChanges()` tells EF to assume tracked entities now match the database. The API is typically called by `SaveChanges()` after a successful save.

```text
Added    -> Unchanged
Modified -> Unchanged
Deleted  -> detached / no longer treated as pending delete
```

Conceptually, original values/snapshots are reset to the current persisted state.

By default, `SaveChanges` calls `AcceptAllChanges()` after the database write succeeds. The `acceptAllChangesOnSuccess` parameter controls this.

```csharp
await context.SaveChangesAsync(acceptAllChangesOnSuccess: false);

// do more work here, maybe commit an external transaction, maybe verify something

context.ChangeTracker.AcceptAllChanges();
```

Retry / commit uncertainty:

```csharp
await using var tx = await context.Database.BeginTransactionAsync();

context.Blogs.Add(new Blog { Name = "New blog" });

await context.SaveChangesAsync(acceptAllChangesOnSuccess: false);
await tx.CommitAsync();

context.ChangeTracker.AcceptAllChanges();
```

Saving with `acceptAllChangesOnSuccess: false` means entity states are not immediately reset to `Unchanged`. That can allow retrying the same operation if the commit fails or if a transaction is rolled back.

## What should be recallable

- What `ChangeTracker` owns versus what an `EntityEntry` owns, and what `Entries()` / `Entries<T>()` return.
- What `HasChanges()` answers, and why it can be stale when automatic detection is off.
- What `DetectChanges()` compares, that it is in-memory, and why `AsNoTracking` / detached attach may have no snapshot.
- What `AutoDetectChangesEnabled = false` does and does not disable, which APIs can auto-detect, and a safe try/finally or batch pattern.
- That `Clear()` detaches without saving.
- That `QueryTrackingBehavior` is a query default and does not block `Add` / `Attach` / `Update`.
- What `DebugView` is for (short vs long).
- The difference between `CascadeDeleteTiming` and `DeleteOrphansTiming`, the three timings, and `CascadeChanges()` vs `DetectChanges()`.
- What `AcceptAllChanges()` does to states, and why `acceptAllChangesOnSuccess: false` exists.

## Related knowledge

- `ef-core.entityentry-state-values-and-property-control` - per-entity state, values, and property modification
- `ef-core.entityentry-navigations-explicit-load-and-query` - navigation load and `Query()`
- `ef-core.lazy-loading-and-query-shaping` - `LazyLoadingEnabled` as a ChangeTracker toggle on top of proxy/`ILazyLoader` setup
- `ef-core.trackgraph-disconnected-graphs-and-nodestate` - custom per-node tracking of disconnected graphs
- `ef-core.changetracker-tracking-and-state-events` - Tracking / Tracked / StateChanging / StateChanged
- `ef-core.transactions-isolation-savepoints-and-retries` - explicit transactions around `SaveChanges`

## Sources

- Workspace: `_ai-conspects/changetracker/`
- Authoritative processed source: `regions/R01-changetracker-core-methods-detection-cascade-debugview.md` (includes Stage2 correction of S-001-S-003 into R01)
- Quality / coverage: `04-stage4-final-coverage-audit.md`
- Original SVG: `source/changetracker.svg` (Git blob SHA: `50d75c751eb9f20252807b6433d90f496b91f960`)
