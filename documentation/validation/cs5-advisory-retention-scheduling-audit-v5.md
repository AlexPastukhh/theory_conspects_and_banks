# CS5 Advisory Retention & Scheduling Audit v5

Status: current validation evidence; not a semantic owner.

## Decision checked
Current methodology must preserve all of the following simultaneously:

1. no universal `ACTIVE | STABLE` Knowledge Unit lifecycle;
2. broad personal Repetition Map coverage of durable Review Scopes;
3. `CORE | WORKING | RECOGNITION | MAP_ONLY` as useful qualitative retention flags;
4. those flags guide depth/frequency but do not form a rigid state machine or uniquely determine dates;
5. D+2 materialization is the first learning/review contact and map-entry/update point, not blind recall evidence;
6. five clear days after materialization is a useful default for important CORE knowledge, not an invariant;
7. manual scheduling/reclassification is normal operation and may respond to current context/workload;
8. the interval ladder and score-to-gap tables are reusable defaults/heuristics, not mandatory transitions;
9. `MAP_ONLY` remains a lightweight map/comparison treatment without requiring full Recall State;
10. real review history/scores are never invented during CS5 migration.

## Owner consistency
Checked/updated current owners and execution surfaces:
- `../principles/priority-model.md`;
- `../principles/retention-repetition.md`;
- `../policies/repetition-scheduling-policy.md`;
- `../knowledge-conspect-principles.md`;
- `../workflows/default-daily-learning-inbox-workflow.md`;
- `../use-cases/UC-LEARNING-CAPTURE-BATCH.md`;
- `../use-cases/UC-LEARNING-REVIEW-AND-RECORD.md`;
- `../processes/triage-learning-batch.md`;
- `../migration/CS5-REPETITION-CUTOVER-ANALYSIS.md`;
- `../migration/CURRENT-MIGRATION-STATE.md`.

## Corrected operational shape

```text
D0 capture
→ D+2 materialize / Review Scope / Repetition Map entry
→ choose useful next date
   using Retention Class + context + workload as guidance
→ later real review updates only actual evidence
```

Retention Class is primarily a human/AI orientation aid. It can be assigned, changed, or temporarily absent without requiring a formal transition protocol or a fifth `UNDECIDED` class.

The Repetition Map remains user-facingly simple: **date + what to revisit**, with optional class/type/context fields that help judgment.

## Scheduling boundary
The current ladder and calibration tables remain useful defaults. They do not require:
- exact fixed starting gaps for every Retention Class;
- a deterministic formula from Priority dimensions to class;
- a formal transition algorithm when class changes;
- a mandatory rationale for every manual date adjustment.

CS5 therefore should implement enough state for useful map operation and truthful history, not a complete automated scheduler.

## Data integrity boundary
This correction does not authorize changes to legacy repetition CSVs, initial-wave data, Knowledge Unit bodies, or semantic hierarchy.

## Remaining CS5 questions
1. Minimal physical Repetition Map/history schema.
2. Safe staged rollout of the existing 576 Review Scopes and their first future dates.
3. Physical representation of `MAP_ONLY` refresh versus recall-bearing events.
4. Legacy initial-wave/scheduler/dashboard retirement path.
