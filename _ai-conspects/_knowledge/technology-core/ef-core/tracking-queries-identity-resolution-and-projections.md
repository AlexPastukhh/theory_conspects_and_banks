# Tracking queries, identity resolution, and read projections

Knowledge ID: `ef-core.tracking-queries-identity-resolution-and-projections`

Topic: `ef-core`

A tracking query registers every materialized entity in the `DbContext` identity map and retains state for change detection, original-value comparison, relationship fix-up, and a later `SaveChanges`. One context can track only one entity instance for a primary key. Materializing or attaching a second instance with the same key can therefore conflict. This bookkeeping costs client CPU and heap memory; it is not itself an extra database round trip.

For read-only work, plain `AsNoTracking()` is normally the cheapest default. `AsNoTrackingWithIdentityResolution()` adds a temporary identity map when repeated database rows must become the same object instance inside one materialized result graph. It costs more CPU and memory than plain no-tracking, but usually less than full tracking, and does not retain long-lived tracking after materialization. Identity resolution removes duplicate object instances after rows arrive; it does not reduce SQL row multiplication.

`Find(key)` first checks the current context. When the entity is already tracked, it returns that exact instance without querying the database. A warm unit-of-work can therefore reuse a tracked root and explicitly load a missing navigation. A fresh read path may be clearer as eager loading or, preferably when only part of the model is needed, a projection.

DTO and anonymous-shape projections avoid full entity and navigation materialization. They are also the appropriate representation for partial read models: a partially initialized domain entity can falsely imply that its invariants and complete data are available.

## What should be recallable

- What state and costs a tracking query adds, and why one context rejects two instances for one key.
- The lifetime and trade-off of `AsNoTrackingWithIdentityResolution()` versus tracking and plain no-tracking.
- Why identity resolution does not cure SQL cartesian expansion.
- Why `Find` can avoid a database query in a warm context.
- Why a projection is safer than a partially initialized domain entity for partial reads.

## Related knowledge

- `ef-core.entityentry-navigations-explicit-load-and-query`
- `ef-core.query-shape-cartesian-expansion`

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr01-tracking-query-materialization-v002.md`, "Tracking modes and identity maps", "Find, tracked roots, and explicit loading", and "Projections and domain integrity"
- Authoritative processed source: `transcripts/fr07-query-shape-row-count-v002.md`, "Row multiplication"
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
