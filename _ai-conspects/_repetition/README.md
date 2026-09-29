# Repetition Runtime

Status: **current operational owner** for personal repetition after the CS5 cutover.

Semantic meaning is owned by:

- `../../documentation/principles/retention-repetition.md`;
- `../../documentation/principles/priority-model.md`;
- `../../documentation/policies/repetition-scheduling-policy.md`.

This directory stores operational state only. It does not own Knowledge ontology or canonical semantic placement.

## Current files

- `REPETITION_MAP.csv` — one current operational row per durable Knowledge Unit / Review Scope.
- `LEARNING_INBOX.md` — current D0 → D+2 capture/triage batch registry.
- `REVIEW_ENTRY_TEMPLATE.md` — optional template for lazy append-only review history.
- `history/` — created lazily when actual review history is worth keeping.
- `legacy/` — superseded pre-CS5 runtime kept only for provenance.

## Repetition Map contract

`KnowledgeId` is the stable identity. `UnitPath` is a convenience pointer to the current CS6 physical layout and may change in a later deliberate reorganization.

Current columns:

| Column | Meaning |
|---|---|
| `KnowledgeId` | stable Knowledge Unit identity |
| `Title` | human-readable current title |
| `RetentionBand` | advisory retention depth (`CORE`, `WORKING`, `RECOGNITION`, `MAP_ONLY`, or an adjacent `↔` band) |
| `InitialDay` | relative bucket for the first full-corpus pass; not a calendar date |
| `InitialOrder` | order inside the full first-pass queue |
| `SizeEquivalent` | workload estimate only; never changes semantic priority |
| `UnitPath` | current physical file pointer; synchronized to the CS6 Engineering/Technology Core layout |
| `ReviewScopeRef` | pointer to the authoritative `What should be recallable` section |
| `InitialReviewDate` | actual date when the first-pass review happens; blank until then |
| `LastReview` | last actual review date; blank until real review |
| `LastReviewType` | human-chosen review action/type; no mandatory enum is required |
| `LastRecallScore` | optional 0–4 score only when an actual blind-recall review used that scale |
| `NextReview` | next actual chosen date; blank until chosen after review |
| `NextReviewType` | next chosen action/type; optional |
| `NextScope` | whole Review Scope or narrower target; optional |
| `Notes` | small operational context only |

Do not add a universal Knowledge Unit maturity state such as `ACTIVE/STABLE`.

## Initial full-corpus pass

All 576 current Units enter one first-pass queue.

Priority order is strict:

```text
CORE
→ CORE ↔ WORKING
→ WORKING
→ WORKING ↔ RECOGNITION
→ RECOGNITION
→ RECOGNITION ↔ MAP_ONLY
→ MAP_ONLY
```

The initial queue uses a starting capacity of **at least 30 standard-unit-equivalents per relative day**. The size estimate only packs workload. It never moves a lower-priority Unit ahead of an unreviewed higher-priority Unit.

`InitialDay` is deliberately relative. No calendar dates or fake review history are pre-created. To start work, take the lowest unfinished `InitialDay`, then follow `InitialOrder`.

Day 1 currently contains all 20 `CORE`, the single `CORE ↔ WORKING`, then enough `WORKING` items to reach 30.00 estimated equivalents.

## What happens when a Unit is reviewed

The owner decides the actual depth from the Unit, its advisory Retention Band, current context, and the quality of recall. The system does **not** precompute a second/third repetition schedule.

After the real review:

1. fill `InitialReviewDate` if this was the first-pass review;
2. set `LastReview` and, when useful, `LastReviewType` / `LastRecallScore`;
3. choose `NextReview` manually for this Unit;
4. optionally set `NextReviewType` / `NextScope`;
5. append history only if useful.

Retention guidance and interval heuristics may inform the next date, but they do not determine it mechanically.

`MAP_ONLY` may use a lightweight map/recognition refresh and does not require a normal 0–4 score.

## Findings routing

A review finding should be routed by meaning:

- `MEMORY_GAP` → repetition / next review;
- `KNOWLEDGE_BASE_GAP` → Coverage / Expansion candidate source;
- `NEW_QUESTION` → `_ai-conspects/_planning/QUESTIONS.csv` when independent tracking is useful.

A finding does not automatically create a planned expansion item.

## Physical Knowledge Unit layout

CS6 materialized the canonical physical representation under `_knowledge/engineering/...` and `_knowledge/technology-core/...`. `REPETITION_MAP.csv` was synchronized by `KnowledgeId`: all 576 `UnitPath` values point to the current Unit files and all `ReviewScopeRef` values point to their current recall sections.

A later physical reorganization must preserve `KnowledgeId`, update these pointers, and must not recalculate Retention Band, first-pass order, review dates, scores, or history merely because a file moved.

## Legacy boundary

Everything under `legacy/` is superseded. Do not read those files as current scheduler/state authority.
