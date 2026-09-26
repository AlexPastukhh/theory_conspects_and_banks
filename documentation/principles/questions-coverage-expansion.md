# Questions, Coverage & Expansion

Status: current semantic owner. Current operational projections live under `_ai-conspects/_planning/`; see `../migration/CURRENT-MIGRATION-STATE.md` for migration boundaries.

## Purpose
Make Questions part of the knowledge map's growth without turning them into a heavy graph/workflow schema.

## Two durable meanings of questions

### Key Questions
A Key Question states what an Area / nested Area / Concept is expected to explain.

Example:

```text
Cancellation
Key Questions
- What does cooperative cancellation mean?
- Who owns the cancellation request?
- How is cancellation propagated?
- How does cancellation interact with cleanup/timeouts?
```

Key Questions are part of the semantic definition of that part of the map. They can remain after the answers are fully covered.

A simple defining Key Question does not need a separate Question file/ID merely because it is phrased as a question. Give it independent Question identity when it needs planning, lifecycle/history, references, priority, or resolution tracking.

### Open Expansion Questions
An Open Expansion Question records something the map does not yet answer sufficiently and that may expand/refine knowledge.

Example:

```text
Cancellation
Open Expansion Questions
- How does Python asyncio cancellation differ from the current .NET mental model?
```

## Local Question Inbox
When a new Question appears but exact placement is not yet clear, store it in the nearest sensible local inbox:

```text
A03 Concurrency & Asynchrony
└── Question Inbox
```

or, when already narrower:

```text
Cancellation
└── Question Inbox
```

A local inbox is temporary uncertainty about placement, not a new top-level knowledge domain.

## Processing a Question
Processing asks only what is useful:

1. Where does this Question most likely belong/expand the map?
2. Is it already answered or duplicated?
3. Is it a temporary expansion Question or a durable Key Question?
4. Does it expose a missing Concept/nested Area?
5. Is it worth planning now, deferring, or discarding?

Optional context can be kept:

```text
origin
related_to
likely_expands
notes
```

Do not require all of these fields.

## What happens after an answer
The Question is not the permanent owner of durable answer content.

Possible integration outcomes:

```text
Question answered
├── update existing Knowledge Unit
├── create new Knowledge Unit
├── create/update comparison Knowledge Unit
├── create/refine Concept or nested Area
└── no durable materialization needed
```

The Question may then keep references to what was integrated and become resolved/history.

If the Question became a useful Key Question, keep the Key Question on the map while marking its coverage as answered/covered.

## Coverage discovery order
Coverage discovery should not start from existing folders or named tools. Use this order:

```text
1. domain / Area responsibility
2. Conceptual mechanisms, boundaries, failure modes and Key Questions
3. current durable evidence
4. relevant technology manifestations
5. cross-technology symmetry / analogy checks
```

A responsibility may remain a lightweight checklist item. It does not need to become a nested Area, Concept, Gap entity, or independently tracked Question merely because it is `MISSING`. Create a tracked Question when planning/history/resolution identity is useful.

Technology manifestations are evidence/completeness dimensions, not a demand for tool-to-tool symmetry. If a manifestation is irrelevant, `NOT_APPLICABLE` or “no useful direct equivalent” is a valid result.

## Coverage & Expansion View
The view overlays the canonical map with growth state.

Example:

```text
A03 Concurrency & Asynchrony
└── Cancellation                         PARTIAL
    ├── General model                    COVERED
    ├── .NET manifestation               COVERED
    ├── Node manifestation               PARTIAL
    │   └── ? ownership/propagation detail
    └── Python manifestation             MISSING
        └── ? asyncio cancellation semantics
```

The view can expose:
- existing knowledge;
- Key Questions;
- Open Expansion Questions;
- local Question Inbox items;
- `COVERED / PARTIAL / MISSING` state;
- uncertain/outdated areas where relevant;
- possible new Concepts/nested Areas;
- priority/context.

Coverage becomes explainable because the user can see which responsibilities/questions are and are not answered. A populated Area/nested Area can still contain `MISSING` responsibilities; an empty primary-owner node can still have supporting evidence elsewhere. Structural occupancy is not semantic completeness.

## Expansion Plan
Expansion Plan is separate from the structural map because it adds time/order.

```text
Today
- Python cancellation Question

Tomorrow
- structured concurrency ownership

Later
- cache coherence
```

The same Question/gap remains semantically located on the Coverage & Expansion map while also appearing in the temporal plan.

`UC-KNOWLEDGE-PLAN-EXPANSION` owns selection/prioritization and may assign this lightweight time/order placement. The plan may change freely without moving canonical knowledge or Questions.

Expansion Plan does not coordinate itself against Repetition or Capture/Triage; the current model intentionally has no global daily-work scheduler.

## Relationship to Repetition
Expansion and repetition are parallel operational concerns:

```text
Expansion Plan
    what new/uncertain knowledge to expand

Repetition View
    what existing knowledge to reconstruct/retain
```

They should not be collapsed into one queue merely because both can contain work for the same day. A higher-level daily dashboard may show both counts/queues later if useful, but it is not required by the current model.
