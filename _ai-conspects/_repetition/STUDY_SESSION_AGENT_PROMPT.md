# Study Session Agent Contract

Status: active operational entry point

Purpose: let the learner start or continue a repetition session without
searching the repository or keeping unrelated editor tabs open.

This interface covers the complete repetition lifecycle. It is not an
initial-wave launcher. `INITIAL_WAVE_QUEUE.csv` supplies calibration work only
when higher-order scheduled work does not fill the session.

## Lifecycle coverage

The same session-opening mechanism must support:

```text
CALIBRATION
  first recall of a current Knowledge ID from the initial wave;

FULL
  whole-unit scheduled repetition;

TARGETED
  scheduled repetition of named headings, mechanics or weak areas;

QUESTIONS_ONLY
  recall of questions already integrated into a unit;

SOURCE_REPAIR
  inspection of the unit and its authoritative provenance;

MATERIALIZE_DUE
  processing a learning-inbox batch;

FIRST_REVIEW_DUE
  first recall of units or sections created from a learning batch.
```

For normal repetition, `REPETITION_STATE.csv` is the primary selector. For
new-learning deadlines, use `LEARNING_INBOX.md`. Use
`INITIAL_WAVE_QUEUE.csv` only after overdue, due and learning-pipeline work has
been selected.

## Learner commands

```text
начать повторение
  build today's ordered study packet;

следующий конспект
  return only the next unfinished item from the current packet;

продолжить повторение
  continue the current packet after the last completed item;

покажи служебные файлы
  return links to state, queue, questions and learning inbox.
```

These commands do not by themselves authorize changing recall scores or
marking work complete. State is changed only after the learner supplies the
actual result of a review.

## Agent preflight

For `начать повторение`, the agent must:

1. resolve the current repository root;
2. read `REPETITION_POLICY.md` and `DAILY_STUDY_PLAN.md`;
3. read `REPETITION_STATE.csv` and `INITIAL_WAVE_QUEUE.csv`;
4. inspect `LEARNING_INBOX.md` for materialization or first-review work due;
5. inspect `QUESTIONS_BACKLOG.md` only for explicitly due high-importance work;
6. select work in the canonical order: overdue, due today, learning-pipeline
   deadlines, current initial-wave work, optional new collection;
7. verify that every selected local path exists;
8. keep the packet within the available session budget and split oversized
   units into explicit section scopes when necessary.

Do not infer completion from an open file, editor tab or earlier chat. Use only
the recorded state and explicit learner results.

The planned local opener is specified in the separate local repository at
`C:\Users\alexa\study-tab-launcher\planning\documentation\scenarios\open-selected-study-files.md`.
When it exists, the agent completes all planning before invoking it and passes
an already selected, ordered list of Knowledge IDs plus the requested tab
policy. The launcher is transport only: it opens validated files and does not
select, schedule, interpret or update repetition work.

`ReviewType`, `Scope`, `ReasonDue` and estimates belong to the agent's session
plan and human-facing response. They are not launcher inputs or launcher
responsibilities. Because every review type ultimately resolves to local
files, the same minimal opener works during and after the initial wave.

## Required response format

Return a compact response in Russian. Use clickable absolute local-file links
that the Codex/IDE client can open directly.

```markdown
Сегодня: <date>. План: <estimated minutes>.

1. [<unit title>](<absolute-path-to-unit>:1) — <CALIBRATION/FULL/TARGETED/...>
   Scope: <whole unit or exact headings>
   Why now: <overdue / due today / current wave slot / batch review>

2. ...

Служебный файл, только если нужен в этой сессии:
- [Questions backlog](<absolute-path>:1)
```

Link labels must be human-readable titles, not raw paths. Do not wrap links in
backticks. Do not output `file://`, `vscode://` or relative links.

## Recall boundary

The opening response must not summarize, quote or explain the selected unit.
It may show only:

- title and Knowledge ID;
- review type and scope;
- why it is due;
- estimated time;
- clickable file link.

This preserves active recall. The learner first explains the topic from
memory, then opens the linked unit to check it.

## Tabs workflow

The agent returns the complete minimal link set for the current packet. The
learner can use the editor's **Close All Editors** action once and then click
the returned links in order. The agent must not ask the learner to locate
files manually and must not include unrelated knowledge, source or registry
files.

Normally include only knowledge-unit links. Add a tracker, history, source or
question-registry link only when the learner actually needs to edit or inspect
it during that session.

For `MATERIALIZE_DUE`, the primary link is the registered learning dump. For
`SOURCE_REPAIR`, include the knowledge unit plus only the exact authoritative
source/provenance files needed for that repair. These are the only cases where
the primary session file may not be just a knowledge unit.

## Continuation response

For `следующий конспект`, return one primary link only:

```markdown
Следующий:

[<unit title>](<absolute-path>:1) — <review type>, <scope>, ~<minutes>.
```

Do not repeat already completed links. If no work is due and the current wave
slot is complete, select the first unfinished row of the next slot.

## Session close

After the learner reports recall results, the agent should summarize proposed
state changes before writing them. The result must identify:

- Knowledge ID and reviewed scope;
- provisional and final recall scores;
- memory gaps versus source gaps;
- next gap and exact date;
- questions to defer;
- whether the current initial-wave row is complete.

Only then update the state, queue, history and question registry within the
authority granted by the learner's request.
