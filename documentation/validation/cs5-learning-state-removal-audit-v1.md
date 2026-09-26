# CS5 Learning-State Removal Audit v1

Status: superseded historical validation evidence; not a semantic owner. This v1 missed current workflow dependencies. The later sparse-repetition correction was also superseded. Current validation is `cs5-retention-map-methodology-audit-v4.md`.

## Decision checked
Remove target `Learning State = ACTIVE | STABLE` as a universal persistent axis. Ordinary durable knowledge needs no `STABLE` marker. Exceptional formative/restructuring conditions remain local to the workflow that needs them.

## Current-owner impact
Updated current semantic/process owners:
- `principles/retention-repetition.md`
- `principles/universal-knowledge-principles.md`
- `principles/knowledge-structure-ontology.md`
- `principles/priority-model.md`
- `principles/tags-comparisons-and-views.md`
- `policies/repetition-scheduling-policy.md`
- `use-cases/UC-LEARNING-REVIEW-AND-RECORD.md`
- `use-cases/UC-KNOWLEDGE-EXPAND-BY-PRACTICE.md`
- `processes/integrate-verified-knowledge.md`
- `processes/triage-learning-batch.md`
- `use-case-registry.md`
- current CS5 migration state/analysis.

## Runtime behavior preserved
- ordinary repetition still requires a coherent authoritative Review Scope;
- `CORE | WORKING | RECOGNITION` remain normally schedulable;
- `MAP_ONLY` remains unscheduled by default;
- Recall State remains based only on actual retention-review evidence;
- source/base defects are not memory failures;
- formative recall remains possible when a concrete learning/restructuring workflow requests it;
- such formative work does not receive an authoritative ordinary repetition score while its scope is materially changing.

## Data-migration effect
No target `ACTIVE/STABLE` values need to be assigned to 576 existing Units. Legacy `_ai-conspects/_repetition/REPETITION_STATE.csv` remains untouched before CS5 and its legacy `LearningState` column is not target authority.

## Residual requirement
Before CS5 schema cutover, verify whether any current local workflow needs durable exception/suppression state. If yes, model it at the narrowest owning process/Use Case; do not add a corpus-wide field without demonstrated reuse.
