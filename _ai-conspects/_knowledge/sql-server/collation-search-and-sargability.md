# SQL Server collation, search, and SARGability

Knowledge ID: `sql-server.collation-search-and-sargability`

Topic: `sql-server`

Collation controls SQL Server string comparison: `CI/CS` select case sensitivity, `AI/AS` accent sensitivity, while binary collations follow encoded-value rules. Database, column, and expression collations may differ; equality and `LIKE` obey the selected collation. Parameter type and collation should be compatible with the column. Prefer storing/indexing a column with the application's normal comparison semantics rather than calling `LOWER`/`UPPER` per row.

`CHARINDEX` searches a literal substring, returns a one-based position or zero, accepts an optional start, and follows collation. `%` and `_` are not wildcards there. In `LIKE`, they are wildcards; escape the escape character first and then `%`/`_` using `ESCAPE` or bracket syntax:

```sql
WHERE CHARINDEX(@search, DisplayName) > 0;
WHERE DisplayName LIKE '%' + @escaped + '%' ESCAPE '!';
```

Define an explicit product rule for an empty search string. `CHARINDEX` and leading-wildcard `LIKE` are generally not seek-friendly; use full-text search for linguistic word search.

A SARGable predicate leaves the indexed column directly comparable to a compatible value (equality, ranges, anchored prefixes). Functions, column-side implicit conversions, leading wildcards, and arithmetic transformations commonly prevent seeks. SARGability does not guarantee a seek, and a seek can still read many rows: selectivity, cardinality, statistics, parameter sensitivity, and total cost decide the plan. Inspect the actual execution plan and logical reads.

Per-query `COLLATE` on an indexed column creates a different expression and can impair index use. For an exceptional comparison, applying the intended collation to the parameter may avoid transforming the indexed column, but verify collation precedence and conversions. For recurring alternate semantics, use a persisted computed column:

```sql
ALTER TABLE Users ADD UserName_CI AS
  (UserName COLLATE Latin1_General_100_CI_AS) PERSISTED;
CREATE INDEX IX_Users_UserName_CI ON Users(UserName_CI);
```

Use a separately normalized key when business normalization exceeds collation, and enforce required uniqueness on that key. Computed-index eligibility depends on determinism/settings, and Unicode/locale rules require domain tests.

## Sources
- Workspace: `_ai-conspects/CASE INSENS,collate/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
