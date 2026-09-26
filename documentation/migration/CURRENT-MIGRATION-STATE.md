# Personal Knowledge System Migration — Current State

Status: authoritative temporary migration control for this snapshot. Permanent semantics remain owned by the linked principles, policies, Use Cases, and domain maps.

## Current phase

```text
CS1–CS5                    COMPLETE
- universal methodology
- semantic hierarchy / responsibility-first coverage
- explicit Review Scope for 576 / 576 Units
- retention classification for 576 / 576 Units
- Repetition Map physical/runtime cutover
- Expansion operational owner ready

CS6                       PENDING / separate
- physical Knowledge Unit representation / moves

CS7                       PENDING
- post-move link/path/consistency audit
```

The system is operationally ready **without** moving Knowledge Unit files first. Existing `_ai-conspects/_knowledge/<topic>/...` paths remain the old physical representation and are not semantic authority.

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
- Physical `_ai-conspects/_knowledge/<topic>/` paths remain unchanged.
- Physical path is representation, not canonical semantic ownership.

Current owner-kind migration labels remain:

```text
259 AREA
317 TECHNOLOGY_CORE_CANDIDATE
0 ambiguous
```

`TECHNOLOGY_CORE_CANDIDATE` is still a semantic/representation migration label, not an instruction to duplicate or move a Unit automatically.

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
0 planned Expansion Map items
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

## Physical Knowledge Unit move — only remaining representation task

A future physical move may reorganize current `_knowledge/<topic>/...` files according to the accepted semantic hierarchy / Technology Core representation.

That move must:

1. preserve every `KnowledgeId`;
2. preserve Knowledge Unit content unless a separate semantic edit is explicitly intended;
3. update `UnitPath` / `ReviewScopeRef` in `_ai-conspects/_repetition/REPETITION_MAP.csv`;
4. update any path-bearing current projections/links that truly depend on physical location;
5. not recalculate Retention Band, first-pass order, review dates, or history merely because a file moved;
6. run a post-move link/ID/Review-Scope consistency audit.

The move is separate from Expansion: reorganizing existing files does not populate `EXPANSION_MAP.md`.

## Current validation evidence

- `documentation/validation/software-engineering-semantic-hierarchy-v3.csv`
- `documentation/validation/retention-priority-classification-v4.csv`
- `documentation/validation/cs5-initial-repetition-rollout-v1.csv`
- `documentation/validation/cs5-retention-classification-rollout-audit-v6.md`
- `documentation/validation/cs5-operational-readiness-audit-v7.md`

Older audits/proposals remain provenance only where superseded.

## Next gate

There is no remaining CS5 methodology/schema blocker for ordinary operation.

The next separate migration gate is the physical Knowledge Unit representation/move followed by consistency validation. Until that move is requested, use stable Knowledge IDs plus the current paths recorded in `REPETITION_MAP.csv`.
