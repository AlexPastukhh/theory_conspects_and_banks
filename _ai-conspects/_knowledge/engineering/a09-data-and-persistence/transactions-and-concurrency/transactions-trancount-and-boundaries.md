# SQL Server transactions, TRANCOUNT, and boundaries

Knowledge ID: `sql-server.transactions-trancount-and-boundaries`

Topic: `sql-server`

## 6. Transactions

Transaction pattern:

```sql
BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE dbo.Accounts
    SET Balance = Balance - @Amount
    WHERE Id = @FromAccountId;

    UPDATE dbo.Accounts
    SET Balance = Balance + @Amount
    WHERE Id = @ToAccountId;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
```

Meaning:

```text
BEGIN TRANSACTION -> start atomic unit
COMMIT            -> persist all changes
ROLLBACK          -> undo all changes in transaction
```

Use transactions when multiple statements must succeed/fail together.

## 7. `@@TRANCOUNT`

`@@TRANCOUNT` tells how many active transactions are open in the current session.

Inside catch blocks:

```sql
IF @@TRANCOUNT > 0
    ROLLBACK TRANSACTION;
```

This avoids trying to rollback when there is no active transaction.

## What should be recallable

- How BEGIN/COMMIT/ROLLBACK define atomic work.
- What @@TRANCOUNT reports and why nested transaction assumptions require care.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R05-upsert-merge-transactions-indexes-alter-constraints-views.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
