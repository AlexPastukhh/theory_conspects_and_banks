# Retention & Repetition

Status: current semantic owner. CS5 physical repetition runtime is active at `_ai-conspects/_repetition/REPETITION_MAP.csv`; legacy pre-CS5 files are provenance only.

## Goal
Maintain useful awareness of the durable Knowledge Base at a depth appropriate to each Review Scope, without introducing a universal Knowledge Unit maturity lifecycle such as `ACTIVE | STABLE`.

The current personal policy is **broad Repetition Map coverage**: durable Knowledge Units normally receive a retention treatment and appear in the Repetition Map. Low-value knowledge is not necessarily removed; it can be retained at a much lighter level.

This is an operational retention policy, not an ontology rule. A Knowledge Unit remains valid knowledge independently of repetition mechanics, and temporary migration gaps in retention metadata do not invalidate the Unit.

## Retention intent
The four anchor retention classes are:
- `CORE`
- `WORKING`
- `RECOGNITION`
- `MAP_ONLY`

When forcing one anchor would create false precision, an adjacent **boundary band** is also allowed:
- `CORE ↔ WORKING`
- `WORKING ↔ RECOGNITION`
- `RECOGNITION ↔ MAP_ONLY`

A boundary band means that the Review Scope reasonably belongs between two adjacent retention depths in the current context. It may remain on that boundary indefinitely; it is not a transitional lifecycle state and does not require a formal move to one side later. There is no separate `MIXED` Retention Class.

These labels answer **how available the Review Scope should be from memory / awareness**, not how mature the Knowledge Unit is. They are semantic/advisory retention flags: they help the owner and AI reason about desired depth, but they do not define a rigid lifecycle or uniquely determine a review date. Manual judgment remains normal.

### CORE
Should be readily available for reasoning and decisions. Mental models, invariants, causal mechanisms, important boundaries, and expensive-to-verify decisions tend to belong here.

### WORKING
Should be well understood and quickly reconstructable. It matters in practical work but does not need maximal ready-memory pressure.

### RECOGNITION
The owner should recognize what the knowledge is, why it matters, when it applies, and where/how to recover detail. Exact syntax, signatures, boilerplate, and cheap external lookup often belong here.

### MAP_ONLY
Kept primarily as a semantic/navigation/comparison anchor. The owner should at least retain awareness that the knowledge exists, what area/responsibility it belongs to, and what it is useful to compare or connect with.

`MAP_ONLY` is especially useful for transfer/analogy. For example, a familiar C# manifestation may be retained only as a map/comparison anchor while the corresponding Python manifestation is being learned more deeply. This works with the existing manifestation-coverage and analogy/comparison mechanisms; it does not require a pairwise relation taxonomy.

`MAP_ONLY` is therefore **not equivalent to absence from the Repetition Map**. It may use a very low-frequency map-refresh/recognition action rather than full active-recall scoring.

Do not create `UNDECIDED` as a fifth Retention Class. During migration, an as-yet-unassessed Scope may simply lack a final class temporarily; that is migration incompleteness, not a permanent semantic class.

## Priority is the assignment input
`documentation/principles/priority-model.md` provides the inputs:
- Leverage;
- Consequence;
- Usefulness in the current planning horizon;
- External Recoverability.

The retention owner interprets those dimensions against the concrete Review Scope. In an AI-assisted environment, high External Recoverability can reduce required ready-memory depth, but it does not erase knowledge whose map/comparison value remains useful.

The target personal policy aims to classify essentially the durable corpus over time, but the class is a qualitative aid rather than a computed outcome. Human judgment may assign or change it directly; AI may propose it from the four dimensions. CS5 must not fabricate classes from legacy `ReviewPriority` merely to fill rows, and assignment may be staged while evidence is gathered.

## Review Scope is the retention subject
Retention treatment applies to the authoritative coherent Review Scope.

If meaningful parts of one Unit pull toward different adjacent retention depths:
- do not pretend that one exact anchor is more precise than the evidence;
- an adjacent boundary band may describe the whole Review Scope when that is operationally useful;
- keep the internal nuance in notes when useful;
- split or narrow the Review Scope only when that improves the knowledge boundary itself, not merely to eliminate a retention boundary label;
- keep supporting detail outside the required recall target when appropriate.

Review Scope remains useful beyond repetition: explanation, self-check, formative learning, comparison, and Unit-boundary checks all use the same semantic boundary.

## Learning workflow and retention are separate concerns
Removing `ACTIVE | STABLE` does **not** remove the learning workflow.

A normal daily learning flow may:

```text
D0   capture raw material
D+2  triage/materialize it into durable knowledge
     + place/update the resulting Review Scope in the Repetition Map
     + choose/update retention treatment
     + count this materialization pass as the first learning/review contact
later active recall according to retention treatment
```

The D+2 materialization pass is not a blind recall calibration: the owner is reading, checking, organizing, and placing knowledge. Therefore it must not fabricate a recall score or `WEAK/RECOVERING/STRONG` state.

For important knowledge, a useful default next active-recall check is after five complete days following materialization (review on the next calendar day; D+8 when materialization happened on D+2). Lower-retention classes are commonly scheduled later, but the owner may choose dates directly from context, workload, and current importance.

Thus:

```text
D+8 is not a universal extra formative lifecycle stage.
It is the common five-clear-day next review for knowledge whose retention treatment calls for it.
```

A workflow may still run additional formative practice when needed, but that is locally workflow-owned and does not introduce a persistent maturity axis.

## Recall State
Recall State records observed memory condition for Review Scopes that use normal active-recall repetition:
- `UNCALIBRATED` — entered normal active-recall retention but no valid blind-recall baseline exists yet;
- `WEAK`;
- `RECOVERING`;
- `STRONG`.

`WEAK | RECOVERING | STRONG` require real review evidence.

`MAP_ONLY` map-refresh activity does not require a normal Recall State unless the Scope is promoted into a recall-bearing class.

Retention intent and observed recall must not be collapsed.

## Review modes
`EXPLAIN`, `CONTRAST`, `DIAGNOSE`, `DECIDE`, `TRANSFER`, `RECOGNIZE`.

Comparison Units and technology manifestations are especially suitable for `CONTRAST` and `TRANSFER`. `MAP_ONLY` anchors can participate in those learning actions even when they are not maintained through full recall scoring.

## Finding classification
Keep only the distinctions needed by the review behavior:
- `MEMORY_GAP` — expected in the Review Scope but not recalled; affects recall/scheduling;
- `KNOWLEDGE_BASE_GAP` — expected understanding is missing/inadequate in the base; routes to Coverage/Expansion;
- `NEW_QUESTION` — meaningful new uncertainty; routes to Questions/Expansion;
- source/evidence defect routes to source repair.

Do not turn these findings into a larger universal state machine.

## AI-era implication
High External Recoverability can reduce memory pressure for syntax, signatures, boilerplate, and easy lookup detail. It should not automatically reduce retention for mental models, invariants, causal reasoning, failure modes, boundaries, or decisions whose correctness is expensive to verify.

## Repetition Map
Current physical owner: `_ai-conspects/_repetition/REPETITION_MAP.csv`. Runtime usage contract: `_ai-conspects/_repetition/README.md`.

Repetition Map is the operational projection of retention work. Its central user-facing question is:

> **On what date, and what exactly should I revisit?**

The current personal target is broad coverage of durable Review Scopes, with very different treatment by Retention Class.

Recommended subviews:

```text
Today
Upcoming
Attention
History
```

### Today / Upcoming
Show due and future items with:
- date;
- Knowledge ID / title;
- authoritative Review Scope or map-refresh scope;
- Retention Class;
- review type/mode where useful.

### Attention
Surface concrete intervention needs such as repeated memory failure, overly broad Review Scope, overdue work, or a retention classification that needs reassessment. Do not add global maturity states merely for this view.

### History
Store actual review evidence. Do not invent historical review events merely because a Unit was placed into the map.

### Coverage and Expansion remain independent
A Unit can simultaneously:
- have a scheduled Repetition Map item; and
- have gaps/questions in Coverage & Expansion.

Repetition maintains memory/awareness of what is already represented. Expansion handles what is missing or needs deeper knowledge. Neither owns the other.

## Scheduling owner
Scheduling defaults, clear-day semantics, calibration guidance, map-refresh guidance, and history rules belong to `documentation/policies/repetition-scheduling-policy.md`. That policy supplies useful defaults rather than a requirement that every date be algorithmically derived.
