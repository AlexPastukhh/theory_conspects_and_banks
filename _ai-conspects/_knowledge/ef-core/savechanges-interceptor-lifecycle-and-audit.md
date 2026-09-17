# SaveChangesInterceptor lifecycle, event data, and audit stamping

Knowledge ID: `ef-core.savechanges-interceptor-lifecycle-and-audit`

Topic: `ef-core`

`ISaveChangesInterceptor` is the interface; `SaveChangesInterceptor` is the convenience base class so only needed methods must be overridden.

Common uses:

- auditing (`CreatedAt`, `UpdatedAt`, `CreatedBy`, `UpdatedBy`);
- soft delete;
- multi-tenant stamping;
- validation and global rules before saving;
- reacting after a successful save;
- automatically assigning a new GUID concurrency token before save.

## Lifecycle phases

The interceptor exposes separate methods for each outcome:

```text
before save starts     -> SavingChanges / SavingChangesAsync
after save succeeds    -> SavedChanges / SavedChangesAsync
save threw an error    -> SaveChangesFailed / SaveChangesFailedAsync
concurrency conflict   -> ThrowingConcurrencyException / ThrowingConcurrencyExceptionAsync
save was cancelled     -> SaveChangesCanceled / SaveChangesCanceledAsync
```

Each phase has synchronous and asynchronous versions.

## Event data types by phase

| Phase | Event data type |
|---|---|
| Before save | `DbContextEventData` |
| After success | `SaveChangesCompletedEventData` |
| On failure | `DbContextErrorEventData` |
| On concurrency | `ConcurrencyExceptionEventData` |

In `SavingChanges` / `SavingChangesAsync` the most useful property is:

```csharp
eventData.Context  // the current DbContext
```

## Pre-save method signatures

```csharp
public override InterceptionResult<int> SavingChanges(
    DbContextEventData eventData,
    InterceptionResult<int> result)

public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
    DbContextEventData eventData,
    InterceptionResult<int> result,
    CancellationToken cancellationToken = default)
```

Use these to inspect tracked entities and modify them before SQL is sent. In the normal path return the incoming `result` unchanged. The async version also receives cancellation.

## Inspecting the ChangeTracker before save

```csharp
public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
    DbContextEventData eventData,
    InterceptionResult<int> result,
    CancellationToken cancellationToken = default)
{
    var context = eventData.Context;

    foreach (var entry in context!.ChangeTracker.Entries())
    {
        // inspect Added / Modified / Deleted entities
    }

    return new(result);
}
```

This is where audit stamping, validation, soft-delete conversion, and similar pre-save mutations are performed.

## Audit timestamp interceptor

```csharp
public sealed class AuditSaveChangesInterceptor
    : SaveChangesInterceptor
{
    public override InterceptionResult<int> SavingChanges(
        DbContextEventData eventData,
        InterceptionResult<int> result)
    {
        var context = eventData.Context;
        if (context is null)
            return result;

        var now = DateTime.UtcNow;

        foreach (var entry in context.ChangeTracker.Entries())
        {
            if (entry.Entity is IAuditable auditable)
            {
                if (entry.State == EntityState.Added)
                {
                    auditable.CreatedAt = now;
                    auditable.UpdatedAt = now;
                }
                else if (entry.State == EntityState.Modified)
                {
                    auditable.UpdatedAt = now;
                }
            }
        }

        return result;
    }
}
```

Added entities receive both `CreatedAt` and `UpdatedAt`. Modified entities receive only `UpdatedAt`. The interceptor centralizes these timestamps so EF generates SQL with them already set.

## Post-save success method signatures

```csharp
public override int SavedChanges(
    SaveChangesCompletedEventData eventData,
    int result)

public override ValueTask<int> SavedChangesAsync(
    SaveChangesCompletedEventData eventData,
    int result,
    CancellationToken cancellationToken = default)
```

`result` is the integer returned by `SaveChanges` (affected-row count). Return it normally or return a different integer to change what the caller receives. Changing it is rare and should be deliberate.

Normal async return forms:

```csharp
return new(result);
// or
return ValueTask.FromResult(result);
```

## Post-save success logging example

The same `AuditSaveChangesInterceptor` class (or a dedicated logging interceptor) can also override `SavedChangesAsync`:

```csharp
public override ValueTask<int> SavedChangesAsync(
    SaveChangesCompletedEventData eventData,
    int result,
    CancellationToken cancellationToken = default)
{
    var context = eventData.Context;
    var contextName =
        context?.GetType().Name ?? "UnknownContext";

    Console.WriteLine(
        $"[{DateTime.UtcNow:O}] {contextName}: " +
        $"SaveChangesAsync succeeded. " +
        $"Rows/entities written: {result}");

    return new ValueTask<int>(result);
}
```

## Commit verification caveat

A successful SaveChanges callback does not prove that an outer transaction later committed. Command interceptors prove that a database command executed, but that command may still be rolled back later.

The lifecycle scopes also differ before command execution. A SaveChanges interceptor can enter `SavingChanges`, then EF can fail during change detection or another client/model step before it sends SQL. In that case a database-command interceptor may never run because there was no command to observe; `SaveChangesFailed` can still run for the failed SaveChanges lifecycle.

Conversely, when an INSERT really executes inside an outer transaction, a command interceptor can observe it and `SavedChanges` can report success, yet a later transaction rollback can remove the row. Durable audit or external event publishing at the SaveChanges boundary is therefore dangerous when it treats either callback as proof of final transaction commit.

## What should be recallable

- What interface and base class does SaveChanges interception use?
- Which five lifecycle phases have separate callbacks?
- Which event-data type is supplied before save, and which property gives the DbContext?
- Which entity states get `CreatedAt` set, and which get only `UpdatedAt`?
- What are the two normal async return forms from a post-save callback?
- Can a post-save callback reverse committed database changes?
- Why might SaveChanges callbacks run while no command interceptor runs?
- Why can neither command execution nor `SavedChanges` prove that a surrounding transaction ultimately committed?

## Related knowledge

- `ef-core.savechanges-interceptor-suppression-and-failure`
- `ef-core.changetracker-detection-cascade-and-save-lifecycle`
- `ef-core.dbcommand-interceptor-callbacks-and-sql-mutation`

## Sources

- Workspace: `_ai-conspects/dbcontext interseptors savechanges , dbcommand/`
- Authoritative processed source: `06-stage6-corrected-source-preserving-transcript-v003.md`, R01 (S-003, S-004, S-008, S-009, S-013, S-015, S-018, S-019, S-021) and R03 (S-034, S-052 — cancellation callbacks)
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB03-savechanges-generated-values-batching-clear.md`, interceptor lifecycle/audit portion
