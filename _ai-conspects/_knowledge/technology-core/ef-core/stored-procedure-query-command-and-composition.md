# EF Core stored-procedure query, command, and composition boundaries

Knowledge ID: `ef-core.stored-procedure-query-command-and-composition`

Topic: `ef-core`

Choose the EF Core raw-SQL API from the result contract rather than from the fact that the SQL invokes a procedure.

For entity-shaped row results, start from the entity set:

```csharp
var users = await context.Users
    .FromSqlInterpolated($"EXEC dbo.GetUsersByRole {role}")
    .ToListAsync();
```

For scalar or unmapped results, supported EF Core versions provide `Database.SqlQuery<T>` / `SqlQueryRaw<T>`:

```csharp
var count = await context.Database
    .SqlQuery<int>($"EXEC dbo.GetUserCount")
    .SingleAsync();
```

For command-style work that does not materialize returned rows, use an execution API:

```csharp
var affected = await context.Database
    .ExecuteSqlInterpolatedAsync(
        $"EXEC dbo.UpdateUserEmail {id}, {email}");
```

The decision is:

```text
FromSql / SqlQuery
    materialize entity, DTO, or scalar query results

ExecuteSql
    execute a command and normally observe affected rows rather than SELECT results
```

Use the interpolated/parameterized API correctly; do not build procedure calls by concatenating untrusted values.

## SQL Server procedure calls are not composable subqueries

An `EXEC` call is generally not a relational subquery over which EF can append additional server-side SQL. This shape is therefore problematic:

```csharp
context.People
    .FromSql($"EXEC dbo.People_GetByCity {city}")
    .Where(person => person.Name.StartsWith("A"));
```

If filtering must stay on the server, put it inside the procedure or use a table-valued function/composable SQL. If the result is deliberately small, materialize first and then filter in memory. `AsEnumerable()` also switches the remaining operators to client-side LINQ, so it can transfer more rows than expected.

Raw-SQL and stored-procedure API details vary across EF Core versions and providers. Verify the API/version used by the application and keep result shape, parameters, and materialization expectations synchronized with the SQL contract.

## Immediate commands and transactions

`ExecuteSql...` runs immediately and returns an affected-row count. It is not part of the change tracker and does not automatically wait for `SaveChanges`.

Several immediate commands are not automatically one atomic unit. If multiple immediate operations and tracked changes must succeed or fail together, create an explicit transaction.

## What should be recallable

- Which result shapes call for `FromSql`, `Database.SqlQuery<T>`, or `ExecuteSql`?
- Why must interpolated/raw API choice preserve parameterization?
- Why can SQL Server `EXEC` not normally accept appended server-side LINQ operators?
- Which server-side and client-side alternatives preserve the intended filtering boundary?

## Sources

- Workspace: `_ai-conspects/stored procedures/`
- Authoritative processed source: `01-final-transcript.md`, sections 6-7
- Identical regional copy: `regions/R01R02R03R04R05-stored-procedures-corrected-final-v002.md`
- Original SVG: `source/stored procedures.svg`
- Additional provenance: `_ai-conspects/dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery/`, `regions/full-semantic-transcript-v001.md`, section 10 (immediate command APIs and transactions)

