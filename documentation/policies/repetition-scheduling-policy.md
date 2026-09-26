# Repetition Scheduling Policy

Status: current scheduling policy. Current runtime is `_ai-conspects/_repetition/REPETITION_MAP.csv`; legacy pre-CS5 files under `_ai-conspects/_repetition/legacy/` are provenance only.

## 1. One Repetition Map, different retention strengths
The target personal system uses one Repetition Map over durable Review Scopes.

The map is intended to cover essentially the durable corpus, but the work item is not identical for every class:
- `CORE | WORKING | RECOGNITION` use active-recall retention at different strengths;
- `MAP_ONLY` uses very light map/relationship refresh and does not require ordinary recall scoring;
- adjacent boundary bands (`CORE ↔ WORKING`, `WORKING ↔ RECOGNITION`, `RECOGNITION ↔ MAP_ONLY`) may be used when one exact anchor would create false precision.

A boundary band is descriptive/advisory. It does not introduce a transition state or an automatic interval halfway between two classes; the owner chooses the useful review depth/date from context.

This broad coverage is a personal retention policy, not a requirement that Knowledge ontology itself depend on repetition state. Retention Class/band and interval guidance are decision aids, not a deterministic scheduler contract: manual choice of the next useful date is normal.

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

## 3A. Existing-corpus initial rollout

For the current 576-Unit CS5 rollout, use **priority-first batching**, not balanced quotas across retention classes.

Starting order:

```text
CORE
→ CORE ↔ WORKING
→ WORKING
→ WORKING ↔ RECOGNITION
→ RECOGNITION
→ RECOGNITION ↔ MAP_ONLY
→ MAP_ONLY
```

Fill a rollout day from the strongest remaining band first. Only after that band is exhausted may the same day continue into the next band. Do not manufacture mixes such as `10 CORE + 10 WORKING + 10 RECOGNITION` merely to diversify a day.

The owner selected a starting capacity of **at least 30 standard-unit-equivalents per rollout day**. This is a workload calibration, not a permanent ceiling.

The calibration Unit is `javascript.timers-tasks-microtasks-and-abortable-delay`:
- 53 total lines;
- 38 non-empty lines;
- approximately one standard review Unit at the current Review Scope.

The current rollout artifact also records Review-Scope size so very large support files do not count linearly as dozens of reviews. Its exact size-equivalent formula is an implementation heuristic documented in `../validation/cs5-retention-classification-and-rollout-v1.md`; it may be recalibrated from actual review time.

Rules:
- Retention Band outranks size. A smaller lower-priority Unit must not jump ahead of remaining higher-priority work merely because it fits a day better.
- Add whole Units until the day's estimated load reaches at least 30 equivalents; do not split a Unit only to hit an exact number.
- If observed daily capacity is comfortably higher, increase the practical target later without changing retention semantics.
- Initial rollout buckets are relative (`Day 1`, `Day 2`, ...). Do not invent calendar dates or review history before the owner actually starts/reviews the work.

Current generated rollout evidence is in `../validation/cs5-initial-repetition-rollout-v1.csv`.

## 4. Active-recall score
For a recall-bearing map item — normally `CORE` through `RECOGNITION`, including adjacent boundary bands when the owner chooses active recall — score actual recall **before opening the Unit**:

```text
0 — practically nothing reconstructed
1 — isolated fragments only
2 — core model recalled, substantial gaps remain
3 — coherent model recalled; gaps mostly details or one boundary
4 — model + important mechanics/failure modes/boundaries reconstructed without material hints
```

Score only against the authoritative Review Scope and the depth expected by the Retention Class. A base/source defect must not lower the memory score.

`MAP_ONLY` map-refresh does not require this 0–4 score. A `RECOGNITION ↔ MAP_ONLY` item may use lightweight map refresh or active recall depending on the current purpose; the boundary label itself does not force one mechanism.

## 5. Recall State
For items actually participating in active recall:

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

These are post-calibration gaps. They do **not** redefine the separate initial post-materialization timing in section 3. For an adjacent boundary band, use the neighboring rows as guidance and choose the next useful date manually rather than inventing a mandatory interpolated interval.

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

Its cadence is chosen manually and may later gain a useful low-frequency default if practice justifies one. Do not force the normal 0–4 ladder onto it.

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

## 12. Current physical Repetition Map
The current physical table is `_ai-conspects/_repetition/REPETITION_MAP.csv`. It intentionally stores only operational facts that are useful now:

```text
KnowledgeId
Title
RetentionBand
InitialDay
InitialOrder
SizeEquivalent
UnitPath
ReviewScopeRef
InitialReviewDate
LastReview
LastReviewType
LastRecallScore
NextReview
NextReviewType
NextScope
Notes
```

`InitialDay` / `InitialOrder` seed the one-time full-corpus first pass. Actual calendar/history fields start blank and are populated only by real reviews.

An explicit stored Recall State is **not required** by the current physical schema. `WEAK / RECOVERING / STRONG` may be used as interpretive labels when actual evidence makes them useful, but the table does not need a mandatory state-machine column. Likewise, `MAP_ONLY` shares the same table without requiring a normal recall score.

Future/new Units may temporarily have a blank Retention Band until the owner assesses it; do not invent `UNDECIDED`. `UnitPath` / `ReviewScopeRef` are non-authoritative representation pointers and must be updated after any physical file move while preserving `KnowledgeId`.
