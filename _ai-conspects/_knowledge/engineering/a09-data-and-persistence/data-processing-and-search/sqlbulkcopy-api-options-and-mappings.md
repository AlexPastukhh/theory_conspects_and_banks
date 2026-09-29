# SqlBulkCopy API, options, and column mappings

Knowledge ID: `sql-server.sqlbulkcopy-api-options-and-mappings`

Topic: `sql-server`

`SqlBulkCopy` is a direct SQL Server bulk-insert path. It can load many rows faster than ordinary EF Core change tracking, but it is not an update/merge abstraction and does not automatically enforce application-domain invariants.

A representative lifecycle is:

```csharp
await using var connection = new SqlConnection(connectionString);
await connection.OpenAsync(cancellationToken);

using var bulk = new SqlBulkCopy(connection)
{
    DestinationTableName = "dbo.Destination"
};

bulk.ColumnMappings.Add("SourceName", "DestinationName");

bulk.WriteToServer(dataTable);
```

Set `BatchSize` and `BulkCopyTimeout` when the workflow requires them. Dispose/close the bulk-copy object and own the connection/transaction lifetime explicitly. Sources can be a `DataTable`, `DataRow[]`, `IDataReader`, or `DbDataReader`-style forward stream. `DataTable` is convenient but materializes the dataset; readers support streaming and database-to-database/custom-parser flows.

## Schema and mappings

Explicit mappings by name or ordinal are safer than relying on source/destination order. When only some destination columns are mapped, every unmapped column must be satisfied by identity generation, a SQL default, nullability, or another database rule.

Bulk copy is not a general conversion layer. Validate source values against SQL type, size, precision, nullability, constraints, and intended normalization. Mapping/type/constraint failures can abort a batch coarsely, which is why messy imports often need staging.

## Behavioral options

Options are database-side behavior switches:

- `TableLock` can improve throughput while reducing concurrency;
- `KeepIdentity` preserves supplied identity values instead of generating them;
- `KeepNulls` preserves incoming nulls instead of allowing defaults to fill them;
- `CheckConstraints` enables constraint checks during load;
- `FireTriggers` runs insert triggers;
- internal transaction support gives bulk copy its own transaction boundaries.

These choices interact. Constraints, triggers, indexes, locks, batches, and transaction boundaries all affect throughput and failure behavior. An internal transaction differs from a caller-managed transaction that coordinates staging, validation, and final merge work.

## What should be recallable

- Why SqlBulkCopy is separate from EF change tracking and merge/upsert behavior.
- Source-shape memory/streaming differences and explicit mapping rules.
- Identity, null/default, constraint, trigger, lock, and transaction switches.
- Why schema validation and failed-row isolation need surrounding design.

## Sources

- Workspace: `_ai-conspects/sqlserver-efcore-bulk-sqlbulkcopy/`
- Authoritative processed source: `regions/R01-core-sqlbulkcopy-api-options-type-mapping.md`, R01
- Original SVG: `source/sqlserver-efcore-bulk-sqlbulkcopy.svg`
