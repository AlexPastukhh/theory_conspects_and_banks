# EF Core savepoints, SaveChanges, and transaction recovery

Knowledge ID: `ef-core.savepoints-savechanges-and-transaction-recovery`

Topic: `ef-core`

## Savepoints around SaveChanges

If a transaction is already open, EF Core normally creates a savepoint before `SaveChanges`, provided the provider supports savepoints and automatic savepoints are enabled.

If the save fails, EF rolls the transaction back to that savepoint. Work committed earlier inside the still-open outer transaction remains part of the transaction. The application then decides whether to:

- correct the cause and call `SaveChanges` again;
- continue with another action;
- or roll back the whole transaction.

Example flow:

```csharp
await using var tx = await db.Database.BeginTransactionAsync();

db.Orders.Add(order);
await db.SaveChangesAsync();      // first save succeeds

db.OrderLines.Add(invalidLine);
await db.SaveChangesAsync();      // failure; EF rolls back this save to its savepoint
```

A failed `SaveChanges` does not necessarily roll back the entire outer transaction.

On SQL Server, Multiple Active Result Sets (MARS) is an important limitation: EF does not create these savepoints when MARS is enabled. After a save failure, the transaction may then be in a state that cannot be safely recovered in the same way.

A savepoint rollback and an execution-strategy retry are different mechanisms:

- savepoint rollback moves the current transaction back to an earlier checkpoint;
- execution-strategy retry reruns an operation or an entire delegate, usually with a new transaction attempt.

## SaveChanges(false) and AcceptAllChanges

The default `SaveChanges` behavior writes changes and then calls `AcceptAllChanges`. Accepting changes updates tracked states such as `Added` and `Modified` to `Unchanged` and updates original-value snapshots.

`SaveChanges(false)` writes to the database but deliberately does not accept tracked changes yet:

```csharp
await db.SaveChangesAsync(acceptAllChangesOnSuccess: false);
```

This matters when the database write may have succeeded but transaction success has not yet been safely confirmed. If tracked state were accepted too early, the context could lose the information needed to retry or recover using the same tracked objects.

The pattern is:

1. keep the entity changes in their pending tracked state;
2. execute and commit the transactional operation;
3. verify ambiguous success when necessary;
4. only after success is known, call `ChangeTracker.AcceptAllChanges()`.

`SaveChanges(false)` is not mandatory for every execution-strategy use. If every attempt creates a new context and reconstructs all state inside the delegate, preserving state from the failed attempt may not be useful. The deciding question is whether recovery depends on the current context retaining its pending changes.

## What should be recallable

- When does EF Core create a savepoint automatically?
- What does EF roll back when a `SaveChanges` call fails inside an existing transaction?
- Which work remains after rollback to the latest savepoint?
- Who decides whether to retry, continue, or roll back the whole transaction?
- Why is SQL Server MARS relevant to EF savepoints?
- How is savepoint rollback different from execution-strategy retry?
- What does normal `SaveChanges` do after a successful write?
- What is different about `SaveChanges(false)`?
- Why can accepting tracked changes too early make ambiguous-commit recovery harder?
- When should `ChangeTracker.AcceptAllChanges()` be called?
- When may `SaveChanges(false)` be unnecessary?
- What question determines whether tracked state needs to be preserved?

## Sources

- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 3-4
- Original SVG: `source/source-complete-v002.svg`
