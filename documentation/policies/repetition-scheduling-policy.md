# Repetition Scheduling Policy

Status: current target scheduling policy. Legacy `_repetition` records remain transitional until CS5; do not silently reinterpret them.

## 1. One Repetition Map, different retention strengths
The target personal system uses one Repetition Map over durable Review Scopes.

The map is intended to cover essentially the durable corpus, but the work item is not identical for every class:
- `CORE | WORKING | RECOGNITION` use active-recall retention at different strengths;
- `MAP_ONLY` uses very light map/relationship refresh and does not require ordinary recall scoring.

This broad coverage is a personal retention policy, not a requirement that Knowledge ontology itself depend on repetition state. Retention Class and interval guidance are decision aids, not a deterministic scheduler contract: manual choice of the next useful date is normal.

## 2. Entry after learning/materialization
When a learning batch is triaged/materialized into a new or materially reshaped durable Knowledge Unit:
1. finalize/update its authoritative Review Scope;
2. assess/update priority/retention treatment when useful;
3. insert/update the Scope in the Repetition Map;
4. treat the D+2 materialization pass as the first learning/review contact;
5. choose the next review date using Retention Class, current context, and workload as guidance.

The materialization pass is **not** a blind recall calibration. It must not create a recall score, `WEAK/RECOVERING/STRONG`, or fictional review history.

If class assessment is not useful or cannot yet be justified, the map item may temporarily have no class; this must not block scheduling a sensible next review. Do not use `UNDECIDED` as a fifth Retention Class.

## 3. Initial post-materialization timing
For important `CORE` knowledge, the default first active-recall review is after **five complete clear days** following materialization, then review on the next calendar day:

```text
materialized/reviewed on M
5 clear days
next review on M + 6
```

If materialization occurred on D+2, that review is D+8.

`WORKING`, `RECOGNITION`, and `MAP_ONLY` will often start later because their memory-pressure goal is lower. No exact class-specific starting gap is required as a system invariant. The owner may choose an appropriate date directly; future defaults may be added or adjusted when repeated use makes them helpful.

Choosing an earlier/later date manually is ordinary operation, not an exceptional override. Record a rationale only when it is useful for later interpretation.

## 4. Active-recall score
For `CORE | WORKING | RECOGNITION`, score actual recall **before opening the Unit**:

```text
0 — practically nothing reconstructed
1 — isolated fragments only
2 — core model recalled, substantial gaps remain
3 — coherent model recalled; gaps mostly details or one boundary
4 — model + important mechanics/failure modes/boundaries reconstructed without material hints
```

Score only against the authoritative Review Scope and the depth expected by the Retention Class. A base/source defect must not lower the memory score.

`MAP_ONLY` map-refresh does not require this 0–4 score unless the Scope is being promoted to a recall-bearing class.

## 5. Recall State
For recall-bearing classes:

```text
UNCALIBRATED — in the Repetition Map with CORE/WORKING/RECOGNITION treatment, but no valid blind-recall baseline yet
WEAK         — latest valid recall 0–1
RECOVERING   — latest valid recall 2–3, or recent failure after strength
STRONG       — at least two consecutive unhinted 4s and a completed interval >= 20 clear days
```

Observed states beyond `UNCALIBRATED` require real review evidence.

`MAP_ONLY` does not need normal Recall State.

## 6. Calendar semantics
Intervals count complete calendar days between reviews.

```text
review on D
Gap 1  → next review D + 2
Gap 5  → next review D + 6
Gap 10 → next review D + 11
```

Default active-recall ladder (a reusable scheduling heuristic, not a mandatory state machine):

```text
1, 5, 10, 20, 30, 60, 90, 180 complete days
```

`Next review date = review date + Gap + 1 calendar day`.

Late review records actual elapsed gap. Overdue status alone is not memory failure.

## 7. First blind-recall calibration
The first valid blind-recall review establishes evidence for Recall State. The table below provides recommended next gaps; the owner may choose another sensible date.

| Recall | Recall State | Next gap |
|---:|---|---:|
| 0 | WEAK | 1 |
| 1 | WEAK | 1 |
| 2 | RECOVERING | 5 |
| 3 | RECOVERING | 10 |
| 4 + CORE | RECOVERING | 20 |
| 4 + WORKING | RECOVERING | 30 |
| 4 + RECOGNITION | RECOVERING | 60 |

These are post-calibration gaps. They do **not** redefine the separate initial post-materialization timing in section 3.

## 8. Later interval guidance
When the default ladder is being used, let `completed stage` be the ladder gap that led to the current review. The rules below are default adaptation heuristics, not mandatory transitions.

| Final recall | Next interval rule |
|---:|---|
| 0–1 | reset to Gap 1 |
| 2 | move one ladder stage shorter; minimum 1 |
| 3 | move one ladder stage longer |
| 4 | move one stage longer; two stages allowed after two consecutive unhinted 4s |

Additional rules:
- a material misconception or missed critical invariant prevents score 4;
- a knowledge-base/source gap does not shorten interval by itself;
- a new Question may create expansion work without resetting the whole Scope;
- the owner may choose a different next interval/date when context, workload, or judgment warrants it; rationale is optional unless it is useful evidence.

Retention Class communicates desired memory pressure and actual recall informs scheduling; neither mechanically determines the next date.

## 9. `MAP_ONLY` scheduling
`MAP_ONLY` is a lightweight Repetition Map item, not full spaced-recall maintenance.

A map refresh should be able to ask only for lightweight awareness such as:
- what this Unit/manifestation is;
- where it belongs;
- why it exists;
- what other technology/responsibility it is useful to compare with;
- where the detailed knowledge can be recovered.

Its cadence can be chosen manually and may later gain a useful low-frequency default if practice justifies one. CS5 does not need an exact universal `MAP_ONLY` interval before cutover. Do not force the normal 0–4 ladder onto it.

## 10. Review/event types

```text
PLACEMENT     D+2 materialization/map entry or substantial rematerialization; no recall score
CALIBRATION   first valid blind active-recall pass for CORE/WORKING/RECOGNITION
FULL          reconstruct/verify full Review Scope
TARGETED      named weak scope/mechanism/question
QUESTIONS_ONLY answer already integrated questions without rereading full Unit
MAP_REFRESH   lightweight MAP_ONLY awareness/comparison refresh
SOURCE_REPAIR resolve evidence/provenance; no memory score
```

`FORMATIVE` may still be used by a local learning workflow when genuine extra practice is needed, but it is not a universal mandatory post-materialization stage.

## 11. Relationship to learning and expansion
The Repetition Map does not rank itself globally against Capture/Triage or Expansion.

A Scope can have both:
- a repetition due date; and
- expansion gaps/questions.

Only actual memory performance changes recall scheduling. Expansion findings route outward to their own owners.

## 12. Logical state requirements
For `CORE | WORKING | RECOGNITION`, the map needs enough state to support:
- Knowledge ID + authoritative Review Scope;
- Retention Class when assigned;
- Recall State when real recall evidence/participation makes it applicable;
- last real recall date/type/score when one exists;
- completed/next gap when applicable;
- next review date/type;
- lazy append-only history after real review activity.

For `MAP_ONLY`, the map needs at least:
- Knowledge ID + Review Scope/map-awareness scope;
- Retention Class = `MAP_ONLY`;
- next map-refresh date/type;
- optional last map-refresh evidence.

CS5 owns the exact physical schema. Legacy fields must not be copied merely because they exist.
