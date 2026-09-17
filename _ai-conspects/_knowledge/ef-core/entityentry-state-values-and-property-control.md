# EntityEntry state, values, and property control

Knowledge ID: `ef-core.entityentry-state-values-and-property-control`

Topic: `ef-core`

`ChangeTracker.Entries()` and `context.Entry(entity)` return `EntityEntry`: the per-entity handle EF exposes for inspecting and controlling tracked state.

```text
ChangeTracker = context-level state manager
EntityEntry   = one tracked entity's state/control object
PropertyEntry = one scalar property's state/control object
```

Each entry exposes at least:

```text
Entity
State
CurrentValues
OriginalValues
Properties
Members
Property(...)
Context
Metadata
IsKeySet
```

## `Entity` and `State`

`entry.Entity` is the actual CLR object being tracked. `entry.State` is EF's state for that entity: `Detached`, `Unchanged`, `Added`, `Modified`, `Deleted`.

```csharp
foreach (var entry in context.ChangeTracker.Entries())
{
    Console.WriteLine($"{entry.Entity.GetType().Name}: {entry.State}");
}

var entry = context.Entry(order);
entry.State = EntityState.Modified;
```

```text
Added     -> insert
Modified  -> update
Deleted   -> delete
Unchanged -> tracked but no pending write
Detached  -> not tracked
```

## `CurrentValues` and `OriginalValues`

`CurrentValues` are the current in-memory values EF will use when saving. `OriginalValues` are the values EF remembers from when the entity was queried or attached as original state. They matter for change detection, audit, optimistic concurrency, diff views, and merge/retry logic.

```csharp
var entry = context.Entry(order);

var currentName = entry.CurrentValues["Name"];
var originalName = entry.OriginalValues["Name"];

foreach (var property in entry.Properties)
{
    if (property.IsModified)
    {
        Console.WriteLine($"{property.Metadata.Name}: {property.OriginalValue} -> {property.CurrentValue}");
    }
}
```

```text
CurrentValues.SetValues(...) changes what EF intends to save.
OriginalValues.SetValues(...) changes what EF uses as the baseline/concurrency snapshot.
```

## `Property(...)` and scalar control

`entry.Property(...)` is a handle for one scalar property: `CurrentValue`, `OriginalValue`, `IsModified`.

```csharp
var versionProp = entry.Property(x => x.AggregateVersion);

var original = versionProp.OriginalValue;
var current = versionProp.CurrentValue;
var isModified = versionProp.IsModified;
```

Mark only one property modified after attach, instead of a full `Update(entity)`:

```csharp
context.Attach(order);

context.Entry(order)
    .Property(x => x.Name)
    .IsModified = true;
```

`Attach` means that the entity already exists and should normally begin as `Unchanged`; it is not an insert instruction. For a narrow disconnected update, a key-only stub can be attached and only the intended properties marked modified. Normal change detection can instead observe mutations made after attachment.

String-based access is useful for generic code:

```csharp
var prop = context.Entry(entity).Property("Name");
prop.CurrentValue = "New name";
prop.IsModified = true;
```

```text
EntityEntry.State = coarse whole-entity state.
PropertyEntry.IsModified = precise per-property update control.
```

`entry.Properties` enumerates scalar property entries. `entry.Members` enumerates members generically without compile-time knowledge of the entity type:

```csharp
foreach (var member in entry.Members)
{
    Console.WriteLine(member.Metadata.Name);
}

foreach (var property in entry.Properties)
{
    Console.WriteLine($"{property.Metadata.Name}: {property.CurrentValue}");
}
```

## `IsKeySet`

`entry.IsKeySet` answers whether the key value is set. Useful in disconnected scenarios, not as a universal truth detector:

```csharp
var entry = context.Entry(entity);

if (entry.IsKeySet)
{
    context.Update(entity);
}
else
{
    context.Add(entity);
}
```

```text
key not set -> likely new entity
key set     -> likely existing entity, though still validate by domain/database rules
```

## `Context`

`entry.Context` points back to the `DbContext` that owns this entry. Use sparingly. It can be useful inside generic helpers or interceptors, but most code already has the context.

## `Reload()` / `ReloadAsync()`

`Reload()` refreshes a tracked entity from the database: current tracked values are overwritten with database values, and the entity usually becomes `Unchanged`.

```csharp
await context.Entry(order).ReloadAsync();
```

Use it to discard local changes, refresh stale tracked state, or sync with the database after external changes. It can wipe local unsaved changes.

## `GetDatabaseValues()` / `GetDatabaseValuesAsync()`

`GetDatabaseValues()` fetches database values for the entity without automatically replacing the current tracked values.

```csharp
var databaseValues = await context.Entry(order).GetDatabaseValuesAsync();

if (databaseValues is null)
{
    // row was deleted
}
```

Use it for concurrency conflict handling, diffing current/original/database values, merge/retry logic, and admin/debugging.

```csharp
catch (DbUpdateConcurrencyException ex)
{
    foreach (var entry in ex.Entries)
    {
        var databaseValues = await entry.GetDatabaseValuesAsync();

        if (databaseValues is null)
        {
            throw; // row was deleted
        }

        entry.OriginalValues.SetValues(databaseValues);

        // optionally keep or adjust entry.CurrentValues here
    }
}
```

`OriginalValues.SetValues(databaseValues)` refreshes the concurrency baseline. `CurrentValues` can keep the intended user changes or be merged manually. Application code still needs explicit product-level merge rules.

## `SetValues()`

`SetValues()` copies values from another object/value container into EF property values.

```csharp
var entry = context.Entry(entity);
entry.CurrentValues.SetValues(dto);

entry.OriginalValues.SetValues(databaseValues);
```

Common uses: copy DTO fields into a tracked entity, merge database values after a concurrency conflict, reset original values after conflict resolution, generic update helpers.

## `Metadata`

`entry.Metadata` describes the EF model type, not just what properties happen to exist on the CLR object. Use it for generic audit code, debugging mappings, admin tools, and type-independent logic.

```csharp
var meta = entry.Metadata;

var prop = meta.FindProperty("Name");
var nav = meta.FindNavigation("Posts");
var pk = meta.FindPrimaryKey();

foreach (var p in meta.GetProperties())
{
    Console.WriteLine(p.Name);
}

foreach (var n in meta.GetNavigations())
{
    Console.WriteLine(n.Name);
}
```

## What should be recallable

- What `EntityEntry` is relative to `ChangeTracker` and `PropertyEntry`.
- The five entity states and what `SaveChanges` does for each pending write state.
- What `CurrentValues` vs `OriginalValues` represent, and what each `SetValues` target changes.
- How to mark a single property modified after `Attach`.
- What `IsKeySet` answers and what it does not prove.
- `Reload` vs `GetDatabaseValues` (overwrite tracked entity vs fetch a value snapshot).
- The concurrency-conflict shape: `GetDatabaseValuesAsync`, null means deleted row, `OriginalValues.SetValues(databaseValues)`.
- What `Metadata` is for (`FindProperty`, `FindNavigation`, `FindPrimaryKey`).

## Related knowledge

- `ef-core.changetracker-detection-cascade-and-save-lifecycle` - context-level detection, cascade timing, `AcceptAllChanges`
- `ef-core.entityentry-navigations-explicit-load-and-query` - `Reference` / `Collection` / `Query` / `IsLoaded`
- `ef-core.trackgraph-disconnected-graphs-and-nodestate` - using `IsKeySet` and `State` per graph node
- `ef-core.aggregate-version-etag-propagation` - scanning `ChangeTracker.Entries<T>()` around concurrency tokens

## Sources

- Workspace: `_ai-conspects/changetracker/`
- Authoritative processed source: `regions/R02-entityentry-properties-methods-query-and-values.md` (state/values/property/reload/SetValues/Metadata); `regions/R03-trackgraph-nodestate-and-member-api.md` sections 8-9 (`Members`, attach + `IsModified`)
- Quality / coverage: `04-stage4-final-coverage-audit.md`
- Original SVG: `source/changetracker.svg` (Git blob SHA: `50d75c751eb9f20252807b6433d90f496b91f960`)
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr02-constructors-attach-graphs-v002.md`, "Attach and entity state"
