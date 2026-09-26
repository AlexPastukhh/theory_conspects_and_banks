# CS5 Repetition Cutover Analysis

Status: current pre-cutover migration analysis; not a permanent semantic owner.

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
The target personal policy favors broad map coverage, so the existing 576 Review Scopes can be classified gradually over time. Class assignment is useful orientation, not a prerequisite that must be completed before the Repetition Map can function.

Do not populate classes blindly:
- use the current Priority Model (Leverage, Consequence, Usefulness, External Recoverability);
- use Review Scope content/boundaries;
- use current planning context;
- do not mechanically translate legacy `HIGH/NORMAL/LOW/UNASSESSED`.

A missing class during migration is acceptable and does not require a permanent `UNDECIDED` value. The item can still have a Review Scope and manually chosen next date while classification catches up.

## Candidate logical target representation
Not final physical schema, but runtime behavior implies at least:

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
2. assign Retention Class where current evidence/judgment makes that useful; leave it unset temporarily rather than inventing a class;
3. create `UNCALIBRATED` only when a recall-bearing item is actually initialized for active recall and no valid baseline exists;
4. initialize `MAP_ONLY` without fake Recall State;
5. choose future first-review/map-refresh dates explicitly during rollout, using defaults and manual workload balancing rather than invented historical dates;
6. carry no synthetic initial-wave slot/history forward as evidence.

## What remains genuinely unresolved before data/schema cutover
1. Exact minimal physical schema for the Repetition Map and actual review history.
2. Practical rollout of the existing 576 Review Scopes: how to seed useful future dates without an impossible workload spike.
3. How nullable/advisory Retention Class is represented during staged classification without inventing `UNDECIDED`.
4. Whether `MAP_ONLY` shares the same physical state table/event history or uses a lightweight variant.
5. Replacement of legacy initial-wave scheduling/dashboard behavior and the retirement boundary for legacy repetition artifacts.

Exact class-specific intervals, a deterministic class-assignment formula, and formal class-transition protocols are **not** CS5 prerequisites. Current owners intentionally allow human judgment and manual scheduling.

## Exit condition
CS5 design is ready for physical migration when the target can safely represent and operate:
- the Review Scope / thing to revisit;
- the next date/action shown in the Repetition Map;
- optional qualitative Retention Class guidance;
- Recall State and score/history only from real recall evidence;
- lightweight `MAP_ONLY` refresh when used;
- manual/default scheduling without requiring a rigid transition algorithm;
- a safe staged rollout of existing corpus items;
- clear retirement of legacy scheduler/state authority.

Until then, legacy repetition data remains unchanged.
