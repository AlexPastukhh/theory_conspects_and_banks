# UC-LEARNING-REVIEW-AND-RECORD — Review and Strengthen Knowledge

## Situation
A Knowledge Unit needs a real recall check before reading its content.

Two modes are supported by the same Use Case:
- `FORMATIVE` — the unit is `ACTIVE` and the current model is still being formed;
- retention review — the unit is `STABLE` and is due for calibration, scheduled repetition, or a targeted follow-up.

## Result
Recall happens before reading, is checked against the current review scope, and the appropriate state is updated.

For `ACTIVE` knowledge:
- current understanding is reconstructed;
- contradictions, gaps, and questions are surfaced;
- the unit remains ACTIVE, is restructured, or becomes STABLE;
- normal spaced-repetition score/state is not fabricated while scope is still changing.

For `STABLE` knowledge:
- recall is assessed against the agreed review scope;
- memory gaps are separated from base/source gaps and new questions;
- repetition history/state and the next review are updated from actual performance.

## Process
1. Select the Knowledge Unit / review scope.
2. Read its `Learning State` before choosing review mode.
3. Hide the content before recall.
4. Choose a suitable recall mode when useful: `EXPLAIN`, `CONTRAST`, `DIAGNOSE`, `DECIDE`, `TRANSFER`, or `RECOGNIZE`.
5. Obtain actual recall before revealing the unit.
6. Compare the answer with the explicit review scope.
7. If `ACTIVE`:
   - treat the review as formative;
   - capture contradictions and missing questions;
   - update the unit/Questions through the proper owners;
   - transition to `STABLE` only when the stability criteria are met;
   - do not commit a normal spaced-repetition score unless the same review is explicitly eligible to serve as stable baseline calibration under the scheduling policy.
8. If `STABLE`:
   - classify at least `MEMORY_GAP`, `KNOWLEDGE_BASE_GAP`, and `NEW_QUESTION`;
   - score actual recall according to the repetition policy;
   - update Recall State, history, interval, and next review date.
9. Route base gaps and new questions into expansion planning.
10. Never penalize recall for material outside the agreed scope.

## Boundary
This Use Case is active recall over a defined knowledge scope.

It does not treat AI's extra knowledge as required learner knowledge, and it does not pretend an ACTIVE evolving scope has the same scoring semantics as stable retention review.
