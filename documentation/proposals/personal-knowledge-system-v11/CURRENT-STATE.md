# Personal Knowledge System — current state (v11)

This package preserves the latest best current variants while keeping proposal status explicit.

## Stable / accepted direction

- universal methodology; domain-specific ontology;
- semantic completeness relative to explicit scope;
- Sources / Knowledge / Questions / Memory remain separate responsibilities;
- Questions are first-class planning objects and should normally live near the Area/nested Area/Concept they most likely expand;
- uncertain Questions may enter a local Area/nested-Area/Concept Question Inbox;
- Areas/nested Areas/Concepts may expose durable Key Questions that state what they are expected to explain; simple defining Key Questions need no independent ID unless they need their own planning/lifecycle/history;
- durable answers integrate into canonical knowledge rather than remaining owned by the Question;
- `ACTIVE/STABLE` learning lifecycle is separate from retention strength and observed Recall State;
- one canonical semantic home per Knowledge Unit;
- broad engineering concepts own ordinary technology manifestations;
- technology-defining models may use the Technology-Core exception;
- tags provide lightweight cross-cutting retrieval for both themes (`caching`) and technologies (`python`, `dotnet`, `node`);
- separate Technology/Tag maps are not required merely for retrieval;
- comparison itself may be durable knowledge represented as a comparison Knowledge Unit;
- cross-technology comparison belongs to the broader Concept that gives it meaning;
- analogy does not require a machine-readable pairwise relation graph;
- the canonical knowledge structure itself is not a `Knowledge View`;
- maintain only views that add distinct operational meaning.

## Current core views

```text
1. Coverage & Expansion View
   map + coverage + Key/Open Questions + gaps + growth edges

2. Expansion Plan
   temporal/actionable plan for new clarification/expansion

3. Repetition View
   temporal/actionable plan for maintaining existing knowledge
```

Technology, topic, comparison, performance, reliability, and similar perspectives default to tags/filters/navigation rather than separately maintained views.

`Inbox / Triage` is a workflow/process surface, not a view.

No current policy globally ranks Capture/Triage, Expansion Plan, and Repetition against one another. Each keeps its own scheduling/order semantics.

## Repetition View shape

```text
Repetition
├── Today
│   ├── FORMATIVE — ACTIVE
│   └── RETENTION — STABLE
├── Upcoming
├── Attention
└── History
```

Review items operate on `Knowledge ID + Review Scope`, not merely on files. Comparison Knowledge Units can participate in repetition. `MAP_ONLY` is unscheduled by default. Base gaps/new Questions found during review route to Coverage & Expansion rather than being treated as memory failure.

## Latest Software Engineering domain proposal
Software Engineering Map v3 is retained under:

`domains/software-engineering/proposals/map-v3/`

Its 15-Area taxonomy remains the current best domain proposal, not yet final ontology. The **system-level view model in v10 supersedes older view suggestions inside that proposal**; Quality/Performance/etc. are currently filters/tags unless a concrete future use case justifies a dedicated view.

## Not yet done
- no physical migration of the existing 576 Knowledge Units;
- no final per-ID semantic mapping;
- no final controlled tag vocabulary;
- no final repository representation of local Question Inboxes/Key Questions;
- no forced formal comparison schema;
- no final UI/storage implementation for the three core views.
