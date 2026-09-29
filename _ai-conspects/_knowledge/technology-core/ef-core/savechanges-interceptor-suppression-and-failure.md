# SaveChangesInterceptor suppression, failure, and concurrency

Knowledge ID: `ef-core.savechanges-interceptor-suppression-and-failure`

Topic: `ef-core`

## Where suppression is possible

Only the pre-save callbacks can suppress the pending save:

- `SavingChanges` / `SavingChangesAsync` — can suppress the entire save operation.

Post-save callbacks (`SavedChanges*`) cannot undo a completed save; they can only observe or replace the returned integer.

Suppressing the normal save from `SavingChanges*` does not mean the post-save lifecycle disappears; the source notes that `SavedChanges` is still called afterward even for a suppressed save.

This generalizes across EF interception: suppression belongs to the callback for the pending operation, not to a callback that runs after the operation completes.

## InterceptionResult and HasResult

`InterceptionResult<T>` carries both the suppress/continue decision and, when suppressed, the replacement result.

If `HasResult == true`, EF suppresses the operation and uses the replacement result instead.

```csharp
public override ValueTask<InterceptionResult<int>> SavingChangesAsync(
    DbContextEventData eventData,
    InterceptionResult<int> result,
    CancellationToken cancellationToken = default)
{
    return new(
        InterceptionResult<int>.SuppressWithResult(0));
}
```

EF does not execute the normal save; `SaveChangesAsync()` returns `0`.

## Return type cannot change

`SuppressWithResult` can replace the result value but not the method's declared return type. The public API remains `Task<int>`; the caller always receives an `int`. A custom result type cannot be introduced through interception.

## Richer outcome reporting via side channels

When the caller needs to know more than a raw integer, encode or report it through an explicit side channel:

- **scoped marker service** — the most explicit pattern:

```csharp
public sealed class SaveOutcome
{
    public bool WasSuppressed { get; set; }
}
```

Register as scoped. The interceptor sets `WasSuppressed = true`; the repository checks the service after `SaveChangesAsync()` returns.

- reserve a sentinel integer value such as `-999`;
- log or publish a domain event;
- throw and catch a domain-specific exception.

A scoped marker is clearer than a magic number because it is named and type-safe.

## Modifying the post-save returned count

A post-save interceptor can alter the integer returned to the caller:

```csharp
public override ValueTask<int> SavedChangesAsync(
    SaveChangesCompletedEventData eventData,
    int result,
    CancellationToken cancellationToken = default)
{
    return new ValueTask<int>(result + 1000);
}
```

The actual database work and affected rows do not change; only the caller-visible integer changes. This is usually a bad production practice.

## Failure callbacks

`SaveChangesFailed` / `SaveChangesFailedAsync` run when `SaveChanges` throws. They receive `DbContextErrorEventData` with `Context` and `Exception`.

```csharp
public sealed class FailureLoggingInterceptor
    : SaveChangesInterceptor
{
    public override Task SaveChangesFailedAsync(
        DbContextErrorEventData eventData,
        CancellationToken cancellationToken = default)
    {
        var ex = eventData.Exception;
        var contextName =
            eventData.Context?.GetType().Name
            ?? "UnknownContext";

        Console.WriteLine(
            $"[{DateTime.UtcNow:O}] {contextName}: " +
            $"SaveChangesAsync failed: " +
            $"{ex.GetType().Name}: {ex.Message}");

        return Task.CompletedTask;
    }
}
```

Failure callbacks are for logging, cleanup, and compensating behavior; they do not return an alternate save result.

## Concurrency callbacks

`ThrowingConcurrencyException` / `ThrowingConcurrencyExceptionAsync` run before EF throws `DbUpdateConcurrencyException`. They receive `ConcurrencyExceptionEventData` with `Context`, `Exception`, and `Entries` — the tracked entries involved in the conflict.

For relational providers, cast to `RelationalConcurrencyExceptionEventData` for extra database-operation information.

Returning the incoming `result` unchanged lets EF throw normally. Using `InterceptionResult.Suppress()` prevents the throw.

```csharp
// log and let EF throw
return new ValueTask<InterceptionResult>(result);

// suppress the throw
return new ValueTask<InterceptionResult>(
    InterceptionResult.Suppress());
```

### Relationship between concurrency and failure callbacks

Safe practical model:

1. `ThrowingConcurrencyException*` runs first.
2. If it is not suppressed, EF throws `DbUpdateConcurrencyException` and the ordinary failure path is expected to apply.
3. If it is suppressed, there is no thrown concurrency exception, so the ordinary exception-driven failure path is not the same.

### When suppressing a concurrency exception is valid

Suppression is advanced. Typical valid scenarios:

- treat a conflict as a non-error in a special workflow;
- convert "somebody already updated/deleted this" into idempotent success;
- perform custom conflict-resolution logic;
- idempotent delete where the desired final state is already achieved.

After suppression the application must provide a clear follow-up policy. Options:

- reload state from the database;
- detach conflicted entries;
- mark them unchanged;
- return a domain-level status.

Suppression does not automatically resolve the conflicted state; it only prevents EF from raising the exception.

### Suppression example

```csharp
public sealed class SuppressConcurrencyInterceptor
    : SaveChangesInterceptor
{
    public override ValueTask<InterceptionResult>
        ThrowingConcurrencyExceptionAsync(
            ConcurrencyExceptionEventData eventData,
            InterceptionResult result,
            CancellationToken cancellationToken = default)
    {
        Console.WriteLine(
            "Suppressing optimistic concurrency exception.");

        return new ValueTask<InterceptionResult>(
            InterceptionResult.Suppress());
    }
}
```

## Cancellation callbacks

`SaveChangesCanceled` / `SaveChangesCanceledAsync` run when `SaveChangesAsync` is canceled. They receive `DbContextEventData` and are for logging, metrics, cleanup, and tracing correlation IDs. They do not return an alternate affected-row count.

```csharp
public sealed class CancellationInterceptor
    : SaveChangesInterceptor
{
    public override Task SaveChangesCanceledAsync(
        DbContextEventData eventData,
        CancellationToken cancellationToken = default)
    {
        Console.WriteLine(
            $"[{DateTime.UtcNow:O}] SaveChangesAsync was canceled for " +
            $"{eventData.Context?.GetType().Name}");

        return Task.CompletedTask;
    }
}
```

## What should be recallable

- Which callback can suppress the save, and which cannot?
- What does `HasResult == true` tell EF?
- Why can the interceptor not change `SaveChangesAsync` to a different return type?
- What is the scoped marker service pattern for richer outcome reporting?
- Which event-data type carries the failed-save exception?
- What are `Entries` in `ConcurrencyExceptionEventData`?
- In what order do concurrency and failure callbacks run?
- Give one valid idempotent scenario for suppressing a concurrency exception.
- What must the application do after suppressing a concurrency exception?

## Related knowledge

- `ef-core.savechanges-interceptor-lifecycle-and-audit`
- `ef-core.changetracker-detection-cascade-and-save-lifecycle`

## Sources

- Workspace: `_ai-conspects/dbcontext interseptors savechanges , dbcommand/`
- Authoritative processed source: `06-stage6-corrected-source-preserving-transcript-v003.md`, R02 (S-001, S-005, S-007, S-014, S-030, S-037, S-056, S-057) and R03 (S-017, S-022, S-025, S-026, S-027, S-028, S-034, S-040, S-044, S-049, S-050, S-051, S-052, S-053)
- Original SVG: `source/source-complete-v002.svg`
