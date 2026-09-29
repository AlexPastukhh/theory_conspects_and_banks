# EF Core execution strategies, retry behavior, and configuration

Knowledge ID: `ef-core.execution-strategies-retry-behavior-and-configuration`

Topic: `ef-core`

An EF Core execution strategy is a policy that recognizes provider-specific transient database failures and retries an operation. Examples include a temporary network interruption, a short SQL Server or Azure SQL availability problem, or another error that the provider classifies as transient.

## Execution strategy configuration

For SQL Server, retry behavior is normally enabled when configuring the context:

```csharp
services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(
        connectionString,
        sql => sql.EnableRetryOnFailure()));
```

The retrying SQL Server strategy has provider defaults and a built-in set of transient SQL error numbers. The conspect records the common defaults as six retries and a maximum delay of thirty seconds. They can be customized:

```csharp
options.UseSqlServer(
    connectionString,
    sql => sql.EnableRetryOnFailure(
        maxRetryCount: 10,
        maxRetryDelay: TimeSpan.FromSeconds(30),
        errorNumbersToAdd: null));
```

A custom execution strategy can be registered when provider defaults are not enough.

`Database.CreateExecutionStrategy()` returns the strategy configured for the current `DbContext`. It is important to distinguish two modes:

1. When retries are enabled and there is no user-managed transaction, each query and each `SaveChanges` call is its own retriable unit.
2. When several operations must be retried as one logical unit, especially when code starts an explicit transaction, the whole unit must run inside the strategy delegate.

Without an explicit wrapper, the following calls may retry independently:

```csharp
var users = await db.Users.CountAsync();
var orders = await db.Orders.CountAsync();
await db.SaveChangesAsync();
```

That does not make the three calls one atomic or one retriable application operation.

## Explicit transactions must belong to the retry delegate

When code calls `BeginTransaction` or `BeginTransactionAsync`, retrying one inner command is not enough. A retry may need to recreate and replay the complete transaction. Therefore the transaction must be created inside the delegate passed to the execution strategy:

```csharp
var strategy = db.Database.CreateExecutionStrategy();

await strategy.ExecuteAsync(async () =>
{
    await using var tx = await db.Database.BeginTransactionAsync();

    var user = await db.Users.SingleAsync(x => x.Id == userId);
    user.Name = "A";

    await db.SaveChangesAsync();
    await tx.CommitAsync();
});
```

The strategy owns the complete attempt. On a transient failure it can invoke the delegate again, which creates a new transaction and replays the work.

A useful rule is to create fresh context and entity state inside the retry delegate when possible. Reusing already-mutated tracked objects can accumulate changes across attempts. For example, if a delegate executes `entity.Count += 1` on the same in-memory instance and is invoked twice, the application may increment twice before the successful database attempt. Rebuilding state in each attempt avoids this class of retry bug.

The delegate must contain the complete replayable logical operation. A reused context can also append the same child twice or retain `Added` entities from a failed attempt. A new context per attempt is the safest general pattern. SQL Server deadlock victim `1205` is a strong whole-operation retry candidate; lock timeout `1222` is situational and should normally trigger blocking/lock-duration diagnosis before it is added to retry classification.

An explicit transaction is not required just because `ExecuteAsync` is used. The strategy can also group a read, application calculation, and save into one retriable delegate without making the sequence atomic:

```csharp
await strategy.ExecuteAsync(async () =>
{
    var user = await db.Users.SingleAsync(x => x.Id == userId);
    user.LastSeenUtc = DateTime.UtcNow;
    user.VisitCount++;
    await db.SaveChangesAsync();
});
```

This means "replay the whole sequence after a transient failure", not "wrap the sequence in a database transaction".

## Execution-strategy diagnostics

An execution strategy is retry policy/helper logic, not an `IDisposable` resource. The context, connection, and transaction hold the resources and must follow their own disposal lifetimes; there is no strategy resource to dispose merely because `CreateExecutionStrategy()` returned an object.

A concrete SQL Server retrying strategy exposes useful diagnostic information such as:

- maximum retry count;
- maximum retry delay;
- exceptions encountered during retry attempts;
- additional SQL error numbers configured as transient.

This information can be logged after failure or when diagnosing a slow operation. Logging should preserve the original exception and the list of retry-triggering exceptions.

## What should be recallable

- What problem does an EF Core execution strategy solve?
- Which failures should normally be considered transient?
- What does `EnableRetryOnFailure` configure?
- What does `Database.CreateExecutionStrategy()` return?
- What is the default retriable unit when retries are enabled and no explicit transaction is used?
- Why are several independent EF calls not automatically one retriable application operation?
- Why must a user-created transaction be started inside the execution-strategy delegate?
- What can happen if an already-tracked entity is incremented inside a delegate that is retried?
- Why is fresh context or entity state often safer for every retry attempt?
- Can `ExecuteAsync` be useful without an explicit database transaction?
- What diagnostic information does a retrying strategy expose?

## Sources

- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 1-2, 9
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, "Execution strategies and retry boundaries"
