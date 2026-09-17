# EF Core composite keys, relationships, and indexes

Knowledge ID: `ef-core.composite-keys-relationships-and-indexes`

Topic: `ef-core`

A composite key gives one entity an ordered identity made from several properties:

```csharp
modelBuilder.Entity<Item>()
    .HasKey(x => new { x.TenantId, x.LocalId });
```

It fits a natural tuple, a dependent identity scoped by another value, or an existing multi-column database key. The cost is that lookup, relationship configuration, and indexing must carry the complete ordered shape.

## Lookup and relationships

`Find` and other identity lookups require every key value in configured order; a partial tuple cannot identify one row.

A foreign key targeting a composite key is itself composite. The dependent exposes all matching properties and `HasForeignKey` lists the complete dependent tuple. When the relationship targets a non-primary principal key, `HasPrincipalKey` lists the matching principal-side tuple as well. Order and values must correspond on both sides.

```text
principal key:  (TenantId, LocalId)
dependent FK:   (TenantId, ItemLocalId)
```

## Null, uniqueness, and index order

Composite primary-key components are normally non-null. For an optional composite foreign key, if any component is null, the tuple is treated as null/incomplete rather than as a complete relationship value.

Uniqueness applies to the complete combination, not each component. Many rows may repeat `TenantId` or `LocalId` separately as long as the full tuple is unique.

Composite index order affects useful access paths. Predicates matching the leftmost prefix can use that order effectively; frequent filters on only later columns may require another index.

## What should be recallable

- Why is property order part of a composite key's identity?
- Which values must a key lookup receive?
- How do `HasForeignKey` and `HasPrincipalKey` represent matching tuples?
- What does a null component mean for an optional composite foreign key?
- How do tuple uniqueness and leftmost index-prefix behavior differ from per-column assumptions?

## Sources

- Workspace: `_ai-conspects/composite-key/`
- Authoritative processed source: `regions/r01r02r03-final-coverage-transcript-v001.md`, R01–R03
- Original SVG: `source/composite-key.svg`
