# Query shape and cartesian expansion

Knowledge ID: `ef-core.query-shape-cartesian-expansion`

Topic: `ef-core`

`Include` fits a related entity shape known in advance. `Find` plus explicit `Load` fits a root that may already be tracked or relationships that are loaded conditionally. `AutoInclude` applies to entity queries; it does not turn `Find` into an automatic collection loader.

A large joined query reduces round trips but repeats parent data and can multiply rows. Sibling collection branches multiply: if one branch contributes three rows and another contributes two, their join can produce six rows for the parent. A nested collection contributes inside its branch and does not necessarily multiply every unrelated branch in the same way. Compute each branch contribution, then multiply siblings.

`AsSplitQuery` avoids the sibling cartesian explosion in exchange for additional statements, round trips, and consistency considerations. Projection can avoid both over-materialization and much of the unnecessary joined shape by selecting the required read model. Identity resolution changes object reuse during materialization, not the number of SQL rows returned.

## What should be recallable

- When `Include`, `Find` plus `Load`, and projection fit.
- Why `AutoInclude` does not make `Find` load collections.
- How nested and sibling collection branches contribute differently to row counts.
- What `AsSplitQuery` trades for reduced cartesian expansion.
- Why identity resolution cannot reduce SQL row multiplication.

## Related knowledge

- `ef-core.split-query-tradeoffs`
- `ef-core.tracking-queries-identity-resolution-and-projections`

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr07-query-shape-row-count-v002.md`, complete verified semantic transcript
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
