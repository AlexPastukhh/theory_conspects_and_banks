# Coverage / Questions / Expansion Operationalization — CS4 validation

Status: CS4 migration/validation evidence.

Date: 2026-09-25

## Inputs

- complete 576-ID semantic map from CS3;
- `Questions, Coverage & Expansion` current principle;
- current Priority Model;
- Software Engineering Map v3 working Area frame.

## Materialized operational state

CS4 introduces `_ai-conspects/_planning/` as an operational projection/state layer, not a new semantic owner:

- `COVERAGE_AND_EXPANSION.md`;
- `COVERAGE_STATE.csv`;
- `QUESTIONS.csv`;
- `EXPANSION_PLAN.md`;
- `README.md`.

## Coverage baseline

- Areas represented: **15 / 15**;
- `COVERED`: **0**;
- `PARTIAL`: **14**;
- `MISSING`: **1** (`A14 — Software Lifecycle & Engineering Practice`).

This is deliberately conservative. A current Knowledge Unit count proves presence, not semantic completeness. An Area is not marked `COVERED` until its responsibilities/Key Questions are explicitly demonstrated sufficiently answered.

## Questions

- durable Area Key Questions: **30** (two per Area), stored in the Coverage & Expansion projection without standalone Question IDs;
- independently tracked Open Expansion Questions: **10**;
- `PURSUE_NOW / READY`: **5**;
- `DEFER / LATER`: **5**.

No `Today` / `Tomorrow` calendar slot was invented. The current migration context supports priority/order, but not a user-selected daily learning schedule.

Tracked Question identity is used only because these ten Questions have independent planning/priority/lifecycle needs. Their durable answers remain owned by canonical Knowledge/Concept locations, not by the Question rows.

## Supersession boundary

`_ai-conspects/_knowledge/AREAS-PRIORITY-MAP.md` is retained as historical pre-v11 planning evidence. Its old P0–P3 backlog is no longer the current Expansion Plan.

Legacy `_repetition/QUESTIONS_BACKLOG.md` is not the current expansion registry after CS4. It remains only transitional storage for the pre-CS5 legacy repetition workflow where needed.

## Integrity result

CS4 changes no Knowledge Unit body or physical Knowledge Unit path and does not alter:

- `_ai-conspects/_repetition/REPETITION_STATE.csv`;
- `_ai-conspects/_repetition/INITIAL_WAVE_QUEUE.csv`.

The complete corpus remains **576 unique Knowledge IDs**.

## Gate

**CS4 PASS.** Coverage / Questions / Expansion is operational enough to stop relying on the legacy Areas/P0–P3 artifact for current expansion planning.

CS5 repetition cutover is **not yet ready**. The blocker remains the CS3 Review Scope / Unit-boundary worklist: 170 Units do not yet have an authoritative explicit Review Scope, and boundary cases must retain explicit dispositions. Physical file migration remains optional and is not a CS5 prerequisite.
