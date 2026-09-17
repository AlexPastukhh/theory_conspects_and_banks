# EF Core value generation, defaults, and save behavior

Knowledge ID: `ef-core.value-generation-defaults-and-save-behavior`

Topic: `ef-core`

`ValueGeneratedOnAdd`, `ValueGeneratedOnAddOrUpdate`, and `ValueGeneratedNever` describe when EF expects store/application generation. They do not by themselves create a database default, computed column, trigger, or application assignment. Configure the actual mechanism: `HasDefaultValue`/`HasDefaultValueSql`, `HasComputedColumnSql`, a trigger/migration, or a client-side value generator.

```csharp
builder.Property(x => x.CreatedUtc)
    .HasDefaultValueSql("SYSUTCDATETIME()")
    .ValueGeneratedOnAdd();

builder.Property(x => x.Total)
    .HasComputedColumnSql("[Quantity] * [UnitPrice]", stored: true)
    .ValueGeneratedOnAddOrUpdate();
```

Before-save and after-save behaviors decide whether an explicitly supplied value is sent/accepted or ignored/rejected around persistence. They must agree with the database contract.

A custom `ValueGenerator` can assign client values. Its `GeneratesTemporaryValues` flag distinguishes a placeholder expected to be replaced by the store from a final generated value. Defaults apply when an insert omits the column; computed values may be virtual or stored/persisted; triggers can update values for all database writers. Application assignment works only when every write path follows that convention. Identity keys, computed columns, rowversion values, and trigger-updated fields are especially sensitive to mismatched before/after-save behavior.

Migration output is part of verification: confirm defaults, computed definitions, sequence dependencies, and save behavior against the exact provider.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 5-6
- Original SVG: `source/onmodelcreating.svg`
