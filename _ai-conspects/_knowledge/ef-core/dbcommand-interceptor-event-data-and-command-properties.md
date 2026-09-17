# DbCommandInterceptor event data properties and DbCommand shortlist

Knowledge ID: `ef-core.dbcommand-interceptor-event-data-and-command-properties`

Topic: `ef-core`

## Common command event data properties

Properties available on `CommandEventData` and its subtypes:

| Property | What it provides |
|---|---|
| `Command` | the `DbCommand` |
| `Context` | the current `DbContext` |
| `CommandId` | correlation ID for this specific command instance |
| `Connection` | the `DbConnection` (e.g. `SqlConnection`, `NpgsqlConnection`) |
| `ConnectionId` | correlation ID for the connection instance |
| `CommandSource` | which EF subsystem created this command |

After execution, `CommandEndEventData` additionally provides duration and execute-method information.

```csharp
public override InterceptionResult<object> ScalarExecuting(
    DbCommand command,
    CommandEventData eventData,
    InterceptionResult<object> result)
{
    Console.WriteLine(command.CommandText);
    Console.WriteLine(eventData.Context?.GetType().Name);
    Console.WriteLine(eventData.CommandId);

    return result;
}
```

## What each identifier answers

- **CommandId** — "which exact command?" Correlates a `ReaderExecuting` log entry with its matching `ReaderExecuted` entry.
- **ConnectionId** — "which connection instance?" Many commands can run on one connection; `ConnectionId` identifies the shared connection in log-friendly form.
- **Connection** — the actual provider connection object. Allows provider-specific inspection: database name, data source, state, transaction association.
- **CommandSource** — "why did EF generate this command?"

```csharp
// intuition summary
CommandId       // which command?
Connection      // which actual DbConnection object?
ConnectionId    // which connection instance (log-friendly)?
CommandSource   // why did EF create this command?
```

## CommandSource values

`CommandSource` classifies the EF subsystem or API that produced the command:

```text
LinqQuery
SaveChanges
Migrations
FromSqlQuery
ExecuteSqlRaw
ValueGenerator
Scaffolding
ExecuteUpdate
ExecuteDelete
```

### Using CommandSource in an interceptor

```csharp
public override InterceptionResult<int> NonQueryExecuting(
    DbCommand command,
    CommandEventData eventData,
    InterceptionResult<int> result)
{
    if (eventData.CommandSource == CommandSource.SaveChanges)
    {
        Console.WriteLine("This SQL came from SaveChanges");
    }

    if (eventData.CommandSource == CommandSource.Migrations)
    {
        Console.WriteLine("This SQL came from a migration");
    }

    return result;
}
```

This enables source-aware diagnostics and policies without guessing from raw SQL.

## DbCommand property shortlist

The five properties most commonly inspected in EF Core interceptors:

```csharp
command.CommandText       // SQL text or stored-procedure name
command.CommandType       // Text or StoredProcedure
command.CommandTimeout    // timeout in seconds
command.Parameters        // e.g. @p0, @p1
command.Transaction       // current transaction if any
```

Sometimes also:

```csharp
command.Connection        // provider connection object
```

## Main DbCommand properties

| Property | Meaning |
|---|---|
| `CommandText` | SQL text or stored-procedure name to execute |
| `CommandTimeout` | timeout in seconds before execution fails |
| `CommandType` | how `CommandText` is interpreted; usually `Text` or `StoredProcedure` |
| `Connection` / `DbConnection` | database connection used by this command |
| `Transaction` / `DbTransaction` | transaction this command runs inside |
| `Parameters` / `DbParameterCollection` | command parameters such as `@p0`, `@id` |
| `DesignTimeVisible` | design-time/UI tooling; not relevant to normal EF interception |
| `UpdatedRowSource` | relevant for `DbDataAdapter`; not typical EF Core usage |

Practical example mapping properties to SQL:

```sql
UPDATE Posts SET Title = @p0 WHERE Id = @p1
```

- `CommandText` — that SQL string;
- `Parameters` — `@p0`, `@p1`;
- `Connection` — current provider connection;
- `Transaction` — current transaction if one exists;
- `CommandType` — usually `Text`.

## Provider-specific subclasses

`DbCommand` is the base class. Runtime objects are normally provider-specific:

- `SqlCommand` (SQL Server);
- `NpgsqlCommand` (PostgreSQL);
- `SqliteCommand` (SQLite).

EF exposes provider-neutral abstractions through the interceptor API while runtime instances retain provider-specific behavior and additional properties.

## What should be recallable

- What does `CommandId` correlate, and how does it differ from `ConnectionId`?
- What information can be obtained from the `Connection` property?
- What does `CommandSource` answer, and name five example values?
- Which five DbCommand properties form the normal shortlist?
- Which two properties are irrelevant for normal EF Core interception?
- Name three provider-specific `DbCommand` subclasses.

## Related knowledge

- `ef-core.dbcommand-interceptor-callbacks-and-sql-mutation`
- `dotnet.ado-net-command-execution-and-row-mapping`

## Sources

- Workspace: `_ai-conspects/dbcontext interseptors savechanges , dbcommand/`
- Authoritative processed source: `06-stage6-corrected-source-preserving-transcript-v003.md`, R05 (S-011, S-036, S-038, S-042, S-047, S-054, S-058, S-059)
- Original SVG: `source/source-complete-v002.svg`
