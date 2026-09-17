# EF Core owned references, collections, and relational identity

Knowledge ID: `ef-core.owned-references-collections-and-relational-identity`

Topic: `ef-core`

An owned value belongs to an owner and is reached through that aggregate. `OwnsOne` commonly table-splits with the owner, so its columns arrive with the owner and no `Include` is needed. `OwnsMany` represents several values and normally uses a separate table; load it with `Include`, explicit loading, or projection. Joined versus split-query behavior still applies, and large owned collections should not be fetched accidentally.

```csharp
builder.OwnsOne(x => x.Address, owned =>
{
    owned.Property(x => x.City).HasColumnName("Address_City");
});

builder.OwnsMany(x => x.Lines, owned =>
{
    owned.ToTable("OrderLines");
    owned.WithOwner().HasForeignKey("OrderId");
    owned.Property<int>("Id").ValueGeneratedOnAdd();
    owned.HasKey("OrderId", "Id");
});
```

The `OwnsMany` key defines relational identity. A composite owner FK plus local/shadow ID keeps a line unique within its owner; a global surrogate gives different move/reparent semantics. Pick it from aggregate identity rules, not merely because EF requires a key.

Tracking queries preserve owned instances with their owner. DTO projection can select only needed columns and avoids tracking. Shadow properties are available through `EF.Property`. Lazy-loading behavior depends on proxy/navigation configuration and should not be assumed from ownership alone.

```csharp
var orders = await context.Orders
    .Include(x => x.Lines)
    .AsSplitQuery()
    .AsNoTracking()
    .ToListAsync();
```

`OwnsMany` establishes ownership; `WithOwner` is mainly needed to customize its FK/relationship. Mutable owned elements can still require deliberate equality and change-tracking behavior.

Owned entities are not independent shared references. When a value needs independent querying, sharing, lifecycle, or references from several owners, model an entity instead.

## Sources

- Workspace: `_ai-conspects/owned entity/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01 and R03
- Original SVG: `source/owned entity.svg`
