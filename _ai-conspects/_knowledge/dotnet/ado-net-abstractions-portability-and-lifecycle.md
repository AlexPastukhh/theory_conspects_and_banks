# ADO.NET abstractions, portability, and resource lifecycle

Knowledge ID: `dotnet.ado-net-abstractions-portability-and-lifecycle`

Topic: `dotnet`

Provider types such as `SqlConnection`, `NpgsqlConnection`, `MySqlConnection`, and `SqliteConnection` inherit `DbConnection`. The common family is: connection manages connection state; command executes SQL/procedures; parameter supplies values; reader consumes rows; transaction groups operations.

The normal flow is connection → open → command → text/procedure → parameters → optional transaction → reader/scalar/non-query execution → mapping → commit/rollback → disposal.

`DbConnection`/`DbCommand` are sufficient for much direct CRUD and query code, but only the API shape is portable. SQL dialect, placeholders (`@id`, `:id`, `?`), connection strings, quoting (`[Users]`, `"Users"`, `` `Users` ``), pagination, concatenation, time functions, identity/upsert/boolean syntax, stored procedures, types, and special features may remain provider-specific. Generic access may therefore need provider adapters.

```csharp
await using DbConnection conn = providerFactory.CreateConnection()!;
conn.ConnectionString = connectionString;
await conn.OpenAsync();

await using DbCommand cmd = conn.CreateCommand();
cmd.CommandText = "SELECT Id, Name FROM Users WHERE Id = @id";
DbParameter p = cmd.CreateParameter();
p.ParameterName = "@id";
p.Value = 123;
cmd.Parameters.Add(p);

await using DbDataReader reader = await cmd.ExecuteReaderAsync();
while (await reader.ReadAsync())
{
    int id = reader.GetInt32(0);
    string name = reader.GetString(1);
}
```

The example is API-neutral but its SQL still assumes a supported placeholder/dialect.

Connections, commands, readers, and transactions hold resources or execution state. With pooling, disposing/closing a logical connection normally returns it to the pool; leaving it checked out can exhaust the pool. A reader can keep the connection/result/network resources busy. Transactions require explicit commit or rollback; disposal is not the normal decision mechanism. Prefer `await using`, open late, close early, and keep connections open only as long as practical.

## What should be recallable

- Responsibilities and normal sequence of the ADO.NET base abstractions.
- What is portable at the API level and which SQL/provider details remain nonportable.
- Why every connection, command, reader, and transaction is disposed and how pooling changes—not removes—the rule.

## Sources

- Workspace: `_ai-conspects/rawconnections,dbconnection,sqlconnection,commands/`
- Processed source: `04-detailed-near-literal-transcript-v002.md`, sections 1–5, 7–8, 22
- Original SVG: `source/rawconnections,dbconnection,sqlconnection,commands.svg`
