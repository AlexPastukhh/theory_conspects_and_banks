# EF Core keyless models versus direct SQL results

Knowledge ID: `ef-core.keyless-models-vs-direct-sql-results`

Topic: `ef-core`

A keyless entity type is an EF model type with no primary key:

```csharp
modelBuilder.Entity<GenreName>().HasNoKey();
```

It suits database views, reporting projections, fixed SQL results, legacy tables/views without a suitable key, and reusable read models. Without identity, EF does not track it as a normal insert/update/delete entity.

Keyless is “read-only to EF,” not CLR immutability. Records, constructors, `init`, or private setters define object immutability separately.

## Registered reusable model

```csharp
modelBuilder.Entity<GenreName>()
    .HasNoKey()
    .ToSqlQuery("SELECT Name FROM dbo.Genres");
```

Query with `Set<GenreName>()` or an optional `DbSet<GenreName>` convenience property. Model registration/configuration—not the property—makes it part of EF's model. This centralizes column/conversion mapping and can support EF composition where the provider/query allows it, at the cost of model ceremony.

## Local direct SQL result

```csharp
var names = await context.Database
    .SqlQuery<GenreName>($"SELECT Name FROM dbo.Genres")
    .ToListAsync();
```

Direct `Database.SqlQuery<T>`/raw variants materialize an ad-hoc DTO without model registration or `DbSet`. They fit local reports and one-off simple shapes. Use the correct interpolated/raw API and never concatenate untrusted parameters.

Choose registered keyless mapping when the read model is stable/reused, maps to a view/fixed query, or benefits from central configuration and an EF query surface. Choose direct SQL when the shape is local and model registration adds no value.

In both cases, CLR properties/SQL columns must line up or be mapped; raw SQL must be parameterized; composition depends on API/provider; and keyless relationship/navigation capabilities are more limited than normal entities. A class does not become a domain aggregate merely because EF materializes it.

## What should be recallable

- Which absence of identity limits make a keyless type query-oriented?
- Why is EF read-only behavior different from CLR immutability?
- What roles belong to `HasNoKey`, `ToSqlQuery`, `Set<T>`, and `DbSet<T>`?
- When is `Database.SqlQuery<T>` simpler than model registration?
- Which mapping, parameterization, composition, and relationship limits remain?

## Sources

- Workspace: `_ai-conspects/keyless entity type/`
- Authoritative processed source: `regions/R01R02R03-final-coverage-transcript.md`, R01–R03
- Original SVG: `source/keyless entity type.svg`
- Workspace: `_ai-conspects/views-idexed-views/`
- Authoritative processed sources: `regions/VIV01-views-concept-ef-core-mapping-toview-tosqlquery.md` and `regions/VIV02-good-bad-use-cases-for-views.md`
- Original SVG: `assets/raw/full.svg`
