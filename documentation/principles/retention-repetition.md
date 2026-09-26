# Retention & Repetition

Status: current target semantic owner. Existing legacy repetition storage and scheduling remain transitional until CS5; see `../migration/CURRENT-MIGRATION-STATE.md`.

## Goal
Define how integrated knowledge moves from active learning into long-term memory maintenance and how review findings are interpreted.

## Three separate axes

### 1. Learning State — model maturity
- `ACTIVE` — understanding/scope is still being formed, clarified, practiced, or reorganized.
- `STABLE` — scope is coherent enough for ordinary retention review.

### 2. Retention Class — desired memory strength
- `CORE`
- `WORKING`
- `RECOGNITION`
- `MAP_ONLY`

`UNDECIDED` means no class has yet been assigned; it is not a fifth class.

### 3. Recall State — observed memory condition
For STABLE reviewable knowledge:
- `UNCALIBRATED`
- `WEAK`
- `RECOVERING`
- `STRONG`

These axes must not be collapsed.

## Retention applies to a coherent Review Scope
A Retention Class describes the desired long-term availability of a coherent review scope.

If meaningful parts of one Unit appear to require substantially different Retention Classes:
- do not average them;
- first split/restructure the Knowledge Unit or narrow the scheduled Review Scope;
- keep purely supporting low-retention detail outside scheduled recall when appropriate.

The initial model avoids independently scheduling many sub-claims inside one Unit.

## Retention classes

### CORE
Should be readily available for reasoning/decisions. Review often uses explanation, diagnosis, decision, transfer, and scenarios.

### WORKING
Should be well understood and quickly reconstructable, but not maximally available at all times.

### RECOGNITION
Should be recognized, purpose understood, relevance detected, and details recoverable externally.

### MAP_ONLY
Kept for semantic coverage/navigation/comparison; no scheduled repetition by default.

Retention is contextual and revisable, not an eternal property of a Concept.

## Assignment authority
Priority provides the inputs; this policy maps them to Retention Class. Do not create a second competing priority model here.

Because Usefulness is context-dependent, Retention may change when the active planning/work context changes even if the Knowledge Unit content itself does not.

## ACTIVE review = formative
While ACTIVE, recall is used to reconstruct the current model, expose contradictions, test predictions, connect ideas, and create Questions. Normal spaced-repetition scoring is not authoritative while expected scope is materially changing.

## Transition ACTIVE → STABLE
A Unit may become STABLE when:
- Review Scope is coherent;
- blocking Questions are resolved or consciously deferred;
- the owner can explain the core model consistently enough for ordinary use;
- expected future learning mostly extends rather than repeatedly redefines the Unit.

At transition, confirm scope, assess/reconfirm Priority, assign Retention Class, and make the Unit eligible for normal repetition when the class requires it.

A STABLE Unit may return to ACTIVE after substantial revision or evidence that the model itself is broken. Its previous Retention Class may remain as the intended long-term class, but normal scheduling for the affected scope pauses until stable again.

## Review modes
`EXPLAIN`, `CONTRAST`, `DIAGNOSE`, `DECIDE`, `TRANSFER`, `RECOGNIZE`.

## Review Scope is authoritative
Do not penalize missing out-of-scope information. Extra AI knowledge can create a base gap/new Question but not a false memory failure.

## Finding classification
- `MEMORY_GAP` — expected in scope but not recalled; affects repetition.
- `KNOWLEDGE_BASE_GAP` — expected understanding is missing/inadequate in the base; routes to expansion, does not directly lower memory score.
- `NEW_QUESTION` — meaningful new uncertainty; routes to expansion.
- source/evidence defect should be handled as source repair, not memory failure.

## Scheduling owner
Exact intervals, review score, Recall State derivation, eligibility, and next-date rules belong to `documentation/policies/repetition-scheduling-policy.md`.

## AI-era implication
High External Recoverability can reduce memory pressure for syntax, signatures, boilerplate, and easy lookup details. It should not automatically reduce retention for mental models, invariants, causal reasoning, failure modes, boundaries, or decisions whose correctness is expensive to verify.

## Repetition View
Repetition View is the operational projection over the common review/repetition state. It does not own Knowledge Units or scheduling rules.

Recommended subviews:

```text
Today
Upcoming
Attention
History
```

### Today
Show due/overdue work in one working queue while preserving the semantic distinction:

```text
FORMATIVE — ACTIVE
RETENTION — STABLE
```

A queue item is the Knowledge ID plus its authoritative Review Scope, review type, and due state—not merely a file path.

### Upcoming
Show expected future review load so review debt and clustering are visible. It is a forecast over scheduling state, not an expansion roadmap.

### Attention
Surface problems that require intervention rather than ordinary repetition, including:
- repeated `MEMORY_GAP`;
- `KNOWLEDGE_BASE_GAP` or `NEW_QUESTION` discovered during review;
- Units returned from STABLE to ACTIVE;
- Review Scopes that appear too broad/heterogeneous;
- overdue work;
- missing retention assignment for stable reviewable knowledge.

### History
Show past review events/state changes for diagnosis, not primarily for streaks or gamification.

Useful history includes review date/type, recall result when applicable, findings, completed/next gap, and important state transitions.

### Eligible content
Normal Knowledge Units and comparison Knowledge Units can participate when they have a coherent Review Scope.

Comparison Units are especially suitable for `CONTRAST` and `TRANSFER` modes.

`STABLE + MAP_ONLY` remains unscheduled by default.

Generated views, tags, indexes, Expansion Plans, and other navigation/planning surfaces are not repetition subjects merely because they exist.

### Findings route outward
`MEMORY_GAP` affects memory/repetition state.

`KNOWLEDGE_BASE_GAP` and `NEW_QUESTION` route into the local Question/Coverage & Expansion system without being mis-scored as forgetting.

