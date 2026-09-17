# SQL Server PIVOT and UNPIVOT shaping

Knowledge ID: `sql-server.pivot-unpivot-shaping`

Topic: `sql-server`

`PIVOT` rotates pivot-key row values into a fixed `IN` column list while aggregating a measure. Prepare the source in a CTE or derived table containing only the grouping key, pivot key, and measure; unintended columns change grouping grain. Establish one row per intended grain and verify totals before rotation. Missing intersections are null unless `COALESCE` supplies the reporting fallback.

```sql
PIVOT (SUM(value) FOR pivot_key IN ([A], [B])) p
```

Dynamic columns require safely quoted identifiers and parameterized data values. One PIVOT directly aggregates one value; multiple measures can use separate pivots, measure-name/value reshaping, or conditional aggregation.

`UNPIVOT` converts compatible wide columns into name/value rows but omits null inputs. Keep identifier columns outside the operator while listed measurement columns become name/value rows. Cast mixed types first; use `CROSS APPLY (VALUES ...)` for explicit null/type control. Column names become data and may need normalization/collation handling.

Alias generated report columns clearly and order the final output explicitly; keep business labels separate from physical source names. Filter early, index relevant grouping/filter columns, inspect plans, and do not assume PIVOT beats conditional aggregation. Avoid repeatedly pivoting and unpivoting the same large dataset. Static columns fit stable schemas; dynamic reports make consumers handle changing schemas. Document null and duplicate-row semantics.

## Sources
- Workspace: `_ai-conspects/pivot unpivot/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
