# Planning / Expansion Operational Layer

Status: current operational projection/state layer after responsibility-first coverage refinement and semantic hierarchy v3; repetition cutover has not occurred yet.

This directory materializes Coverage / Questions / Expansion state without becoming a second semantic owner. Canonical meaning remains in `documentation/principles/`, relevant Use Cases, and current domain maps.

## Files and exact meaning

- `COVERAGE_STATE.csv` — coarse root-Area roll-up. `PARTIAL` here means the Area has some evidence; it is **not** a completeness claim.
- `SUBAREA_COVERAGE_STATE.csv` — broad nested-Area **primary-occupancy** projection using `HAS_PRIMARY_EVIDENCE / NO_PRIMARY_EVIDENCE`. These are not semantic coverage statuses; responsibility coverage can still be `PARTIAL` or `MISSING` independently.
- `RESPONSIBILITY_COVERAGE.csv` — responsibility-first semantic coverage checklist; primary machine-readable surface for generic `PARTIAL/MISSING` gaps.
- `MANIFESTATION_COVERAGE.csv` — selected cross-runtime manifestation baseline. It is not exhaustive and does not define a complete Python/Node/.NET curriculum.
- `QUESTIONS.csv` — independently tracked Open Expansion Questions only. Most gaps intentionally do not receive Question IDs.
- `EXPANSION_PLAN.md` — temporal/actionable projection over selected tracked work; it does not own the underlying gap/Question.
- `COVERAGE_AND_EXPANSION.md` — human-readable summary across these projections.

## Do not merge coverage layers

```text
hierarchy / occupancy
    where primary-owned knowledge currently sits

responsibility coverage
    what the domain is expected to explain

manifestation coverage
    how selected responsibilities appear in relevant ecosystems
```

The same broad node can have `NO_PRIMARY_EVIDENCE` while a responsibility in that family is `PARTIAL` because supporting evidence has a different primary home. Conversely, a node with `HAS_PRIMARY_EVIDENCE` may still have many semantic `MISSING` responsibilities.

`COVERED` must be explicitly assessed. Unit count never implies it.

`responsibility_family` in `RESPONSIBILITY_COVERAGE.csv` is only a coverage-grouping label. It may coincide with a current nested Area, but it is not itself proof that such an ontology node exists. Likewise, `concept_label` in hierarchy v3 is not a fully normalized Concept registry.

In `RESPONSIBILITY_COVERAGE.csv`, `evidence_ids` are accepted current support; `candidate_evidence_ids` are only audit leads. Do not upgrade `MISSING` because candidate matches exist.

## Ownership boundary

```text
canonical Knowledge / Area / Concept
        +
Questions / coverage semantics
        ↓
this directory = operational projection/state
```

A row in `QUESTIONS.csv` does not own its durable answer. The `area` / `concept` fields point to where the Question belongs in the knowledge map. Simple defining Key Questions remain local without standalone Question IDs unless they need independent planning/lifecycle/history.

The current physical `_knowledge/<topic>/` layout remains unchanged and is not semantic authority.

## Manifestation boundary

Cross-runtime checking starts from a generic responsibility. It does not require one concrete framework/tool to have a direct counterpart in every ecosystem. `NOT_APPLICABLE` or no useful direct equivalent is valid.

A responsibility discovered while studying Python/Node/browser/.NET must be checked symmetrically against other relevant ecosystems, including .NET; historical corpus size does not grant automatic coverage.

## Scheduling boundary

Expansion Plan does not globally outrank or merge with Repetition or Capture/Triage. `_ai-conspects/_repetition/` remains legacy/transitional until CS5 state/scheduler cutover.
