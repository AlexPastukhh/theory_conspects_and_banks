# DbCommandInterceptor callbacks, result shapes, and SQL mutation

Knowledge ID: `ef-core.dbcommand-interceptor-callbacks-and-sql-mutation`

Topic: `ef-core`

## DbCommandInterceptor versus SaveChangesInterceptor

`SaveChangesInterceptor` works at the unit-of-work and entity lifecycle level.

`DbCommandInterceptor` works at the raw SQL command level. It can:

- view execution;
- change the `DbCommand` (SQL text, parameters, timeout);
- suppress execution;
- modify the result returned to EF.

It sees SQL text, parameters, execution type, and the returned reader, scalar, or affected-row count.

Choose based on abstraction level: entity/save lifecycle versus provider command execution.

## Three command categories and callback families

A `DbCommand` executes in one of three shapes:

| Category | SQL examples | Result type | Executing callback | Executed callback |
|---|---|---|---|---|
| Reader | `SELECT ...` | `DbDataReader` | `ReaderExecuting` | `ReaderExecuted` |
| Scalar | `SELECT COUNT(*) ...` | `object` | `ScalarExecuting` | `ScalarExecuted` |
| NonQuery | `INSERT`, `UPDATE`, `DELETE` | `int` (affected rows) | `NonQueryExecuting` | `NonQueryExecuted` |

Each family has asynchronous counterparts.

Scalar uses `object` because different scalar queries can return different CLR types: `int`, `long`, `string`, `bool`, `DateTime`, `decimal`, `DBNull.Value`, and others.

## Event data types

| When | Event data type |
|---|---|
| Before execution | `CommandEventData` |
| After successful execution | `CommandExecutedEventData` |
| On command error | `CommandErrorEventData` |

`CommandEndEventData` (available after execution) also provides duration and execute-method information.

## Logging examples

### Reader — log SQL and parameters before execution

```csharp
public override InterceptionResult<DbDataReader> ReaderExecuting(
    DbCommand command,
    CommandEventData eventData,
    InterceptionResult<DbDataReader> result)
{
    Console.WriteLine("About to run SQL:");
    Console.WriteLine(command.CommandText);

    foreach (DbParameter p in command.Parameters)
    {
        Console.WriteLine(
            $"  {p.ParameterName} = {p.Value}");
    }

    return result;
}
```

### Scalar — before and after

```csharp
public override InterceptionResult<object> ScalarExecuting(
    DbCommand command,
    CommandEventData eventData,
    InterceptionResult<object> result)
{
    Console.WriteLine("Scalar SQL:");
    Console.WriteLine(command.CommandText);
    return result;
}

public override object ScalarExecuted(
    DbCommand command,
    CommandExecutedEventData eventData,
    object result)
{
    Console.WriteLine(
        $"Scalar result type: {result?.GetType().Name}");
    Console.WriteLine(
        $"Scalar result value: {result}");
    return result;
}
```

### NonQuery — log and observe affected rows

```csharp
public override InterceptionResult<int> NonQueryExecuting(
    DbCommand command,
    CommandEventData eventData,
    InterceptionResult<int> result)
{
    Console.WriteLine("NonQuery SQL:");
    Console.WriteLine(command.CommandText);
    return result;
}

public override int NonQueryExecuted(
    DbCommand command,
    CommandExecutedEventData eventData,
    int result)
{
    Console.WriteLine($"Rows affected: {result}");
    return result;
}
```

## HasResult and the incoming result parameter

Before execution, the incoming `result` parameter should normally not be inspected for its value; what matters is whether `HasResult == true`, meaning an earlier interceptor already suppressed execution. If not suppressing, return the incoming `result` unchanged.

## SQL mutation

A command interceptor can change `command.CommandText` before execution reaches the provider:

```csharp
public sealed class TaggingInterceptor
    : DbCommandInterceptor
{
    public override InterceptionResult<DbDataReader> ReaderExecuting(
        DbCommand command,
        CommandEventData eventData,
        InterceptionResult<DbDataReader> result)
    {
        command.CommandText =
            "-- intercepted\n" + command.CommandText;

        return result;
    }
}
```

Real uses: add database-specific hints, prepend comments or tags, enforce query-shape conventions.

Caution: changing SQL text can break provider assumptions if not done carefully.

## Command suppression

Command execution can be suppressed by returning a `SuppressWithResult`:

```csharp
public override InterceptionResult<object> ScalarExecuting(
    DbCommand command,
    CommandEventData eventData,
    InterceptionResult<object> result)
{
    return InterceptionResult<object>
        .SuppressWithResult(42);
}
```

The caller receives the replacement value (`42` as an `object`). Use cases: deny certain commands, emulate/cache specific commands, testing.

For a non-query deny pattern:

```csharp
if (command.CommandText.Contains("forbidden_table"))
    return InterceptionResult<int>.SuppressWithResult(0);
```

Suppression is much less common than logging or SQL mutation.

## Registering interceptors

Interceptors are attached through `AddInterceptors` in EF Core options, typically during DI registration:

```csharp
builder.Services.AddDbContext<AppDbContext>((sp, options) =>
{
    options.UseSqlServer(connectionString);
    options.AddInterceptors(
        new AuditSaveChangesInterceptor());
});
```

To supply a DI-resolved interceptor, resolve it from `sp` and pass it to `AddInterceptors`.

## What should be recallable

- What four capabilities does DbCommandInterceptor provide?
- What result type does each command category use, and why is scalar `object`?
- Which event-data type is used before execution, after execution, and on error?
- What does `HasResult == true` indicate when inspecting the incoming result?
- Which property is mutated to change SQL text, and what are valid use cases?
- How are interceptors registered in DI?
- Name three use cases for command suppression.

## Related knowledge

- `ef-core.savechanges-interceptor-lifecycle-and-audit`
- `ef-core.dbcommand-interceptor-event-data-and-command-properties`
- `dotnet.ado-net-command-execution-and-row-mapping`

## Sources

- Workspace: `_ai-conspects/dbcontext interseptors savechanges , dbcommand/`
- Authoritative processed source: `06-stage6-corrected-source-preserving-transcript-v003.md`, R04 (S-002, S-006, S-010, S-012, S-023, S-024, S-029, S-032, S-033, S-035, S-039, S-041, S-043, S-045, S-055) and R05 partial (S-016, S-020, S-031, S-046, S-048)
- Original SVG: `source/source-complete-v002.svg`
