# Review Scope & Boundary Resolution — CS5 Preparation

Status: applied to the working snapshot.

## Purpose

Close the Review Scope and semantic-boundary blocker before repetition-state migration.

## Applied changes

- 170 Knowledge Units received an explicit inline `## What should be recallable` section.
- 161 scopes were derived from the Unit's existing explanatory prose.
- 6 scopes were manually normalized because the Unit needed a more deliberate review boundary.
- 3 previous unit-boundary blockers received manually bounded scopes.
- 30 semantic `BOUNDARY_REVIEW` rows were resolved to one primary home.
- 4 `UNIT_BOUNDARY_REVIEW` rows were resolved without splitting their stable Knowledge IDs.
- all 5 previously `AMBIGUOUS` owner-kind rows now have a resolved owner kind.
- one misleading title was corrected: `XOR semantics, cancellation, and equality alternatives` → `XOR semantics and collection equality alternatives`.

No new technical knowledge was introduced by this pass. Scope additions select existing content for recall.

## Result

```text
Knowledge IDs                         576
primary semantic homes                576
placement CLEAR                       576
ambiguous ownership                     0

explicit Review Scope                 576
missing Review Scope                    0

Knowledge IDs changed                   0
physical Knowledge paths changed        0
```

## Repetition boundary

`REPETITION_STATE.csv` and `INITIAL_WAVE_QUEUE.csv` remain untouched.

Therefore this pass does not perform the repetition cutover and does not infer:

```text
NOT_REVIEWED → ACTIVE
```

CS5 must derive target Learning State from Unit maturity/Review Scope coherence and set Recall State independently.

## Evidence

- [`software-engineering-full-semantic-map-v2.csv`](software-engineering-full-semantic-map-v2.csv)
- [`software-engineering-full-semantic-map-v2.md`](software-engineering-full-semantic-map-v2.md)
- [`review-scope-and-boundary-resolution-v2.csv`](review-scope-and-boundary-resolution-v2.csv)

The v1 map/worklist remain historical evidence of the pre-resolution state.

## Next step

Proceed to **CS5 — repetition cutover**.

CS5 must:

1. introduce the target state representation for Learning State / Retention Class / Recall State;
2. preserve all 576 Knowledge IDs;
3. treat coherent existing Units as candidates for `STABLE + UNCALIBRATED`, not mechanically `ACTIVE`;
4. keep genuinely changing/repaired Units `ACTIVE`;
5. assign Retention Class independently from the legacy `ReviewPriority`;
6. remove initial-wave scheduling as architecture only after the new state/query can represent uncalibrated Units.
