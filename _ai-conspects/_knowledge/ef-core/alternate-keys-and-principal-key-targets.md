# EF Core alternate keys and principal-key relationship targets

Knowledge ID: `ef-core.alternate-keys-and-principal-key-targets`

Topic: `ef-core`

The primary key is an entity's default identity and the default target of relationships. An alternate key is an additional unique key in EF Core's key model. It can identify a principal row and serve as the target of a foreign key.

A unique index enforces uniqueness but is not automatically a principal-key target. Use a unique index when no relationship needs to reference the value; use an alternate key when the value participates in identity/relationship semantics.

Before choosing a relationship shape, decide whether the referenced identity is meaningful only inside an aggregate or globally. Aggregate-local children normally belong to the root's ownership relationship. A reference to another aggregate normally stores that aggregate's identifier and uses an ordinary relationship. Optional child entities, optional owned values, and external aggregate references are separate modeling choices even when nullable columns appear in each design.

## Relationship configuration

```csharp
modelBuilder.Entity<Customer>()
    .HasAlternateKey(c => c.Code);

modelBuilder.Entity<Order>()
    .HasOne(o => o.Customer)
    .WithMany(c => c.Orders)
    .HasForeignKey(o => o.CustomerCode)
    .HasPrincipalKey(c => c.Code);
```

The roles are distinct:

```text
Order.CustomerCode -> dependent foreign-key value
Customer.Code      -> principal alternate-key target
```

`HasForeignKey` selects the dependent-side property. `HasPrincipalKey` selects a non-primary target on the principal. `HasAlternateKey` declares the additional key directly; configuring `HasPrincipalKey` can also cause EF Core to introduce the required alternate key.

For composite alternate keys, foreign-key and principal-key property order must match:

```text
dependent FK:   (TenantId, CustomerCode)
principal key:  (TenantId, Code)
```

## Stability and database effects

Keys anchor identity resolution and relationships. EF Core treats tracked key values as read-only identity anchors, so treat alternate-key values as stable rather than ordinary mutable business fields. Generated migrations normally create a unique constraint and make the dependent foreign key reference it. Inspect the migration.

Natural/business keys also require an explicit policy for normalization, case sensitivity, database collation, and long-term value stability. A column being unique today is not enough if its business meaning permits later mutation.

## What should be recallable

- Alternate key versus primary key versus unique index.
- `HasForeignKey` dependent side versus `HasPrincipalKey` principal target.
- Why composite property order and key stability matter.
- What migration and collation/normalization details to verify.

## Related knowledge

- `ef-core.composite-keys-relationships-and-indexes`

## Sources

- Workspace: `_ai-conspects/alternate-key/`
- Authoritative processed source: `regions/R01R02R03-efcore-alternate-key-final.md`, R01-R03
- Original SVG: `source/alternate-key.svg`
- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr03-model-owned-complex-relationships-v002.md`, "Keys and relationships"
