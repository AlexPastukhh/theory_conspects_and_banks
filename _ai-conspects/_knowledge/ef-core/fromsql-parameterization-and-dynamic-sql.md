# EF Core FromSql parameterization and safe dynamic SQL

Knowledge ID: `ef-core.fromsql-parameterization-and-dynamic-sql`

Topic: `ef-core`

## Interpolated SQL parameterizes values

Interpolated EF SQL APIs accept a `FormattableString`. Interpolated expressions become database parameters rather than being concatenated into SQL text:

```csharp
string userInput = "Alice' OR 1=1 --";

var users = await db.Users
    .FromSql($"SELECT * FROM Users WHERE Name = {userInput}")
    .ToListAsync();
```

The provider sends:

```sql
SELECT * FROM Users WHERE Name = @p0
```

with `@p0` containing the full input value. The database treats it as data, not executable SQL syntax.

Benefits:

- protection against SQL injection for values;
- provider-correct quoting and type conversion;
- `DbParameter` type information;
- often better query-plan reuse.

The same principle applies to interpolated command APIs:

```csharp
int rows = await db.Database.ExecuteSqlInterpolatedAsync(
    $"UPDATE Users SET IsActive = {false} WHERE LastLogin < {cutoff}");
```

## Raw APIs are not automatically unsafe

Raw APIs accept SQL text. They are required when the SQL structure must be constructed dynamically. They can still parameterize values safely:

```csharp
var users = await db.Users
    .FromSqlRaw(
        "SELECT * FROM Users WHERE Name = {0}",
        userInput)
    .ToListAsync();
```

```csharp
int rows = await db.Database.ExecuteSqlRawAsync(
    "UPDATE Users SET IsActive = @p0 WHERE LastLogin < @p1",
    false,
    cutoff);
```

The unsafe pattern is inserting untrusted input directly into SQL text:

```csharp
string sql =
    $"DELETE FROM Users WHERE Name = '{userInput}'"; // unsafe

await db.Database.ExecuteSqlRawAsync(sql);
```

"Raw" means the application controls the SQL text. It does not mean that all data values must be inlined.

## Parameters can represent values, not SQL grammar

Database parameters cannot stand for:

- table names;
- column names;
- `ASC` or `DESC`;
- operators;
- complete `WHERE` fragments;
- arbitrary clauses or expressions.

This does not work as intended:

```csharp
string columnName = "LastLogin";

db.Users.FromSql(
    $"SELECT * FROM Users ORDER BY {columnName}");
```

The expression becomes a parameter value, not a SQL identifier. When SQL structure must vary, construct only trusted or validated fragments and continue to pass data values as parameters.

## Safe dynamic SQL structure

### Dynamic column — whitelist mapping

Map external input to a fixed set of trusted identifiers:

```csharp
string sortColumn = requestedSort switch
{
    "name" => "Name",
    "lastLogin" => "LastLogin",
    _ => throw new ArgumentException("Invalid sort column")
};

string sql = $"SELECT * FROM Users ORDER BY [{sortColumn}]";

var users = await db.Users.FromSqlRaw(sql).ToListAsync();
```

Do not copy an arbitrary request value into the identifier position.

### Dynamic sort direction

Choose between fixed tokens:

```csharp
string direction = descending ? "DESC" : "ASC";
```

### Dynamic table

Dynamic table selection requires equally strict validation: map a known partition identifier to a known table name.

### Optional fragments with parameterized values

```csharp
var sql = new StringBuilder("SELECT * FROM Users WHERE 1 = 1");
var parameters = new List<object>();

if (onlyActive)
    sql.Append(" AND IsActive = 1");

if (hasEmail)
    sql.Append(" AND Email IS NOT NULL");

if (!string.IsNullOrWhiteSpace(name))
{
    sql.Append($" AND Name = {{{parameters.Count}}}");
    parameters.Add(name);
}

sql.Append(" ORDER BY CreatedUtc DESC");

var users = await db.Users
    .FromSqlRaw(sql.ToString(), parameters.ToArray())
    .ToListAsync();
```

Structure is built by trusted application logic; user data remains in separate parameters.

Often a dynamic query is easier and safer to express with ordinary LINQ. Raw SQL is justified when the SQL shape genuinely cannot be represented conveniently through the provider's LINQ translation.

## FormattableString does not turn SQL fragments into grammar

`FormattableString` solves interpolated value parameterization:

```csharp
FormattableString query =
    $"SELECT * FROM Users WHERE Name = {name} AND Age >= {minAge}";
```

It does not solve dynamic SQL fragments:

```csharp
string clause = "AND IsActive = 1";
FormattableString query =
    $"SELECT * FROM Users WHERE 1 = 1 {clause}";
```

The clause would be parameterized as a string value, not inserted as SQL grammar. To build grammar, use validated raw fragments and separate parameters for values.

## What should be recallable

- What happens to interpolated expressions in EF SQL APIs?
- Why are raw APIs not inherently unsafe?
- Which SQL structural elements cannot be represented as parameters?
- Describe the whitelist pattern for safe dynamic identifiers.
- How does the optional-fragments pattern separate structure from data values?
- Why does inserting a `FormattableString` clause not produce SQL grammar?

## Related knowledge

- `ef-core.fromsql-and-sqlquery-apis`
- `ef-core.executeupdate-executedelete-and-set-based-dml`

## Sources

- Workspace: `_ai-conspects/dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 5-9
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `6cd7d851e1faf6da4ebadbdd509713f7a552b5b52769d44c084ccc10da70ab8d`, Git blob `38a2d5583e5fda228cfcb9e511297aaf0c86a989`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr04-transactions-retries-rawsql-v002.md`, "Raw SQL and FromSql"
