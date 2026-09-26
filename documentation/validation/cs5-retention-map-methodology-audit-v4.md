# CS5 Retention Map Methodology Audit v4

Status: historical validation evidence; superseded by `cs5-advisory-retention-scheduling-audit-v5.md` where v4 over-formalized class assignment and interval decisions; not a semantic owner.

## Decision checked
Current methodology must preserve simultaneously:

1. no universal `Learning State = ACTIVE | STABLE` axis;
2. D0 capture → D+2 triage/materialization as the default learning flow;
3. D+2 materialization counts as the first learning/review contact and Repetition Map entry/update, but not as blind recall evidence;
4. current personal policy aims for broad Repetition Map coverage of durable Review Scopes;
5. `CORE | WORKING | RECOGNITION | MAP_ONLY` remain meaningful retention treatments derived from the Priority Model;
6. important CORE knowledge normally receives the next active-recall review after five clear days (D+8 when materialized on D+2), while lower-retention classes may start later;
7. `MAP_ONLY` remains useful as a low-intensity semantic/navigation/comparison anchor rather than simple absence from repetition;
8. Coverage & Expansion remains independent from Repetition;
9. historical recall evidence is never fabricated during migration.

## Owner consistency
Checked current owners:
- `../principles/priority-model.md`;
- `../principles/retention-repetition.md`;
- `../policies/repetition-scheduling-policy.md`;
- `../knowledge-conspect-principles.md`;
- `../principles/tags-comparisons-and-views.md`;
- `../workflows/default-daily-learning-inbox-workflow.md`;
- `../use-cases/UC-LEARNING-CAPTURE-BATCH.md`;
- `../use-cases/UC-LEARNING-REVIEW-AND-RECORD.md`;
- `../processes/triage-learning-batch.md`;
- `../processes/integrate-verified-knowledge.md`;
- `../migration/CS5-REPETITION-CUTOVER-ANALYSIS.md`;
- `../migration/CURRENT-MIGRATION-STATE.md`.

Cross-technology support remains present in:
- `../domains/software-engineering/MANIFESTATION-COVERAGE.md`;
- `../use-cases/UC-KNOWLEDGE-EXPAND-BY-ANALOGY.md`;
- comparison-Unit semantics in `../principles/tags-comparisons-and-views.md`.

## Corrected semantic shape

```text
DURABLE KNOWLEDGE
Knowledge Unit → Review Scope

LEARNING
D0 capture
→ D+2 materialize / first review contact

REPETITION MAP
Review Scope
→ Retention Class
→ next date + what to review

CORE / WORKING / RECOGNITION
→ active recall + Recall State/history

MAP_ONLY
→ low-frequency map/comparison awareness refresh

COVERAGE & EXPANSION
→ independent gaps/questions/planning
```

## Important corrections over v3
- Repetition is not treated as a tiny opt-in sparse subset by default.
- Missing Retention Class is migration incompleteness for durable corpus coverage, not the desired permanent state.
- D+8 is not a universal separate formative stage; it is the common five-clear-day next review for important knowledge after D+2 materialization.
- `MAP_ONLY` is retained as a useful low-intensity comparison/navigation treatment.
- Existing 576 legacy rows still do not prove valid target class/history; target state must be reconstructed from current owners without invented review evidence.

## Data integrity boundary
This methodology correction does not authorize changes to:
- legacy `REPETITION_STATE.csv`;
- `INITIAL_WAVE_QUEUE.csv`;
- Knowledge Unit bodies;
- semantic hierarchy.

## Remaining CS5 questions
1. Exact class-assignment procedure for the existing corpus.
2. Initial gaps for `WORKING` and `RECOGNITION`.
3. `MAP_ONLY` refresh cadence/representation.
4. Safe first future due-date distribution for the existing uncalibrated corpus.
5. Exact physical schema and legacy retirement path.
