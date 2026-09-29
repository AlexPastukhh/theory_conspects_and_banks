# EF Core FromSql and SqlQuery APIs

Knowledge ID: `ef-core.fromsql-and-sqlquery-apis`

Topic: `ef-core`

## Four execution models

The raw-SQL APIs belong to four distinct execution models:

### Query APIs (deferred)
- `DbSet<TEntity>.FromSql(...)`
- `FromSqlInterpolated(...)`
- `FromSqlRaw(...)`
- `Database.SqlQuery<T>(...)` — interpolated/parameterized form
- `Database.SqlQueryRaw<T>(...)` — raw SQL form

They create a queryable and execute when materialized with `ToListAsync`, `SingleAsync`, `FirstAsync`, and similar.

### Immediate SQL command APIs
- `Database.ExecuteSql(...)`
- `ExecuteSqlInterpolatedAsync(...)`
- `ExecuteSqlRawAsync(...)`

They execute immediately and return affected-row count. They are not queued for a later `SaveChanges`.

### Immediate set-based DML
- `ExecuteUpdateAsync`
- `ExecuteDeleteAsync`

They translate a LINQ filter and update/delete description into an immediate SQL statement without loading entities.

### Change-tracker workflow
A normal entity query loads and tracks entities. Application code modifies in-memory objects, and `SaveChanges` later produces SQL for those tracked changes.

Keeping these four models separate prevents most confusion in this area.

## FromSql is a query API, not a mutation API

`FromSql`, `FromSqlInterpolated`, and `FromSqlRaw` are designed to return rows. They are part of a LINQ query pipeline:

```csharp
var users = await db.Users
    .FromSql($"SELECT * FROM Users WHERE IsActive = {true}")
    .ToListAsync();
```

The SQL executes when the query is materialized, not earlier. It is not registered for execution by `SaveChanges`.

A database can technically expose stored procedures or statements that both change data and return rows, but using `FromSql` as a hidden mutation mechanism is outside its normal design and makes application behavior hard to reason about.

## Entity results and tracking

`DbSet<TEntity>.FromSql(...)` starts from a mapped entity set. Returned results follow normal EF query tracking rules — by default, entity results are tracked.

The SQL may read a different physical table, but every returned column still has to satisfy the mapped entity shape associated with that `DbSet<TEntity>`. Selecting an incompatible table shape through another entity's `DbSet` does not turn it into an arbitrary result mapping.

Therefore changes to a returned entity can be persisted:

```csharp
var user = await db.Users
    .FromSql($"SELECT * FROM Users WHERE Id = {id}")
    .SingleAsync();

user.Name = "New name";
await db.SaveChangesAsync();
```

`FromSql` performed only the read; the update is ordinary change-tracker behavior on the tracked entity.

Changes are not automatically saved when:

- `AsNoTracking()` was used;
- the result is not an entity from the model;
- the entity is detached or belongs to another context;
- the SQL result cannot be materialized as a normal tracked entity shape.

Keyless entity types can also be queried through model-based SQL APIs, but their tracking/update behavior depends on their model role and keylessness.

## Database.SqlQuery<T> for scalar and non-entity results

`Database.SqlQuery<T>` is for SQL results that are not normal tracked entities:

- scalars: `int`, `string`, `DateTime`;
- DTOs;
- report rows;
- read-model classes, records, or structs.

Scalar example:

```csharp
List<int> ids = await db.Database
    .SqlQuery<int>($"SELECT Id AS Value FROM Users WHERE IsActive = {true}")
    .ToListAsync();
```

Multi-column example:

```csharp
public sealed class UserSummary
{
    public int Id { get; init; }
    public string Name { get; init; } = "";
}

List<UserSummary> users = await db.Database
    .SqlQuery<UserSummary>(
        $"SELECT Id, Name FROM Users WHERE IsActive = {true}")
    .ToListAsync();
```

A non-entity result is a projection. Modifying it does not make `SaveChanges` update a table.

The stable distinction:

- use `DbSet<TEntity>.FromSql` for entity or keyless-entity results in the EF model;
- use `Database.SqlQuery<T>` / `SqlQueryRaw<T>` for scalar, DTO, report, and other non-entity results.

Exact column-alias requirements can depend on LINQ composition and EF Core version. For scalar queries composed further with LINQ, the output column should be named `Value`; the scalar example above uses `AS Value` for this reason.

## What should be recallable

- What are the four EF Core raw-SQL execution models and how do their execution timing and result shapes differ?
- Why is using `FromSql` for mutations problematic?
- Under what conditions are `FromSql` entity results tracked?
- Why does modifying a `SqlQuery<T>` result not trigger a `SaveChanges` update?
- What is the difference between `DbSet<TEntity>.FromSql` and `Database.SqlQuery<T>`?

## Related knowledge

- `ef-core.fromsql-parameterization-and-dynamic-sql`
- `ef-core.executeupdate-executedelete-and-set-based-dml`
- `ef-core.stored-procedure-query-command-and-composition`

## Sources

- Workspace: `_ai-conspects/dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 1-4
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `6cd7d851e1faf6da4ebadbdd509713f7a552b5b52769d44c084ccc10da70ab8d`, Git blob `38a2d5583e5fda228cfcb9e511297aaf0c86a989`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, "Raw SQL and FromSql"
