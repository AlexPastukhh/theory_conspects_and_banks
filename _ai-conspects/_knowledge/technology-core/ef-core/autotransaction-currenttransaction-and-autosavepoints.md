# EF Core AutoTransactionBehavior, CurrentTransaction, and AutoSavepoints

Knowledge ID: `ef-core.autotransaction-currenttransaction-and-autosavepoints`

Topic: `ef-core`

## SaveChanges atomicity and AutoTransactionBehavior

SaveChanges remains a single atomic save unit on providers that support transactions. By default, if the provider supports transactions, all changes in one SaveChanges call are applied transactionally. EF says that if any change fails, the transaction is rolled back and none of the changes are applied.

However, that does not always mean EF starts an explicit transaction itself. `AutoTransactionBehavior` controls whether EF creates its own explicit transaction when no user transaction exists.

### WhenNeeded (default)

This is the default. EF says transactions are automatically created as needed, and that most single SQL statements are implicitly transactional already, so an extra explicit transaction is not required.

For a single statement, EF may decide an explicit BEGIN TRANSACTION / COMMIT is unnecessary. The statement is still atomic at the database level. This is why WhenNeeded is the best default for most apps: it keeps the safety of SaveChanges while avoiding unnecessary transaction round trips for trivial single-statement saves.

For multiple statements in one SaveChanges, EF sees that multiple SQL statements are required and creates an explicit transaction to ensure atomicity.

### Always

Always creates explicit transaction boundaries for every save. This can add overhead but ensures consistent transaction boundaries.

### Never

Never prevents automatic transaction creation and is risky except in very specialized contexts. It can make practical sense in specific scenarios where you want complete manual control, but this requires careful transaction management.

AutoTransactionBehavior only matters when you have not already started or provided a transaction with BeginTransaction() or UseTransaction().

## CurrentTransaction for transaction ownership

`CurrentTransaction` returns the current EF Core transaction, or null if none is active. Use it when your code may run in two modes:

- sometimes standalone
- sometimes inside a broader transaction started by caller code

It helps you avoid doing the wrong thing, like starting a nested transaction, committing a transaction you do not own, or skipping special handling when a transaction is already active.

A common pattern:

```csharp
var ownsTransaction = db.Database.CurrentTransaction == null;

if (ownsTransaction)
    await db.Database.BeginTransactionAsync();

try
{
    db.Orders.Add(order);
    await db.SaveChangesAsync();

    db.AuditLogs.Add(new AuditLog { Message = $"Order {order.Id} created" });
    await db.SaveChangesAsync();

    if (ownsTransaction)
        await db.Database.CommitTransactionAsync();
}
catch
{
    if (ownsTransaction && db.Database.CurrentTransaction != null)
        await db.Database.RollbackTransactionAsync();

    throw;
}
```

Flow:

- Case A: no outer transaction → CurrentTransaction == null → method starts a transaction and commits
- Case B: outer transaction already exists → CurrentTransaction != null → method does not start a new transaction → SaveChanges calls participate in the existing transaction → outer caller decides commit/rollback

This is especially useful when mixing EF Core operations with raw ADO.NET / Dapper / stored procedures. If a transaction already exists, you want the raw SQL command to use the same connection + transaction, not run outside it.

## AutoSavepointsEnabled

`AutoSavepointsEnabled` controls whether SaveChanges creates a savepoint inside a manually started transaction. The default is true. EF says that means SaveChanges will create a savepoint inside that manually started transaction, assuming the provider supports savepoints. EF also warns that setting it to false should be done cautiously because the database could be left in a corrupted state if SaveChanges fails.

The practical split:

- true: you want safer mid-transaction recovery and retry behavior
- false: you plan to roll back the whole transaction on any save failure anyway, or you want full manual control over savepoint placement

Flow with AutoSavepointsEnabled = true:

1. Manual transaction begins
2. Before first SaveChanges, EF creates a savepoint
3. Order insert succeeds
4. Before second SaveChanges, EF creates another savepoint
5. If the reservation save fails, EF rolls back to that savepoint
6. The surrounding transaction remains usable instead of being completely blown away

This is especially useful when the second or third SaveChanges may fail due to optimistic concurrency or other database issues, and you still want the transaction to remain recoverable.

For large batch imports where you might disable automatic savepoints to reduce overhead, you should have a deliberate savepoint/failure policy.

## What should be recallable

- What does AutoTransactionBehavior control?
- When is WhenNeeded appropriate and why is it the default?
- What is the difference between WhenNeeded for single vs multiple statements?
- When might Always or Never be appropriate?
- What does CurrentTransaction return and when is it useful?
- How does CurrentTransaction help with transaction ownership?
- What does AutoSavepointsEnabled control?
- When is AutoSavepointsEnabled = true useful?
- What are the risks of setting AutoSavepointsEnabled = false?

## Sources

- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB02-auto-transactions-current-transaction-savepoints.md`
