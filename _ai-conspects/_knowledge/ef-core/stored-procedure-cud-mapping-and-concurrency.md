# EF Core stored-procedure CUD mapping and concurrency

Knowledge ID: `ef-core.stored-procedure-cud-mapping-and-concurrency`

Topic: `ef-core`

EF Core can route `SaveChanges` insert, update, and delete operations through stored procedures. The model mapping defines parameter and result roles; it does not generate or validate the procedure body.

```csharp
modelBuilder.Entity<Document>()
    .InsertUsingStoredProcedure("Documents_Insert", builder =>
    {
        builder.HasParameter(document => document.Title);
        builder.HasResultColumn(document => document.Id);
        builder.HasResultColumn(document => document.RowVersion);
    });

modelBuilder.Entity<Document>()
    .UpdateUsingStoredProcedure("Documents_Update", builder =>
    {
        builder.HasOriginalValueParameter(document => document.Id);
        builder.HasParameter(document => document.Title);
        builder.HasOriginalValueParameter(document => document.RowVersion);
        builder.HasResultColumn(document => document.RowVersion);
        builder.HasRowsAffectedResultColumn();
    });

modelBuilder.Entity<Document>()
    .DeleteUsingStoredProcedure("Documents_Delete", builder =>
    {
        builder.HasOriginalValueParameter(document => document.Id);
        builder.HasOriginalValueParameter(document => document.RowVersion);
        builder.HasRowsAffectedResultColumn();
    });
```

## Current, original, output, and result roles

`HasParameter` sends the current property value. `HasOriginalValueParameter` sends the value originally read by the change tracker, which is needed for original keys and optimistic-concurrency tokens. One conceptual property can therefore legitimately have separate current and original SQL parameters, such as `@Title` and `@Title_Original`.

A parameter can be input/output when the database receives a value and returns a refreshed one. Exact overloads vary by EF Core version, so the mapping must follow the provider/version API in use.

```csharp
builder.HasParameter(
    document => document.RowVersion,
    parameter => parameter.IsOutput());
```

Generated keys, computed columns, and refreshed row versions can instead arrive as result columns:

```csharp
builder.HasResultColumn(document => document.Id);
builder.HasResultColumn(document => document.RowVersion);
```

Normally choose one return channel for one property; do not map the same property simultaneously as both an output parameter and a result column.

## Rows-affected and optimistic concurrency

EF needs an observable success signal when one row is expected. Mapping alternatives include:

```text
HasRowsAffectedParameter()
HasRowsAffectedResultColumn()
HasRowsAffectedReturnValue()
```

They represent alternative contracts, not three signals to configure for the same operation. The SQL procedure can expose an output parameter, `SELECT @@ROWCOUNT AS RowsAffected`, a procedure return value, or a result set whose presence proves that the expected row matched.

A mapped update must reproduce normal EF optimistic-concurrency semantics:

```sql
CREATE OR ALTER PROCEDURE dbo.Documents_Update
    @Id int,
    @OriginalRowVersion varbinary(8),
    @Title nvarchar(200)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Documents
    SET Title = @Title
    WHERE Id = @Id
      AND RowVersion = @OriginalRowVersion;

    SELECT Id, RowVersion
    FROM dbo.Documents
    WHERE Id = @Id
      AND @@ROWCOUNT = 1;
END
```

The original token participates in the match; zero matching rows means that the row changed or disappeared; a successful result returns the refreshed token. If the mapped contract reports zero where EF expects one, EF can raise `DbUpdateConcurrencyException`. EF does not inspect the SQL body, so correct behavior is the joint responsibility of the procedure and mapping.

Insert procedures receive current values and return generated values. Update procedures receive original identity/concurrency values plus new values. Delete procedures normally receive original key and concurrency values so a stale/already-deleted row is distinguishable.

## Selection boundary

CUD mapping is useful when the database already exposes procedures, direct table writes are prohibited, several applications share a fixed database API, legacy integration must remain stable, one write spans several tables, database-specific auditing/side effects/custom concurrency behavior is required, or DBAs require versioned procedures and monitored execution. Ordinary CRUD often remains clearer with EF-generated SQL; procedure mapping adds provider-specific contracts, deployment, and testing work.

## What should be recallable

- Which responsibility belongs to EF mapping and which remains in the stored-procedure body?
- How do current-value, original-value, output-parameter, and result-column roles differ?
- Why should one property normally use one return channel?
- Which alternative rows-affected contracts can expose a concurrency result?
- How must an update procedure compare and refresh a row-version token?
- Which database constraints justify CUD procedure mapping despite its contract/deployment cost?

## Sources

- Workspace: `_ai-conspects/stored procedures/`
- Authoritative processed source: `01-final-transcript.md`, sections 8-15
- Identical regional copy: `regions/R01R02R03R04R05-stored-procedures-corrected-final-v002.md`
- Original SVG: `source/stored procedures.svg`
