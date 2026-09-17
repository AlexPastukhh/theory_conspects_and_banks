# EF Core SaveChanges flush lifecycle and rollback scope

Knowledge ID: `ef-core.savechanges-flush-lifecycle-and-rollback-scope`

Topic: `ef-core`

`SaveChanges` is an EF flush operation: it turns tracked in-memory changes into real database commands. It is not necessarily one SQL query, and it is not the same as committing a transaction.

## SaveChanges is a flush, not a single query

One `SaveChanges()` means one flush, but that flush may contain many SQL statements. If the change tracker holds 1,000 entities, EF may send many INSERT statements, often batched together.

```text
One SaveChanges ≠ one INSERT
One SaveChanges ≠ always one round trip
One SaveChanges = one EF flush operation
```

EF batches multiple statements when possible, but batching has limits depending on provider, generated values, relationships, parameter limits, and configuration.

## Flush pipeline

When you call `SaveChangesAsync()`, EF turns tracked object changes into real database commands:

1. detects what changed
2. builds INSERT/UPDATE/DELETE commands
3. orders commands correctly
4. opens/uses a database connection
5. sends commands to the database
6. reads generated values back, such as identity IDs
7. updates entity states if save succeeded

## Transaction state lives in the database engine

The transaction lives in the database engine, attached to a specific database connection/session. EF Core does not store the transaction in memory. EF only holds a handle to it.

```text
DbContext
  -> DbConnection
      -> DbTransaction handle
          -> real transaction state inside the database
```

When you begin a transaction, EF tells the database to begin the transaction.

## Rows are written before commit

Inside an outer transaction, `SaveChanges` sends real database commands, but the changes are uncommitted until commit. Other transactions usually cannot see them, depending on isolation level.

Conceptually, the database sees:

```text
BEGIN TRANSACTION;
INSERT A;
INSERT B;
-- changes are real but uncommitted --
COMMIT;
-- or --
ROLLBACK;
```

`SaveChanges` inside an outer transaction can later be rolled back. Rollback undoes rows that were already sent by `SaveChanges` because they belong to the uncommitted transaction.

## Add vs SaveChanges vs Commit vs Rollback

The important distinction:

```text
Add(...)         -> EF memory only
SaveChanges()    -> sends SQL to database transaction
Commit()         -> makes the transaction permanent
Rollback()       -> tells database to undo everything in the transaction
```

## What should be recallable

- What does one `SaveChanges` mean: one flush or one SQL query?
- What are the steps in the SaveChanges flush pipeline?
- Where does the transaction state actually live?
- Are rows written to the database before commit inside an outer transaction?
- Can rollback undo rows that were already sent by SaveChanges?
- What is the clean mental model: Add = memory, SaveChanges = SQL sent to transaction, Commit = permanent, Rollback = undo?

## Sources

- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB04-savechanges-transaction-lifecycle-flush-rollback.md`
