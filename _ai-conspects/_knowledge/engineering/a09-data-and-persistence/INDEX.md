# A09 — Data & Persistence

This index is a physical/navigation projection. Finer semantic placement remains in the semantic hierarchy.

## Caching & Derived State

### Area-owned Units

- [`aspnet-core.distributed-cache-storage-and-invalidation` — Distributed cache storage, expiration, and invalidation](caching-and-derived-state/distributed-cache-storage-and-invalidation.md)
- [`dotnet.hybridcache-key-tag-invalidation` — HybridCache key and tag invalidation](caching-and-derived-state/hybridcache-key-tag-invalidation.md)
- [`dotnet.hybridcache-local-cache-flags` — HybridCache local-cache read/write flags](caching-and-derived-state/hybridcache-local-cache-flags.md)
- [`dotnet.hybridcache-registration-getorcreate-and-single-flight` — HybridCache registration, GetOrCreateAsync, and single-flight](caching-and-derived-state/hybridcache-registration-getorcreate-and-single-flight.md)
- [`aspnet-core.imemorycache-expiration-invalidation-and-stampede` — IMemoryCache expiration, invalidation, and stampede control](caching-and-derived-state/imemorycache-expiration-invalidation-and-stampede.md)

## Data Access & ORM

### Area-owned Units

- [`dotnet.ado-net-abstractions-portability-and-lifecycle` — ADO.NET abstractions, portability, and resource lifecycle](data-access-and-orm/ado-net-abstractions-portability-and-lifecycle.md)
- [`dotnet.ado-net-command-execution-and-row-mapping` — ADO.NET command execution, parameters, and row mapping](data-access-and-orm/ado-net-command-execution-and-row-mapping.md)
- [`ef-core.database-failure-layers-and-sql-server-classification` — Database failure layers and SQL Server classification](data-access-and-orm/database-failure-layers-and-sql-server-classification.md)
- [`ef-core.entity-materialization-and-safe-constructors` — Entity materialization and safe constructors](data-access-and-orm/entity-materialization-and-safe-constructors.md)
- [`ef-core.entityentry-navigations-explicit-load-and-query` — EntityEntry navigations, explicit load, and Query()](data-access-and-orm/entityentry-navigations-explicit-load-and-query.md)
- [`ef-core.entityentry-state-values-and-property-control` — EntityEntry state, values, and property control](data-access-and-orm/entityentry-state-values-and-property-control.md)
- [`ef-core.global-query-filters-and-required-navigations` — Global query filters and required navigations](data-access-and-orm/global-query-filters-and-required-navigations.md)
- [`ef-core.iqueryable-repository-and-resource-boundaries` — IQueryable repository and resource boundaries](data-access-and-orm/iqueryable-repository-and-resource-boundaries.md)
- [`ef-core.shadow-properties-and-persistence-only-state` — Shadow properties and persistence-only state](data-access-and-orm/shadow-properties-and-persistence-only-state.md)
- [`ef-core.trackgraph-disconnected-graphs-and-nodestate` — TrackGraph, disconnected graphs, and NodeState](data-access-and-orm/trackgraph-disconnected-graphs-and-nodestate.md)

### Technology Core links

- [`ef-core.changetracker-detection-cascade-and-save-lifecycle` — ChangeTracker detection, cascade timing, and save lifecycle](../../technology-core/ef-core/changetracker-detection-cascade-and-save-lifecycle.md)
- [`ef-core.changetracker-tracking-and-state-events` — ChangeTracker Tracking, Tracked, and state-change events](../../technology-core/ef-core/changetracker-tracking-and-state-events.md)
- [`ef-core.dbcommand-interceptor-callbacks-and-sql-mutation` — DbCommandInterceptor callbacks, result shapes, and SQL mutation](../../technology-core/ef-core/dbcommand-interceptor-callbacks-and-sql-mutation.md)
- [`ef-core.dbcommand-interceptor-event-data-and-command-properties` — DbCommandInterceptor event data properties and DbCommand shortlist](../../technology-core/ef-core/dbcommand-interceptor-event-data-and-command-properties.md)
- [`ef-core.dbcontext-configuration-encapsulation` — DbContext configuration encapsulation](../../technology-core/ef-core/dbcontext-configuration-encapsulation.md)
- [`ef-core.alternate-keys-and-principal-key-targets` — EF Core alternate keys and principal-key relationship targets](../../technology-core/ef-core/alternate-keys-and-principal-key-targets.md)
- [`ef-core.backing-fields-and-property-access-modes` — EF Core backing fields and property access modes](../../technology-core/ef-core/backing-fields-and-property-access-modes.md)
- [`ef-core.composite-keys-relationships-and-indexes` — EF Core composite keys, relationships, and indexes](../../technology-core/ef-core/composite-keys-relationships-and-indexes.md)
- [`ef-core.database-view-and-defining-query-mapping` — EF Core database-view and defining-query mapping](../../technology-core/ef-core/database-view-and-defining-query-mapping.md)
- [`ef-core.dbcontext-pooling-tenant-and-connection-state` — EF Core DbContext pooling, tenant state, and connection cleanup](../../technology-core/ef-core/dbcontext-pooling-tenant-and-connection-state.md)
- [`ef-core.executeupdate-executedelete-and-set-based-dml` — EF Core ExecuteUpdate, ExecuteDelete, and set-based DML](../../technology-core/ef-core/executeupdate-executedelete-and-set-based-dml.md)
- [`ef-core.fromsql-and-sqlquery-apis` — EF Core FromSql and SqlQuery APIs](../../technology-core/ef-core/fromsql-and-sqlquery-apis.md)
- [`ef-core.fromsql-parameterization-and-dynamic-sql` — EF Core FromSql parameterization and safe dynamic SQL](../../technology-core/ef-core/fromsql-parameterization-and-dynamic-sql.md)
- [`ef-core.identity-sequences-and-hilo-key-generation` — EF Core identity, sequences, and HiLo key generation](../../technology-core/ef-core/identity-sequences-and-hilo-key-generation.md)
- [`ef-core.index-configuration` — EF Core index configuration](../../technology-core/ef-core/index-configuration.md)
- [`ef-core.inheritance-mapping-tph-tpt-tpc` — EF Core inheritance mapping with TPH, TPT, and TPC](../../technology-core/ef-core/inheritance-mapping-tph-tpt-tpc.md)
- [`ef-core.json-converted-collections-and-sql-server-querying` — EF Core JSON-converted collections and SQL Server querying](../../technology-core/ef-core/json-converted-collections-and-sql-server-querying.md)
- [`ef-core.keyless-models-vs-direct-sql-results` — EF Core keyless models versus direct SQL results](../../technology-core/ef-core/keyless-models-vs-direct-sql-results.md)
- [`ef-core.lazy-loading-and-query-shaping` — EF Core lazy loading and query shaping](../../technology-core/ef-core/lazy-loading-and-query-shaping.md)
- [`ef-core.linq-relational-translation-shapes` — EF Core LINQ relational translation shapes](../../technology-core/ef-core/linq-relational-translation-shapes.md)
- [`ef-core.manual-dbcontext-and-multi-context-patterns` — EF Core manual DbContext construction and multi-context patterns](../../technology-core/ef-core/manual-dbcontext-and-multi-context-patterns.md)
- [`ef-core.many-to-many-join-entities-and-delete-behavior` — EF Core many-to-many join entities and delete behavior](../../technology-core/ef-core/many-to-many-join-entities-and-delete-behavior.md)
- [`ef-core.migrations-development-and-deployment-workflows` — EF Core migrations in development and deployment](../../technology-core/ef-core/migrations-development-and-deployment-workflows.md)
- [`ef-core.model-configuration-conventions-and-discovery` — EF Core model configuration, conventions, and discovery](../../technology-core/ef-core/model-configuration-conventions-and-discovery.md)
- [`ef-core.owned-references-collections-and-relational-identity` — EF Core owned references, collections, and relational identity](../../technology-core/ef-core/owned-references-collections-and-relational-identity.md)
- [`ef-core.relational-property-types-collations-and-metadata` — EF Core relational property types, collations, and metadata](../../technology-core/ef-core/relational-property-types-collations-and-metadata.md)
- [`ef-core.retry-buffering-and-streaming-behavior` — EF Core retry buffering and streaming behavior](../../technology-core/ef-core/retry-buffering-and-streaming-behavior.md)
- [`ef-core.savechanges-flush-lifecycle-and-rollback-scope` — EF Core SaveChanges flush lifecycle and rollback scope](../../technology-core/ef-core/savechanges-flush-lifecycle-and-rollback-scope.md)
- [`ef-core.savechanges-generated-values-batching-and-changetracker` — EF Core SaveChanges generated values, batching, and ChangeTracker.Clear](../../technology-core/ef-core/savechanges-generated-values-batching-and-changetracker.md)
- [`ef-core.stored-procedure-cud-mapping-and-concurrency` — EF Core stored-procedure CUD mapping and concurrency](../../technology-core/ef-core/stored-procedure-cud-mapping-and-concurrency.md)
- [`ef-core.stored-procedure-query-command-and-composition` — EF Core stored-procedure query, command, and composition boundaries](../../technology-core/ef-core/stored-procedure-query-command-and-composition.md)
- [`ef-core.search-with-like` — EF Core substring and LIKE search](../../technology-core/ef-core/search-with-like.md)
- [`ef-core.value-converters-and-mutable-value-comparers` — EF Core value converters and mutable value comparers](../../technology-core/ef-core/value-converters-and-mutable-value-comparers.md)
- [`ef-core.value-generation-defaults-and-save-behavior` — EF Core value generation, defaults, and save behavior](../../technology-core/ef-core/value-generation-defaults-and-save-behavior.md)
- [`ef-core.optional-nested-owned-values-and-requiredness` — Optional nested owned values and requiredness](../../technology-core/ef-core/optional-nested-owned-values-and-requiredness.md)
- [`ef-core.savechanges-interceptor-lifecycle-and-audit` — SaveChangesInterceptor lifecycle, event data, and audit stamping](../../technology-core/ef-core/savechanges-interceptor-lifecycle-and-audit.md)
- [`ef-core.savechanges-interceptor-suppression-and-failure` — SaveChangesInterceptor suppression, failure, and concurrency](../../technology-core/ef-core/savechanges-interceptor-suppression-and-failure.md)
- [`ef-core.tracking-queries-identity-resolution-and-projections` — Tracking queries, identity resolution, and read projections](../../technology-core/ef-core/tracking-queries-identity-resolution-and-projections.md)

## Data Modeling & Integrity

### Area-owned Units

- [`sql-server.declarative-invariants-and-cross-row-enforcement` — Declarative invariants and cross-row enforcement](data-modeling-and-integrity/declarative-invariants-and-cross-row-enforcement.md)
- [`sql-server.table-schema-types-identifiers-and-foreign-keys` — SQL Server table schemas, identifiers, and foreign keys](data-modeling-and-integrity/table-schema-types-identifiers-and-foreign-keys.md)

## Data Processing & Search

### Area-owned Units

- [`sql-server.bulk-import-staging-validation-and-recovery` — Bulk-import staging, validation, and recovery](data-processing-and-search/bulk-import-staging-validation-and-recovery.md)
- [`sql-server.full-text-search` — SQL Server full-text search model and APIs](data-processing-and-search/full-text-search.md)
- [`sql-server.sqlbulkcopy-api-options-and-mappings` — SqlBulkCopy API, options, and column mappings](data-processing-and-search/sqlbulkcopy-api-options-and-mappings.md)

## Other Data Systems

### Technology Core links

- [`redis.connection-and-data-structures` — Redis connection model and data structures](../../technology-core/redis/connection-and-data-structures.md)
- [`redis.server-key-scanning` — Redis server facades and key scanning](../../technology-core/redis/server-key-scanning.md)
- [`redis.values-and-command-atomicity` — Redis values, pipelining, and command atomicity](../../technology-core/redis/values-and-command-atomicity.md)

## Query Performance & Indexing

### Area-owned Units

- [`sql-server.computed-columns-persistence-and-indexing` — Computed columns, persistence, and indexing](query-performance-and-indexing/computed-columns-persistence-and-indexing.md)
- [`ef-core.split-query-tradeoffs` — EF Core split-query tradeoffs](query-performance-and-indexing/split-query-tradeoffs.md)
- [`ef-core.query-shape-cartesian-expansion` — Query shape and cartesian expansion](query-performance-and-indexing/query-shape-cartesian-expansion.md)
- [`sql-server.collation-search-and-sargability` — SQL Server collation, search, and SARGability](query-performance-and-indexing/collation-search-and-sargability.md)
- [`sql-server.date-extraction-formatting-and-sargability` — SQL Server date extraction, formatting, and SARGability](query-performance-and-indexing/date-extraction-formatting-and-sargability.md)
- [`sql-server.index-design-and-query-cost` — SQL Server index design and query cost](query-performance-and-indexing/index-design-and-query-cost.md)
- [`sql-server.indexed-view-materialization-and-write-cost` — SQL Server indexed-view materialization and write cost](query-performance-and-indexing/indexed-view-materialization-and-write-cost.md)
- [`sql-server.indexed-view-schemabinding-and-eligibility` — SQL Server indexed-view schemabinding and eligibility](query-performance-and-indexing/indexed-view-schemabinding-and-eligibility.md)
- [`sql-server.keyset-pagination` — SQL Server keyset pagination](query-performance-and-indexing/keyset-pagination.md)
- [`sql-server.offset-fetch-and-top` — SQL Server OFFSET/FETCH and TOP](query-performance-and-indexing/offset-fetch-and-top.md)

### Technology Core links

- [`ef-core.query-performance-shape-diagnostics-and-batching` — EF Core query shape, diagnostics, and batching](../../technology-core/ef-core/query-performance-shape-diagnostics-and-batching.md)

## Query Semantics & SQL

### Area-owned Units

- [`sql.subquery-membership-and-existence` — IN, EXISTS, ANY, and anti-join semantics](query-semantics-and-sql/subquery-membership-and-existence.md)
- [`sql-server.delete-duplicate-rows-safely` — Safely deleting duplicate SQL Server rows](query-semantics-and-sql/delete-duplicate-rows-safely.md)
- [`sql-server.logical-query-processing-order` — SQL logical query processing order](query-semantics-and-sql/logical-query-processing-order.md)
- [`sql-server.dml-output-rowcount-and-table-variables` — SQL Server DML, OUTPUT, row counts, and table variables](query-semantics-and-sql/dml-output-rowcount-and-table-variables.md)
- [`sql-server.openjson-relational-shaping` — SQL Server OPENJSON relational shaping](query-semantics-and-sql/openjson-relational-shaping.md)
- [`sql-server.pivot-unpivot-shaping` — SQL Server PIVOT and UNPIVOT shaping](query-semantics-and-sql/pivot-unpivot-shaping.md)
- [`sql-server.row-string-aggregation` — SQL Server row string aggregation](query-semantics-and-sql/row-string-aggregation.md)
- [`sql-server.stored-procedure-contracts-and-result-channels` — SQL Server stored-procedure contracts and result channels](query-semantics-and-sql/stored-procedure-contracts-and-result-channels.md)
- [`sql-server.upsert-merge-and-concurrency` — SQL Server upsert, MERGE, and concurrency](query-semantics-and-sql/upsert-merge-and-concurrency.md)
- [`sql-server.views-read-contracts-and-query-abstractions` — SQL Server views as read contracts and query abstractions](query-semantics-and-sql/views-read-contracts-and-query-abstractions.md)
- [`sql-server.window-functions-ranking-navigation-frames` — SQL Server window ranking, navigation, and frames](query-semantics-and-sql/window-functions-ranking-navigation-frames.md)

### Technology Core links

- [`sql-server.procedural-control-flow-variables-and-errors` — SQL Server procedural control flow, variables, and errors](../../technology-core/sql-server/procedural-control-flow-variables-and-errors.md)

## Storage & Database Systems

### Area-owned Units

- [`sql-server.database-creation-files-system-databases-and-batches` — SQL Server database creation, files, system databases, and batches](storage-and-database-systems/database-creation-files-system-databases-and-batches.md)
- [`sql-server.mars-reader-interleaving-and-yield-points` — SQL Server MARS reader interleaving and yield points](storage-and-database-systems/mars-reader-interleaving-and-yield-points.md)
- [`sql-server.schema-evolution-indexes-and-constraints` — SQL Server schema evolution, indexes, and constraints](storage-and-database-systems/schema-evolution-indexes-and-constraints.md)

### Technology Core links

- [`ef-core.databasefacade-connectivity-and-migrations` — EF Core DatabaseFacade connectivity and migrations](../../technology-core/ef-core/databasefacade-connectivity-and-migrations.md)
- [`ef-core.dbconnection-lifetime-setdbconnection-and-timeouts` — EF Core DbConnection lifetime, SetDbConnection, and timeouts](../../technology-core/ef-core/dbconnection-lifetime-setdbconnection-and-timeouts.md)

## Transactions & Concurrency

### Area-owned Units

- [`dotnet.ado-net-transactions-and-ef-core-state` — ADO.NET transactions and EF Core connection state](transactions-and-concurrency/ado-net-transactions-and-ef-core-state.md)
- [`ef-core.aggregate-version-etag-propagation` — Aggregate-version ETags across root and child changes](transactions-and-concurrency/aggregate-version-etag-propagation.md)
- [`ef-core.optimistic-concurrency-resolution-and-savepoints` — Optimistic concurrency resolution and savepoints](transactions-and-concurrency/optimistic-concurrency-resolution-and-savepoints.md)
- [`sql-server.mars-transactions-savepoints-and-tradeoffs` — SQL Server MARS transactions, savepoints, and tradeoffs](transactions-and-concurrency/mars-transactions-savepoints-and-tradeoffs.md)
- [`ef-core.rowversion-http-etag-concurrency` — SQL Server rowversion as an HTTP ETag concurrency token](transactions-and-concurrency/rowversion-http-etag-concurrency.md)
- [`sql-server.rowversion-concurrency-and-returning-values` — SQL Server rowversion concurrency and returned values](transactions-and-concurrency/rowversion-concurrency-and-returning-values.md)
- [`sql-server.transactions-trancount-and-boundaries` — SQL Server transactions, TRANCOUNT, and boundaries](transactions-and-concurrency/transactions-trancount-and-boundaries.md)

### Technology Core links

- [`ef-core.autotransaction-currenttransaction-and-autosavepoints` — EF Core AutoTransactionBehavior, CurrentTransaction, and AutoSavepoints](../../technology-core/ef-core/autotransaction-currenttransaction-and-autosavepoints.md)
- [`ef-core.executeintransactionasync-ambiguous-commit-verification` — EF Core ExecuteInTransactionAsync and ambiguous commit verification](../../technology-core/ef-core/executeintransactionasync-ambiguous-commit-verification.md)
- [`ef-core.idbcontext-transaction-savepoints-and-dbtransaction-interop` — EF Core IDbContextTransaction, savepoints, and DbTransaction interop](../../technology-core/ef-core/idbcontext-transaction-savepoints-and-dbtransaction-interop.md)
- [`ef-core.isolation-levels-and-retry-semantics` — EF Core isolation levels and retry semantics](../../technology-core/ef-core/isolation-levels-and-retry-semantics.md)
- [`ef-core.savepoints-savechanges-and-transaction-recovery` — EF Core savepoints, SaveChanges, and transaction recovery](../../technology-core/ef-core/savepoints-savechanges-and-transaction-recovery.md)
- [`ef-core.transactions-isolation-savepoints-and-retries` — EF Core transactions, isolation, savepoints, and retries](../../technology-core/ef-core/transactions-isolation-savepoints-and-retries.md)
