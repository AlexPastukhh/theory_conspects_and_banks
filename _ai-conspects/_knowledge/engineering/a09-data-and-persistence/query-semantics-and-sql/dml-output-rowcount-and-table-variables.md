# SQL Server DML, OUTPUT, row counts, and table variables

Knowledge ID: `sql-server.dml-output-rowcount-and-table-variables`

Topic: `sql-server`

## 6. `INSERT`

Basic insert:

```sql
INSERT INTO dbo.Users (Name, Email, CreatedAt)
VALUES (N'Alex', N'alex@example.com', SYSDATETIME());
```

Insert multiple rows:

```sql
INSERT INTO dbo.Users (Name, Email)
VALUES
    (N'Alex', N'a@example.com'),
    (N'Bob', N'b@example.com');
```

Insert from select:

```sql
INSERT INTO dbo.ArchiveUsers (Id, Name, Email)
SELECT Id, Name, Email
FROM dbo.Users
WHERE IsDeleted = 1;
```

## 7. `UPDATE`

Basic update:

```sql
UPDATE dbo.Users
SET Name = N'New name'
WHERE Id = @Id;
```

Important:

```text
Always think about WHERE.
Without WHERE, UPDATE affects all rows in the table.
```

Update with multiple columns:

```sql
UPDATE dbo.Users
SET
    Name = @Name,
    Email = @Email
WHERE Id = @Id;
```

## 8. `DELETE`

Basic delete:

```sql
DELETE FROM dbo.Users
WHERE Id = @Id;
```

Important:

```text
Without WHERE, DELETE removes all rows from the table.
```

Often prefer soft delete in application schemas:

```sql
UPDATE dbo.Users
SET IsDeleted = 1
WHERE Id = @Id;
```

when permanent physical deletion is not desired.

## 9. `OUTPUT inserted` / `OUTPUT deleted`

The `OUTPUT` clause returns values affected by DML.

Insert:

```sql
INSERT INTO dbo.Users (Name)
OUTPUT inserted.Id, inserted.Name
VALUES (N'Alex');
```

Update:

```sql
UPDATE dbo.Users
SET Name = N'Alex Updated'
OUTPUT deleted.Name AS OldName, inserted.Name AS NewName
WHERE Id = @Id;
```

Delete:

```sql
DELETE FROM dbo.Users
OUTPUT deleted.Id, deleted.Name
WHERE Id = @Id;
```

Mental model:

```text
inserted = new row version
deleted  = old row version
```

For `INSERT`, only `inserted` exists.

For `DELETE`, only `deleted` exists.

For `UPDATE`, both exist:

```text
deleted  -> old values
inserted -> new values
```

## 10. `OUTPUT INTO`

Store changed rows in a table variable:

```sql
DECLARE @Changed table
(
    Id int,
    OldName nvarchar(100),
    NewName nvarchar(100)
);

UPDATE dbo.Users
SET Name = @Name
OUTPUT deleted.Id, deleted.Name, inserted.Name
INTO @Changed
WHERE Id = @Id;

SELECT * FROM @Changed;
```

Use this when you need to:

```text
audit changed rows
return generated IDs
return new rowversion
compare old/new values
drive follow-up logic
```

## 11. Variables and table variables

Scalar variable:

```sql
DECLARE @UserId int = 1;
DECLARE @Name nvarchar(100);
```

Table variable:

```sql
DECLARE @Changed table
(
    Id int,
    OldValue nvarchar(100),
    NewValue nvarchar(100)
);
```

Table variables are useful for capturing `OUTPUT INTO` rows in small/local procedural logic.

## 15. DML safety checklist

Before running DML:

```text
For UPDATE/DELETE, check WHERE.
For important changes, run SELECT with the same predicate first.
For concurrency, check rowversion or expected state.
For caller feedback, use OUTPUT or @@ROWCOUNT.
For multi-step changes, use transaction + TRY/CATCH.
```

## What should be recallable

- How INSERT, UPDATE, DELETE, OUTPUT inserted/deleted, and OUTPUT INTO expose changed rows.
- How scalar/table variables and DML safety checks support controlled writes.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R04-core-table-dml-output-variables-if-trycatch.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
