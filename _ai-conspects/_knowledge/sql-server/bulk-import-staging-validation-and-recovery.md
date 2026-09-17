# Bulk-import staging, validation, and recovery

Knowledge ID: `sql-server.bulk-import-staging-validation-and-recovery`

Topic: `sql-server`

Directly bulk-inserting into a final table is often too blunt for messy or partially valid input. A staging table separates fast landing from validation, transformation, deduplication, merge/upsert, and error isolation:

```text
source -> bulk load staging -> validate/normalize/dedupe
-> transactional merge into final tables -> cleanup/audit
```

Staging can be a heap for fast raw loading, with indexes added after load when appropriate. Auxiliary columns such as `ImportId`, validation status, and error text separate concurrent imports and preserve diagnostics.

## Throughput is a combined decision

`TableLock`, `BatchSize`, indexes, triggers, constraints, transaction size, and transaction-log capacity interact. Larger batches reduce per-batch overhead but enlarge rollback and log impact. Table locks can raise loading throughput but reduce concurrency. Existing indexes/triggers/constraints add work. Large files may need chunking or a reader source to control both memory and log growth.

Decide which steps require one transaction. A common design loads staging first, then validates and merges final-table changes in a transaction. Cleanup or diagnostic retention may intentionally occur outside that critical transaction. There is no universal boundary; choose atomicity, retry, auditability, and log duration deliberately.

## Failed rows and cleanup

Production imports need a durable way to identify bad input. Options include:

- keep failed rows in staging with status/error details;
- delete successful rows so failures remain;
- move failures to a separate table/path;
- process cleanup in bounded batches;
- use a temporary/per-import table and drop it after success;
- use a shared table partitioned by `ImportId` and retention policy.

Dropping a temporary table is simple. Shared staging with import identity supports diagnostics, partial success, and later repair, but needs bounded cleanup and concurrency-safe queries.

## Reader and retry boundary

`IDataReader`/`DbDataReader` or a custom CSV reader avoids a full `DataTable` and fits one-pass/large input. That benefit changes failure handling: the source may not be rewindable, validation lacks a materialized whole-set view, and a retry may require reopening/reparsing the original source. Complex validation inside a custom reader is harder to test and explain.

Choose the simplest architecture that meets the constraints:

```text
small clean import                    -> DataTable/simple source
large input or memory pressure        -> reader/streaming source
messy input or partial failures       -> staging plus error records
upsert and final-table invariants      -> staging plus validated merge
detailed retry/failed-row diagnostics -> replayable source and retained staging state
```

## Sources

- Workspace: `_ai-conspects/sqlserver-efcore-bulk-sqlbulkcopy/`
- Authoritative processed source: `regions/R02R03-staging-performance-idatareader-final.md`, R02-R03
- Original SVG: `source/sqlserver-efcore-bulk-sqlbulkcopy.svg`
