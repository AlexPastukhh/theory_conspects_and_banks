# EF Core DbConnection lifetime, SetDbConnection, and timeouts

Knowledge ID: `ef-core.dbconnection-lifetime-setdbconnection-and-timeouts`

Topic: `ef-core`

## GetDbConnection and connection ownership

`GetDbConnection()` returns the underlying ADO.NET connection object. It does not guarantee that the connection is open.

Connection disposal ownership:

- If EF created the connection from a connection string, do not dispose it yourself
- If you supplied the connection, you own disposal

## OpenConnection for explicit open scope

`OpenConnection()` and `OpenConnectionAsync()` make the open scope explicit for manual ADO.NET plus EF work. Use them when you need to:

- Manually control when the connection opens
- Perform manual ADO.NET operations before EF work
- Ensure the connection is open for specific operations

A safer pattern:

```csharp
await using var db = new AppDbContext(options);
await db.Database.OpenConnectionAsync();

// Manual ADO.NET work + EF work
```

## SetDbConnection and connection strings

`SetDbConnection()` allows you to replace the connection used by the context. Connection strings should be changed before database work starts and treated as sensitive configuration.

Important considerations:

- SetConnectionString before database work
- Avoid open/close churn
- Connection/session-level state sharing between operations
- Same connection is needed for multiple operations in one transaction

Sharing one local transaction requires the same connection and same DbTransaction. Use one connection object in options when you need this sharing.

## Command timeout

`GetCommandTimeout()` and `SetCommandTimeout()` control the command timeout. Command timeout should be raised only for operations that truly need it, such as long-running reports or bulk operations.

## System.Transactions enlistment

System.Transactions enlistment is for ambient transaction scenarios. Normal EF code usually uses BeginTransaction. Use ambient transactions when you need to coordinate with other resources that participate in System.Transactions.

## Provider helpers

Provider helpers are useful for provider-specific branches but should not be overused. They allow you to:

- Check for specific provider types
- Use provider-specific features
- Generate provider-specific SQL

Use provider-specific casts only when needed. The base DbTransaction API is sufficient for most operations.

## GenerateCreateScript

`GenerateCreateScript()` generates schema SQL for inspection/export. It does not apply the schema. This is useful for:

- Reviewing what the schema will look like
- Exporting schema for documentation
- Generating SQL for external tools

## What should be recallable

- What does GetDbConnection return and does it guarantee the connection is open?
- When should you use OpenConnection/OpenConnectionAsync?
- What are the rules for connection disposal ownership?
- When should you use SetDbConnection or SetConnectionString?
- Why is avoiding open/close churn important?
- What do GetCommandTimeout and SetCommandTimeout control?
- When is System.Transactions enlistment appropriate?
- What are provider helpers useful for?
- What does GenerateCreateScript do and not do?

## Sources

- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB06-dbconnection-open-set-timeout-provider-helpers.md`
