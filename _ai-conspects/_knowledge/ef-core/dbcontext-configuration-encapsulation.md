# DbContext configuration encapsulation

Knowledge ID: `ef-core.dbcontext-configuration-encapsulation`

Topic: `ef-core`

Infrastructure encapsulation reduces how many EF details startup code can choose. A long `AddDbContext` chain can expose provider, connection lookup, logger factory, and sensitive-data logging. The conspect's alternative passes only environment-varying inputs—such as connection string and logging flag—to the context, while `OnConfiguring` composes `UseSqlServer` and logging internally.

This narrows configuration possibilities and keeps sensitive logging policy near the infrastructure implementation; sensitive-data logging can place SQL parameters in logs. Simple configuration can remain conventional, while growing option chains may justify a smaller wrapper/constructor surface.

```csharp
builder.Services.AddScoped(_ =>
    new SchoolContext(connectionString, useConsoleLogger));
```

The manual factory remains scoped, matching the default scoped lifetime of `AddDbContext`; the difference is exposed API shape, not lifetime. More broadly, client code should receive the minimum meaningful configuration inputs rather than assembling every internal detail.

## Sources
- Workspace: `_ai-conspects/encapsulating-dbcontext/`
- Processed source: `regions/R01R02-encapsulating-dbcontext-final.md`, complete transcript

