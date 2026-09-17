# Repetition Index

Status: active human-readable dashboard

Canonical per-unit current state: `REPETITION_STATE.csv`

Canonical baseline order: `INITIAL_WAVE_QUEUE.csv`

Scheduling rules: `REPETITION_POLICY.md`

Agent session command contract: `STUDY_SESSION_AGENT_PROMPT.md`

## Current summary

Snapshot: 2026-09-03

| Metric | Value |
|---|---:|
| Knowledge IDs | 576 |
| NOT_REVIEWED | 576 |
| WEAK | 0 |
| RECOVERING | 0 |
| STABLE | 0 |
| Due/overdue | 0 |
| Initial-wave slot | 1 of 96 |
| Initial-wave rows completed | 0 of 576 |

These are bootstrap values. Update the summary from `REPETITION_STATE.csv`; do not infer progress from history-file count.

## Today's queue

Populate only for an actual study date.

The normal learner entry point is a short chat command:

```text
начать повторение
```

The agent then selects the current work and answers with clickable links to
the exact unit files. The learner may close existing editor tabs first and
open only those links; manual repository navigation is not part of the study
workflow.

This entry point applies to all later repetitions, not only to the initial
wave. `REPETITION_STATE.csv` supplies ordinary due/overdue work;
`LEARNING_INBOX.md` supplies new-material deadlines; the wave queue is only the
fallback source of never-reviewed calibration items.

Selection is performed by the agent/session planner. A local launcher does not
interpret this index or make scheduling decisions; it only opens the ordered
Knowledge IDs selected by the planner.

| Order | Knowledge ID / batch | Work type | Why due | Scope | Estimate | Status |
|---:|---|---|---|---|---:|---|

Selection order:

1. overdue repetition;
2. repetition due today;
3. learning batch due for materialization or first review;
4. unfinished rows of the current initial-wave slot;
5. optional new collection;
6. deferred-question triage if capacity remains.

## Initial-wave operation

- A wave slot is a six-unit balanced work packet, not a calendar date.
- Do not advance to the next slot until all six rows are calibrated.
- Due work may spread one slot across multiple days.
- `InitialPriority=HIGH` marks the immediate prerequisite/context pack; it does not claim that the unit itself is elementary.
- Every other row remains `UNASSESSED` until its first recall.

## Update contract

After every completed review, update the matching `KnowledgeId` row in `REPETITION_STATE.csv`:

```text
SourceStatus
ReviewPriority
LearningState
LastReview
ProvisionalRecall
FinalRecall
CompletedGapDays
IntervalStage
NextReview
NextType
NextScope
ConsecutiveFours
OpenQuestionCount
HistoryPath
OverrideReason
```

Then append the review to `_repetition/history/<topic>/<unit>.md` and refresh this dashboard summary.

## Consistency invariants

- exactly one state row and one initial-wave row per current Knowledge ID;
- no state row for a nonexistent Knowledge ID;
- `NextReview` is present for `WEAK` and `RECOVERING` unless review is explicitly paused;
- `STABLE` still has a next review date unless intentionally retired;
- manual interval changes require `OverrideReason`;
- open-question count agrees with `QUESTIONS_BACKLOG.md`;
- source status is independent from learning state.
