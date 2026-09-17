# EF Core model configuration, conventions, and discovery

Knowledge ID: `ef-core.model-configuration-conventions-and-discovery`

Topic: `ef-core`

`OnModelCreating` refines conventions into an explicit EF Core model: entity inclusion/exclusion, keys, relationships, relational names, functions, sequences, inheritance, conversions, generation, and other metadata.

Split large models into `IEntityTypeConfiguration<T>` classes and apply them explicitly or with `ApplyConfigurationsFromAssembly`. Assembly scanning discovers every matching configuration in the chosen assembly and can introduce unexpected types when configuration classes are accidental or too broad. `ConfigureConventions` supplies model-wide defaults before per-property configuration; a later, more specific configuration wins.

Types enter the model through `DbSet`, relationship/navigation discovery, explicit `Entity<T>`, configuration application, or shared-type configuration. Use `Ignore<T>`/`builder.Ignore(...)` for non-persistent types and inspect the final model when discovery is surprising. `Ignore` removes a type/property/navigation from the model; it is not merely a scalar-column option.

A `DbSet<TEntity>` property can delegate directly to the context's set lookup:

```csharp
public DbSet<Order> Orders => Set<Order>();
```

This expression-bodied form has no backing field and avoids nullable initialization noise. An auto-property initialized with `null!` remains valid; the expression-bodied form simply makes delegation to `Set<TEntity>()` explicit.

A default schema is a fallback namespace and does not silently move existing objects. `HasDbFunction` connects a CLR marker method to a database function; function name, schema, nullability, and any custom translation must match the provider. Provider-specific schema, sequence, function, collation, computed SQL, and store-type choices should remain explicit and be verified in migrations/generated SQL.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 2, 6 and 12-13
- Original SVG: `source/onmodelcreating.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr01-tracking-query-materialization-v002.md`, "DbSet properties"
