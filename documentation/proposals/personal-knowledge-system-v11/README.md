> **Historical proposal snapshot.** Current canonical methodology was promoted during CS1. Start at [`../../README.md`](../../README.md) and [`../../migration/CURRENT-MIGRATION-STATE.md`](../../migration/CURRENT-MIGRATION-STATE.md).

# Personal Knowledge System — consolidated target v11

Status:
- **Use Cases:** historical snapshot of the set later promoted to current owners.
- **Principles / policies / workflows:** proposals to approve.
- **Appendix:** explanatory simulation, not a second methodology.

This package supersedes the earlier proposal packages created in this conversation. It consolidates the corrected files so that one package has one terminology and one authority chain.

## Main model

```text
Universal Principles
       │
       ├───────────────┐
       ▼               ▼
Priority Model     Knowledge Structure / Ontology
       │               │
       └───────┬───────┘
               ▼
      Retention & Repetition
               │
               ├── Repetition Scheduling Policy
               └── review/repetition state

Capture Use Case
       │
       └── Default Daily Learning Inbox Workflow

Knowledge-producing Use Cases
       │
       └── Integrate Verified Knowledge process
```

## Critical distinctions

```text
Learning State     = maturity of the knowledge model
  ACTIVE | STABLE

Retention Class    = desired long-term availability from memory
  CORE | WORKING | RECOGNITION | MAP_ONLY

Recall State       = observed memory condition from stable reviews
  UNCALIBRATED | WEAK | RECOVERING | STRONG
```

These are separate axes.

## Navigation

- `use-case-registry.md`
- `use-cases/`
- `principles/UNIVERSAL-KNOWLEDGE-PRINCIPLES-PROPOSAL.md`
- `principles/PRIORITY-MODEL-PROPOSAL.md`
- `principles/KNOWLEDGE-STRUCTURE-ONTOLOGY-PROPOSAL.md`
- `principles/QUESTIONS-COVERAGE-EXPANSION-PROPOSAL.md`
- `principles/TAGS-COMPARISONS-AND-VIEWS-PROPOSAL.md`
- `principles/RETENTION-REPETITION-PROPOSAL.md`
- `policies/REPETITION-SCHEDULING-POLICY-PROPOSAL.md`
- `workflows/DEFAULT-DAILY-LEARNING-INBOX-WORKFLOW-PROPOSAL.md`
- `processes/PROCESS-TRIAGE-LEARNING-BATCH-PROPOSAL.md`
- `processes/PROCESS-INTEGRATE-VERIFIED-KNOWLEDGE-PROPOSAL.md`
- `appendices/END-TO-END-SYSTEM-SIMULATION.md`
- `appendices/PRIORITY-MODEL-REAL-CORPUS-VALIDATION-v1.md`

## Default personal learning lane

The generic Capture Use Case is implemented by a default personal workflow:

```text
D0   collect raw daily batch
D+2  triage / verify / split / materialize
D+8  first formative recall of materialized learning (when still ACTIVE)
      or baseline calibration when the scope is already STABLE and eligible
```

The dates are an operational default, not a universal semantic truth.


## Priority validation adjustments in v7

Real-corpus validation kept the four priority dimensions and added two explicit rules:

1. **Usefulness is contextual.** Priority is interpreted relative to a current planning context/horizon.
2. **Do not average heterogeneous retention needs.** If one Knowledge Unit contains main content that clearly deserves different retention treatment, first revisit the Unit/Review Scope boundary.

These changes refine the existing model; they do not add a fifth priority dimension.


## Canonical ownership rule in v8

Knowledge is not stored under a technology merely because the technology is involved.

- broader engineering concept → owns ordinary technology manifestations;
- technology → owns its own defining model;
- if the defining technology model is also a broader engineering manifestation, keep one technology-owned canonical Unit and link it from the engineering concept map.

This rule is now part of the ontology proposal and should be used when designing the Software Engineering map and migration plan.

- `appendices/CANONICAL-KNOWLEDGE-OWNERSHIP-EXAMPLES.md`


## v9 current-state additions

- `CURRENT-STATE.md` — concise current best system state.
- `principles/TAGS-COMPARISONS-AND-VIEWS-PROPOSAL.md` — current tag/comparison/view model.
- `domains/software-engineering/CURRENT-PROPOSAL-STATE.md` — current Software Engineering proposal status.
- `domains/software-engineering/proposals/map-v3/` — latest Engineering Map proposal and audits.
- `CHANGELOG-v9.md` — changes from v8.

v9 deliberately does not make pairwise analogy relations mandatory. Durable comparison knowledge is stored as normal comparison Knowledge Units with ordinary links.


## v10 current-state additions

- `CURRENT-STATE.md` — current best system state and three-view model.
- `principles/QUESTIONS-COVERAGE-EXPANSION-PROPOSAL.md` — local Question placement, Key Questions, answer integration, Coverage & Expansion, and Expansion Plan.
- `principles/TAGS-COMPARISONS-AND-VIEWS-PROPOSAL.md` — updated lightweight tags/comparison model plus the reduced core view set.
- `principles/RETENTION-REPETITION-PROPOSAL.md` — now includes the operational Repetition View (`Today / Upcoming / Attention / History`).
- `CHANGELOG-v10.md` — changes from v9.

### Current core views

```text
Coverage & Expansion View
Expansion Plan
Repetition View
```

The canonical knowledge base itself is not a view. Technology/topic/comparison perspectives default to tags and filters. `Inbox / Triage` remains a workflow, not a view.

## v11 consistency cleanup

v11 resolves the remaining consistency seams found in the v10 audit:

- Repetition Scheduling Policy no longer defines a global daily work order across repetition, triage, expansion, and questions.
- `UC-KNOWLEDGE-EXPAND-BY-ANALOGY` no longer requires fixed analogy-relation enums; durable comparison is expressed in comparison Knowledge Units/prose.
- `UC-KNOWLEDGE-PLAN-EXPANSION` explicitly owns optional temporal/order placement into Expansion Plan.
- local Question Inbox terminology is normalized to Area / nested Area / Concept.
- defining Key Questions may remain local without an independent ID unless they need their own planning/lifecycle/history.
- the end-to-end simulation now exercises the current three-view model and local Question lifecycle.
