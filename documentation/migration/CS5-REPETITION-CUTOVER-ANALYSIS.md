# CS5 Repetition Cutover Analysis

Status: completed CS5 cutover analysis / migration provenance; not a permanent semantic owner. Current runtime is `_ai-conspects/_repetition/REPETITION_MAP.csv`.

## Purpose
Derive the target repetition representation/runtime from the current Personal Knowledge System owners before mutating legacy data.

CS5 must preserve two facts simultaneously:
- no universal `ACTIVE | STABLE` Knowledge Unit lifecycle;
- the current personal retention strategy wants essentially the durable corpus visible in a Repetition Map at different memory strengths.

This is not the earlier opt-in/sparse model.

## Current semantic picture

```text
Durable Knowledge Base
Domain → Area → nested Area → Concept → Knowledge Unit → Review Scope

Independent operational concerns
Coverage & Expansion
Learning workflow
Repetition Map
```

Repetition does not own Knowledge ontology, but current personal policy normally uses one of these qualitative retention flags for durable Review Scopes:

```text
CORE
WORKING
RECOGNITION
MAP_ONLY
```

## Verified legacy facts
The current legacy layer still has:
- 576 Knowledge IDs in `REPETITION_STATE.csv`;
- 576 initial-wave rows;
- legacy `LearningState = NOT_REVIEWED` across the corpus;
- no trustworthy completed review dates/scores/interval history for those rows.

Therefore legacy cardinality is not proof of valid target state, and legacy fields must not be reinterpreted as if the target policy had already been executed.

## Deterministic non-mappings

| Legacy evidence | Target consequence |
|---|---|
| Knowledge ID | preserve identity/reference |
| explicit Review Scope | preserve as authoritative review subject |
| no actual review date/score/history | do not invent review evidence |
| `NOT_REVIEWED` | proves no valid blind-recall baseline; not a Retention Class |
| `ReviewPriority` | input/evidence only; not a deterministic Retention Class mapping |
| `NextType=CALIBRATION` default | not proof that a real calibration occurred |
| initial-wave slot | legacy scheduling artifact; not a target retention decision |

## Daily learning handoff
The accepted target flow is:

```text
D0 capture
→ D+2 triage/materialization
   → canonical placement / Review Scope
   → Retention Class assessment/update when useful
   → Repetition Map entry/update
   → first learning/review contact (no blind-recall score)
→ next review chosen from retention guidance + current judgment
```

For important `CORE`, five complete days after materialization (then review on the next day) is a useful default. If materialized on D+2, that is D+8. It is guidance, not a mandatory transition.

This corrects the over-sparse intermediate design: D+8 is not a universal extra formative stage detached from repetition. Additional formative work may still be scheduled locally when actually needed.

## Runtime scenarios that drive target design

### Scenario A — new durable knowledge at D+2
The Unit is materialized, Review Scope fixed, and retention treatment assessed.

Required facts:
- Knowledge ID / Review Scope;
- Repetition Map next action/date;
- Retention Class when useful/assigned.

Do not create a recall score from materialization itself.

### Scenario B — `CORE` initial follow-up

```text
D+2 placement/review contact
→ 5 clear days
→ D+8 active recall (when materialized on D+2)
```

This is normally the first blind-recall calibration and can establish Recall State/next interval.

### Scenario C — lower-retention initial follow-up
`WORKING`, `RECOGNITION`, and `MAP_ONLY` will often start later than CORE. CS5 does not need exact universal starting gaps for these classes; dates may be chosen manually, with defaults added/refined later if useful.

### Scenario D — first blind recall
For `CORE | WORKING | RECOGNITION`:

```text
UNCALIBRATED
→ recall before reading
→ score 0–4
→ WEAK / RECOVERING (or later STRONG)
→ next interval
```

No pre-review score/history may be invented.

### Scenario E — normal later reviews
Use the existing clear-day ladder as a default heuristic and adjust dates by workload, current context, and actual recall. Do not turn the ladder into a mandatory state machine.

### Scenario F — `MAP_ONLY`
`MAP_ONLY` remains in the Repetition Map as a low-intensity semantic/navigation/comparison anchor.

Typical map refresh checks existence, location, purpose, and useful analogies/links. It does not require the normal 0–4 Recall State ladder.

This supports cross-technology learning such as retaining a familiar C# manifestation as a comparison anchor while learning the corresponding Python manifestation.

### Scenario G — class change
Priority context can change. A Scope may move between `CORE / WORKING / RECOGNITION / MAP_ONLY` without changing its semantic identity. Changing the flag does not require a formal transition protocol: preserve real history and choose the next useful date from the new context.

### Scenario H — Repetition and Expansion coexist
The same Scope may be due in the Repetition Map while related responsibilities/questions remain `PARTIAL/MISSING` in Coverage & Expansion. These operational maps remain independent.

## Existing-corpus Retention Class assignment
The target personal policy favors broad map coverage. A current working classification has now been produced for all **576 / 576** Review Scopes using the current Priority Model, Review Scope content/boundaries, and the current planning context rather than legacy `ReviewPriority`.

Current distribution:

- `CORE`: 20
- `CORE ↔ WORKING`: 1
- `WORKING`: 273
- `WORKING ↔ RECOGNITION`: 16
- `RECOGNITION`: 258
- `RECOGNITION ↔ MAP_ONLY`: 0
- `MAP_ONLY`: 8

The four anchor classes remain `CORE | WORKING | RECOGNITION | MAP_ONLY`. Adjacent boundary bands are allowed when forcing one anchor would create false precision. They are advisory descriptions and may remain indefinitely; there is no separate `MIXED` Retention Class.

Machine-readable evidence: `../validation/retention-priority-classification-v4.csv`.

The classification is a working recommendation, not an immutable semantic property. Manual reassignment remains normal when context, actual repetition, or Review Scope boundaries change. A target schema should still permit a temporarily absent Retention Class for future/new items when a justified assessment has not yet been made; however, missing classification is no longer a blocker for the current 576-row rollout.

## Physical representation chosen at cutover
The current runtime uses `_ai-conspects/_repetition/REPETITION_MAP.csv` with a deliberately minimal schema. The semantic requirements that drove it are:

Common map identity:
- Knowledge ID;
- authoritative Review Scope reference;
- next action type/date;
- Retention Class when assigned (advisory).

For `CORE | WORKING | RECOGNITION`:
- Recall State (`UNCALIBRATED` until first valid blind recall);
- last actual review date/type/score when present;
- completed/next gap when present;
- append-only actual history.

For `MAP_ONLY`:
- map-refresh date/type;
- optional last map-refresh evidence;
- no normal Recall State requirement.

## Legacy migration consequence
The legacy system already happens to contain 576 rows, and the target policy also aims for broad corpus coverage. **Those facts must not be confused.** Target rows/classes must be created from current semantics, not copied because legacy rows exist.

Safe migration principles:
1. preserve IDs and Review Scopes;
2. use the current 576-row classification as the working retention input, while allowing manual correction and nullable class for future/unassessed items; never translate legacy `ReviewPriority` mechanically;
3. create `UNCALIBRATED` only when a recall-bearing item is actually initialized for active recall and no valid baseline exists;
4. initialize `MAP_ONLY` without fake Recall State;
5. seed first-review/map-refresh work from the current priority-first relative rollout, then attach actual future dates only from a real cutover/start date and observed workload;
6. carry no synthetic initial-wave slot/history forward as evidence.

### Current relative rollout calibration

The current rollout uses a starting workload of **at least 30 standard-unit-equivalents/day**, calibrated around `javascript.timers-tasks-microtasks-and-abortable-delay` as approximately one standard Unit.

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

A day is not deliberately balanced across classes. It consumes the strongest remaining band first and enters the next band only after the stronger one is exhausted. Unit size affects workload packing, not semantic priority.

The generated v1 relative rollout spans 25 buckets. Day 1 is 20 `CORE` + 1 `CORE ↔ WORKING` + 8 `WORKING` = 30.00 estimated equivalents.

Evidence: `../validation/cs5-initial-repetition-rollout-v1.csv` and `../validation/cs5-retention-classification-and-rollout-v1.md`.

## Cutover decisions resolved

CS5 physical/runtime choices are now fixed for the current working system:

1. **Physical map:** `_ai-conspects/_repetition/REPETITION_MAP.csv`, one row per current Knowledge ID.
2. **First-pass scheduling:** retain the 25 relative priority-first `InitialDay` buckets; do not fabricate calendar dates before actual work.
3. **Daily capacity:** start at at least 30 standard-unit-equivalents/day and adjust empirically later.
4. **Future/new classification:** Retention Band may be blank temporarily; no `UNDECIDED` class.
5. **MAP_ONLY:** shares the same table; normal recall score/state is optional/not required.
6. **Recall State storage:** not mandatory in the physical CSV. Interpretive labels may be used when actual evidence makes them useful, without creating a required state-machine column.
7. **Legacy retirement:** pre-CS5 state/wave/dashboard/policy/agent artifacts are isolated under `_ai-conspects/_repetition/legacy/` and are non-authoritative.
8. **Actual recurrence:** after each real Unit review, the owner decides depth and the next date manually using Retention Band, actual recall, context, and scheduling heuristics as guidance. No second/third review schedule is precomputed for the initial corpus.

## Current physical columns

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

All actual-review/date/history fields begin empty. `UnitPath` / `ReviewScopeRef` are convenience pointers and must be updated during later physical Knowledge Unit moves without changing semantic identity or review evidence.

## Exit result

**CS5 repetition cutover is complete.**

The current runtime can safely represent and operate:
- all 576 Review Scopes;
- advisory retention bands including adjacent boundaries;
- priority-first first-pass workload;
- manual per-Unit review depth and next-date choice;
- optional real recall evidence only after actual review;
- lightweight `MAP_ONLY` treatment;
- no universal Knowledge Unit maturity state;
- explicit legacy retirement boundary.

The remaining migration task is separate physical Knowledge Unit representation/movement, followed by path/link consistency checks.
