# CS6 Physical Knowledge Move / CS7 Consistency Audit v1

Status: **PASS**

Scope: finalized offline repository state after materializing the accepted Engineering Area + Technology Core physical representation. This audit is validation/provenance; semantic authority remains in current principles/domain maps and operational authority remains in current planning/repetition owners.

## Result

CS6 physical representation and CS7 post-move consistency validation are complete in this snapshot.

## Corpus preservation

- Manifest rows: **576**
- Unique target paths: **576**
- Stable Knowledge IDs preserved: **576 / 576**
- Explicit `## What should be recallable` sections preserved: **576 / 576**
- Target-path collisions: **0**
- Old active Unit paths remaining: **0**
- Old topic directories remaining under `_knowledge/`: **0**

Physical ownership after the CS6 gate:

```text
AREA             257
TECHNOLOGY_CORE  319
ambiguous          0
```

Technology Core currently materializes **13** technology/ecosystem folders.

## Ownership boundary corrections

The pre-CS6 semantic hierarchy contained provisional ownership labels. The physical gate retained 572 ownership decisions and corrected four clear boundary cases:

- `css.fullscreen-modal-overlay`: `TECHNOLOGY_CORE_CANDIDATE -> AREA`
- `dotnet.async-concurrency-and-task-start`: `AREA -> TECHNOLOGY_CORE`
- `javascript.set-basics`: `AREA -> TECHNOLOGY_CORE`
- `javascript.symbol-identity-and-registry`: `AREA -> TECHNOLOGY_CORE`

These corrections implement the current ownership rule: broad engineering concepts own ordinary implementations; defining language/runtime/framework/library models belong to Technology Core and are linked from the relevant broad Area when needed.

## Content preservation

- **575 / 576** moved Unit bodies are byte-identical to their pre-move source files.
- **1 / 576** differs only because three relative Markdown links had to be repaired after both source/target movement:
  - `aspnet-core.cache-control-headers-responsecache-attribute-and-middleware`
- No Knowledge ID, Review Scope item, learning claim, source/provenance statement, retention metadata, or review evidence was intentionally changed as part of physical relocation.

## Physical navigation

Current root navigation separates:

```text
_ai-conspects/_knowledge/engineering/
_ai-conspects/_knowledge/technology-core/
```

Generated navigation:

- Engineering root index: **1**
- Engineering Area indexes: **15**
- Technology Core root index: **1**
- Technology Core indexes: **13**

Engineering Area indexes include Area-owned Units plus links to semantically relevant Technology Core Units. Technology-owned learning bodies are not duplicated under broad Areas.

## Repetition/runtime synchronization

`_ai-conspects/_repetition/REPETITION_MAP.csv`:

- rows: **576 / 576**
- `UnitPath`: **576 / 576** match manifest target paths
- `ReviewScopeRef`: **576 / 576** match current recall anchors
- all referenced Unit files exist
- Retention Band unchanged
- InitialDay / InitialOrder unchanged
- SizeEquivalent unchanged
- actual review/date/score/history/next-review fields unchanged

Physical relocation did not create or infer review evidence.

## Current path-bearing projections

The following current projections were synchronized by Knowledge ID:

- `documentation/validation/software-engineering-semantic-hierarchy-v3.csv`
  - `current_path` points to the current target Unit
  - `owner_kind` is finalized to `AREA | TECHNOLOGY_CORE`
- `documentation/validation/retention-priority-classification-v4.csv`
  - `SourceFile` points to the current target Unit
  - physical owner is finalized where represented
- `documentation/validation/cs5-initial-repetition-rollout-v1.csv`
  - `SourceFile` points to the current target Unit
- `_ai-conspects/_planning/COVERAGE_STATE.csv`
  - provisional `technology_core_candidates` was replaced by final `technology_core_units` counts per semantic Area

Historical v1/v2 maps and legacy repetition state are not rewritten as current truth; they remain provenance.

## Current owner wording synchronization

Current repository guidance was synchronized to the materialized layout, including root repository guidance, Knowledge-layer rules, planning/repetition runtime documentation, the Software Engineering map, and migration control/plan files.

No current operational/semantic owner scanned by this audit contains an exact old active Unit path.

## Link audit

Standard Markdown links checked after finalization: **1037**.

- broken non-placeholder standard Markdown links: **0**
- migration-introduced broken standard Markdown links: **0**

Legacy prompt placeholders such as `<absolute-path...>` are examples, not repository targets, and are excluded from the non-placeholder broken-link count.

## Expansion / Questions boundary

Physical reorganization is not Expansion.

- existing open Questions were not scheduled by this move;
- `EXPANSION_MAP.md` was not populated by relocation;
- no new knowledge was claimed merely because a Unit changed physical location.

## Closure

The finalized snapshot satisfies the CS6/CS7 migration invariants:

```text
stable semantic identity
+ canonical physical ownership
+ synchronized runtime pointers
+ broad-topic navigation to Technology Core
+ no duplicate learning bodies
+ no new broken links
```

Any later physical/taxonomy change should be treated as a new deliberate migration rather than continuation of CS6.
