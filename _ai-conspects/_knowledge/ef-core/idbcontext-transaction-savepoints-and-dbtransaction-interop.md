# EF Core IDbContextTransaction, savepoints, and DbTransaction interop

Knowledge ID: `ef-core.idbcontext-transaction-savepoints-and-dbtransaction-interop`

Topic: `ef-core`

`IDbContextTransaction` is EF's transaction control wrapper. It exposes commit, rollback, savepoints, and transaction metadata. The underlying ADO.NET `DbTransaction` is the bridge to raw commands, stored procedures, bulk APIs, or another `DbContext`.

## IDbContextTransaction API

### Commit / CommitAsync

Makes the whole transaction permanent. Use it when all steps succeeded and you want the database to keep the changes.

```csharp
await tx.CommitAsync();
```

### Rollback / RollbackAsync

Discards the transaction. Use it when anything important failed and you want none of that transaction's work to remain.

```csharp
await tx.RollbackAsync();
```

### CreateSavepoint / CreateSavepointAsync

Creates a named checkpoint inside the transaction. A savepoint lets you undo only the work that happened after that point, instead of throwing away the whole transaction.

```csharp
await tx.CreateSavepointAsync("after-order");
```

### RollbackToSavepoint / RollbackToSavepointAsync

Rewinds only to that checkpoint. It is useful when step 2 fails but step 1 was still valid and you want to keep the outer transaction open.

```csharp
await tx.RollbackToSavepointAsync("after-order");
```

### ReleaseSavepoint / ReleaseSavepointAsync

Removes a savepoint you no longer need. EF says this destroys the savepoint and allows the system to reclaim resources before the transaction ends.

```csharp
await tx.ReleaseSavepointAsync("after-order");
```

### SupportsSavepoints

Tells you whether the provider supports savepoints. If it is false, the savepoint methods are expected to throw `NotSupportedException`.

```csharp
if (tx.SupportsSavepoints)
{
    await tx.CreateSavepointAsync("x");
}
```

### TransactionId

Gives you an identifier for correlation. Helpful for tracing logs across service layers.

```csharp
_logger.LogInformation("Tx id: {Id}", tx.TransactionId);
```

## Savepoint overhead

A savepoint is a real transaction checkpoint. It is not a free object; it consumes transaction-related resources until released or until the transaction ends.

In large batch imports, automatic savepoints add some overhead. Whether it matters depends on how many chunks you have and how sensitive that path is. The docs do not give a numeric cost; the overhead is an engineering inference from the fact that savepoints are real transaction operations.

If you disable automatic savepoints for performance, your failure policy should usually be "rollback the whole transaction immediately" because without the savepoint a failed `SaveChanges` can leave the transaction in a bad or uncertain state.

## GetDbTransaction

`GetDbTransaction()` gives you the underlying relational `DbTransaction`. That is useful when mixing EF Core with raw ADO.NET, stored procedures, or another context that needs to enlist in the same transaction.

```csharp
var adoTx = tx.GetDbTransaction();
```

At runtime the underlying type is typically something like `SqlTransaction` for SQL Server, `NpgsqlTransaction` for PostgreSQL, or `SqliteTransaction` for SQLite. Those provider-specific classes derive from `DbTransaction`, which is the ADO.NET base class.

You do not need a provider-specific cast if all you need is the common transaction API. `CommitAsync` and `RollbackAsync` work through the base `DbTransaction` type. Cast only when you specifically need provider-specific behavior.

## Raw ADO.NET sharing

A common pattern is to begin an EF transaction, save through EF, get the `DbConnection` and `DbTransaction`, create a `DbCommand`, attach the same transaction, run manual SQL, then commit the EF transaction.

```csharp
await using var efTx = await db.Database.BeginTransactionAsync();

db.Orders.Add(order);
await db.SaveChangesAsync();

var conn = db.Database.GetDbConnection();
var adoTx = efTx.GetDbTransaction();

await using var cmd = conn.CreateCommand();
cmd.Transaction = adoTx;
cmd.CommandText = "UPDATE Inventory SET Quantity = Quantity - 1 WHERE ProductId = @p0";

var p = cmd.CreateParameter();
p.ParameterName = "@p0";
p.Value = order.ProductId;
cmd.Parameters.Add(p);

await cmd.ExecuteNonQueryAsync();

await efTx.CommitAsync();
```

EF work and raw SQL work now succeed or fail together. If the command fails, you can roll back the whole unit. You do not accidentally run raw SQL outside EF's transaction.

## Sharing one local transaction

To share one local transaction, participants must share both the same connection and the same transaction:

1. create one connection
2. create one transaction
3. make both contexts use that same connection
4. call `UseTransaction` for the second context, or for any context that did not create the transaction itself

`UseTransaction` does not merge two existing transactions. It only accepts one existing `DbTransaction` and tells EF to use it. If you already created two separate transactions, you are past the point where `UseTransaction` helps.

Same connection is not enough without same transaction. For plain ADO.NET on a connection with an active local transaction, executing a command without assigning the command's `Transaction` is a bad pattern. The safe mental model is: if another context must share the transaction, explicitly attach it with `UseTransaction`.

On one connection, do not design for two separate active local transactions for different participants. Expect failure or invalid behavior rather than anything useful.

## What should be recallable

- What does `IDbContextTransaction` give you beyond `DbTransaction`?
- What is the difference between `CreateSavepoint`, `RollbackToSavepoint`, and `ReleaseSavepoint`?
- When does `SupportsSavepoints` matter?
- What is `TransactionId` for?
- Why does `GetDbTransaction()` matter for raw ADO.NET interop?
- What must participants share to use one local transaction?
- What does `UseTransaction` actually do?
- Why is same connection not enough without same transaction?
- Why can two separate local transactions on one connection not be merged?

## Sources

- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB05-transaction-object-dbtransaction-usetransaction.md`
