# SQL Server MARS transactions, savepoints, and tradeoffs

Knowledge ID: `sql-server.mars-transactions-savepoints-and-tradeoffs`

Topic: `sql-server`

## Savepoints are disabled with MARS

EF Core does not create transaction savepoints when SQL Server MARS is enabled, even if the connection appears idle at the moment a savepoint would normally be created. This is a configuration-level compatibility boundary, not a check for whether one particular reader is currently open.

The conflict comes from combining one transaction with several active protocol streams or commands:

```text
one physical connection
-> one active transaction
-> Reader A active
-> Reader B active
-> another command active or pending
-> one request fails
-> ROLLBACK TO savepoint ?
```

A savepoint assumes a recoverable logical marker inside the transaction. With several active requests, already-observed rows, and commands at different logical positions, rollback-to-savepoint assumptions are not safe enough for EF Core to use automatically. MARS does not create parallel or isolated transactions; eligible work is only interleaved inside the same connection and transaction context.

If reliable savepoint-based recovery is important, enabling MARS can therefore be the wrong tradeoff. Code that relies on savepoints or execution recovery must account for their absence instead of assuming the usual `SaveChanges` rollback behavior remains available.

## MARS does not remove other bottlenecks

MARS mainly helps when the concrete problem is intermediate buffering caused by multiple active readers on one connection. It does not repair:

- high server CPU or a poor query plan;
- network latency;
- object materialization or tracking cost;
- lock contention;
- a reader or statement that cannot reach a useful yield point.

One request can still block another request on the same MARS connection because interleaving is constrained by statement and transaction behavior.

## Ownership and concurrency boundary

Do not use one MARS connection as a substitute for independently owned concurrent connections across threads. MARS operations and the surrounding provider/transaction objects are not thread-safe merely because several results may be active.

Prefer explicit ownership:

```text
one operation owns one connection
or
one deliberate unit of work owns one connection and transaction
```

When work is genuinely independent and must progress concurrently, separate connections are the clearer boundary. When nested access is not essential, buffering the outer result before the next command is often simpler. Enable MARS for a measured need, not as a default concurrency switch.

## Related knowledge

- `sql-server.mars-reader-interleaving-and-yield-points`
- `ef-core.transactions-isolation-savepoints-and-retries`
- `ef-core.split-query-tradeoffs`

## What should be recallable

- Why does EF Core disable savepoints whenever MARS is enabled?
- Why are several active readers not several independent transactions?
- Which bottlenecks are unaffected by MARS?
- Why should one MARS connection not be shared as a general concurrency primitive?
- When is a separate connection or explicit buffering a clearer design?

## Sources

- Workspace: `_ai-conspects/sql-server-mars/`
- Processed source-preserving transcript: `04-source-preserving-transcript-v002.md`, S-020-S-026
- Original SVG: `source/sql-server-mars.svg`
