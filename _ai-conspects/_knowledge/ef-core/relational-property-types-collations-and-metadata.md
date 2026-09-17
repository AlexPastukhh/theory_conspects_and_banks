# EF Core relational property types, collations, and metadata

Knowledge ID: `ef-core.relational-property-types-collations-and-metadata`

Topic: `ef-core`

Property configuration spans different concerns. `HasColumnType` selects the complete provider store type; `IsUnicode` is provider-facing text metadata; `HasPrecision` expresses decimal precision/scale and provider-supported temporal precision. `HasColumnName` names a column, while `HasDatabaseName` names an index. Stable explicit database names help when scripts, diagnostics, or operational procedures refer to the object.

In SQL Server, Unicode semantics and collation are independent. `nvarchar` stores Unicode; a UTF-8 collation can make `varchar` represent Unicode text on supported versions. Collation controls comparison, sorting, and case/accent sensitivity. It can be set at database or column level, or overridden for a query with `EF.Functions.Collate`.

```csharp
modelBuilder.UseCollation("Latin1_General_100_CI_AS_SC_UTF8");

builder.Property(x => x.Code)
    .HasColumnType("varchar(100)")
    .UseCollation("Latin1_General_100_BIN2_UTF8");
```

An explicit query collation may prevent use of an index built under a different collation. Prefer schema-level semantics for common queries and verify generated SQL/query plans. A default schema can be overridden per table, sequence, or function; migrations create or move the actual objects. Store-type, collation, computed-column, schema, sequence, and mapped-function metadata are separate relational/provider contracts.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 3-4 and 6
- Original SVG: `source/onmodelcreating.svg`
