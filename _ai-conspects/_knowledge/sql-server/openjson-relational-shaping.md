# SQL Server OPENJSON relational shaping

Knowledge ID: `sql-server.openjson-relational-shaping`

Topic: `sql-server`

`OPENJSON` turns JSON text into a rowset. Without `WITH`, it returns `key`, `value`, and JSON `type`: array keys are indexes, object keys are property names, and complex values remain JSON text. With an explicit schema, each opened item becomes typed named columns with conversion during parsing.

```sql
SELECT j.id, j.name
FROM OPENJSON(@json, '$.rows')
WITH (
  id   int           '$.id',
  name nvarchar(100) '$.name'
) AS j
WHERE j.name = @name;
```

The optional path navigates to a nested value before opening it. In lax mode a missing projected path normally becomes NULL; strict path mode makes absence an error. Parameterize predicates and `sp_executesql` values instead of concatenating untrusted input.

Project nested scalar fields with paths such as `$.address.city`. Mark a nested object/array column `AS JSON` to preserve it for another parse. To expand child arrays, open parents with `WITH (... tags nvarchar(max) '$.tags' AS JSON)` and `CROSS APPLY OPENJSON(tags)`; use `OUTER APPLY` when parents with no children must remain.

Mental model: the first `OPENJSON` selects parent rows, `AS JSON` preserves a child fragment, and an applied `OPENJSON` produces child rows. Use default schema for inspection/generic traversal and `WITH` for stable relational contracts. Verify the database compatibility level supports `OPENJSON`.

## Sources
- Workspace: `_ai-conspects/ef has conversion, value converte,comparer/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R04-R05
- Original SVG: `source/ef has conversion, value converte,comparer.svg`

- Workspace: `_ai-conspects/openjson/`
- Processed source: `01-final-transcript.md`, complete transcript
