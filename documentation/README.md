# Documentation

Status: current structural navigation for Personal Knowledge System methodology and repository-specific guidance.

## Reading contract / authority

For a fresh snapshot, use this authority order:

```text
CURRENT semantic owner (principle / policy / Use Case / domain map)
        ↓
CURRENT operational projection/state
        ↓
validation evidence / migration history
        ↓
proposal provenance / legacy implementation
```

A validation CSV, old proposal, legacy dashboard, or physical folder may contain useful evidence, but it does not override a current owner.

Start with:

1. [Current migration state](migration/CURRENT-MIGRATION-STATE.md)
2. [Use-Case Registry](use-case-registry.md)
3. the applicable principle/policy/domain map.

## Universal methodology

- [Universal Knowledge Principles](principles/universal-knowledge-principles.md)
- [Knowledge Structure & Ontology](principles/knowledge-structure-ontology.md)
- [Priority Model](principles/priority-model.md)
- [Questions, Coverage & Expansion](principles/questions-coverage-expansion.md)
- [Tags, Comparisons & Core Views](principles/tags-comparisons-and-views.md)
- [Retention & Repetition](principles/retention-repetition.md)
- [Repetition Scheduling policy](policies/repetition-scheduling-policy.md)

## Repository-specific guidance

- [Repository work principles](repository-work-principles.md)
- [Knowledge Unit principles](knowledge-conspect-principles.md)
- [Image/source visual principles](image-conspect-principles.md)

## Current operational state

- [Planning-layer boundary](../_ai-conspects/_planning/README.md)
- [Coverage & Expansion](../_ai-conspects/_planning/COVERAGE_AND_EXPANSION.md)
- [Tracked Questions](../_ai-conspects/_planning/QUESTIONS.csv)
- [Expansion Map](../_ai-conspects/_planning/EXPANSION_MAP.md) — current planned expansion owner; currently empty
- [Repetition runtime](../_ai-conspects/_repetition/README.md)
- [Repetition Map](../_ai-conspects/_repetition/REPETITION_MAP.csv) — current 576-row operational table

These are projections/state, not replacement semantic owners for principles, Use Cases, or domain ontology.

## Current domain maps

### Software Engineering

- [Knowledge Map](domains/software-engineering/KNOWLEDGE-MAP.md) — current logical Area / recursive nested-Area hierarchy; non-prescriptive about physical layout.
- [Responsibility Catalog](domains/software-engineering/RESPONSIBILITY-CATALOG.md) — responsibility-first completeness checklist independent of current folder/node occupancy.
- [Cross-Runtime Manifestation Coverage](domains/software-engineering/MANIFESTATION-COVERAGE.md) — selected symmetric .NET / JavaScript / Browser / Node.js / Python coverage projection; not an exhaustive curriculum.
- Current machine-readable hierarchy: [semantic hierarchy v3](validation/software-engineering-semantic-hierarchy-v3.csv).

## Important interpretation boundary

```text
hierarchy = where knowledge belongs
responsibility catalog = what the domain should explain
manifestation coverage = how relevant technologies express those responsibilities
repetition = memory/awareness maintenance over Review Scopes at Retention-Class-dependent strength
```

Do not infer `COVERED` from Unit count. Do not infer `MISSING` merely from an empty folder. Do not turn every responsibility into a nested Area or every manifestation into a required one-to-one tool analogue.

## Migration

- [Current migration state](migration/CURRENT-MIGRATION-STATE.md) — authoritative temporary boundary for this snapshot.
- [CS5 repetition cutover analysis](migration/CS5-REPETITION-CUTOVER-ANALYSIS.md) — completed cutover analysis/provenance; current runtime is `_ai-conspects/_repetition/REPETITION_MAP.csv`.
- [CS5 sparse repetition / learning workflow audit v3](validation/cs5-sparse-repetition-methodology-audit-v3.md) — superseded validation evidence from the over-sparse intermediate model.
- [CS5 retention-map methodology audit v4](validation/cs5-retention-map-methodology-audit-v4.md) — superseded validation evidence; retained for provenance.
- [CS5 advisory retention/scheduling audit v5](validation/cs5-advisory-retention-scheduling-audit-v5.md) — current validation evidence that Retention Classes and interval tables are guidance/defaults rather than a rigid automated state machine.
- [CS5 retention classification + initial rollout v1](validation/cs5-retention-classification-and-rollout-v1.md) — current full-corpus 576-Unit advisory classification and priority-first relative rollout evidence.
- [Retention priority classification v4 CSV](validation/retention-priority-classification-v4.csv) — machine-readable current working retention distribution.
- [Initial repetition rollout v1 CSV](validation/cs5-initial-repetition-rollout-v1.csv) — relative day buckets using the current 30-standard-unit starting workload.
- [CS5 classification/rollout audit v6](validation/cs5-retention-classification-rollout-audit-v6.md) — current integrity checks for the full-corpus classification and rollout.
- [CS5 operational readiness audit v7](validation/cs5-operational-readiness-audit-v7.md) — validates the current Repetition Map cutover, empty Expansion Map, legacy isolation, and unchanged Knowledge Unit bodies.
- [Migration plan](migration/PERSONAL-KNOWLEDGE-SYSTEM-MIGRATION-PLAN.md) — plan/provenance; current state wins when they differ.

The previous consolidated v11 package remains under `proposals/personal-knowledge-system-v11/` as provenance. Its wrapper/index files are non-authoritative after CS1.
