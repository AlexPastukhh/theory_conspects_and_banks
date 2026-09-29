# EF Core manual DbContext construction and multi-context patterns

Knowledge ID: `ef-core.manual-dbcontext-and-multi-context-patterns`

Topic: `ef-core`

## UseTransaction requires same connection

UseTransaction works only when the context uses the same connection that owns the transaction. If the contexts use different connections, UseTransaction is invalid.

## Same DbContext vs multiple DbContext instances

Same DbContext instance only needs BeginTransaction, but multiple DbContext instances must share connection and transaction to participate in one transaction.

Different databases cannot share one local DbTransaction. Sharing a transaction across different databases requires distributed transactions or a different architecture.

## Manual DbContext construction

DbContext classes should accept `DbContextOptions<TContext>` to allow externally built options. This pattern allows:

- Manual construction with custom options
- Sharing the same connection between contexts
- Building contexts without DI

Example:

```csharp
var options = new DbContextOptionsBuilder<AppDbContext>()
    .UseSqlServer(connectionString)
    .Options;

await using var db = new AppDbContext(options);
```

## DI setup and lifetime

Default DI `AddDbContext` is fine for normal use but does not automatically make two contexts share one connection/transaction. DI contexts may not share the same connection unless you explicitly configure them to do so.

DbContext lifetime in DI is typically scoped. Each request gets its own context instance, which is disposed at the end of the request.

## Multiple contexts sharing connection and transaction

For multiple contexts in one local transaction:

1. Manually build options around one shared DbConnection
2. Start one transaction on that connection
3. Attach the other contexts with UseTransaction

Example pattern:

```csharp
var connection = new SqlConnection(connectionString);
await connection.OpenAsync();

var options1 = new DbContextOptionsBuilder<Context1>()
    .UseSqlServer(connection)
    .Options;

var options2 = new DbContextOptionsBuilder<Context2>()
    .UseSqlServer(connection)
    .Options;

await using var context1 = new Context1(options1);
await using var context2 = new Context2(options2);

await using var transaction = await context1.Database.BeginTransactionAsync();
context2.Database.UseTransaction(transaction.GetDbTransaction());

// Both contexts now share the same transaction
```

## What should be recallable

- When does UseTransaction work?
- Can different databases share one local DbTransaction?
- Why should DbContext accept DbContextOptions<TContext>?
- Does default DI AddDbContext automatically make contexts share connections?
- How do you make multiple contexts share one connection and transaction?
- What is the pattern for manual DbContext construction?
- What are the lifetime considerations for DbContext in DI?

## Sources

- Workspace: `_ai-conspects/ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction/`
- Authoritative processed source: `regions/CTXDB07-manual-dbcontext-options-di-multiple-contexts.md`
