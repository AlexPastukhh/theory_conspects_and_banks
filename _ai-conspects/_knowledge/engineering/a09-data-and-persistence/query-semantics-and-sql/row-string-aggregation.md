# SQL Server row string aggregation

Knowledge ID: `sql-server.row-string-aggregation`

Topic: `sql-server`

SQL Server 2017+ directly concatenates grouped row values with `STRING_AGG`:

```sql
SELECT dept_id,
       STRING_AGG(name, ', ') AS names
FROM employees
GROUP BY dept_id;
```

The separator is supplied explicitly. Prefer this clearer form when available.

Older versions commonly combine a correlated subquery, typed XML, text extraction, and `STUFF`:

```sql
SELECT dept_id,
       STUFF((
           SELECT ', ' + name
           FROM employees x
           WHERE x.dept_id = e.dept_id
           FOR XML PATH(''), TYPE
       ).value('.', 'nvarchar(max)'), 1, 2, '') AS names
FROM employees e
GROUP BY e.dept_id;
```

For each department, the inner query prepends `", "` to each name. `FOR XML PATH(''), TYPE` concatenates rows as typed XML. `.value('.', 'nvarchar(max)')` extracts the current node's text and decodes entities such as `&amp;` to `&`. Finally `STUFF(..., 1, 2, '')` removes the leading comma and space.

`STUFF(character_expression, start, length, replacement)` uses a 1-based start; `length` characters are removed, and length `0` inserts without deletion.

## What should be recallable

- Modern `STRING_AGG(value, separator)` grouped form and version boundary.
- Every stage of the legacy correlated XML + `STUFF` pipeline.
- Why typed XML `.value('.', ...)` is used and what the dot means.
- `STUFF` parameter semantics and why `(1, 2, '')` removes the leading delimiter.

## Sources

- Workspace: `_ai-conspects/CONCATENATE MULT ROWS AS AGGR,STUFF,STRING_AGG/`
- Processed source: `regions/R01R02R03R04-final-transcript.md`, S-001–S-004
- Original SVG: `source/CONCATENATE MULT ROWS AS AGGR,STUFF,STRING_AGG.svg`
