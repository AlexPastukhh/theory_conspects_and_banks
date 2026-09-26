# CS5 Retention Classification / Rollout Audit v6

Status: current validation evidence extending the advisory-retention audit v5. Not a semantic owner.

## Checks

- 576 classification rows.
- 576 unique Knowledge IDs.
- Every classification Knowledge ID resolves to an existing current Knowledge Unit file.
- All 576 rows have a current advisory Retention Band.
- Classification provenance is explicit: 22 corpus-validation anchors and 554 AI first-pass/recheck rows.
- Of the 22 anchors, 20 retain the original anchor class directly and 2 historical `MIXED` anchors are normalized to adjacent boundary bands.
- Anchor distribution:
  - CORE: 20
  - CORE ↔ WORKING: 1
  - WORKING: 273
  - WORKING ↔ RECOGNITION: 16
  - RECOGNITION: 258
  - RECOGNITION ↔ MAP_ONLY: 0
  - MAP_ONLY: 8
- No separate `MIXED` Retention Class is used in current classification.
- Boundary bands are descriptive/advisory, not lifecycle transitions.
- Initial rollout is priority-first, not quota-balanced across classes.
- Starting rollout capacity is at least 30 standard-unit-equivalents/day.
- Size weighting affects workload batching only; it does not outrank Retention Band.
- No calendar dates, Recall State, scores, intervals, or history were invented.
- Legacy `_ai-conspects/_repetition/` files remain unchanged.

## Evidence

See:

- `retention-priority-classification-v4.csv`
- `cs5-initial-repetition-rollout-v1.csv`
- `cs5-retention-classification-and-rollout-v1.md`
