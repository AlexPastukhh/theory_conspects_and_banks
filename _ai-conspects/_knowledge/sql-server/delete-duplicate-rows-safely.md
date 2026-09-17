# Safely deleting duplicate SQL Server rows

Knowledge ID: `sql-server.delete-duplicate-rows-safely`

Topic: `sql-server`

Delete later duplicates while retaining the smallest ID by correlating each outer row with an earlier same-key row:

```sql
DELETE p
FROM Person AS p
WHERE EXISTS (
  SELECT 1 FROM Person AS earlier
  WHERE earlier.id < p.id
    AND earlier.email = p.email
);
```

`SELECT 1` communicates existence; its value is not materialized. The strict `<` preserves the smallest ID. Replacing it with equality permits self-match and can target every row.

In the original unaliased subquery, unqualified `id` and `email` bind to the inner `Person`, while `p.id` and `p.email` bind to the current outer row. Explicitly aliasing the inner table as `earlier` makes that correlation visible and safer to review.

Preview with the exact same predicate, then verify inside a transaction with `@@ROWCOUNT` and rollback before committing. Check collation/case/trailing-space/normalization behavior, explicit NULL policy (`NULL = NULL` is not true), supporting indexes, and concurrent writes/isolation. After cleanup, add a unique index consistent with the application's null and normalization policy.

## Sources
- Workspace: `_ai-conspects/delete/`
- Processed source: `regions/final-transcript.md`, corrected complete transcript
