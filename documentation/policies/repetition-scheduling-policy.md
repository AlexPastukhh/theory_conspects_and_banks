# Repetition Scheduling Policy

Status: current target scheduling policy for v11-state records. Legacy `_repetition` records remain under the transitional legacy policy until CS5; do not silently convert them.

## 1. One common review queue/state

The system uses one logical review/repetition queue for both:
- ACTIVE formative reviews;
- STABLE retention reviews.

The review type determines scoring semantics.

ACTIVE formative due dates can be created by a learning workflow (default daily inbox: first formative review after five clear days). They do not use the interval ladder until the Unit becomes STABLE.

## 2. Eligibility — what enters normal spaced repetition?

Scheduling applies to the Unit's **authoritative scheduled Review Scope**, not automatically to every detail stored in the file.

If a Unit contains materially heterogeneous retention needs, resolve the Unit/Review Scope boundary before normal scheduling rather than averaging them into one class.

Normal spaced repetition is eligible only when:

```text
Learning State = STABLE
AND Retention Class ∈ {CORE, WORKING, RECOGNITION}
```

`MAP_ONLY` is not scheduled by default.
`ACTIVE` uses formative review, not normal repetition scheduling.

A targeted source repair is not a memory review.

## 3. Stable review score
Score actual recall **before opening the Unit**:

```text
0 — practically nothing reconstructed
1 — isolated fragments only
2 — core model recalled, substantial gaps remain
3 — coherent model recalled; gaps mostly details or one boundary
4 — model + important mechanics/failure modes/boundaries reconstructed without material hints
```

A base/source defect must not lower the memory score.

## 4. Recall State

```text
UNCALIBRATED — no valid STABLE baseline review yet
WEAK         — latest stable recall 0–1
RECOVERING   — latest stable recall 2–3, or recent failure after strength
STRONG       — at least two consecutive unhinted 4s and a completed interval >= 20 clear days
```

Recall State describes observed memory, not knowledge maturity.

## 5. Calendar semantics
Intervals count complete calendar days between reviews.

```text
review on D
Gap 1  → next review D + 2
Gap 5  → next review D + 6
Gap 10 → next review D + 11
```

Canonical ladder:

```text
1, 5, 10, 20, 30, 60, 90, 180 complete days
```

`Next review date = review date + Gap + 1 calendar day`.

Late review records actual elapsed gap. Overdue status alone is not memory failure.

## 6. Baseline calibration after STABLE
The first valid stable recall establishes the starting interval.

| Recall | Recall State | Next gap |
|---:|---|---:|
| 0 | WEAK | 1 |
| 1 | WEAK | 1 |
| 2 | RECOVERING | 5 |
| 3 | RECOVERING | 10 |
| 4 + CORE | RECOVERING | 20 |
| 4 + WORKING | RECOVERING | 30 |
| 4 + RECOGNITION | RECOVERING | 60 |

`MAP_ONLY` has no baseline repetition by default.

## 7. Later interval updates
Let `completed stage` be the ladder gap that led to the current review.

| Final recall | Next interval rule |
|---:|---|
| 0–1 | reset to Gap 1 |
| 2 | move one ladder stage shorter; minimum 1 |
| 3 | move one ladder stage longer |
| 4 | move one stage longer; two stages allowed after two consecutive unhinted 4s |

Additional rules:
- a material misconception or missed critical invariant prevents score 4;
- `KNOWLEDGE_BASE_GAP`/source defect does not shorten interval by itself;
- an integrated new Question may create a targeted follow-up without resetting the whole Unit;
- manual override is allowed only with an override reason.

Retention Class determines *whether* and *how strongly* the Unit participates; actual recall controls interval growth/shrinkage. No hard class-specific maximum gap is imposed initially; validate this empirically.

## 8. Review types

```text
FORMATIVE     ACTIVE learning; no authoritative normal score
CALIBRATION   first valid STABLE recall
FULL          reconstruct/verify full Review Scope
TARGETED      named weak scope/mechanism/question
QUESTIONS_ONLY answer already integrated questions without rereading full Unit
SOURCE_REPAIR resolve evidence/provenance; no memory score
```

## 9. Scope boundary

This policy schedules **review/repetition work only**.

It does not rank or coordinate repetition against:
- Capture/Triage work;
- Expansion Plan work;
- Question processing;
- other daily work.

Those concerns keep their own due/order semantics. A future higher-level daily dashboard may display them together, but no global daily-work scheduler is part of the current model.

## 10. State fields (logical minimum)
A Knowledge ID participating in the common review queue should be able to record the state of its authoritative scheduled Review Scope:
- Learning State (referenced, not owned here);
- Retention Class (possibly UNDECIDED while ACTIVE);
- Recall State (only meaningful for STABLE retention review);
- last review date/type;
- last stable recall score when applicable;
- completed gap when applicable;
- next review type/date/scope;
- next gap when normal spaced repetition applies;
- optional override reason.

Detailed append-only history may remain lazy per Unit rather than pre-created for every Knowledge ID.
