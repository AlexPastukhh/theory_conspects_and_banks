# EF Core isolation levels and retry semantics

Knowledge ID: `ef-core.isolation-levels-and-retry-semantics`

Topic: `ef-core`

`EnableRetryOnFailure` decides whether to retry based on transient exceptions, not directly on transaction isolation level. Isolation level still matters because it determines what a retry inside the same transaction can observe.

A single `SaveChanges` is normally transactional. Multiple `SaveChanges` calls, bulk/set-based operations, or raw SQL do not become one atomic unit merely because they use the same context; an explicit transaction must surround the complete logical operation when all effects must commit or roll back together. Isolation controls what concurrent transactions observe, while atomicity comes from that transaction boundary. Later SQL in one transaction normally sees earlier SQL writes in that transaction. `ReadUncommitted` permits dirty database reads but cannot expose unsaved ChangeTracker mutations, because those exist only in client memory until SQL is sent.

## Read Committed

Under SQL Server `READ COMMITTED`, values can change between statements. A transaction that rolls back to a savepoint and performs a new query may observe a more recent committed state. This makes same-transaction re-read and retry plausible for some application-level conflict resolution.

## Read Committed Snapshot (RCSI)

`READ_COMMITTED_SNAPSHOT` is a SQL Server database option. With the option enabled, a transaction using `IsolationLevel.ReadCommitted` reads a version-consistent snapshot as of the start of each statement.

After rolling back to a savepoint, the next statement can normally see data committed before that next statement. Reads use row versions rather than holding ordinary shared read locks for the full transaction.

RCSI is not a separate `IsolationLevel` enum value passed from EF Core:

```csharp
await db.Database.BeginTransactionAsync(IsolationLevel.ReadCommitted);
```

Whether that transaction uses lock-based Read Committed or RCSI depends on the SQL Server database setting. The `READ_COMMITTED_SNAPSHOT` option is SQL Server and Azure SQL specific. Other providers may use MVCC, but that is not the same named database option.

## Snapshot

Under SQL Server `SNAPSHOT`, the transaction sees data as of the start of the transaction. Rolling back to a savepoint does not create a newer transaction snapshot. If recovery requires current data, restart the entire transaction.

## Repeatable Read

SQL Server holds shared locks on rows that were read until transaction completion. Same-transaction savepoint retry is usually less useful because the transaction intentionally preserves a stable locked view. Keep these transactions short and normally restart the complete transaction after failure.

## Serializable

Serializable adds range protection and preserves the read set even more strongly. It favors correctness at the cost of concurrency. Retrying the whole transaction is normally clearer than remaining in the same transaction and expecting a fresher view.

## Match the failure to the correct retry mechanism

### Transient infrastructure failure

Examples: dropped connection, temporary service unavailability, recognized transient timeout.

Use an execution strategy. The retry unit is one EF operation or the complete strategy delegate.

### Optimistic concurrency conflict

Example: `DbUpdateConcurrencyException` caused by a row-version or concurrency-token mismatch.

This is not normally a transient execution-strategy error. Resolve it at the application level:

- reload current database values;
- merge or choose values;
- update the concurrency token;
- retry the logical operation on the new state.

The appropriate transaction restart behavior depends on isolation level.

### Unknown commit outcome

A connection failure during commit can leave the final outcome unknown. This is neither a savepoint problem nor a normal concurrency conflict. Use idempotent operation design, durable verification, or `ExecuteInTransactionAsync` with `verifySucceeded`.

## What should be recallable

- Does isolation level directly decide whether `EnableRetryOnFailure` retries?
- Under `ReadCommitted`, why can same-transaction re-read after a savepoint be useful?
- What does `READ_COMMITTED_SNAPSHOT` change?
- Is RCSI a separate EF `IsolationLevel` enum value?
- Why does `Snapshot` usually favor restarting the transaction?
- Why are `RepeatableRead` and `Serializable` poor fits for hoping to see fresher data after a savepoint?
- How should `DbUpdateConcurrencyException` normally be handled?
- Which failure type belongs to execution-strategy retry?
- Which failure type belongs to application conflict resolution?
- Which failure type requires verification or idempotency?
- Why is an unknown commit outcome not a savepoint problem?

## Sources

- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 10-11
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, "Atomicity versus isolation"
