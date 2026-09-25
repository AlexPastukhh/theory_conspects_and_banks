# Appendix — End-to-End System Simulation

Status: explanatory appendix. It demonstrates the same Use Cases/principles/policies; it is not a second methodology.

## Scenario

The owner is learning Node cancellation while already knowing .NET cancellation. The example exercises:

- raw learning capture and delayed triage;
- local Question placement;
- Coverage & Expansion;
- Expansion Plan;
- comparison Knowledge Units;
- ACTIVE → STABLE;
- Repetition;
- separation of memory gaps from knowledge-base gaps.

---

# D0 — capture without premature normalization

During work/reading/AI discussion the owner drops into one raw batch:

```text
Batch L-001 — Node cancellation

- AbortSignal seems similar to CancellationToken
- Node docs link
- question: who should own AbortController?
- observation: abort happened but a resource stayed open
- hypothesis: maybe cancellation != cleanup
- temporary code snippet
- question: how do multiple signals compose?
```

State:

```yaml
L-001:
  status: COLLECTED
  materialize_due: D+2
```

No Knowledge Unit or repetition item exists merely because the raw thought appeared.

Use Case: `UC-LEARNING-CAPTURE-BATCH`.

---

# D+2 — triage

The raw batch is reopened after one complete intervening day.

Triage classifies the items:

```text
Node docs link
→ Source/Evidence reference

"AbortSignal seems similar to CancellationToken"
→ comparison research candidate, not accepted knowledge yet

"Who should own AbortController?"
→ tracked Question Q-201

"cancellation != cleanup?"
→ verify; durable knowledge candidate

temporary debug snippet
→ DISCARD

"How do multiple signals compose?"
→ tracked Question Q-202
```

Both Questions most likely expand:

```text
Software Engineering
└── Concurrency & Asynchrony
    └── Cancellation
```

If exact placement were still uncertain, they could temporarily remain in:

```text
Cancellation
└── Question Inbox
```

After processing:

```text
Cancellation
├── Key Questions
│   ├── What does cooperative cancellation mean?
│   ├── Who owns initiation/propagation?
│   └── How does cancellation interact with cleanup?
│
└── Open Expansion Questions
    ├── Q-201 Who should own AbortController?
    └── Q-202 How do multiple signals compose?
```

The defining Key Questions above do not need independent Question IDs unless they themselves require planning/history.

Priority/work disposition:

```yaml
Q-201:
  leverage: HIGH
  consequence: HIGH
  usefulness: HIGH
  external_recoverability: MEDIUM
  disposition: PURSUE_NOW

Q-202:
  leverage: MEDIUM
  consequence: LOW
  usefulness: MEDIUM
  external_recoverability: HIGH
  disposition: DEFER
```

`UC-KNOWLEDGE-PLAN-EXPANSION` selects Q-201 for immediate work:

```text
Expansion Plan

Today
└── Q-201 AbortController ownership

Later
└── Q-202 signal composition
```

This temporal placement does not move the Questions from their semantic home under Cancellation.

Capture/Triage is now done. The batch closes after handoff; it does not become a second owner of Questions, Knowledge Units, or future review state.

---

# D+2 — resolve selected expansion work

The owner uses analogy/comparison research plus practice.

No fixed relation enum is required. The comparison is written in ordinary language:

- what transfers from the existing .NET model;
- what is only partially analogous;
- what Node does differently;
- where similar API shape is misleading;
- where no useful direct equivalent exists.

Durable results are integrated under the broader Concept:

```text
Concurrency & Asynchrony
└── Cancellation
    ├── node-abortsignal-ownership-and-cleanup.md
    └── comparison-dotnet-node-cancellation.md
```

Logical state:

```yaml
K-120:
  title: ".NET CancellationToken vs Node AbortSignal"
  knowledge_type: comparison
  learning_state: ACTIVE
  retention: UNDECIDED
  review_scope:
    - shared cooperative-cancellation model
    - important propagation/lifecycle differences
    - limits of the analogy

K-121:
  title: "Node AbortSignal ownership and cancellation vs cleanup"
  learning_state: ACTIVE
  retention: UNDECIDED
  review_scope:
    - ownership/lifetime boundary
    - cancellation request vs cleanup responsibility
```

Q-201 becomes resolved and records integration references to K-120/K-121.

Q-202 stays open/deferred under Cancellation and remains visible in Coverage & Expansion.

The review/repetition state now contains formative reviews for K-120/K-121. Expansion Plan and Repetition remain separate operational projections.

---

# Coverage & Expansion after integration

A simplified projection may now show:

```text
Cancellation                                      PARTIAL
├── General cancellation model                    COVERED
├── .NET manifestation                            COVERED
├── Node ownership/cleanup                        COVERED
├── comparison .NET ↔ Node                        COVERED
├── signal composition                            PARTIAL
│   └── Q-202 OPEN
└── Python manifestation                          MISSING
```

This is not a separate copy of the knowledge base. It is the canonical map plus coverage/questions/growth state.

---

# D+8 — first formative review

Five clear days have passed after D+2 materialization.

Before reading K-120/K-121, the system asks the owner to reconstruct the authoritative Review Scopes.

The owner reconstructs the comparison well but is unsure which resources still require explicit cleanup.

Because K-121 is still `ACTIVE`, this uncertainty is formative evidence rather than an automatic stable-memory failure.

A new tracked Question is placed where it most likely expands the map:

```yaml
Q-203:
  question: "Which Node resources still require explicit cleanup after abort?"
  placement: "Concurrency & Asynchrony / Cancellation"
  role: OPEN_EXPANSION
```

K-120 is coherent enough and its Review Scope remains stable:

```text
K-120 ACTIVE → STABLE
```

The same recall may serve as baseline calibration when policy conditions are satisfied.

Suppose stable recall score = 3:

```text
retention = WORKING
Recall State = RECOVERING
next gap = 10 complete days
next review = D+19
```

K-121 remains ACTIVE because Q-203 still blocks a sufficiently coherent model.

---

# Resolve Q-203 and stabilize K-121

Q-203 is selected through expansion planning, researched, and integrated into K-121.

After another coherent formative reconstruction:

```text
K-121 ACTIVE → STABLE
retention = CORE
```

Suppose the qualifying baseline stable recall score is 4:

```text
Recall State = RECOVERING
next gap = 20 clear days
```

K-121 now participates in normal spaced repetition.

---

# D+19 — scheduled WORKING review of comparison K-120

Review mode: `CONTRAST`.

Prompt:

> Explain the useful similarities between CancellationToken and AbortSignal, then identify where the analogy breaks.

Suppose recall = 4.

Completed gap was 10 clear days, so policy moves one ladder stage longer:

```text
next gap = 20 clear days
```

No expansion work is created merely because the repetition succeeded.

---

# Later — scheduled CORE review of K-121

Review mode: `DIAGNOSE`.

Prompt:

> A request was aborted, but a resource remained open. Does that prove cancellation failed?

The owner correctly explains that cancellation signalling and cleanup responsibility are separate concerns.

Result:

```text
score 4
MEMORY_GAP: none
KNOWLEDGE_BASE_GAP: none
NEW_QUESTION: none
```

The repetition interval grows according to policy.

---

# Later — a real memory gap

A review prompt targets an ownership boundary explicitly inside K-121's Review Scope.
The owner cannot reconstruct it.

Classification:

```text
MEMORY_GAP
```

Effects:

- stable recall score decreases;
- Recall State may become WEAK/RECOVERING;
- next interval shortens according to the repetition policy;
- no new Knowledge Unit is required merely because memory failed.

---

# Later — a knowledge-base gap found during review

A `TRANSFER` prompt raises Python asyncio cancellation.

The system verifies that Python-specific cancellation semantics were never part of the expected Review Scope.

Classification:

```text
KNOWLEDGE_BASE_GAP
not MEMORY_GAP
```

A new Question is placed under the concept it most likely expands:

```text
Cancellation
└── Open Expansion Questions
    └── Q-204 How does Python asyncio cancellation differ from the current model?
```

Coverage & Expansion now exposes the missing Python manifestation.

If selected by `UC-KNOWLEDGE-PLAN-EXPANSION`, Q-204 may also appear in the temporal plan:

```text
Expansion Plan

Tomorrow
└── Q-204 Python asyncio cancellation
```

The current stable recall score is not penalized for missing out-of-scope knowledge.

---

# Parallel operational surfaces

At some later date both views may contain work:

```text
Expansion Plan
Today
├── Q-204 Python cancellation
└── Q-202 signal composition
```

```text
Repetition
Today
├── K-120 comparison review
└── K-121 ownership/cleanup review
```

There is intentionally **no current global policy** saying which of these two views must always win, nor is Capture/Triage inserted into a repetition-owned priority order.

A future higher-level daily dashboard may display these queues together if useful, but it is outside the current methodology.

---

# Resulting loop

```text
Capture
→ Triage
→ local Questions / Sources / knowledge candidates

Coverage & Expansion
→ semantic placement + coverage + gaps/questions

UC-KNOWLEDGE-PLAN-EXPANSION
→ priority + optional Expansion Plan placement

Resolve / Analogy / Practice
→ Integrate canonical knowledge
→ ACTIVE
→ STABLE

Repetition
→ reconstruct existing Review Scope
→ memory findings and/or new knowledge-base Questions
→ back to Coverage & Expansion when expansion is needed
```

The three responsibilities remain distinct:

```text
Capture/Triage
    classify and route new raw material

Expansion
    decide and plan how the knowledge map grows

Repetition
    maintain already integrated knowledge in memory
```
