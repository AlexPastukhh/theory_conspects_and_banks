# SQL Server indexed-view schemabinding and eligibility

Knowledge ID: `sql-server.indexed-view-schemabinding-and-eligibility`

Topic: `sql-server`

`WITH SCHEMABINDING` declares exact dependencies between a view and its underlying schema. SQL Server then blocks changes that would invalidate those dependencies:

```sql
DROP TABLE dbo.OrderLines;

ALTER TABLE dbo.OrderLines
DROP COLUMN Quantity;
```

These operations fail while a schema-bound view depends on the table or column. This protection is required for indexed views because SQL Server must keep a physically stored derived result valid; dropping a column used by `Quantity * UnitPrice`, for example, would make maintenance impossible.

## Explicit and deterministic definition

Schema-bound definitions use explicit two-part object names:

```sql
-- Bad
FROM OrderLines

-- Good
FROM dbo.OrderLines
```

They also list required columns instead of using unstable `SELECT *`. Adding or removing an unrelated table column must not silently change the view contract. Indexed-view-compatible expressions must satisfy SQL Server's deterministic and aggregate restrictions.

Grouped indexed views commonly require `COUNT_BIG(*)`. `COUNT` returns `int` and can overflow when the row count exceeds that range; `COUNT_BIG` returns `bigint` and extends the usable count range while supplying the maintained count per group required by the indexed-view rules.

## Integrated eligible definition

```sql
DROP VIEW IF EXISTS dbo.OrderTotals;
GO

CREATE VIEW dbo.OrderTotals
WITH SCHEMABINDING
AS
SELECT
    ol.OrderId,
    COUNT_BIG(*) AS LineCount,
    SUM(CONVERT(decimal(19,4),
        ol.Quantity * ol.UnitPrice, 0)) AS TotalAmount
FROM dbo.OrderLines AS ol
GROUP BY ol.OrderId;
GO

CREATE UNIQUE CLUSTERED INDEX IX_OrderTotals_OrderId
ON dbo.OrderTotals (OrderId);
```

The sequence matters: define a schema-bound, schema-qualified, deterministic and aggregate-compatible view first; only then create the unique clustered index that materializes it.

## Related knowledge

- `sql-server.indexed-view-materialization-and-write-cost`

## What should be recallable

- Which incompatible schema changes does `SCHEMABINDING` block?
- Why does physical indexed-view maintenance require that protection?
- Why are schema-qualified names and explicit columns required?
- Which result type differs between `COUNT` and `COUNT_BIG`?
- Why do grouped indexed views commonly include `COUNT_BIG(*)`?
- Which clauses and ordering make the `OrderTotals` example eligible for indexing?

## Sources

- Workspace: `_ai-conspects/views-idexed-views/`
- Authoritative processed source: `regions/VIV04-schemabinding-indexed-view-requirements.md`, complete region
- Materialized source: `assets/raw/full.svg`
