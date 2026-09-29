# SQL Server MARS reader interleaving and yield points

Knowledge ID: `sql-server.mars-reader-interleaving-and-yield-points`

Topic: `sql-server`

## Multiple active results on one connection

SQL Server Multiple Active Result Sets (MARS) lets one physical connection have more than one active command or result set. A second reader can be opened before the first has been fully consumed, and the client can later continue an earlier reader.

The defining boundary is:

```text
multiple active result sets
= interleaved progress on one connection
!= unrestricted parallel execution
```

SQL Server controls when work may switch between requests. The word *active* does not imply that every statement executes simultaneously.

Without MARS, a workflow that needs another command on the same connection normally closes or fully buffers the first reader before continuing:

```text
execute roots query
-> read all roots into a client buffer
-> close Reader 1
-> query children
-> correlate children to buffered roots
-> query another child collection
-> correlate again
```

For an EF Core split query, that can mean buffering `Blog` roots, then reading `Posts`, then `Contributors`. EF builds one object graph by matching keys such as `BlogId`; it does not splice pieces from several SQL statements into one SQL row.

With MARS, the roots, posts, and contributors readers may remain active on the same connection while progress is interleaved:

```text
Reader 1: Blogs         active
Reader 2: Posts         active
Reader 3: Contributors  active

read root -> read related rows -> continue roots -> continue related rows
```

This can remove some intermediate-buffering pressure. The final graph still depends on key correlation and client-side materialization.

## Enablement and provider boundary

MARS is enabled in the SQL Server connection string:

```text
Server=.;Database=AppDb;Trusted_Connection=True;MultipleActiveResultSets=True;
```

SQL authentication can use the same option. No separate EF Core package is normally required: MARS is a SQL Server provider capability exposed through `Microsoft.Data.SqlClient`, not a provider-neutral EF Core setting.

Enabling it also changes transaction recovery behavior: EF Core does not create savepoints when MARS is enabled. That tradeoff belongs in the transaction-focused unit.

## Row-producing yield points

Interleaving occurs around work that yields rows or messages. `SELECT` is the ordinary example:

```sql
SELECT BlogId, Name
FROM Blogs;
```

A cursor produces rows incrementally through `FETCH`:

```sql
DECLARE c CURSOR FOR
SELECT Id, Name
FROM Person.Person;

OPEN c;

FETCH NEXT FROM c INTO @id, @name;
FETCH NEXT FROM c INTO @id, @name;
```

SQL Server Service Broker `RECEIVE` reads queued messages as a result set and is another row/message-producing yield point:

```sql
RECEIVE TOP (1)
    conversation_handle,
    message_type_name,
    message_body
FROM dbo.MyQueue;
```

These statements show where another MARS request *may* be interleaved; they do not promise parallelism or useful concurrent progress.

## Related knowledge

- `sql-server.mars-transactions-savepoints-and-tradeoffs`
- `ef-core.split-query-tradeoffs`

## What should be recallable

- What is the difference between an active result set, interleaving, and parallel execution?
- Why might a split query buffer roots without MARS?
- How does EF turn several result sets into one graph?
- How is MARS enabled, and why is it provider-specific?
- Why are `SELECT`, cursor `FETCH`, and Service Broker `RECEIVE` yield points?

## Sources

- Workspace: `_ai-conspects/sql-server-mars/`
- Processed source-preserving transcript: `04-source-preserving-transcript-v002.md`, S-001-S-019
- Original SVG: `source/sql-server-mars.svg`
