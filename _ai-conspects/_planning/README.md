# Planning / Expansion Operational Layer

Status: **current operational projection/state layer**. Semantic authority remains in `documentation/principles/`, applicable Use Cases, and current domain maps.

## Current files

- `COVERAGE_STATE.csv` — coarse root-Area roll-up; `technology_core_units` is the final CS6 ownership count by semantic Area, while presence/`PARTIAL` is not completeness.
- `SUBAREA_COVERAGE_STATE.csv` — broad nested-Area primary occupancy only.
- `RESPONSIBILITY_COVERAGE.csv` — responsibility-first semantic coverage checklist and main generic gap surface.
- `MANIFESTATION_COVERAGE.csv` — selected cross-runtime manifestation coverage; not an exhaustive curriculum.
- `QUESTIONS.csv` — independently tracked Open Expansion Questions. Current rows are candidates, not scheduled work.
- `EXPANSION_MAP.md` — **current owner of explicitly planned expansion work**. Read the file for the current selected items rather than inferring them from coverage or Questions.
- `EXPANSION_PLAN.md` — compatibility pointer for older references; not current authority.
- `COVERAGE_AND_EXPANSION.md` — human-readable summary across the coverage projections.

## Coverage is not the Expansion Map

```text
coverage / Questions
    expose what may be incomplete or worth learning

explicit selection
    chooses what to work on

EXPANSION_MAP.md
    contains only selected expansion work
```

A `MISSING` responsibility, manifestation gap, or open Question does not automatically enter the Expansion Map. The current repository has **2 explicitly selected expansion directions** (Go and Rust), while other coverage gaps and 12 open Questions remain candidate state only.

`QUESTIONS.csv` may retain qualitative priority evidence, but current open rows use `UNSCHEDULED` and have no plan slot until the owner explicitly chooses expansion work.

## Do not merge coverage layers

- hierarchy / occupancy = where primary-owned knowledge currently sits;
- responsibility coverage = what the domain is expected to explain;
- manifestation coverage = how selected responsibilities appear in relevant ecosystems.

`COVERED` must be explicitly assessed. Unit count never implies it.

## Ownership boundary

A row in `QUESTIONS.csv` does not own its durable answer. The Area/Concept fields locate the question in the knowledge map. Durable answers belong in canonical Knowledge Units / semantic structure.

The current physical Knowledge layout is `_knowledge/engineering/...` plus `_knowledge/technology-core/...`. Physical location follows canonical ownership, while Expansion semantics remain owned by Area/Concept/Question selection rather than by folder paths.

## Relationship to repetition

Expansion and repetition are independent operational maps:

- `EXPANSION_MAP.md` — selected new/uncertain knowledge to expand;
- `../_repetition/REPETITION_MAP.csv` — existing durable knowledge to revisit.

Do not populate Expansion merely because a repetition review exposed a gap. Route the gap/question first; plan it only when explicitly selected.
