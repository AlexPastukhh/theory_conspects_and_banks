# Personal Knowledge System Migration — Current State

Status: authoritative temporary migration control for this snapshot. It tells a new chat which representations are current versus historical/transitional; permanent semantic rules remain owned by the linked principles/Use Cases/domain maps.

## Current phase

```text
CS5 pre-cutover
- semantic hierarchy v3 established
- responsibility-first coverage refinement established
- Review Scope blocker closed

NEXT: CS5 repetition state/scheduler cutover
- pre-cutover analysis in progress; target repetition schema/retention migration still requires a methodological decision
```

## Read this snapshot in this order

1. `README.md` / `AGENTS.md`;
2. `documentation/README.md`;
3. this file;
4. applicable Use Case + principle/policy;
5. current domain map/projections.

Do **not** reconstruct current truth from an older validation CSV, proposal, legacy dashboard, or physical folder when a current owner is named below.

## Current semantic owners

Universal/current owners:

- `documentation/use-case-registry.md` and `documentation/use-cases/`;
- `documentation/principles/`;
- `documentation/processes/`;
- target repetition semantics: `documentation/principles/retention-repetition.md`;
- target scheduling semantics: `documentation/policies/repetition-scheduling-policy.md`;
- repository execution/authority boundary: `documentation/repository-work-principles.md`.

Software Engineering current owners/projections:

- logical hierarchy: `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`;
- machine-readable current Unit assignment: `documentation/validation/software-engineering-semantic-hierarchy-v3.csv`;
- generic completeness checklist: `documentation/domains/software-engineering/RESPONSIBILITY-CATALOG.md` / `_ai-conspects/_planning/RESPONSIBILITY_COVERAGE.csv`;
- selected cross-runtime projection: `documentation/domains/software-engineering/MANIFESTATION-COVERAGE.md` / `_ai-conspects/_planning/MANIFESTATION_COVERAGE.csv`;
- operational planning state: `_ai-conspects/_planning/`.

## Knowledge corpus state

- **576 / 576** Knowledge IDs are present.
- **576 / 576** have one `CLEAR` primary Software Engineering root-Area + recursive nested-Area path in hierarchy v3.
- All current Units have exactly one explicit `## What should be recallable` Review Scope.
- Physical `_ai-conspects/_knowledge/<topic>/` paths remain unchanged and are **not** canonical semantic ownership.
- No physical Knowledge Unit move is required for repetition cutover.

History matters here: the CS5-preparation pass **did modify 170 Knowledge Unit files** to add/normalize missing Review Scopes and made one title correction. Later structure/coverage refinement passes did not change Unit bodies. Therefore “knowledge bodies untouched” is true only for those later passes, not for the migration snapshot as a whole.

Title correction retained with stable ID/path:

```text
dotnet.xor-semantics-and-collection-equality
XOR semantics, cancellation, and equality alternatives
→ XOR semantics and collection equality alternatives
```

## Area / Subarea / Concept interpretation

- `Subarea` is not a separate entity; it means a nested `Area`.
- Area nesting is recursive and depth is evidence-driven, not fixed.
- A responsibility/checklist row is **not automatically** an Area, Concept, Question, or Unit.
- `concept_label` in hierarchy v3 is a Unit-level semantic label used for navigation/review; it is not automatically a separately materialized canonical Concept entity or a complete Concept registry.
- In hierarchy v3, `v1_*`, `v2_*`, `structure_changed`, `review_basis`, and `responsibility_pass_*` columns are provenance/audit fields. Current assignment comes from `area`, `nested_area_path`, `concept_label`, `owner_kind`, and the current status fields.
- A Unit may participate in an Engineering Area/nested-Area path for coverage/navigation while the Technology Core exception owns its defining technology model.

Current hierarchy v3 has 15 root Areas and 80 broad nested Areas. Do not treat the number of occupied nodes as the definition of semantic completeness.

## Technology Core label during migration

Hierarchy rows currently classify owner kind as:

```text
259 AREA
317 TECHNOLOGY_CORE_CANDIDATE
0 ambiguous
```

`TECHNOLOGY_CORE_CANDIDATE` is intentionally retained as a migration label: the Unit has been classified as likely technology-defining under the Technology Core ownership exception, but a final physical Technology Core tree/layout is not materialized or required now. It is **not** an instruction to move/duplicate the file.

## Coverage semantics — do not collapse the layers

The current planning layer contains several projections with different meanings:

```text
COVERAGE_STATE.csv
    coarse root-Area roll-up

SUBAREA_COVERAGE_STATE.csv
    broad nested-Area PRIMARY OCCUPANCY (`HAS_PRIMARY_EVIDENCE / NO_PRIMARY_EVIDENCE`)

RESPONSIBILITY_COVERAGE.csv
    generic responsibility-first semantic coverage

MANIFESTATION_COVERAGE.csv
    selected cross-runtime manifestation baseline
```

Status rules:

- occupancy-only states in `SUBAREA_COVERAGE_STATE.csv`: `HAS_PRIMARY_EVIDENCE | NO_PRIMARY_EVIDENCE`; they say nothing by themselves about semantic completeness;
- `PARTIAL` = some durable evidence exists for the explicit scope; completeness is not established;
- `MISSING` = current durable evidence is insufficient for the explicit scope; it does not mean no related files exist;
- `COVERED` = adequacy was explicitly assessed against the scope/Key Questions; do not infer it from counts;
- `NOT_APPLICABLE` = manifestation is not meaningful at that ecosystem/layer; not a gap.

Primary ownership and evidential support are different. Example: a broad Subarea can have `0` primary-owned Units while one responsibility from that family is `PARTIAL` because Units primarily owned elsewhere provide relevant evidence.

### Current responsibility-first baseline

```text
15 root Areas: all coarse PARTIAL
80 broad nested Areas: 52 `HAS_PRIMARY_EVIDENCE`, 28 `NO_PRIMARY_EVIDENCE`
183 generic responsibilities:
  101 PARTIAL
   82 MISSING
    0 COVERED asserted
```

The lack of `COVERED` is deliberate conservatism, not a claim that nothing is well understood.

### Cross-runtime baseline

`MANIFESTATION_COVERAGE.csv` currently contains **30 selected transferable responsibilities** across generic / .NET / JavaScript-language / Browser / Node.js / Python. It is a gap-discovery baseline, **not** an exhaustive curriculum for any technology.

Cross-technology analysis starts from a generic responsibility. Do not create one-to-one framework/tool analogues merely for symmetry; `NOT_APPLICABLE` / no useful direct equivalent is valid. A responsibility discovered in Python/Node/browser/.NET should be checked back against other relevant ecosystems, including .NET.

## Questions / Expansion

- `_ai-conspects/_planning/` is the current operational projection.
- `QUESTIONS.csv` stores independently tracked Open Expansion Questions only.
- Most of the 82 responsibility `MISSING` rows intentionally remain lightweight gaps and do not receive Question IDs.
- A tracked Question does not own its durable answer; durable knowledge integrates into canonical Knowledge Units/Concepts/Areas.
- Expansion Plan adds action/order context only and is not a global scheduler with Repetition or Capture/Triage.

Current tracked Questions: 12 total; 6 `PURSUE_NOW / READY`, 6 `DEFER / LATER`. No calendar day was invented.

## Repetition — still transitional

- `_ai-conspects/_repetition/REPETITION_STATE.csv` remains the unchanged legacy 576-row state store;
- `_ai-conspects/_repetition/INITIAL_WAVE_QUEUE.csv` remains unchanged;
- legacy policy/dashboard/agent files under `_repetition/` are transitional implementation, not target semantic owners;
- legacy `NOT_REVIEWED` does **not** mechanically determine target Retention Class or observed Recall State; together with verified empty review/history fields, it proves there is no valid blind-recall baseline;
- current personal target policy wants broad Repetition Map coverage of durable Review Scopes, but the legacy 576-row shape is not evidence that the old rows already contain valid target retention decisions;
- target class assignment must come from the current Priority/Retention owners, not from legacy `ReviewPriority`; migration may stage those assessments rather than fabricate them;
- `CORE | WORKING | RECOGNITION` rows begin `UNCALIBRATED` until a real blind-recall calibration occurs; `MAP_ONLY` uses lightweight map-refresh behavior rather than normal Recall State;
- do not invent observed Recall State (`WEAK | RECOVERING | STRONG`), recall score, completed interval, or historical review evidence before real reviews occur.

The semantic-placement and Review-Scope prerequisites for CS5 are closed. Expansion completeness is independent of repetition readiness.

## Source mechanics

Existing source/provenance rules remain specialized supporting mechanics. Historical paths/branches/ZIP commands inside old source-processing documents are not current execution authority without revalidation.

## Retired Use-Case identities

These are no longer independent current Use Cases:

- `UC-KNOWLEDGE-CREATE-OR-CHANGE` → knowledge-producing UCs + `PROCESS-INTEGRATE-VERIFIED-KNOWLEDGE`;
- `UC-KNOWLEDGE-MIGRATE-WORKSPACE` → `UC-KNOWLEDGE-MATERIALIZE-SOURCE` + specialized no-loss mechanics;
- `UC-LEARNING-COLLECT-DAY` → `UC-LEARNING-CAPTURE-BATCH`.

## Validation history versus current evidence

Historical/provisional evidence includes CS2 pilot, semantic-map v1, worklists, hierarchy v1/v2 and old audits. These remain useful for provenance but are not the current assignment.

Current evidence:

- [`../domains/software-engineering/KNOWLEDGE-MAP.md`](../domains/software-engineering/KNOWLEDGE-MAP.md)
- [`../validation/software-engineering-semantic-hierarchy-v3.csv`](../validation/software-engineering-semantic-hierarchy-v3.csv)
- [`../domains/software-engineering/RESPONSIBILITY-CATALOG.md`](../domains/software-engineering/RESPONSIBILITY-CATALOG.md)
- [`../domains/software-engineering/MANIFESTATION-COVERAGE.md`](../domains/software-engineering/MANIFESTATION-COVERAGE.md)
- [`../validation/software-engineering-responsibility-first-coverage-audit-v1.md`](../validation/software-engineering-responsibility-first-coverage-audit-v1.md)

## Next gate — CS5 repetition cutover

Current pre-cutover analysis: [`CS5-REPETITION-CUTOVER-ANALYSIS.md`](CS5-REPETITION-CUTOVER-ANALYSIS.md). It records verified source facts, deterministic non-mappings, candidate representations, and unresolved decisions. It is not a permanent semantic owner and does not yet authorize schema/data cutover.
Current validation: [`../validation/cs5-advisory-retention-scheduling-audit-v5.md`](../validation/cs5-advisory-retention-scheduling-audit-v5.md). The earlier v4 retention-map audit remains provenance but is superseded where it over-formalized class assignment and interval decisions; the sparse-repetition audit v3 is also superseded.

The previous target design introduced a universal `Learning State = ACTIVE | STABLE` axis. Current methodology still rejects that axis.

The current daily flow is instead:

```text
D0 capture
→ D+2 triage/materialization + first learning/review contact + Repetition Map entry/update
→ next review date chosen with Retention Class + context/workload as guidance
```

For important `CORE` knowledge, five clear days after D+2 materialization gives D+8. Less important knowledge may be scheduled later. D+8 is therefore not a mandatory extra lifecycle stage for every Unit.

Current personal policy aims for broad Repetition Map coverage of the durable corpus. `CORE | WORKING | RECOGNITION | MAP_ONLY` are qualitative retention flags that help communicate desired memory/awareness depth; they guide rather than mechanically determine scheduling. `MAP_ONLY` is a low-intensity map/comparison anchor rather than absence from the map.

CS5 may proceed from the semantic/Review-Scope side, but must still decide/validate:

1. minimal physical Repetition Map/history schema, including nullable/advisory Retention Class during staged classification;
2. safe staged rollout of the existing 576 Review Scopes and practical first future dates without inventing history or creating an impossible workload spike;
3. physical treatment of lightweight `MAP_ONLY` refresh versus recall-bearing review events;
4. replacement of initial-wave architecture by the new map/date workflow while preserving normal manual scheduling;
5. retirement boundary for the legacy scheduler/dashboard/state authority.

Exact per-class interval formulas, a deterministic Retention Class assignment algorithm, and formal class-transition rules are not CS5 prerequisites. Defaults such as the CORE five-clear-day follow-up remain guidance that the owner may adjust by context and workload.

Physical Knowledge Unit moves remain optional and are not a CS5 prerequisite.
