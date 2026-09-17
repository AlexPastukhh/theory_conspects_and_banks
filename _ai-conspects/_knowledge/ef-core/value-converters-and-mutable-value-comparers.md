# EF Core value converters and mutable value comparers

Knowledge ID: `ef-core.value-converters-and-mutable-value-comparers`

Topic: `ef-core`

`HasConversion` maps a model value to one provider value and back. It works naturally for deterministic reversible scalars—an enum string or one-column value object, for example. Serialization/encryption converters change storage representation but do not automatically supply query translation, item-level constraints, searchable encryption, or change-detection semantics.

Mutable reference values need an explicit tracking model. Mutating `Tags.Add(...)` keeps the same list reference; the converter does not tell EF how to compare, hash, or snapshot it. A `ValueComparer<T>` supplies all three:

```csharp
var comparer = new ValueComparer<List<string>>(
    (left, right) => left != null && right != null
        ? left.SequenceEqual(right)
        : left == right,
    value => value == null
        ? 0
        : value.Aggregate(0, (hash, item) => HashCode.Combine(hash, item.GetHashCode())),
    value => value == null ? null! : value.ToList());

builder.Property(x => x.Tags)
    .HasConversion(converter)
    .Metadata.SetValueComparer(comparer);
```

Equality, hash, and snapshot must implement one semantic model. `SequenceEqual` is appropriate when order and duplicate position matter. Set semantics normalize away order/duplicates; multiset semantics retain duplicate counts. The hash must use the same comparer/order normalization as equality, and the snapshot must be independent enough that later mutation does not alter the original tracked value.

Alternatives are immutable replacement, provider-native primitive collections, or owned/entity rows when individual elements need constraints, queries, updates, or relationships. Model-wide conversion conventions affect every matching property and migration, so review existing data.

Converting `DateTime` to formatted text is usually inferior to a native temporal column unless a legacy schema requires it; the provider type and length must fit the representation. Enum-to-string storage is readable and avoids dependence on numeric enum values, but ordering/ranges become lexicographic under database collation rather than CLR enum order, and renaming a member becomes a data migration.

## Sources

- Workspace: `_ai-conspects/ef has conversion, value converte,comparer/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01-R03
- Original SVG: `source/ef has conversion, value converte,comparer.svg`
- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, section 11
- Original SVG: `source/onmodelcreating.svg`
