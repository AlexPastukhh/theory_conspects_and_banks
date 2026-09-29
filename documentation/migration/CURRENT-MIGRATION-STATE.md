# Personal Knowledge System Migration — Current State

Status: migration closure/current-state control for this snapshot. Permanent semantics remain owned by the linked principles, policies, Use Cases, and domain maps.

## Current phase

```text
CS1–CS5                    COMPLETE
- universal methodology
- semantic hierarchy / responsibility-first coverage
- explicit Review Scope for 576 / 576 Units
- retention classification for 576 / 576 Units
- Repetition Map physical/runtime cutover
- Expansion operational owner ready

CS6                       COMPLETE
- physical Knowledge Unit representation / moves
- path-bearing runtime/projections synchronized

CS7                       COMPLETE
- post-move link/path/ID/Review-Scope consistency audit
```

The physical Knowledge representation now follows canonical ownership: Area-owned Units are under `_ai-conspects/_knowledge/engineering/...`; defining language/runtime/framework/library Units are under `_ai-conspects/_knowledge/technology-core/...`. The semantic hierarchy remains authority over meaning; folders are a deliberately shallow projection.

## Read this snapshot in this order

1. `README.md` / `AGENTS.md`;
2. `documentation/README.md`;
3. this file;
4. applicable Use Case + principle/policy;
5. current operational map/state;
6. validation/migration history only when provenance is needed.

Do not reconstruct current truth from an older validation artifact, proposal, legacy scheduler, or physical folder when a current owner is named below.

## Current semantic owners

Universal/current owners:

- `documentation/use-case-registry.md` and `documentation/use-cases/`;
- `documentation/principles/`;
- `documentation/processes/`;
- repetition semantics: `documentation/principles/retention-repetition.md`;
- repetition scheduling: `documentation/policies/repetition-scheduling-policy.md`;
- repository authority boundary: `documentation/repository-work-principles.md`.

Software Engineering owners/projections:

- logical hierarchy: `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`;
- current Unit assignment: `documentation/validation/software-engineering-semantic-hierarchy-v3.csv`;
- responsibility catalog: `documentation/domains/software-engineering/RESPONSIBILITY-CATALOG.md`;
- responsibility coverage: `_ai-conspects/_planning/RESPONSIBILITY_COVERAGE.csv`;
- manifestation coverage: `_ai-conspects/_planning/MANIFESTATION_COVERAGE.csv`.

## Knowledge corpus state

- **576 / 576** stable Knowledge IDs are present.
- **576 / 576** have current semantic placement in hierarchy v3.
- **576 / 576** have exactly one explicit `## What should be recallable` Review Scope.
- **576 / 576** Units have a current physical path in the CS6 representation.
- Physical path is representation of canonical ownership, not a replacement for semantic Area/Concept authority.

Final physical owner kinds are:

```text
257 AREA
319 TECHNOLOGY_CORE
0 ambiguous
```

Historical `TECHNOLOGY_CORE_CANDIDATE` values remain only in superseded validation/provenance artifacts. Current hierarchy v3 contains final physical ownership for migrated Units.

## Coverage / Questions / Expansion

Current operational directory: `_ai-conspects/_planning/`.

Coverage layers remain distinct:

- `COVERAGE_STATE.csv` — coarse Area roll-up;
- `SUBAREA_COVERAGE_STATE.csv` — primary occupancy only;
- `RESPONSIBILITY_COVERAGE.csv` — generic semantic coverage/gap checklist;
- `MANIFESTATION_COVERAGE.csv` — selected cross-runtime projection;
- `QUESTIONS.csv` — independently tracked open Questions;
- `EXPANSION_MAP.md` — **only explicitly planned expansion work**.

Current baseline:

```text
15 root Areas
80 broad nested Areas: 52 HAS_PRIMARY_EVIDENCE / 28 NO_PRIMARY_EVIDENCE
183 responsibilities: 101 PARTIAL / 82 MISSING / 0 COVERED asserted
12 open tracked Questions
2 planned Expansion Map items: Go foundations/manifestations; Rust foundations/manifestations
```

All 12 current open Questions are `UNSCHEDULED`; their qualitative priority evidence remains available, but none is currently selected for expansion work. A `MISSING` responsibility or open Question is not automatically an expansion plan.

`EXPANSION_PLAN.md` is now only a compatibility pointer. Current owner: `_ai-conspects/_planning/EXPANSION_MAP.md`.

## Repetition — current runtime

Current operational owner: `_ai-conspects/_repetition/REPETITION_MAP.csv`.

Runtime contract: `_ai-conspects/_repetition/README.md`.

The table contains **576 / 576** current Knowledge IDs and seeds one first-pass review for the full durable corpus. It does not contain fabricated review evidence.

Current retention distribution:

- `CORE`: 20
- `CORE ↔ WORKING`: 1
- `WORKING`: 273
- `WORKING ↔ RECOGNITION`: 16
- `RECOGNITION`: 258
- `RECOGNITION ↔ MAP_ONLY`: 0
- `MAP_ONLY`: 8

The first-pass queue is priority-first:

```text
CORE
→ CORE ↔ WORKING
→ WORKING
→ WORKING ↔ RECOGNITION
→ RECOGNITION
→ RECOGNITION ↔ MAP_ONLY
→ MAP_ONLY
```

Starting load: **at least 30 standard-unit-equivalents per relative day**. The current queue spans 25 relative buckets. Day 1 contains all 20 `CORE`, the 1 `CORE ↔ WORKING`, then 8 `WORKING`, for 30.00 estimated equivalents.

Important runtime rules:

- `InitialDay` is relative; it is not a fabricated calendar review date.
- all actual review/history/date fields start blank;
- the owner chooses review depth per Unit at the actual review;
- the owner chooses `NextReview` per Unit after that actual review;
- retention band and interval heuristics guide judgment but do not mechanically determine the next date;
- `MAP_ONLY` can use a lightweight refresh and does not require a normal 0–4 score;
- no universal `ACTIVE/STABLE` Knowledge Unit state exists;
- no mandatory stored Recall-State column is required by the current physical map.

Pre-CS5 repetition artifacts are isolated under `_ai-conspects/_repetition/legacy/` and are provenance only. Their old `LearningState`, synthetic `CALIBRATION`, wave slots, priorities, and empty history are not current state.

## Learning capture / triage

Current batch registry: `_ai-conspects/_repetition/LEARNING_INBOX.md`.

Current lifecycle:

```text
D0 COLLECTED
→ D+2 TRIAGE_DUE
→ TRIAGED / CLOSED
```

D+2 may create/update durable Knowledge, Review Scope, Questions, and Repetition Map entries. It is not a blind-recall score. There is no universal D+8 batch lifecycle stage; the Unit's next review belongs to the Repetition Map and is chosen per Unit.

## Physical Knowledge Unit representation — completed

CS6 materialized the accepted ownership rule:

- Area-owned Units: `_ai-conspects/_knowledge/engineering/<area>/<broad-nested-area>/<unit>.md`;
- defining technology models: `_ai-conspects/_knowledge/technology-core/<technology>/<unit>.md`;
- broad Area indexes link to relevant Technology Core Units without duplicating bodies.

The move preserved all 576 `KnowledgeId` values and all 576 Review Scopes. 575 Unit bodies are byte-identical to the pre-move body; one Unit received link-only relative-path repair for three Markdown links. No retention band, first-pass order, actual review evidence, Questions, or Expansion plan was changed because of the move.

`REPETITION_MAP.csv` and current path-bearing validation projections were synchronized to the new paths. The move remains separate from Expansion: reorganizing existing files did not populate `EXPANSION_MAP.md`.

## Current validation evidence

- `documentation/validation/software-engineering-semantic-hierarchy-v3.csv`
- `documentation/validation/retention-priority-classification-v4.csv`
- `documentation/validation/cs5-initial-repetition-rollout-v1.csv`
- `documentation/validation/cs5-retention-classification-rollout-audit-v6.md`
- `documentation/validation/cs5-operational-readiness-audit-v7.md`
- `documentation/validation/cs6-physical-move-manifest-v1.csv`
- `documentation/validation/cs6-physical-move-audit-v1.md`

Older audits/proposals remain provenance only where superseded.

## Migration closure state

There is no remaining CS1–CS7 migration blocker in this finalized snapshot. Ordinary operation should use the current semantic owners, the current Engineering/Technology Core physical representation, `REPETITION_MAP.csv`, and the current planning layer.

Historical validation/proposal/legacy artifacts remain provenance only. Any later taxonomy or physical-layout change is a new deliberate migration, not continuation of CS6.
