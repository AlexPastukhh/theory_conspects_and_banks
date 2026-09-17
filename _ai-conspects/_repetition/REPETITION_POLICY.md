# Repetition Policy

Status: active knowledge-unit repetition and learning policy

Scope: learning state for units under `_ai-conspects/_knowledge/` and controlled creation of new knowledge material.

## 1. Purpose

The repetition layer must answer:

- what is due today;
- what has never received a baseline recall check;
- what was reconstructed before reading the unit;
- which interval follows from the observed recall;
- what is weak, recovering, or stable;
- which question or clarification appeared and was deliberately deferred;
- which raw learning batch must be materialized or reviewed;
- whether source quality, rather than learner memory, caused a problem.

The repetition layer does not replace knowledge units, source workspaces, transcripts, SVGs, provenance, or migration registries.

## 2. Review identity

The canonical review subject is a stable `Knowledge ID`, not a source-workspace name.

Why:

- one workspace can produce several knowledge units;
- one unit can merge evidence from several workspaces;
- recall scope should match one coherent 5–15 minute learning model;
- Knowledge IDs survive source-layout changes.

A review may target a named section inside a unit. The state still belongs to the unit, while `Next scope` records the narrower weak area.

## 3. Files and ownership

```text
_repetition/REPETITION_POLICY.md
  = canonical scheduling, review and learning-flow rules;

_repetition/REPETITION_STATE.csv
  = one current-state row per Knowledge ID;

_repetition/INITIAL_WAVE_QUEUE.csv
  = deterministic first-pass order; slots are study sessions, not fixed dates;

_repetition/REPETITION_INDEX.md
  = human-readable dashboard contract and daily selection rules;

_repetition/QUESTIONS_BACKLOG.md
  = canonical registry of deferred questions and clarifications;

_repetition/LEARNING_INBOX.md
  = registry of raw learning batches and their D0/D+2/D+8 lifecycle;

_repetition/STUDY_SESSION_AGENT_PROMPT.md
  = agent-facing contract for selecting a session and returning clickable file links;

_repetition/inbox/<date>-<slug>.md
  = source-preserving daily knowledge dump before semantic partition;

_repetition/history/<topic>/<unit>.md
  = append-only review history, created lazily on first actual review;

_knowledge/<topic>/<unit>.md
  = material that is recalled and checked;

_ai-conspects/<workspace>/...
  = source/provenance authority.
```

Do not pre-create 576 empty history files. The state and initial queue may be complete machine-readable inventories; detailed history remains lazy.

## 4. Independent state axes

### Source status

```text
OK
CHECK_BEFORE_REVIEW
REBUILD_REQUIRED
UNKNOWN
```

Source status describes trust in the unit and its provenance. It does not describe memory.

### Learning state

```text
NOT_REVIEWED
WEAK
RECOVERING
STABLE
```

Suggested derivation:

- `NOT_REVIEWED`: no baseline review;
- `WEAK`: latest recall 0–1;
- `RECOVERING`: latest recall 2–3, or a recent failure after stability;
- `STABLE`: at least two consecutive scores of 4 and the completed interval was at least 20 clear days.

### Review priority

```text
HIGH
NORMAL
LOW
UNASSESSED
```

Priority affects ordering, not the truth of the recall score. It may reflect prerequisite value, current work, production risk, or repeated failure. A high-priority item that is recalled well still receives a growing interval.

## 5. Recall score

Score before opening the unit:

```text
0 — practically nothing reconstructed;
1 — isolated fragments only;
2 — core model recalled, substantial gaps remain;
3 — coherent model recalled; gaps are mostly details or one boundary;
4 — model, important mechanics, failure modes and boundaries reconstructed without material hints.
```

Record both provisional and final scores. The final score may change after checking the source, but source defects must not reduce a memory score.

## 6. Review types

```text
CALIBRATION
  first active-recall pass used to establish the starting interval;

FULL
  reconstruct and verify the complete unit;

TARGETED
  review named weak sections, mechanics or questions;

QUESTIONS_ONLY
  answer already integrated questions without rereading the whole unit;

SOURCE_REPAIR
  resolve source/provenance quality; do not score it as learner recall.
```

## 7. Calendar semantics

Intervals count complete calendar days between reviews:

```text
review on day D
gap 1  -> next review on D + 2 (послезавтра)
gap 5  -> next review on D + 6
gap 10 -> next review on D + 11
```

Canonical interval ladder:

```text
1, 5, 10, 20, 30, 60, 90, 180 complete days
```

`Next review date = Review date + Gap + 1 calendar day`.

If the learner reviews late, record the actual elapsed gap. Do not lower the score merely because the item was overdue.

## 8. Initial-wave calibration

Every current Knowledge ID begins as `NOT_REVIEWED` with no invented interval.

The initial wave is a real active-recall pass:

1. select the next item from `INITIAL_WAVE_QUEUE.csv` after all due work;
2. recall before reading;
3. check the unit and classify gaps;
4. assign score 0–4;
5. establish the first interval;
6. write state and append history.

Starting interval after calibration:

| Recall | Learning state | Next gap | Next type |
|---:|---|---:|---|
| 0 | WEAK | 1 | FULL |
| 1 | WEAK | 1 | TARGETED or FULL |
| 2 | RECOVERING | 5 | TARGETED |
| 3 | RECOVERING | 10 | TARGETED or QUESTIONS_ONLY |
| 4, priority HIGH | RECOVERING | 20 | QUESTIONS_ONLY or TARGETED |
| 4, other priority | RECOVERING | 30 | QUESTIONS_ONLY or TARGETED |

This is the requested baseline discovery: the repository does not guess what the learner knows. Actual recall produces the initial interval.

## 9. Later interval updates

`Completed stage` means the ladder gap that led to the current review.

| Final recall | Next interval rule |
|---:|---|
| 0–1 | Reset to gap 1. |
| 2 | Move one ladder stage shorter; minimum gap 1. |
| 3 | Move one ladder stage longer. |
| 4 | Move one stage longer; two stages are allowed after two consecutive unhinted 4s. |

Additional rules:

- a material misconception or missed safety invariant prevents score 4;
- an integrated new question may create a targeted follow-up without resetting the whole unit;
- a source defect creates `SOURCE_REPAIR`, not a shorter memory interval;
- after a long break, do not infer failure before active recall;
- manual interval override is allowed, but `Override reason` is required.

## 10. Daily workload and balance

Default planning envelope: 90 minutes, six study days per week. It is a configurable default, not a learner constraint.

Daily order:

1. overdue and due repetitions;
2. D+2 materialization or D+8 new-material review due today;
3. current initial-wave slot;
4. optional new knowledge collection;
5. question-backlog triage only if capacity remains.

Default time split while the initial wave is active:

```text
50–60% due repetition
20–30% initial-wave calibration
15–25% new-learning pipeline
```

Capacity protection:

- a wave slot contains six units, but it is not bound to a calendar date;
- advance the slot only after its rows are completed;
- when due work fills the session, postpone new calibration rather than skipping due reviews;
- pause fresh collection when D+2 materialization is overdue;
- do not create interval debt merely to finish the initial wave faster.

Balance rules for non-due selections:

- include at least three macro areas when a full six-unit slot is completed;
- normally use no more than two units from one topic in the same session;
- alternate conceptual and mechanical units when possible;
- due dates override balance; balance never delays an already due item;
- one weekly session may be used for catch-up, state cleanup and backlog triage, or kept as rest.

## 11. Immediate prerequisite pass

The first three wave slots contain a small existing-unit prerequisite set. It does not claim the knowledge base already has complete beginner tracks. It gives enough context to diagnose ability to solve tasks while the missing P0 learning paths are being created.

The immediate set emphasizes:

- JavaScript event loop/promises/fetch;
- C# async, disposal, deferred execution and equality;
- HTTP/REST and request flow;
- ASP.NET middleware, routing, DI and validation;
- EF Core tracking, translation and SaveChanges;
- SQL logical processing, transactions and indexes;
- React render/effect behavior;
- TypeScript narrowing/contracts;
- essential browser/API security boundaries.

## 12. New-knowledge pipeline

New knowledge is intentionally not partitioned on collection day.

### D0 — COLLECTED

Create one raw dump under `_repetition/inbox/`:

```text
facts, links, quotes within copyright limits, examples, uncertainties
optional rough headings by direction
```

Requirements:

- preserve source links and access date;
- distinguish copied evidence, paraphrase and personal hypothesis;
- do not create/update knowledge units on D0 merely to make the dump look clean;
- register the batch in `LEARNING_INBOX.md`.

### D+2 — MATERIALIZE_DUE

After one complete intervening day, review the dump and:

1. remove exact repetition;
2. verify important claims;
3. split by durable semantic boundary;
4. create a new knowledge unit or add source-grounded content to an existing one;
5. update topic indexes and provenance;
6. record unresolved claims instead of guessing;
7. record affected Knowledge IDs in `LEARNING_INBOX.md`.

The due date is `Collection date + 2 calendar days`.

### D+8 — FIRST_REVIEW_DUE

After five complete days following actual materialization, actively recall the new units or only the sections added from that batch.

```text
Materialized on M
five clear days
first review on M + 6
```

Score that review normally and then enter the regular interval ladder. If materialization was late, calculate from the actual materialization date, not the planned date.

## 13. Questions and future clarifications

A question discovered during repetition does not automatically interrupt the session.

Record it in `QUESTIONS_BACKLOG.md` when it is substantial and classify it as:

```text
QUESTION
CLARIFICATION
SOURCE_GAP
NEW_UNIT_CANDIDATE
```

Statuses:

```text
OPEN
DEFERRED
RESOLVED
INTEGRATED
DISCARDED
```

Default during an ordinary review is `DEFERRED`: capture the question, connect it to one or more Knowledge IDs, and continue the scheduled review. Investigate immediately only when the answer is necessary to judge the current recall or safety/correctness of the unit.

Only `INTEGRATED` questions automatically enter future review scope.

## 14. Canonical review workflow

```text
1. Select overdue/due item; otherwise take the next initial-wave row.
2. Resolve Knowledge ID and unit path.
3. Resolve source status and perform source preflight if needed.
4. Run active recall before displaying the unit.
5. Record provisional score.
6. Check body, recall contract and relevant source evidence.
7. Classify each finding as MEMORY_GAP, SOURCE_GAP or NEW_QUESTION.
8. Defer non-blocking questions into the backlog.
9. Record final score and learning state.
10. Calculate the next gap/date from this policy.
11. Append unit history.
12. Update REPETITION_STATE.csv and the human-readable daily view.
```

The learner does not need to navigate the repository manually. For an actual
session, the agent-facing entry point is `STUDY_SESSION_AGENT_PROMPT.md`. A
session-opening response must expose only the selected titles, work types and
clickable local-file links; it must not reveal unit content before active
recall.

The same entry point remains active after the initial wave. Ordinary
due/overdue state, targeted follow-ups, integrated questions, source repairs
and learning-batch reviews all use the same link/launcher interface; only their
selection source and review scope differ.

The agent/session planner owns selection, scheduling, scope and state changes.
A local launcher, if used, owns only validation of the already selected IDs
and opening their resolved files in VS Code.

## 15. History and source preflight

Create `_repetition/history/<topic>/<unit>.md` only on first review. History is append-only. Corrections add a record; they do not erase earlier evidence.

Source preflight defaults:

```text
OK                  -> unit can normally be used directly;
CHECK_BEFORE_REVIEW -> inspect relevant provenance/source before judging details;
REBUILD_REQUIRED    -> repair source before treating content as authoritative;
UNKNOWN             -> resolve provenance when a disputed detail matters.
```

## 16. Boundaries

Do not:

- assign memory intervals before an actual calibration review;
- infer depth or recall from unit count, topic, file age or priority;
- reveal the unit before active recall unless source repair requires it;
- rewrite a source because the learner forgot something;
- lower recall because the source was incomplete;
- turn every curiosity into mandatory review material;
- silently incorporate an unchecked answer into knowledge units;
- let new collection crowd out due reviews or overdue materialization;
- create hundreds of empty history files;
- use the legacy PDF calendar as current Knowledge-ID state.
