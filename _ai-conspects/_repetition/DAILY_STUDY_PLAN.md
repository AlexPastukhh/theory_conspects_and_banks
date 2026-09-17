# Daily Study Plan

Status: active rolling plan

This plan starts on the learner's first actual study date. `Day N` means a calendar day from that start, while an initial-wave slot advances only when its six calibration rows are complete.

To obtain the actual files for a session, tell the repository-aware agent
`начать повторение`. The response contract and clickable-link format are in
`STUDY_SESSION_AGENT_PROMPT.md`.

## Default session

Target envelope: 90 minutes.

```text
1. 45–55 min — overdue/due unit reviews
2. 20–30 min — initial-wave calibration
3. 15–25 min — materialize or collect new knowledge
4. final 5 min — state, questions and next dates
```

If due work requires the full session, omit initial-wave and new collection. Never hide overload by marking unfinished work complete.

## First three prerequisite slots

### Slot 1

1. `javascript.timers-tasks-microtasks-and-abortable-delay`
2. `aspnet-core.middleware-ordering-short-circuit-and-json`
3. `sql-server.logical-query-processing-order`
4. `react.render-snapshots-batching-and-memoization`
5. `dotnet.async-concurrency-and-task-start`
6. `ef-core.tracking-queries-identity-resolution-and-projections`

### Slot 2

1. `http.rest-constraints-resource-and-method-semantics`
2. `aspnet-core.endpoint-matching-phases-and-route-precedence`
3. `dotnet.disposable-ownership-and-deterministic-cleanup`
4. `javascript.fetch-response-contract-and-wrapper-policy`
5. `sql-server.transactions-trancount-and-boundaries`
6. `security.cors-and-antiforgery-boundaries`

### Slot 3

1. `aspnet-core.di-scope-lifetime-and-disposal`
2. `ef-core.linq-relational-translation-shapes`
3. `react.strict-mode-effect-cleanup`
4. `dotnet.deferred-enumeration-replay-and-materialization`
5. `typescript.control-flow-type-narrowing`
6. `sql-server.index-design-and-query-cost`

The remaining 93 balanced slots are in `INITIAL_WAVE_QUEUE.csv`.

## First fourteen calendar days

This is a dependency pattern, not a promise that every slot finishes in one day.

| Day | Due repetition | Initial wave | New-knowledge lane |
|---:|---|---|---|
| 1 | none | begin/finish Slot 1 | optional D0 collection batch A |
| 2 | none | begin/finish Slot 2 | no required processing for batch A |
| 3 | score 0–1 items from Day 1 | Slot 3 with remaining capacity | materialize batch A (D+2) |
| 4 | score 0–1 items from Day 2 | next unfinished slot | optional D0 collection batch B |
| 5 | score 0–1 items from Day 3 | next unfinished slot | no required processing for batch B |
| 6 | score 0–1 items from Day 4 | next unfinished slot | materialize batch B (D+2) |
| 7 | score 2 items from Day 1; other due items | only if capacity remains | catch-up, backlog triage or rest |
| 8 | score 2 items from Day 2; recent weak items | next unfinished slot | optional D0 collection batch C |
| 9 | first review of batch A materialized on Day 3; score 2 items from Day 3 | next unfinished slot if capacity remains | no new collection by default |
| 10 | score 2 items from Day 4; recent weak items | next unfinished slot | materialize batch C (D+2) |
| 11 | score 2 items from Day 5; recent weak items | next unfinished slot | optional D0 collection batch D |
| 12 | first review of batch B materialized on Day 6; score 2 items from Day 6; score 3 items from Day 1 | next unfinished slot if capacity remains | no new collection by default |
| 13 | score 3 items from Day 2; other calculated due items | next unfinished slot | materialize batch D (D+2) |
| 14 | score 3 items from Day 3; other calculated due items | only if capacity remains | catch-up, backlog triage or rest |

Only rows whose score produced that interval are due. For example, a Day 1 score 4 is not repeated on Day 3 or Day 7; its first next review is Day 22 for HIGH priority or Day 32 otherwise.

## Continuing weekly rhythm

Default maximum while the initial wave is active:

- six study sessions per seven calendar days;
- up to six new calibration units per session, reduced by due workload;
- no more than two new D0 collection batches per week;
- every D+2 materialization has priority over starting another batch;
- one catch-up/rest opportunity per week;
- at least three macro areas in a completed six-unit wave slot.

At six calibrated units per completed slot, the baseline contains 96 slots. It therefore needs at least 96 study sessions before added repetitions. The real duration will be longer and is intentionally controlled by recall evidence rather than a false fixed deadline.

## Parallel new-knowledge direction

During the initial wave, collect at most two new batches per week. Start with the P0 backlog from `../_knowledge/AREAS-PRIORITY-MAP.md` in this order:

1. C# fundamentals learning path.
2. JavaScript fundamentals learning path.
3. SQL fundamentals.
4. ASP.NET Core request-pipeline overview.
5. EF Core mental model.
6. HTTP + HTTPS/TLS beginner model.
7. Semantic HTML and accessibility fundamentals.
8. CSS Grid and responsive layout.
9. Testing fundamentals.

Do not open a third unmaterialized batch. A new direction starts only after the previous batch reached `MATERIALIZED`; its D+8 review may remain scheduled in parallel.

After P0, take P1 groups in map order unless current work or a repeatedly failed review provides a documented reason to reorder them.

## End-of-session checklist

```text
[ ] active recall happened before reading
[ ] every reviewed unit has provisional and final score
[ ] memory gaps and source gaps are separated
[ ] next gap/date follows the policy or has an override reason
[ ] state CSV is updated
[ ] history entry is appended
[ ] non-blocking questions are deferred and linked to Knowledge IDs
[ ] learning-batch lifecycle is updated
[ ] current wave slot is advanced only if complete
```
