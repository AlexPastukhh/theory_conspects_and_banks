# CS5 Retention Classification and Initial Repetition Rollout v1

Status: current supporting validation / rollout evidence. It is **not** a semantic owner and does not mutate legacy `_ai-conspects/_repetition/` state.

## Scope

This artifact records the current full-corpus first-pass retention recommendation for all **576 / 576** durable Review Scopes and a relative initial rollout order for first repetition placement.

Semantic owners remain:

- `../principles/priority-model.md`
- `../principles/retention-repetition.md`
- `../policies/repetition-scheduling-policy.md`

Machine-readable files:

- [`retention-priority-classification-v4.csv`](retention-priority-classification-v4.csv)
- [`cs5-initial-repetition-rollout-v1.csv`](cs5-initial-repetition-rollout-v1.csv)

## Planning context

The classification uses the current working engineering context:

- broad software-engineering understanding;
- strong existing .NET anchor;
- expansion into Node.js / Python / frontend / data;
- AI/docs available for cheap lookup and verification;
- mental models, boundaries, invariants, failure modes, and expensive verification deserve stronger ready-memory pressure than mechanical API detail.

The four Priority inputs remain qualitative:

- Leverage;
- Consequence;
- Usefulness in the current planning horizon;
- External Recoverability, including verification cost.

No universal numeric priority score is introduced.

## Classification provenance

The full-corpus CSV preserves the distinction between earlier validated anchors and the later corpus-wide recommendation pass:

- **22** Units come from `priority-model-real-corpus-validation-v1.md`;
- **20** of those retain the anchor recommendation directly and use `Basis = CORPUS_VALIDATION_V1_ANCHOR`;
- the two historical `MIXED` anchors are normalized to adjacent boundary bands and use `Basis = CORPUS_VALIDATION_V1_ANCHOR + boundary normalization v4`;
- the remaining **554** rows use `Basis = AI_FIRST_PASS_V2_RECHECK + boundary normalization v4`.

`Basis` is provenance only. It does not make one row more semantically authoritative than another, and all current retention assignments remain advisory.

## Retention vocabulary used by the corpus

The four anchor classes remain:

`CORE → WORKING → RECOGNITION → MAP_ONLY`

When forcing one anchor would create false precision, an adjacent boundary band is allowed:

`CORE ↔ WORKING`

`WORKING ↔ RECOGNITION`

`RECOGNITION ↔ MAP_ONLY`

A boundary band is an advisory description, not a lifecycle state. It may remain indefinitely. There is no separate `MIXED` Retention Class.

## Current 576-row distribution

| Retention band | Units |
|---|---:|
| `CORE` | 20 |
| `CORE ↔ WORKING` | 1 |
| `WORKING` | 273 |
| `WORKING ↔ RECOGNITION` | 16 |
| `RECOGNITION` | 258 |
| `RECOGNITION ↔ MAP_ONLY` | 0 |
| `MAP_ONLY` | 8 |
| **TOTAL** | **576** |

`RECOGNITION ↔ MAP_ONLY` is allowed by methodology but has no current assignment.

## Initial rollout workload calibration

The owner selected a starting workload of **at least 30 standard-unit-equivalents per rollout day**.

Calibration reference:

`javascript.timers-tasks-microtasks-and-abortable-delay`

- 53 total lines;
- 38 non-empty lines;
- 99 Review-Scope words under the local counting method;
- treated as approximately `1.0` standard review unit.

The rollout CSV uses a reproducible **workload-only heuristic**:

```text
raw size =
max(
  ReviewScopeWords / 99,
  sqrt(NonemptyLines / 38)
)

SizeEquivalent =
raw size rounded to the nearest 0.25,
with a minimum of 0.5
```

Why the full Unit-length factor is square-rooted: repetition is against the authoritative Review Scope, not a mandatory full-file reread. Very large source Units should count as heavier, but not linearly as dozens of ordinary reviews merely because they contain extensive supporting detail.

This formula is not semantic authority and may be recalibrated from observed review time.

## Priority-first batching rule

Initial rollout is filled **strictly from stronger retention toward lighter retention**:

```text
CORE
→ CORE ↔ WORKING
→ WORKING
→ WORKING ↔ RECOGNITION
→ RECOGNITION
→ RECOGNITION ↔ MAP_ONLY
→ MAP_ONLY
```

Do not create balanced daily quotas such as “10 CORE + 10 WORKING + 10 RECOGNITION”.

Instead:

1. consume all currently earlier/higher-priority rows first;
2. only when they are exhausted, continue into the next band;
3. keep adding whole Units until the day reaches at least 30 equivalents;
4. do not split a Unit only to hit exactly 30;
5. the starting `30` is a minimum calibration target, not a permanent ceiling.

Within one band, the v1 rollout uses a stable qualitative ordering heuristic — Leverage, then Consequence, then Usefulness, then lower External Recoverability — only to make the generated order reproducible. It is not a new semantic score and may be manually rearranged.

## Generated rollout shape

Total estimated workload: **763.25 standard equivalents**.

Relative rollout buckets: **25 days** at the current starting capacity rule.

Day 1 demonstrates the intended priority-fill behavior:

- 20 `CORE`;
- 1 `CORE ↔ WORKING`;
- 8 `WORKING`;
- total estimated load: **30.00 equivalents**.

No calendar date is assigned by this artifact. No recall score, Recall State, completed interval, or review history is fabricated.

## Interpretation

This is a working first distribution, not a claim that every recommendation is permanently final. Retention flags and boundary bands remain advisory and can be changed manually as real repetition experience, work context, or Unit boundaries change.
