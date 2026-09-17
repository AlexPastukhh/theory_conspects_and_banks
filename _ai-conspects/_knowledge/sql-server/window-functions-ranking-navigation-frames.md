# SQL Server window ranking, navigation, and frames

Knowledge ID: `sql-server.window-functions-ranking-navigation-frames`

Topic: `sql-server`

Window functions preserve rows. `ROW_NUMBER` uniquely numbers (add a stable tie-breaker), `RANK` shares ranks with gaps, `DENSE_RANK` without gaps, and `NTILE` creates near-equal buckets with earlier buckets possibly larger. Window ordering does not order the final result set.

`LAG`/`LEAD` read prior/next rows for differences, change detection, and interval boundaries. They accept an optional offset and default value. `PARTITION BY` restarts navigation inside each group; ordering determines which row is prior or next. `FIRST_VALUE`/`LAST_VALUE` operate on the active frame; `LAST_VALUE` is not automatically the partition's final row. Use a full frame when required:

```sql
LAST_VALUE(value) OVER (
  PARTITION BY group_id ORDER BY occurred_at
  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
```

`ROWS` counts physical rows; `RANGE` includes peers with equal ordering values and provider offset support varies. Running totals use unbounded preceding through current row; moving frames use N preceding. Defaults depend on function/ORDER BY, so state frames explicitly when peer behavior matters. Duplicate ordering values need tie-breakers; a null navigation result may mean no offset row or a null source value.

## Sources
- Workspace: `_ai-conspects/window funcs/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
