# Entity materialization and safe constructors

Knowledge ID: `ef-core.entity-materialization-and-safe-constructors`

Topic: `ef-core`

EF Core creates entities from database rows and fills mapped members. It may bind a parameterized constructor, or call a parameterless constructor and then assign members. Materialization does not promise to replay the application's normal creation workflow.

Constructors available to persistence materialization should therefore avoid database or service calls, populated-navigation assumptions, and other side effects. Local argument validation and establishment of the object's own invariants are appropriate because they do not depend on an external creation workflow.

## What should be recallable

- The two constructor/member-assignment shapes EF Core may use during materialization.
- Why materialization must not be treated as replaying normal application creation behavior.
- Which constructor behavior is safe and which external side effects are unsafe.

## Sources

- Workspace: `_ai-conspects/ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger/`
- Authoritative processed source: `transcripts/fr02-constructors-attach-graphs-v002.md`, "Materialization and constructors"
- Original SVG: `source/source-complete-v002.svg`, SHA-256 `3f1f8d3f0594043679772ad71c5b40c553fea90716fc781ccf9241542a196efd`
