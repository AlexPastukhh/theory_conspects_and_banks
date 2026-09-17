# Shadow properties and persistence-only state

Knowledge ID: `ef-core.shadow-properties-and-persistence-only-state`

Topic: `ef-core`

A shadow property exists in EF Core model metadata without a corresponding CLR property. Configure it in the model and address it in queries with `EF.Property<T>(entity, "Name")`.

This can keep persistence-only concerns such as a soft-delete flag out of the CLR entity surface. Hidden state should not, however, conceal domain behavior that callers need to understand.

## What should be recallable

- Where a shadow property exists when no CLR member exists.
- How `EF.Property<T>` addresses it in a query.
- The boundary between useful persistence-only state and hidden domain behavior.

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr02-constructors-attach-graphs-v002.md`, "Shadow properties"
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
