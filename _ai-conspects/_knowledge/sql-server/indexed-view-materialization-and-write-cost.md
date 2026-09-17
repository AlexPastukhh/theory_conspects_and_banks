# SQL Server indexed-view materialization and write cost

Knowledge ID: `sql-server.indexed-view-materialization-and-write-cost`

Topic: `sql-server`

A normal view is a query definition. An indexed view gains physical result storage when SQL Server creates the required first unique clustered index:

```sql
CREATE UNIQUE CLUSTERED INDEX IX_ActiveBookings
ON dbo.ActiveBookings (RoomId, BookingNight);
```

At that point the database owns:

```text
view definition
+ physically stored result rows
+ clustered index
+ any later nonclustered indexes
```

The unique clustered index is the physical foundation for indexed-view rows. Only after it exists can additional nonclustered access paths be added:

```sql
CREATE NONCLUSTERED INDEX IX_OrderTotals_TotalAmount
ON dbo.OrderTotals (TotalAmount);
```

Nonclustered indexes need physical rows to reference; the exact unique-clustered-first rule is part of SQL Server's indexed-view contract. In special cases, uniqueness over the indexed projection can also enforce a constraint-like property, though indexed views are primarily a read-performance feature.

## Base-table writes maintain derived storage

Applications continue to write the source tables, not the stored indexed-view result. SQL Server updates the derived rows automatically. For example, inserting another order line changes the aggregate for its order:

```sql
INSERT INTO dbo.OrderLines
    (OrderId, ProductId, Quantity, UnitPrice)
VALUES
    (1, 102, 4, 10.00);

SELECT OrderId, LineCount, TotalAmount
FROM dbo.OrderTotals;
```

The source example changes Order 1 from two lines and `125.00` to three lines and `165.00`; other groups remain unchanged.

## Read acceleration spends write work

A normal table index commonly updates entries corresponding directly to one changed row. An indexed view can contain filters, joins, grouping, aggregates, and computed expressions, with many base rows contributing to one derived row.

One update may therefore require SQL Server to:

```text
update the base row
-> calculate its effect on the view result
-> update the affected clustered indexed-view row
-> update affected nonclustered indexes on the view
```

Indexed views can make suitable reads faster, but every dependent write pays maintenance cost and the definition must obey stricter rules.

## Related knowledge

- `sql-server.indexed-view-schemabinding-and-eligibility`
- `sql-server.views-read-contracts-and-query-abstractions`

## Additional indexed-view transcript

## 14. Indexed views

An indexed view physically materializes the view result through an index.

Basic idea:

```text
normal view   -> saved query definition
indexed view  -> saved query + materialized indexed result
```

Indexed views have restrictions and maintenance costs.

Use only when:

```text
query benefit is real
data changes are not too expensive
requirements/restrictions are understood
```

The notes position indexed views as a specialized performance tool, not the default view mechanism.

## What should be recallable

- Which operation turns a normal view into physically stored indexed-view rows?
- Why must the first index be unique clustered?
- When may nonclustered indexes be added?
- Which object remains the application's write source?
- How does a base-row change reach an aggregate view row?
- Why can indexed-view maintenance cost more than a direct table index update?

## Sources
- Workspace: `_ai-conspects/sql-syntax-sql-server/`
- Authoritative processed source: `regions/R05-upsert-merge-transactions-indexes-alter-constraints-views.md`, section 14
- Original SVG: `source/sql-syntax-sql-server.svg`


- Workspace: `_ai-conspects/views-idexed-views/`
- Authoritative processed source: `regions/VIV03-indexed-views-materialization-write-cost.md`, complete region
- Materialized source: `assets/raw/full.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr05-invariants-constraints-triggers-v002.md`, "Computed uniqueness and indexed views"
