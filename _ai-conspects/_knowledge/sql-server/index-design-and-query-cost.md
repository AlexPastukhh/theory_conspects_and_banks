# SQL Server index design and query cost

Knowledge ID: `sql-server.index-design-and-query-cost`

Topic: `sql-server`

An index is a persistent ordered access structure, normally a B-tree. The optimizer chooses seeks, scans, and lookups by estimated total cost: a seek returning most rows plus many random lookups can lose to a sequential scan, while scanning a narrow nonclustered index can beat scanning a wide clustered table.

A clustered index stores complete rows at its leaves and defines the table's key order; only one can exist. A nonclustered index stores keys plus a locator: the clustered key on a clustered table or a RID on a heap. Keep clustered keys narrow, stable, and non-changing because they are carried by nonclustered indexes. Heap rows that grow may move and leave forwarding pointers. Primary-key and clustered choices are independent.

Composite indexes support leftmost prefixes. For equality predicates followed by a range/order predicate, a useful workload-driven order is `(TenantId, Status, CreatedAt)`. It can seek by the first key or first two and then range on `CreatedAt`, but not normally by `CreatedAt` alone. The optimizer can sometimes intersect separate single-column indexes, but intersection adds work and often does not replace a purpose-built composite index. Functions around indexed columns, implicit conversions, leading wildcards, low selectivity, and poor estimates can prevent efficient seeks.

Key/RID lookups fetch missing columns from the base table after nonclustered access. A small number is normal; many random lookups often mean a covering index, another clustered key, or a scan is cheaper. Key columns drive navigation and ordering, while included columns are leaf payload that can cover a query and remove those lookups. An index can satisfy matching `ORDER BY` (including a uniformly reversed scan) and may assist joins/grouping. Unique indexes enforce uniqueness; filtered indexes store only qualifying rows and require queries that imply the filter. Every index adds storage, cache, log, write, statistics, fragmentation, and maintenance cost, so validate with actual plans and workload evidence rather than indexing every predicate.

Heaps can suit staging, short-lived intermediates, and append-oriented loads, but are not automatically a fast-write default. Review forwarded records, RID lookups, overlapping/unused indexes, write cost, and query distribution as data changes.

## Sources
- Workspace: `_ai-conspects/indexes, onmodel indexes/`
- Processed source: `09-full-combined-final-transcript.md`, complete transcript
