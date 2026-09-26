> **Migration status:** transitional legacy operational artifact for the pre-CS5 repetition/storage model. Target semantics are owned under `documentation/principles/` and `documentation/policies/`; do not silently reinterpret legacy state as v11 state. See `documentation/migration/CURRENT-MIGRATION-STATE.md`.

# Learning Inbox

Status: transitional active legacy batch registry; target Capture/Triage semantics are owned under `documentation/`

This registry implements the collection-to-knowledge cycle defined in `REPETITION_POLICY.md`.

## Lifecycle

```text
D0 COLLECTED
  -> one unpartitioned or roughly grouped daily dump

D+2 MATERIALIZE_DUE
  -> after one complete day, verify and split into new units or additions

MATERIALIZED
  -> record exact affected Knowledge IDs and actual materialization date

D+8 FIRST_REVIEW_DUE
  -> after five complete days following materialization, recall the new material

CLOSED
  -> first review recorded; units continue on the normal interval ladder
```

If a due step is completed late, later dates are calculated from the actual completion date.

## Batch registry

| Batch ID | Direction | Dump | Collected | Status | Materialize due | Materialized | Affected Knowledge IDs / sections | First review due | Questions | Notes |
|---|---|---|---|---|---|---|---|---|---|---|

## Batch rules

- Prefer one batch per study day; use several only for genuinely unrelated source sets.
- D0 may be messy, but provenance and uncertainty markers must remain visible.
- Do not silently convert hypotheses into knowledge claims.
- D+2 decides `new unit`, `merge into existing unit`, `defer`, or `discard` claim by claim.
- Affected units retain their stable Knowledge IDs.
- The D+8 review may target only newly added sections, but its history entry belongs to each affected Knowledge ID.
- Open questions are stored canonically in `QUESTIONS_BACKLOG.md`.

## Raw dump template

Path:

```text
_repetition/inbox/YYYY-MM-DD-<slug>.md
```

Contents:

```markdown
# Learning dump — <direction> — <YYYY-MM-DD>

Batch ID: L-YYYYMMDD-NN
Collected: YYYY-MM-DD
Materialize due: YYYY-MM-DD

## Sources

- <URL/file/reference + access date>

## Raw material

<facts, examples, excerpts within copyright limits, rough grouping allowed>

## Uncertainties

- <claim requiring verification>

## Possible existing Knowledge IDs

- <topic.unit-id or unknown>
```
