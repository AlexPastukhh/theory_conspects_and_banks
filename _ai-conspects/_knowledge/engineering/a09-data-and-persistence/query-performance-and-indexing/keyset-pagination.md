# SQL Server keyset pagination

Knowledge ID: `sql-server.keyset-pagination`

Topic: `sql-server`

Large offsets can be expensive because SQL Server still locates and skips many ordered rows. Keyset pagination continues after the last observed ordering key:

```sql
SELECT TOP (@pageSize)
    product_id,
    price,
    product_name
FROM dbo.Products
WHERE
    price < @lastPrice
    OR (price = @lastPrice AND product_id > @lastId)
ORDER BY
    price DESC,
    product_id ASC;
```

The continuation predicate must mirror the sort directions: after a descending price, lower prices follow; within an equal price, higher ascending IDs follow. The unique tie-breaker prevents ambiguous continuation.

Keyset pagination is often better for deep scrolling and changing datasets, but does not support arbitrary page-number jumps as directly as offsets. Index the columns used by the continuation filter and `ORDER BY`. Correctness depends on a stable deterministic order.

## What should be recallable

- Why deep offsets remain costly.
- How a composite continuation predicate mirrors mixed sort directions.
- Tie-breaker and index requirements.
- Deep-scroll/change resilience versus arbitrary page jumps.

## Sources

- Workspace: `_ai-conspects/pagination offset take/`
- Processed source: `01-final-transcript.md`, region R04
- Original SVG: `source/pagination offset take.svg`
