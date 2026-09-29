# ADO.NET command execution, parameters, and row mapping

Knowledge ID: `dotnet.ado-net-command-execution-and-row-mapping`

Topic: `dotnet`

Choose execution by result shape:

```text
ExecuteReader   -> rows
ExecuteScalar   -> first column of the first row
ExecuteNonQuery -> affected-row count / no result set
```

For one or many rows, execute a reader and call `ReadAsync`; use one read for an optional single row and a loop for many. `ExecuteScalarAsync` fits `COUNT(*)`, a maximum ID, setting, or computed scalar. `ExecuteNonQueryAsync` fits insert/update/delete/DDL where affected rows matter.

Always parameterize untrusted input. `AddWithValue` is not forbidden, but explicit type and size give clearer control over database type, length, conversion behavior, and sometimes plan stability:

```csharp
cmd.Parameters.Add("@email", SqlDbType.NVarChar, 256).Value = email;
```

For stored procedures, set the procedure name as `CommandText`, set `CommandType.StoredProcedure`, add parameters, and choose execution by its result shape; procedure conventions remain provider-specific.

Plain ADO.NET can also use `CommandType.Text` with raw command text such as `EXEC dbo.GetCustomerSummary @CustomerId`; that works, but the caller is then authoring SQL text and still must parameterize values. `CommandType.StoredProcedure` expresses the procedure contract directly.

A procedure can expose three distinct channels:

```text
result set             -> rows read with ExecuteReader
OUTPUT parameter       -> a named parameter whose Direction is Output/InputOutput
procedure RETURN code  -> an integer status captured with Direction.ReturnValue
```

```csharp
cmd.CommandType = CommandType.StoredProcedure;
cmd.CommandText = "dbo.GetCustomerSummary";

var total = cmd.Parameters.Add("@Total", SqlDbType.Int);
total.Direction = ParameterDirection.Output;

var returnCode = cmd.Parameters.Add("@ReturnCode", SqlDbType.Int);
returnCode.Direction = ParameterDirection.ReturnValue;

await using (var reader = await cmd.ExecuteReaderAsync(ct))
{
    while (await reader.ReadAsync(ct))
    {
        // map the result set
    }
}

int totalValue = (int)total.Value;
int status = (int)returnCode.Value;
```

Output and return values are reliably populated only after command execution has completed; with a reader, consume and close/dispose it before reading those parameters. A return code is not a result-set scalar and not the `ExecuteNonQuery` affected-row count.

## Typed mapping and database null

Resolve column names with `GetOrdinal`, preferably once before a hot loop, then use typed getters such as `GetInt32`, `GetString`, and `GetDateTime`. `GetOrdinal` first tries case-sensitive lookup and then case-insensitive lookup.

ADO.NET database null is `DBNull`, distinct from a CLR null reference in the reader API. Check `IsDBNull`/`IsDBNullAsync` before calling a typed getter:

```csharp
int displayNameOrd = reader.GetOrdinal("DisplayName");
string? displayName =
    await reader.IsDBNullAsync(displayNameOrd, ct)
        ? null
        : reader.GetString(displayNameOrd);
```

A repository operation should create/open late, parameterize, execute asynchronously with cancellation, cache ordinals, return `null` when no optional row exists, handle `DBNull`, and promptly dispose reader/command/connection.

## Integrated repository read

The complete flow is visible in one method:

```csharp
public async Task<UserRow?> GetByEmailAsync(
    string email,
    CancellationToken ct = default)
{
    await using var conn =
        new SqlConnection(_connectionString);

    await conn.OpenAsync(ct);

    await using var cmd = new SqlCommand(
        """
        SELECT TOP (1) Id, Email, DisplayName
        FROM dbo.Users
        WHERE Email = @email
        """,
        conn);

    cmd.Parameters
       .Add("@email", SqlDbType.NVarChar, 256)
       .Value = email;

    await using var reader =
        await cmd.ExecuteReaderAsync(ct);

    if (!await reader.ReadAsync(ct))
        return null;

    int idOrd = reader.GetOrdinal("Id");
    int emailOrd = reader.GetOrdinal("Email");
    int displayNameOrd = reader.GetOrdinal("DisplayName");

    return new UserRow
    {
        Id = reader.GetInt32(idOrd),
        Email = reader.GetString(emailOrd),
        DisplayName =
            await reader.IsDBNullAsync(displayNameOrd, ct)
                ? null
                : reader.GetString(displayNameOrd)
    };
}
```

This representative method ties together one connection per operation, cancellation-aware open/read, explicit parameter metadata, an optional no-row result, ordinal caching, typed getters, `DBNull` handling, mapping, and deterministic disposal.

## What should be recallable

- How reader, scalar, and non-query execution differ and how single-row/many-row flows work.
- Why parameters are mandatory for untrusted input and when explicit metadata improves on inference.
- Stored-procedure setup, ordinal caching, typed getters, and the `DBNull` check sequence.
- How those mechanics compose in a cancellation-aware repository method returning an optional typed row.

## Sources

- Workspace: `_ai-conspects/rawconnections,dbconnection,sqlconnection,commands/`
- Processed source: `04-detailed-near-literal-transcript-v002.md`, sections 6, 9–14, 16–19
- Original SVG: `source/rawconnections,dbconnection,sqlconnection,commands.svg`
- Workspace: `_ai-conspects/stored procedures/`
- Authoritative processed source: `01-final-transcript.md`, sections 2-3
- Original SVG: `source/stored procedures.svg`
