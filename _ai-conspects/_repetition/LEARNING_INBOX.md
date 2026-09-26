# Learning Inbox

Status: **current operational batch registry** for D0 capture → D+2 triage/materialization.

Methodology owner: `../../documentation/workflows/default-daily-learning-inbox-workflow.md`.

## Batch lifecycle

```text
COLLECTED
→ TRIAGE_DUE
→ TRIAGED / CLOSED
```

There is no universal D+8 batch lifecycle stage. After durable knowledge is materialized, its future review belongs to `REPETITION_MAP.csv` and is chosen per Unit.

## Batch registry

| Batch ID | Direction | Dump | Collected | Triage due | Status | Triaged | Affected Knowledge IDs / sections | Questions | Notes |
|---|---|---|---|---|---|---|---|---|---|

## Rules

- D0 may be rough, but provenance and uncertainty must remain visible.
- D+2 verifies, partitions, places, merges, discards, or creates durable knowledge as appropriate.
- For each accepted/reshaped durable Review Scope, update canonical knowledge, assess Retention Band when useful, and ensure a row exists in `REPETITION_MAP.csv`.
- D+2 is a real learning/review contact but not a blind-recall score.
- Choose the Unit's next review date manually from the actual material/context; do not fabricate history or memory strength.
- Independently tracked Questions belong in `../_planning/QUESTIONS.csv`.
- A Question or coverage gap is not automatically a planned expansion item. Only `../_planning/EXPANSION_MAP.md` means expansion has actually been selected for work.

## Raw dump template

Path:

```text
_repetition/inbox/YYYY-MM-DD-<slug>.md
```

```markdown
# Learning dump — <direction> — <YYYY-MM-DD>

Batch ID: L-YYYYMMDD-NN
Collected: YYYY-MM-DD
Triage due: YYYY-MM-DD

## Sources

- <URL/file/reference + access date>

## Raw material

<facts, examples, rough grouping, uncertainty markers>

## Possible existing Knowledge IDs

- <topic.unit-id or unknown>
```
