# EF Core index configuration

Knowledge ID: `ef-core.index-configuration`

Topic: `ef-core`

Configure indexes from actual filter, join, order, and projection patterns. Attributes cover simple cases; fluent configuration makes composite order, uniqueness, filters, included properties, and provider choices explicit:

```csharp
modelBuilder.Entity<Order>()
    .HasIndex(x => new { x.TenantId, x.Status });

modelBuilder.Entity<User>()
    .HasIndex(x => x.NormalizedEmail)
    .IsUnique();

modelBuilder.Entity<Order>()
    .HasIndex(x => new { x.TenantId, x.Status })
    .IncludeProperties(x => new { x.Total, x.CreatedAt });

modelBuilder.Entity<User>()
    .HasIndex(x => x.Email)
    .HasFilter("[Email] IS NOT NULL");
```

`IncludeProperties`, `HasFilter`, clustered configuration, descending metadata, and null uniqueness semantics are provider-specific. Included properties can cover projections but do not become navigation/sort keys. Generated migrations are the database change contract: inspect the produced SQL and measure the resulting execution plans and write costs.

A unique index enforces uniqueness without automatically becoming a relationship principal key; an alternate key carries that key-model meaning. Composite unique indexes enforce uniqueness over the complete tuple. Explicit index and constraint names also provide stable identifiers when provider errors must be mapped back to domain rules.

## Sources
- Workspace: `_ai-conspects/indexes, onmodel indexes/`
- Processed source: `09-full-combined-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr05-invariants-constraints-triggers-v002.md`, "Uniqueness and keys"
