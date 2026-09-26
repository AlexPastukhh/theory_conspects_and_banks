# CS5 Sparse Repetition / Learning Workflow Methodology Audit v3

Status: superseded historical validation evidence; not a semantic owner. It captured the no-`ACTIVE/STABLE` correction but over-applied sparsity/opt-in repetition and treated D+8 as a separate universal formative stage. Current validation is `cs5-retention-map-methodology-audit-v4.md`.

## Decision checked
The current methodology must preserve all of the following simultaneously:

1. no universal `Learning State = ACTIVE | STABLE` axis;
2. the accepted workflow-owned D0 → D+2 → D+8 formative learning rhythm;
3. sparse/on-demand ordinary repetition over selected Review Scopes only;
4. no corpus-wide Retention Class or Recall State requirement;
5. no fabricated review history or target repetition participation during CS5 migration.

## Current-owner coverage
Checked current surfaces:
- `../principles/universal-knowledge-principles.md`;
- `../principles/retention-repetition.md`;
- `../policies/repetition-scheduling-policy.md`;
- `../knowledge-conspect-principles.md`;
- `../principles/priority-model.md`;
- `../principles/tags-comparisons-and-views.md`;
- `../workflows/default-daily-learning-inbox-workflow.md`;
- `../use-cases/UC-LEARNING-CAPTURE-BATCH.md`;
- `../use-cases/UC-LEARNING-REVIEW-AND-RECORD.md`;
- `../processes/triage-learning-batch.md`;
- `../processes/integrate-verified-knowledge.md`;
- `../migration/CS5-REPETITION-CUTOVER-ANALYSIS.md`;
- `../migration/CURRENT-MIGRATION-STATE.md`.

## Findings

### Learning workflow
The default personal workflow remains:

```text
D0   capture
D+2  triage/materialization
D+8  first formative recall when materialization occurred on D+2
```

The formative review is owned by the learning workflow and does not require `ACTIVE/STABLE` or an ordinary repetition row.

### Repetition cardinality
The methodology now states explicitly:

```text
576 Knowledge Units
≠
576 target repetition-state rows
```

A non-participating Review Scope has no Recall State, schedule, repetition history, or required Retention Class.

### `UNCALIBRATED`
`UNCALIBRATED` means the Scope already participates in ordinary repetition but has no valid baseline. It is not a synonym for "not reviewed" across the corpus.

### Retention assignment
CS5 no longer requires assigning `CORE | WORKING | RECOGNITION | MAP_ONLY` to all 576 Units. Retention classification exists only when a real retention decision is made.

A stored `UNDECIDED` value is not required merely to encode absence of assignment.

### `MAP_ONLY`
Current runtime Use Cases do not yet demonstrate that the system must persist a distinction between:
- no retention decision/non-participation; and
- an explicit decision to keep a Unit map-only without repetition.

Therefore CS5 leaves persistent `MAP_ONLY` representation open until the start/stop/non-participation Use Cases are resolved. This audit does not remove the semantic label and does not require it to be stored.

### Legacy data
Legacy `_ai-conspects/_repetition/REPETITION_STATE.csv` and `INITIAL_WAVE_QUEUE.csv` remain unchanged. Their 576-row shape is transitional and does not impose target cardinality.

No review date, score, completed interval, or historical success may be invented. Legacy `ReviewPriority` does not prove Retention Class/participation.

## Validation result
The methodology now supports the intended architecture:

```text
DURABLE KNOWLEDGE
Domain → Area → nested Area → Concept → Knowledge Unit → Review Scope

INDEPENDENT OPERATIONAL CONCERNS
Learning workflow
→ capture / materialize / formative recall

Coverage & Expansion
→ gaps / questions / planning

Repetition
→ selected Review Scopes only
→ recall / scheduling / history only where needed
```

It does not require every Knowledge Unit to enter a universal learning/retention state machine.

## Remaining CS5 design questions
1. Exact operation/representation for starting ordinary repetition participation.
2. Whether explicit `MAP_ONLY` must be persisted separately from non-participation.
3. Exact behavior when a user stops repetition for a previously participating Scope.
4. Exact physical target schema for participating repetition state.
5. Post-CS5 durable representation, if any, for workflow-owned formative follow-ups such as D+8.
6. Deterministic legacy-row disposition, including rows that receive no target counterpart.
7. Initial-wave/scheduler/dashboard retirement boundary.
