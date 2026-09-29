# SQL Server procedural control flow, variables, and errors

Knowledge ID: `sql-server.procedural-control-flow-variables-and-errors`

Topic: `sql-server`

## 1. `BEGIN ... END`

`BEGIN ... END` groups multiple statements.

Without a block, an `IF` controls only one statement.

Pattern:

```sql
IF @IsActive = 1
BEGIN
    UPDATE dbo.Users
    SET LastSeenAt = SYSDATETIME()
    WHERE Id = @UserId;

    INSERT INTO dbo.AuditLog(UserId, Message)
    VALUES (@UserId, N'User touched');
END
```

Use it for:

```text
IF/ELSE branches
stored procedure bodies
TRY/CATCH blocks
multi-statement control flow
```

## 2. `IF`, `ELSE`, and `IF EXISTS`

Basic branching:

```sql
IF @Count > 0
BEGIN
    SELECT N'Has rows' AS Message;
END
ELSE
BEGIN
    SELECT N'No rows' AS Message;
END
```

Existence check:

```sql
IF EXISTS (SELECT 1 FROM dbo.Users WHERE Email = @Email)
BEGIN
    SELECT N'Already exists' AS Message;
END
```

`IF EXISTS` is often preferable to `COUNT(*) > 0` when only existence matters.

## 3. `DECLARE`

Local variables:

```sql
DECLARE @UserId int;
DECLARE @Name nvarchar(100);
DECLARE @Now datetime2 = SYSDATETIME();
```

Variables are scoped to the current batch/procedure.

Because `GO` starts a new batch, a variable declared before `GO` does not exist after `GO`.

## 4. `SET` vs `SELECT` assignment

`SET` assigns one variable:

```sql
SET @Name = N'Alex';
```

`SELECT` can assign from a query:

```sql
SELECT @Name = Name
FROM dbo.Users
WHERE Id = @UserId;
```

`SELECT` can assign multiple variables:

```sql
SELECT
    @Name = Name,
    @Email = Email
FROM dbo.Users
WHERE Id = @UserId;
```

Important behavior difference:

```text
SET is clearer for simple assignment.
SELECT is common when assigning from a query.
If SELECT returns multiple rows, the final assigned value may be the last row processed, which is unsafe unless the query is guaranteed to be single-row.
```

## 12. `@@ROWCOUNT`

`@@ROWCOUNT` returns the number of rows affected by the previous statement.

Example:

```sql
UPDATE dbo.Users
SET Name = @Name
WHERE Id = @Id;

IF @@ROWCOUNT = 0
BEGIN
    THROW 50001, 'User not found or concurrency conflict', 1;
END
```

Important:

```text
Read/capture @@ROWCOUNT immediately.
Another statement can change it.
```

Safer:

```sql
DECLARE @Rows int = @@ROWCOUNT;
```

right after the target DML statement.

## 13. `TRY...CATCH`

Basic pattern:

```sql
BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE dbo.Users
    SET Name = @Name
    WHERE Id = @Id;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    THROW;
END CATCH;
```

Inside `CATCH`, SQL Server exposes error details:

```text
ERROR_NUMBER()
ERROR_MESSAGE()
ERROR_SEVERITY()
ERROR_STATE()
ERROR_LINE()
ERROR_PROCEDURE()
```

Use these for logging/debugging.

## 14. `THROW`

`THROW` raises or rethrows an error.

Rethrow current error:

```sql
THROW;
```

Throw custom error:

```sql
THROW 50001, 'Something went wrong', 1;
```

Notes:

```text
custom error number should be >= 50000
THROW preserves error details better than old RAISERROR patterns when rethrowing
```

## What should be recallable

- How BEGIN/END, IF/ELSE, DECLARE, SET, SELECT assignment, and @@ROWCOUNT behave.
- How TRY...CATCH and THROW preserve or propagate procedural failure.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R03-stored-proc-output-params-control-flow-rowversion.md`, listed sections
- Authoritative processed source: `regions/R04-core-table-dml-output-variables-if-trycatch.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
