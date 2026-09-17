# SQL Server schema evolution, indexes, and constraints

Knowledge ID: `sql-server.schema-evolution-indexes-and-constraints`

Topic: `sql-server`

## 8. Indexes

Indexes help SQL Server find rows faster.

Basic nonclustered index:

```sql
CREATE INDEX IX_Users_Email
ON dbo.Users (Email);
```

Unique index:

```sql
CREATE UNIQUE INDEX UX_Users_Email
ON dbo.Users (Email);
```

Composite index:

```sql
CREATE INDEX IX_Orders_UserId_CreatedAt
ON dbo.Orders (UserId, CreatedAt);
```

Practical rule:

```text
create indexes for real query predicates, joins, sorting, and uniqueness needs
```

Tradeoff:

```text
faster reads
slower writes
more storage
maintenance cost
```

## 9. Clustered vs nonclustered

Conceptual distinction:

```text
clustered index    -> data physically organized by key order
nonclustered index -> separate lookup structure pointing to rows
```

A table usually has one clustered index.

Primary keys often create an index, but primary key and clustered index are not the same concept.

## 10. `ALTER TABLE`

Add column:

```sql
ALTER TABLE dbo.Users
ADD IsActive bit NOT NULL CONSTRAINT DF_Users_IsActive DEFAULT 1;
```

Drop column:

```sql
ALTER TABLE dbo.Users
DROP COLUMN MiddleName;
```

Alter column:

```sql
ALTER TABLE dbo.Users
ALTER COLUMN Name nvarchar(200) NOT NULL;
```

Be careful:

```text
ALTER COLUMN can fail if existing data violates the new type/nullability/length.
DROP COLUMN can break dependent objects/code.
```

## 11. Constraints

Primary key:

```sql
ALTER TABLE dbo.Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id);
```

Foreign key:

```sql
ALTER TABLE dbo.Orders
ADD CONSTRAINT FK_Orders_Users
FOREIGN KEY (UserId) REFERENCES dbo.Users(Id);
```

Unique constraint:

```sql
ALTER TABLE dbo.Users
ADD CONSTRAINT UQ_Users_Email UNIQUE (Email);
```

Default constraint:

```sql
ALTER TABLE dbo.Users
ADD CONSTRAINT DF_Users_CreatedAt
DEFAULT SYSDATETIME() FOR CreatedAt;
```

Check constraint:

```sql
ALTER TABLE dbo.Products
ADD CONSTRAINT CK_Products_Price_Positive
CHECK (Price >= 0);
```

## 12. Add / drop constraints

Drop constraint:

```sql
ALTER TABLE dbo.Users
DROP CONSTRAINT UQ_Users_Email;
```

Common note:

```text
You drop constraints by constraint name.
```

So consistent naming matters:

```text
PK_Table
FK_Child_Parent
UQ_Table_Column
DF_Table_Column
CK_Table_Rule
```

## 15. DDL safety checklist

Before applying DDL:

```text
Check existing data.
Check dependencies.
Name constraints explicitly.
Run migrations in a controlled environment.
Understand locks/table size.
Back up important data.
```

For schema changes:

```text
add nullable column first if needed
backfill data
then make NOT NULL or add stricter constraint
```

This avoids failing on existing rows.

## What should be recallable

- How clustered/nonclustered indexes, ALTER TABLE, and constraints change physical access and schema invariants.
- How to add/drop constraints and apply a DDL safety checklist.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R05-upsert-merge-transactions-indexes-alter-constraints-views.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
