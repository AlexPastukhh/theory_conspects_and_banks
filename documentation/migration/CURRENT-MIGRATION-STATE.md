# Personal Knowledge System Migration — Current State

Status: authoritative temporary migration control for this snapshot. It tells a new chat which representations are current versus historical/transitional; permanent semantic rules remain owned by the linked principles/Use Cases/domain maps.

## Current phase

```text
CS5 pre-cutover
- semantic hierarchy v3 established
- responsibility-first coverage refinement established
- Review Scope blocker closed

NEXT: CS5 repetition state/scheduler cutover
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
- legacy `NOT_REVIEWED` does **not** mean target `ACTIVE`;
- do not invent Learning State, Retention Class, Recall State, score, interval, or review history before CS5 cutover.

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

CS5 may proceed from the semantic/Review-Scope side, but must independently decide:

1. target state-file/schema representation;
2. which Units are `STABLE + UNCALIBRATED` versus genuinely `ACTIVE`;
3. Retention Class assignment without mechanically translating legacy `ReviewPriority`;
4. migration of legacy rows without inventing recall history;
5. replacement of initial-wave architecture by target calibration eligibility/query;
6. retirement boundary for the legacy scheduler/dashboard.

Physical Knowledge Unit moves remain optional and are not a CS5 prerequisite.
