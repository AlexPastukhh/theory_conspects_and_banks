# EF Core backing fields and property access modes

Knowledge ID: `ef-core.backing-fields-and-property-access-modes`

Topic: `ef-core`

EF Core can map a backing field so persistence does not require a public setter. `PropertyAccessMode.Field` always uses the field, `Property` always uses the accessor, `FieldDuringConstruction` uses the field while materializing and the property later, and the `PreferField`/`PreferProperty` modes select a preference with fallback. Field-during-construction is useful when property setters contain domain behavior that should not run while materializing a known-valid row.

```csharp
builder.Property<string>("_name")
    .HasField("_name")
    .UsePropertyAccessMode(PropertyAccessMode.Field);

builder.Navigation(x => x.Items)
    .UsePropertyAccessMode(PropertyAccessMode.Field);
```

A domain aggregate can expose `IReadOnlyCollection<T>` while maintaining a private mutable list; EF maps the field/navigation and domain methods enforce legal changes. The read-only wrapper is an API boundary, not proof that the underlying collection cannot change.

Configure a backing field explicitly with `HasField` when conventions cannot discover it. Select field/property access to preserve both persistence behavior and domain invariants.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, section 7
- Original SVG: `source/onmodelcreating.svg`
