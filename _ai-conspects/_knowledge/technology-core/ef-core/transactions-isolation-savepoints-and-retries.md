# EF Core transactions, isolation, savepoints, and retries

Knowledge ID: `ef-core.transactions-isolation-savepoints-and-retries`

Topic: `ef-core`

Atomicity and isolation answer different questions. Atomicity decides whether a unit commits all changes or none; isolation decides what concurrent transactions can observe while reads influence later writes.

## Transaction boundary and execution timing

A relational provider normally wraps one `SaveChanges` call in a transaction. Separate calls are separate units unless an explicit transaction owns both:

```csharp
await using var transaction = await db.Database.BeginTransactionAsync(ct);
try
{
    db.Orders.Add(order);
    await db.SaveChangesAsync(ct);

    db.OutboxMessages.Add(ToOutboxMessage(order));
    await db.SaveChangesAsync(ct);

    await transaction.CommitAsync(ct);
}
catch
{
    await transaction.RollbackAsync(ct);
    throw;
}
```

`ExecuteSql*`, `ExecuteUpdate*`, and `ExecuteDelete*` execute immediately. Tracked changes wait for `SaveChanges`. Put them under the same explicit owner when they must commit atomically; nested services sharing one `DbContext` should not independently begin or commit competing transactions.

LINQ construction is deferred: a query joins the transaction when it is materialized, not when its variable is declared. Database reads can see SQL writes already executed by the same transaction, but an unsaved tracked change exists only in the change tracker and is not automatically part of a database query.

`rowversion`, another EF concurrency token, or an HTTP precondition protects a stale write. It does not create a stable snapshot across several reads or replace an atomic multi-operation transaction.

## Explicit transaction ownership and cleanup

The ordinary owner-controlled lifecycle is begin, perform every required write, commit on success, and rollback on failure. The transaction object owns that begin/commit/rollback boundary; `SaveChanges` only flushes EF work into the active transaction.

Disposal of an uncommitted transaction supplies a failure cleanup path, but an explicit `RollbackAsync` in `catch` can still be useful when cleanup must happen immediately before later catch logic. After rollback, application policy decides whether to log, compensate outside the rolled-back transaction, return a domain result, or rethrow. Those actions are distinct from the rollback itself.

## SQL Server isolation models

- Read Uncommitted can observe dirty values and also permits non-repeatable reads and phantoms; it is normally unsuitable for correctness-sensitive decisions.
- SQL Server defaults to Read Committed unless configured otherwise. In its lock-based form, read locks are normally released at statement completion while write locks are held to transaction completion, so two statements in one transaction may observe different committed values.
- Read Committed Snapshot Isolation (RCSI) gives each statement a row-versioned snapshot, reducing reader/writer blocking while retaining statement-level rather than transaction-level consistency.
- Repeatable Read protects rows already read from modification for the transaction, but new matching rows can still appear according to the provider, access path, and range.
- Snapshot gives one transaction-level versioned view. An update based on an older version can conflict; SQL Server commonly reports error `3960`. Retry the whole logical transaction from a fresh snapshot.
- Serializable protects predicate ranges and prevents phantoms when the provider, access path/index, and competing writers participate in the same invariant-enforcing protocol.

Snapshot/RCSI availability and exact behavior depend on database/provider configuration; SQL Server Snapshot isolation must be enabled for the database before a transaction can request it.

Locks and version dependencies arise as statements touch rows or ranges according to the query plan, indexes, isolation level, and provider—not merely at `BeginTransaction`. Serializable cannot preserve a shared invariant when another writer bypasses the compatible protocol. Prefer a database constraint or atomic SQL operation when it can express the invariant directly.

Use optimistic tokens for ordinary stale single-row edits. Consider Snapshot for a stable multi-statement view when its conflict model is acceptable. Use Serializable only for a range/absence invariant that cannot be expressed more directly.

## Execution strategies and whole-unit retry

A provider execution strategy can retry transient failures. A user-managed transaction must be created and executed inside the strategy delegate so every attempt starts a new transaction and rereads state:

```csharp
var strategy = db.Database.CreateExecutionStrategy();

await strategy.ExecuteAsync(async () =>
{
    await using var transaction = await db.Database.BeginTransactionAsync(ct);

    var account = await db.Accounts
        .SingleAsync(x => x.Id == accountId, ct);

    account.Debit(amount);
    await db.SaveChangesAsync(ct);
    await transaction.CommitAsync(ct);
});
```

Creating the transaction outside the delegate would ask the strategy to retry only part of a user-owned transaction. Retry the smallest complete replay-safe logical unit, not an isolated command after the surrounding state has changed.

## Savepoints and partial rollback

A savepoint can undo a later portion of work without abandoning the outer transaction:

When `SaveChanges` runs inside an already active transaction, EF Core can create an automatic savepoint before writing when the provider and connection configuration support it. Manual savepoints expose the same partial-recovery boundary explicitly:

```csharp
await using var transaction = await db.Database.BeginTransactionAsync(ct);
await transaction.CreateSavepointAsync("BeforeOptionalStep", ct);

try
{
    await RunOptionalStepAsync(db, ct);
    await db.SaveChangesAsync(ct);
}
catch
{
    await transaction.RollbackToSavepointAsync("BeforeOptionalStep", ct);
}

await transaction.CommitAsync(ct);
```

Provider support and connection settings matter. Rolling back to a savepoint undoes writes after it, but does not refresh the version visible to an existing Snapshot transaction.

## Ambiguous commit and replay safety

A connection failure around commit can leave the client unable to tell whether the server committed:

```text
client sends COMMIT
-> server may commit
-> connection drops before acknowledgement
-> client cannot distinguish committed from rolled back
```

Blindly repeating a non-idempotent operation can duplicate effects. Stable operation IDs, idempotency keys, unique constraints, operation/outbox records, or explicit verification make the outcome discoverable and replay safer. Do not continue with a transaction whose state is unknown.

## Contention and practical selection

Keep transactions short, access resources in a consistent order, index predicates used for changes/range checks, avoid user interaction inside the transaction, and retry the whole logical unit after a transient failure or deadlock.

On a deadlock, SQL Server chooses a victim and rolls that transaction back. Treat it as a failed unit and retry the whole replay-safe logical transaction rather than continuing from partial application state.

- One provider-supported `SaveChanges`: use its automatic transaction.
- Several writes that must be atomic: use one explicit transaction owner.
- Stale single-row edit: use an optimistic concurrency token.
- Stable multi-statement read view: consider Snapshot.
- Absence/count/range invariant: prefer a constraint or atomic SQL; use Serializable only when needed.
- Transient retry: put transaction creation and all work inside the execution strategy.
- Partial recovery inside a transaction: use a supported savepoint.

## What should be recallable

- When does `SaveChanges` supply an automatic transaction, and when is an explicit owner needed?
- How do immediate bulk/raw commands, deferred queries, and unsaved tracked state differ?
- How do lock-based Read Committed, RCSI, Repeatable Read, Snapshot, and Serializable differ?
- Why must a retrying execution strategy recreate the transaction and reread state?
- What can a savepoint undo, and what does it not refresh?
- Why is a lost commit acknowledgement dangerous for a non-idempotent retry?
- When are concurrency tokens, constraints, Snapshot, and Serializable appropriate?

## Multiple contexts and transaction sharing

Two relational contexts can participate in one transaction when they share the same underlying `DbConnection` and `DbTransaction`, and the second context is enlisted with `UseTransaction`.

In that arrangement one commit or rollback covers the database work of both contexts. This is a same-database relational transaction pattern. It does not automatically provide a distributed transaction across unrelated databases.

Using one context configured with retries and another without retries can be useful, for example to separate large true-streaming reads from normal resilient operations. Retry behavior is normally a context/provider configuration, not a per-query switch on the same context.

## Sources

- Workspace: `_ai-conspects/transaction-isolation/`
- Authoritative processed source: `regions/r01r02r03r04-final-coverage-transcript-v001.md`, R01-R04
- Original SVG: `source/transaction-isolation.svg`
- Workspace: `_ai-conspects/transaction, isolation/`
- Authoritative processed source: `01-final-transcript.md`, R01-R04
- Original SVG: `source/transaction, isolation.svg`
- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, section 8
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, explicit-transaction lifecycle, rollback, and post-rollback uses `NU-014`-`NU-018`, `NU-029`-`NU-033`
