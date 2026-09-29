# Optimistic concurrency resolution and savepoints

Knowledge ID: `ef-core.optimistic-concurrency-resolution-and-savepoints`

Topic: `ef-core`

A check-then-write workflow does not detect another writer unless the final database operation uses a concurrency token or the database rejects the resulting state. With `rowversion` or another concurrency token, EF Core compares the original token with the current database value and throws `DbUpdateConcurrencyException` when the expected row was not updated.

Conflict handling requires an explicit policy: abort, accept database values, reapply client values, or merge fields. A retrying handler reads current database values, applies its policy, updates the entry's original values to the new database snapshot, and only then retries. Automatic retry is appropriate only for a deterministic, safe merge rule; a human conflict should be surfaced rather than silently merged.

Inside an existing transaction, EF Core can use savepoints where supported. A recoverable later failure can roll back to a savepoint while retaining earlier valid work. This is unsafe when the transaction itself has a stale or failed view: a snapshot update conflict or another transaction-wide failure requires rollback and a new transaction with fresh reads.

## What should be recallable

- Why a pre-check alone does not detect a concurrent writer.
- How a concurrency token turns a missed update into `DbUpdateConcurrencyException`.
- The steps and policy choices in a valid conflict-resolution retry.
- When savepoint rollback can preserve earlier work and when the entire transaction must restart.

## Related knowledge

- `ef-core.isolation-levels-and-retry-semantics`
- `ef-core.savepoints-savechanges-and-transaction-recovery`

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr06-concurrency-provider-errors-v002.md`, "Optimistic concurrency" and "Savepoints"
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
