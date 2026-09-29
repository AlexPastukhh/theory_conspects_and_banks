# SQL Server OFFSET/FETCH and TOP

Knowledge ID: `sql-server.offset-fetch-and-top`

Topic: `sql-server`

SQL Server pagination uses `ORDER BY` followed by `OFFSET` and optional `FETCH`:

```sql
SELECT product_id, product_name, price
FROM dbo.Products
ORDER BY price DESC, product_id ASC
OFFSET @offset ROWS
FETCH NEXT @pageSize ROWS ONLY;
```

`OFFSET n` skips the first `n` ordered rows; `FETCH NEXT m` returns at most the next `m`. The first page uses offset zero. `FETCH FIRST` and `FETCH NEXT` are grammar alternatives. A unique tie-breaker is required for deterministic pages when the main sort column is not unique.

Use `TOP` for a simple first-N result:

```sql
SELECT TOP (10) *
FROM dbo.Products
ORDER BY price DESC;

SELECT TOP (5) WITH TIES product_name, price
FROM dbo.Products
ORDER BY price DESC;
```

`TOP (n) PERCENT` selects a percentage. `WITH TIES` requires meaningful ordering and may return more than `n` rows. SQL Server does not use MySQL/PostgreSQL `LIMIT`; `LIMIT 10 OFFSET 5` corresponds to offset 5 followed by fetch 10.

`DISTINCT` can define the values before paging, for example the second distinct salary:

```sql
SELECT DISTINCT salary
FROM dbo.Employee
ORDER BY salary DESC
OFFSET 1 ROW FETCH NEXT 1 ROW ONLY;
```

Parameterize offset/page size and validate that both are non-negative and bounded.

## What should be recallable

- `OFFSET`/`FETCH` grammar, first-page behavior, and deterministic ordering.
- `TOP`, `PERCENT`, and `WITH TIES` semantics.
- SQL Server equivalents for `LIMIT` and the distinct-value example.
- Paging input validation.

## Sources

- Workspace: `_ai-conspects/pagination offset take/`
- Processed source: `01-final-transcript.md`, regions R01–R03
- Original SVG: `source/pagination offset take.svg`
