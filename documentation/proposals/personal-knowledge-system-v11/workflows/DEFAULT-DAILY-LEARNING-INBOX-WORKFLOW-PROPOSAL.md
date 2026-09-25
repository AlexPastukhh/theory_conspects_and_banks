# Default Daily Learning Inbox Workflow — proposal v6

Status: proposed default personal operational workflow implementing `UC-LEARNING-CAPTURE-BATCH`.

This preserves the useful old behavior: **collect first, partition later**.

## D0 — COLLECTED
Prefer one raw batch per learning day (or session when a day is not natural).

Capture facts/observations, links/sources, examples, Questions, hypotheses, screenshots/snippets, and uncertainty markers.

Rules:
- keep provenance/context;
- rough grouping is allowed;
- do not create polished Knowledge Units merely to keep the inbox clean;
- register `triage_due = collection date + 2 calendar days` by default.

## D+2 — TRIAGE_DUE
After one complete intervening day, run `processes/PROCESS-TRIAGE-LEARNING-BATCH-PROPOSAL.md`.

Outputs may become:
- discarded noise;
- tracked Questions;
- source/evidence work;
- existing Knowledge Unit additions;
- new Knowledge Units.

New/materially reshaped learnable Units normally enter `ACTIVE`.

The batch then closes after recording output references. It does **not** remain the owner of future Question/Knowledge/review state.

## Default first review after materialization
For each newly created/materially reshaped ACTIVE Unit, register a `FORMATIVE` review in the **same common review/repetition state/queue** used for later stable reviews.

Default timing: after five complete days following actual materialization, review on the next calendar day.

If materialization happened on D+2, this is D+8.

If materialization was late, calculate from the actual materialization date.

```text
Review type = FORMATIVE
Learning State = ACTIVE
No interval-ladder score is authoritative yet
```

## Can that review become baseline calibration?
Yes, only when:
- Review Scope was fixed before recall;
- after checking, the Unit meets STABLE criteria;
- the recall can be fairly scored against that unchanged scope.

Then the same session may transition the Unit to STABLE and serve as `CALIBRATION`.

Otherwise it remains FORMATIVE. The Unit stays ACTIVE and another formative review can be scheduled according to learning need rather than the normal interval ladder.

## After stabilization

```text
STABLE + CORE/WORKING/RECOGNITION
→ common review state switches to normal repetition scheduling

STABLE + MAP_ONLY
→ remove normal scheduled review by default
```

## Batch lifecycle

```text
COLLECTED
→ TRIAGE_DUE
→ TRIAGED/CLOSED
```

The long-term lifecycle belongs to resulting Questions and Knowledge Units, not to the batch.
