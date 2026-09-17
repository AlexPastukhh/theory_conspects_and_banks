# SQL Server table schemas, identifiers, and foreign keys

Knowledge ID: `sql-server.table-schema-types-identifiers-and-foreign-keys`

Topic: `sql-server`

## 1. Common SQL Server data types

Common numeric/string/date types:

```text
int
bigint
decimal(p, s)
bit
date
time
datetime2
nvarchar(n)
varchar(n)
```

Other important SQL Server-specific types:

```text
uniqueidentifier
rowversion
varbinary(max)
```

Use `nvarchar` for Unicode text.

Use `datetime2` for modern date/time storage instead of old `datetime` when possible.

Use `decimal(p, s)` for precise numeric values such as money-like quantities where binary floating point is not acceptable.

## 2. `CREATE TABLE`

Basic table:

```sql
CREATE TABLE dbo.Users
(
    Id int IDENTITY(1,1) NOT NULL,
    Name nvarchar(100) NOT NULL,
    Email nvarchar(200) NOT NULL,
    CreatedAt datetime2 NOT NULL,
    CONSTRAINT PK_Users PRIMARY KEY (Id)
);
```

Meaning:

```text
schema.table name
column name
data type
NULL / NOT NULL
IDENTITY
constraints
primary key
```

## 3. `uniqueidentifier`, `NEWID()`, and `NEWSEQUENTIALID()`

GUID column:

```sql
Id uniqueidentifier NOT NULL DEFAULT NEWID()
```

`NEWID()` generates a random GUID.

`NEWSEQUENTIALID()` generates a more sequential GUID and can reduce index fragmentation when used as a clustered key.

Typical table:

```sql
CREATE TABLE dbo.Events
(
    Id uniqueidentifier NOT NULL DEFAULT NEWID(),
    Name nvarchar(100) NOT NULL,
    CONSTRAINT PK_Events PRIMARY KEY (Id)
);
```

Important:

```text
NEWSEQUENTIALID() can be used as a DEFAULT constraint, not usually as a normal ad-hoc scalar call.
```

## 5. Foreign keys and cascade

Foreign key:

```sql
CREATE TABLE dbo.Orders
(
    Id int IDENTITY(1,1) NOT NULL,
    UserId int NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY (Id),
    CONSTRAINT FK_Orders_Users
        FOREIGN KEY (UserId)
        REFERENCES dbo.Users(Id)
);
```

Cascade delete:

```sql
ON DELETE CASCADE
```

Meaning:

```text
when parent row is deleted, child rows can be automatically deleted
```

Use cascade carefully because it can delete many related rows.

Other actions may include:

```text
NO ACTION
SET NULL
CASCADE
```

depending on relationship and constraints.

## What should be recallable

- How common SQL Server types, CREATE TABLE, GUID generation, foreign keys, and cascade rules shape a table contract.
- Why identifier/default choices and referential actions are schema decisions.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R04-core-table-dml-output-variables-if-trycatch.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
