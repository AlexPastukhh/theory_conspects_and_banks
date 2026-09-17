# SQL Server rowversion concurrency and returned values

Knowledge ID: `sql-server.rowversion-concurrency-and-returning-values`

Topic: `sql-server`

## 9. `rowversion`

`rowversion` is a binary value SQL Server changes automatically when the row is updated.

Example column:

```sql
RowVersion rowversion NOT NULL
```

It is often used for optimistic concurrency:

```sql
UPDATE dbo.Users
SET Name = @Name
WHERE Id = @Id
  AND RowVersion = @OriginalRowVersion;
```

Then check whether the update happened:

```sql
IF @@ROWCOUNT = 0
BEGIN
    THROW 50001, 'Concurrency conflict', 1;
END
```

Important:

```text
rowversion is not a timestamp/date.
Do not treat it as a time value.
It is a database-generated binary concurrency token.
```

## 10. Updating and returning new rowversion

A common pattern is to update a row and return the new rowversion.

Using `OUTPUT`:

```sql
DECLARE @Updated table (NewRowVersion varbinary(8));

UPDATE dbo.Users
SET Name = @Name
OUTPUT inserted.RowVersion INTO @Updated
WHERE Id = @Id
  AND RowVersion = @OriginalRowVersion;

SELECT NewRowVersion FROM @Updated;
```

This connects to R04's `OUTPUT inserted/deleted` material, but the stored-procedure/concurrency-owner idea belongs here.

## 4. `rowversion`

`rowversion` is an auto-generated binary value that changes whenever the row is updated.

Example:

```sql
RowVersion rowversion NOT NULL
```

Use it for optimistic concurrency:

```text
client reads row + rowversion
client sends original rowversion back
UPDATE checks Id and RowVersion
if zero rows updated -> conflict
```

Again:

```text
rowversion is not a date/time timestamp.
```

## What should be recallable

- What rowversion represents and how it participates in optimistic concurrency predicates.
- How an update can return the new rowversion and distinguish a lost race.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R03-stored-proc-output-params-control-flow-rowversion.md`, listed sections
- Authoritative processed source: `regions/R04-core-table-dml-output-variables-if-trycatch.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
