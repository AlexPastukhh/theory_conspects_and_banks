# SQL Server database creation, files, system databases, and batches

Knowledge ID: `sql-server.database-creation-files-system-databases-and-batches`

Topic: `sql-server`

## 1. `CREATE DATABASE` basic structure

A basic database creation command:

```sql
CREATE DATABASE TestDb;
```

The fuller shape can include data files and log files:

```sql
CREATE DATABASE TestDb
ON PRIMARY
(
    NAME = TestDb_Data,
    FILENAME = 'C:\SqlData\TestDb.mdf',
    SIZE = 10MB,
    MAXSIZE = 100MB,
    FILEGROWTH = 10MB
)
LOG ON
(
    NAME = TestDb_Log,
    FILENAME = 'C:\SqlData\TestDb.ldf',
    SIZE = 5MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
);
```

Meaning:

```text
database name       -> logical database name
ON PRIMARY          -> primary data file/filegroup section
LOG ON              -> transaction log section
NAME                -> logical file name inside SQL Server
FILENAME            -> physical file path
SIZE                -> initial size
MAXSIZE             -> maximum size
FILEGROWTH          -> growth step
```

## 2. Primary data files and log files

Primary data file:

```text
stores database data and metadata
often has .mdf extension
belongs to PRIMARY filegroup by default
```

Log file:

```text
stores transaction log records
often has .ldf extension
required for recovery and transaction consistency
```

The notes separate the sections:

```text
ON PRIMARY -> data file options
LOG ON     -> log file options
```

This makes the physical layout explicit and avoids relying only on defaults.

## 3. Default database/log behavior

If you do not specify a log file, SQL Server still creates one.

The default values come from server/database defaults and, for new database templates, from `model`.

The practical point:

```text
CREATE DATABASE without LOG ON does not mean "no log".
Every database has a transaction log.
```

This matters because log growth and max size can surprise you if defaults are not understood.

## 4. Checking database files

System views can be used to inspect created files.

Typical query shape:

```sql
SELECT
    name,
    type_desc,
    physical_name,
    size / 128.0 AS CurrentSizeMB,
    CASE max_size
        WHEN -1 THEN 'UNLIMITED'
        ELSE CAST(max_size / 128.0 AS varchar(20)) + ' MB'
    END AS MaxSizeMB,
    growth
FROM sys.master_files
WHERE database_id = DB_ID('TestDb');
```

Important conversion:

```text
size is stored in 8KB pages
size / 128.0 = MB
```

This explains the proof/check for log/data current size and limits.

## 5. `master`

`master` is a SQL Server system database.

Purpose:

```text
instance-level metadata
logins
server configuration
endpoints
database metadata
system-level information
```

If `master` is damaged, the instance can be unusable.

Practical rule:

```text
do not create user application tables in master
use master for instance-level operations and metadata queries
```

## 6. `model`

`model` is the template database used when SQL Server creates a new database.

If you customize `model`, those customizations can appear in future databases.

Examples of defaults affected by `model`:

```text
recovery model
file sizes / growth settings
database options
objects intentionally placed in model
```

The notes show checking model defaults and demonstrate that changes in `model` can influence newly created databases.

Use this carefully:

```text
changing model affects future databases, not existing ones
```

## 7. System databases

Important system databases:

```text
master
model
msdb
tempdb
Resource
```

Basic purpose:

```text
master   -> instance metadata and configuration
model    -> template for new databases
msdb     -> SQL Agent jobs, backup history, maintenance metadata
tempdb   -> temporary objects and working space; recreated on restart
Resource -> hidden read-only system objects
```

The road emphasizes knowing what each contains and why you normally should not use system databases as regular application databases.

## 8. `GO`

`GO` separates batches in SQL Server tools such as SSMS or sqlcmd.

Important:

```text
GO is not a T-SQL command.
SQL Server engine does not execute GO.
The client tool splits the script at GO and sends separate batches.
```

Example:

```sql
CREATE DATABASE DemoDb;
GO

USE DemoDb;
GO

CREATE TABLE dbo.Items
(
    Id int NOT NULL
);
GO
```

Why `GO` matters:

```text
some DDL statements must be first/alone in a batch
variables do not cross GO boundaries
it can separate context-changing operations
```

## 9. `GO n`

`GO` can repeat the previous batch in tools that support it:

```sql
PRINT 'Hello';
GO 5
```

This executes the batch five times.

The notes warn that this can accidentally run `CREATE` or `INSERT` logic multiple times if used carelessly.

## 10. Variable scope across batches

Variables declared before `GO` do not exist after `GO`:

```sql
DECLARE @x int = 1;
GO

SELECT @x; -- error: variable no longer exists
```

Reason:

```text
GO starts a new batch
local T-SQL variables are batch-scoped
```

## 11. Multiple query windows / connections

Multiple query windows can mean multiple connections.

That can affect:

```text
database context
transactions
temp tables
variables
settings
locks
```

Practical takeaway:

```text
If a script behaves differently in another query window, check connection/session context and selected database.
```

The notes also mention confusing behavior around using `model` or another database in one query file/window and seeing different results in another.

## What should be recallable

- How CREATE DATABASE, primary/log files, defaults, master, model, and other system databases relate.
- How GO, GO n, batch-local variables, and separate query-window connections affect execution.

## Related knowledge

- `sql-server.stored-procedure-contracts-and-result-channels`

## Sources

- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R01-database-creation-master-model-go-files.md`, listed sections
- Original SVG: `source/sql-syntax-sql-server.svg`
