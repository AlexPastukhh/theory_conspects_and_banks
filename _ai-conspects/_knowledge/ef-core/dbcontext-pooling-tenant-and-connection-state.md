# EF Core DbContext pooling, tenant state, and connection cleanup

Knowledge ID: `ef-core.dbcontext-pooling-tenant-and-connection-state`

Topic: `ef-core`

Context pooling resets and retains EF context instances, reducing allocation and the cost of constructing the context graph, EF services/helpers, and tracking/query/save machinery; it does not avoid database round trips. Benchmark gains are workload-dependent and pooling does not guarantee the same improvement for every application, so measure the real workload. Pool size limits retained idle contexts, not concurrency: EF can create an extra context when none is available and dispose it when retention is full. Context pooling and provider connection pooling are independent.

`AddDbContextPool<T>` injects a scoped context owned/disposed by DI. `AddPooledDbContextFactory<T>` injects a factory; callers own each `CreateDbContext[Async]` result and must `using`/`await using` it. A scoped wrapper may create from the factory and let DI own that request instance.

Pooled instances must not retain request/user/tenant state. `OnConfiguring` runs only on first construction. A safe multitenant wrapper creates a context, assigns its current `TenantId`, and exposes it for the scope. The cached model can contain:

```csharp
modelBuilder.Entity<Order>()
    .HasQueryFilter(order => order.TenantId == TenantId);
```

`OnModelCreating` builds stable cached metadata, while the context property is read when queries execute. Do not capture the current request inside model/configuration setup.

EF resets its own state when returning a context but cannot guarantee cleanup of arbitrary raw `DbConnection` or database-session changes. Code that manually opens a connection, changes session context/isolation, or starts provider-specific operations must restore that state and close/dispose what it opened. An unclosed logical connection can exhaust the provider pool; stale session state can leak into a later request. Closing usually returns the physical connection to its pool and does not prove every provider setting was reset.

Good designs include:

- separate `DbContext` subclasses with separate pools;
- separate wrapper factories around differently configured pooled factories;
- one pool per stable configuration;
- no pooling when configuration truly must be rebuilt dynamically.

For tenant-specific data on one stable database configuration, a scoped wrapper factory can obtain a pooled context and set `TenantId` before returning it.

Changing the connection string per tenant is a configuration problem, not merely a mutable field. It usually requires separate stable factories/pools or a non-pooled dynamic context design.

## Sources
- Workspace: `_ai-conspects/dbcontextpool, queryfilter/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, section 7
- Original SVG: `source/source-complete-v002.svg`
