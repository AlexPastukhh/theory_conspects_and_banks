# SQL logical query processing order

Knowledge ID: `sql-server.logical-query-processing-order`

Topic: `sql-server`

SQL is written in one order but logically evaluated approximately as:

```text
FROM / JOIN / ON → WHERE → GROUP BY → HAVING
→ window-function area → SELECT → DISTINCT
→ ORDER BY → OFFSET / FETCH / LIMIT / TOP
```

This explains why a `SELECT` alias is generally unavailable in `WHERE`: the filter is logically earlier. Repeat the expression or introduce a subquery/CTE. `HAVING` filters groups after aggregation. Window results such as `ROW_NUMBER()` are normally filtered in an outer query:

```sql
WITH ranked AS
(
  SELECT *, ROW_NUMBER() OVER
    (PARTITION BY customer_id ORDER BY created_at DESC) AS rn
  FROM Orders
)
SELECT * FROM ranked WHERE rn = 1;
```

The optimizer may physically reorder joins, predicates, and operators while preserving the logical result. Use logical order to explain semantics and the actual execution plan to explain work. Vendor-specific features can occupy engine-specific positions.

## Sources
- Workspace: `_ai-conspects/sheet exec order/`
- Processed source: `01-final-transcript.md`, complete transcript

