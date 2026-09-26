# CS5 Learning-State Removal Audit v2

Status: superseded historical validation evidence; not a semantic owner. The no-`ACTIVE/STABLE` conclusion remains valid, but later work corrected both the removed D+8 semantics and the over-sparse/opt-in repetition model. Current validation is `cs5-retention-map-methodology-audit-v4.md`.

## Decision checked
The target methodology does not use `Learning State = ACTIVE | STABLE` as a universal persistent axis. Ordinary durable knowledge needs no `STABLE` marker. Formation, restructuring, scope repair, source repair, and optional formative follow-up are local responsibilities of the concrete workflow that needs them.

## Current-owner coverage
The check includes the current surfaces that can affect learning/repetition behavior:
- `../knowledge-conspect-principles.md`;
- `../principles/universal-knowledge-principles.md`;
- `../principles/retention-repetition.md`;
- `../principles/knowledge-structure-ontology.md`;
- `../principles/priority-model.md`;
- `../principles/tags-comparisons-and-views.md`;
- `../policies/repetition-scheduling-policy.md`;
- `../use-cases/UC-LEARNING-CAPTURE-BATCH.md`;
- `../use-cases/UC-LEARNING-REVIEW-AND-RECORD.md`;
- `../use-cases/UC-KNOWLEDGE-EXPAND-BY-PRACTICE.md`;
- `../processes/integrate-verified-knowledge.md`;
- `../processes/triage-learning-batch.md`;
- `../workflows/default-daily-learning-inbox-workflow.md`;
- `../use-case-registry.md`;
- current CS5 migration state/analysis.

## Runtime behavior preserved
- D0 capture and D+2 delayed triage remain the default inbox workflow.
- Materialization does not automatically create a universal D+8/formative stage.
- A concrete workflow may create a local formative follow-up when there is an actual learning/restructuring need.
- Normal repetition eligibility is determined by Retention Class (`CORE | WORKING | RECOGNITION`); `MAP_ONLY` remains unscheduled by default.
- A local workflow that must affect a concrete scheduled review uses an explicit local handoff/override rather than becoming a hidden global eligibility axis.
- `UNCALIBRATED` means no valid retention baseline exists; `WEAK | RECOVERING | STRONG` require actual review evidence.
- Recall scoring remains separate from base/source defects and from local formative work.

## Migration implications
- No target `ACTIVE/STABLE` values need to be assigned to the 576 existing Units.
- Legacy `_ai-conspects/_repetition/REPETITION_STATE.csv` remains unchanged before CS5; its legacy `LearningState` column is not target authority.
- The verified absence of review/history evidence can support `UNCALIBRATED` for a Unit admitted to target repetition state; it cannot support `WEAK`, `RECOVERING`, or `STRONG`.
- Legacy `ReviewPriority` still does not mechanically determine Retention Class.
- `INITIAL_WAVE_QUEUE.csv` remains legacy until target calibration eligibility/query and retirement behavior are defined.

## Historical artifacts
Older validation/proposal artifacts may still contain `ACTIVE/STABLE` conclusions. They are evidence of earlier design states, not current semantic authority. Current navigation and owners supersede those conclusions; do not rewrite historical proposal bodies merely to make them look current.

## Remaining CS5 decisions
1. Define Retention Class assignment authority/procedure for existing Units.
2. Finalize the minimum target repetition-state schema.
3. Specify deterministic legacy → target field mapping, including `UNCALIBRATED` initialization from verified absence of baseline where applicable.
4. Define concrete local handoff/override representation only for workflows that actually need it.
5. Validate calibration/due/overdue/MAP_ONLY/SOURCE_REPAIR runtime behavior.
6. Define the retirement boundary for legacy initial-wave/scheduler/dashboard artifacts.
