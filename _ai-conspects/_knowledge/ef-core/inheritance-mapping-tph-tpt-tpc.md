# EF Core inheritance mapping with TPH, TPT, and TPC

Knowledge ID: `ef-core.inheritance-mapping-tph-tpt-tpc`

Topic: `ef-core`

TPH stores a hierarchy in one table with a discriminator. It avoids joins for polymorphic queries but creates nullable columns for subtype-only data. TPT stores base and derived parts in separate tables; it resembles normalized class structure but polymorphic queries require joins. TPC gives each concrete type a table containing inherited columns; concrete queries are direct, while base-type queries combine tables (commonly `UNION ALL`) and duplicate base columns.

```csharp
modelBuilder.Entity<Payment>()
    .UseTphMappingStrategy(); // or UseTptMappingStrategy / UseTpcMappingStrategy
```

Choose using actual query/write shapes, hierarchy stability, constraints, and provider measurements. TPT query costs grow with hierarchy/joins; TPC favors concrete reads when duplicated inherited columns are acceptable; TPH commonly gives the simplest polymorphic query.

`HasBaseType` controls EF model inheritance; setting it to `null` detaches a CLR-derived type in the EF model while CLR inheritance remains. Querying a mapped base type is polymorphic. Casting changes compile-time access but not runtime subtype; use type tests/pattern matching/`OfType<TDerived>` for subtype logic.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, section 10
- Original SVG: `source/onmodelcreating.svg`
