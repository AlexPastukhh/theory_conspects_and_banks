# SQL Server upsert, MERGE, and concurrency

Knowledge ID: `sql-server.upsert-merge-and-concurrency`

Topic: `sql-server`

## 1. Upsert

Upsert means:

```text
if row exists -> update it
else          -> insert it
```

A simple application-oriented shape:

```sql
IF EXISTS (SELECT 1 FROM dbo.Users WHERE Email = @Email)
BEGIN
    UPDATE dbo.Users
    SET Name = @Name
    WHERE Email = @Email;
END
ELSE
BEGIN
    INSERT INTO dbo.Users (Email, Name)
    VALUES (@Email, @Name);
END
```

This is easy to read and debug.

Use it when:

```text
one target row
simple key/existence predicate
clear business behavior
```

## 2. Upsert concurrency warning

Naive upsert has a race condition:

```text
session A checks row does not exist
session B checks row does not exist
both try INSERT
```

A unique constraint on the key is still required.

For safety:

```text
enforce uniqueness in the database
use transactions/locking where needed
handle duplicate-key errors when concurrent inserts race
```

The syntax block explains the shape, but production correctness depends on constraints and concurrency handling.

## 3. `MERGE`

`MERGE` can combine insert/update/delete logic.

Basic shape:

```sql
MERGE dbo.Target AS target
USING dbo.Source AS source
    ON target.Id = source.Id
WHEN MATCHED THEN
    UPDATE SET target.Name = source.Name
WHEN NOT MATCHED BY TARGET THEN
    INSERT (Id, Name)
    VALUES (source.Id, source.Name)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;
```

Mental model:

```text
target = table being changed
source = incoming rows
ON     = matching rule
WHEN MATCHED = update existing
WHEN NOT MATCHED BY TARGET = insert missing
WHEN NOT MATCHED BY SOURCE = optional delete rows missing from source
```

## 4. `MERGE` with `OUTPUT`

`MERGE` can return actions and changed rows.

Shape:

```sql
MERGE dbo.Users AS target
USING @Incoming AS source
    ON target.Email = source.Email
WHEN MATCHED THEN
    UPDATE SET Name = source.Name
WHEN NOT MATCHED BY TARGET THEN
    INSERT (Email, Name)
    VALUES (source.Email, source.Name)
OUTPUT
    $action AS MergeAction,
    inserted.Id,
    inserted.Email,
    inserted.Name;
```

`$action` tells whether the row was inserted, updated, or deleted.

Use `OUTPUT` when the caller needs changed IDs, rowversions, or action diagnostics.

## 5. Simpler alternative to `MERGE`

The notes treat the easier path as important:

```text
Sometimes IF EXISTS / UPDATE ELSE INSERT is easier than MERGE.
```

Reasons:

```text
easier to read
easier to debug
easier to add custom branching
less surprising for one-row operations
```

Use `MERGE` when the source/target set-based shape is actually valuable.

## What should be recallable

- Why a read-then-write upsert can race and what concurrency protection is required.
- When MERGE and MERGE OUTPUT fit, and when simpler UPDATE/INSERT logic is clearer.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R05-upsert-merge-transactions-indexes-alter-constraints-views.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
