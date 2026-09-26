# Default Daily Learning Inbox Workflow

Status: current default workflow. Existing `LEARNING_INBOX.md` remains transitional storage until its later migration.

This preserves the useful personal rhythm: **collect first, partition later, then choose the next review date with Retention Class as guidance**. It does not impose `ACTIVE | STABLE` or any other universal Knowledge Unit maturity lifecycle.

## D0 — COLLECTED
Prefer one raw batch per learning day (or session when a day is not natural).

Capture facts/observations, links/sources, examples, Questions, hypotheses, screenshots/snippets, and uncertainty markers.

Rules:
- keep provenance/context;
- rough grouping is allowed;
- do not create polished Knowledge Units merely to keep the inbox clean;
- register `triage_due = collection date + 2 calendar days` by default.

## D+2 — TRIAGE / MATERIALIZATION / FIRST REVIEW CONTACT
After one complete intervening day, run `documentation/processes/triage-learning-batch.md`.

Outputs may become:
- discarded noise;
- tracked Questions;
- source/evidence work;
- existing Knowledge Unit additions;
- new Knowledge Units.

For each accepted durable Knowledge Unit / materially reshaped Review Scope:
1. place the knowledge in its canonical semantic location;
2. establish/update the authoritative Review Scope;
3. assess/update its Retention Class when useful using the priority/retention owners;
4. insert/update it in the Repetition Map;
5. choose the next review date using the class, current context, and workload as guidance.

This D+2 pass counts as the **first learning/review contact** after capture because the material is deliberately revisited, verified, organized, and placed. It is not a blind recall calibration, so it creates no recall score or fabricated memory strength.

The raw batch closes after recording output references. Long-term state belongs to the resulting Knowledge Units, Questions, Repetition Map, and Expansion system.

## Next review after materialization
There is no separate universal `D+8 first formative` stage.

For important `CORE` knowledge, the default next active-recall check is after five complete days following actual materialization, then review on the next calendar day:

```text
D0  capture
D+2 materialize / first review contact / Repetition Map entry
5 clear days
D+8 active recall when materialization happened on D+2
```

For `WORKING`, `RECOGNITION`, or `MAP_ONLY`, the next review will often be later according to their retention treatment. No exact class-specific interval is required; the scheduling policy supplies defaults/heuristics and the owner may choose the date manually.

A concrete learning workflow may schedule extra formative practice when useful, but such practice is an additional local action, not a persistent maturity state and not a mandatory lifecycle step for every new Unit.

## Pre-CS5 compatibility boundary
Until CS5, the physical repetition layer still uses legacy storage. Do not fabricate target Retention Class, Recall State, review score, interval, or history inside `REPETITION_STATE.csv`.

Use legacy inbox/queue mechanics only as transitional execution support. The target semantic facts established here are:
- materialization date;
- affected Knowledge IDs / Review Scopes;
- the need to assess retention treatment;
- the intended next-review timing once that treatment is known.

## Batch lifecycle

```text
COLLECTED
→ TRIAGE_DUE
→ TRIAGED/CLOSED
```

The batch is not the long-term owner of repetition or expansion state.
