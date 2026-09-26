# Knowledge Structure & Ontology

Status: current semantic owner.

## Goal
Define the logical representation required by the Use Cases. This is not primarily a folder-layout specification.

## Core entities

```text
Domain
Area (nestable)
Concept
Knowledge Unit
Question
Source/Evidence reference
Repetition State
```

Do not initially add separate `Gap`, `ExpansionTarget`, `View`, or pairwise `AnalogyRelation` entities.

## Domain / Area
A Domain is a broad knowledge domain. Areas are recursively nestable conceptual/navigation regions used for scope, Concepts, Questions, coverage planning, and canonical ownership.

`Subarea` is only a practical name for an `Area` nested inside another Area. It is **not** a separate entity/type and there is no fixed maximum depth:

```text
Domain
└── Area
    ├── Concept
    └── Area          # often called Subarea
        ├── Concept
        └── Area      # also a Subarea; recursion continues when justified
```

Do not force every level to exist. A Concept may sit directly under any Area, and a nested Area is justified by a durable semantic boundary/navigation responsibility rather than by a desire for uniform depth.

## Concept
A Concept is something that exists in the knowledge map. It can exist before enough knowledge is written, relate to other Concepts, carry Key Questions, and have technology manifestations.

A migration table may use a `concept_label` to describe the local subject of a Knowledge Unit. That label is **not automatically a separately materialized/canonical Concept entity**, and the set of such labels is not automatically a complete Concept taxonomy. Current structural validation may establish Area/nested-Area placement before Concept identities are normalized further.

## Responsibility / coverage criterion
A **responsibility** is a statement of what a scoped part of the domain is expected to explain: a model, mechanism, distinction, failure mode, decision boundary, lifecycle, comparison, or similar semantic obligation.

A responsibility is primarily a **coverage criterion**, not a required core ontology entity. It may be represented by Key Questions, Concepts, nested Areas, one or more Knowledge Units, or remain only as a checklist item while knowledge is missing.

Do **not** automatically create one Area/Concept/Question/Unit per responsibility. The hierarchy answers where knowledge belongs; responsibility coverage answers whether the chosen scope is sufficiently understood.

## Knowledge Unit
A Knowledge Unit is a coherent, learnable, reviewable piece of understanding. `Concept != Knowledge Unit`.

Possible mappings:
- one Concept → one Unit;
- one Concept → several Units;
- one coherent Unit → a tight cluster of Concepts when splitting would damage understanding.

Unit boundaries should be reconsidered when one Unit repeatedly produces materially different required depth or retention needs across its main content.

A Unit should support:
- stable Knowledge ID;
- explicit learning/review scope;
- formal/current knowledge;
- optional personal mental model and caveats;
- ordinary links and comparisons;
- provenance where required;
- Retention Class reference when assigned;
- optional tags.

These are semantic capabilities, not mandatory headings.

## Review Scope
Review Scope answers:

> What exactly is the learner responsible for reconstructing from this Unit?

It is authoritative for recall assessment and must be updated when the Unit changes materially.

### Heterogeneous retention needs
Do not assign one averaged Retention Class to a Unit whose meaningful parts clearly require different memory treatment.

When this happens, first reconsider the knowledge boundary:

1. **Split the Knowledge Unit** when the parts are independently coherent and reviewable.
2. If the lower-retention material is only supporting detail, keep it in the same Unit but **outside the scheduled Review Scope**.
3. Introduce multiple independently scheduled scopes inside one Unit only if real usage later proves that splitting is worse; this is not part of the initial model.

Do not add priority dimensions to compensate for an oversized or heterogeneous Knowledge Unit.

## Questions
Questions are first-class planning objects, but they are intentionally lightweight.

### Semantic placement
A Question should normally live with the Area / nested Area / Concept that it most likely expands or helps define.

When placement is still uncertain, keep it in a **local Question Inbox** of the nearest sensible Area / nested Area / Concept. This preserves context without requiring a global semantic dump.

The system does not require a complicated `origin → target` graph for every Question.

Useful optional context may include:
- `origin` — where the Question arose;
- `related_to` — nearby Concepts/Units;
- `likely_expands` — where it currently appears to extend the map;
- free-form notes about why the Question matters.

These are hints, not hard ownership edges.

### Question roles
The following roles are useful, but need not become a rigid state machine initially:

```text
Inbox Question
    captured locally but not yet placed precisely

Open Expansion Question
    placed on the map and still unresolved

Key Question
    a durable question that defines what an Area / nested Area / Concept should explain

Resolved Question
    no longer active expansion work; keeps resolution/integration references when useful
```

A Question may move from Inbox → Open Expansion → Key Question, but this is not mandatory. A Key Question can remain permanently after its answer becomes covered because it expresses the responsibility of that part of the knowledge map.

### Question identity and minimal tracked data

Not every question-shaped sentence on the map must become an independently tracked Question entity.

A durable **defining Key Question** may remain local to an Area / nested Area / Concept without a separate stable ID when it only states what that part of the map should explain.

Create/retain independent Question identity when the Question itself needs to participate in planning, lifecycle/history, cross-references, priority, or resolution tracking.

An independently tracked Question should normally preserve:
- stable Question ID;
- wording;
- semantic placement (Domain/Area/Concept as known);
- status/role sufficient for current workflows;
- optional origin/context/likely-expands details;
- priority/work disposition when planned;
- resolution/integration references when resolved.

### Answer integration
The durable answer does **not** remain owned by the Question merely because the Question produced it.

After research/learning, integrate durable results into their canonical semantic home:
- update an existing Knowledge Unit;
- create a new Knowledge Unit;
- create a comparison Knowledge Unit;
- create/refine a Concept or nested Area when the ontology itself expands;
- or record that no durable knowledge was worth materializing.

The resolved Question may link to those results.

## Gap
A Gap is initially a **coverage state/observation**, not its own entity. A meaningful gap normally creates/updates Questions. Add Gap IDs only if real usage later needs an independent lifecycle.

## Expansion Target
An Area, Concept, Question, or bounded Question cluster can temporarily play the target role. No `ExpansionTarget` entity is required.

## Links and optional relations
Knowledge is not required to be representable as one strict tree. Units may link to other Units, Concepts, Areas, tags, sources, and comparison Units.

A small general relation vocabulary may be introduced only where a real use case requires machine-readable semantics. Do not build a relation graph merely because two files are conceptually related.

In particular, **cross-technology analogy does not require explicit pairwise relation objects**. Human-readable comparison knowledge is sufficient unless later automation proves otherwise.

## Tags
A tag is a lightweight cross-cutting label for knowledge that is useful to retrieve together even when its canonical locations differ.

Tags can represent:

### Logical topics
```text
caching
streaming
cancellation
serialization
transactions
```

### Technologies / ecosystems
```text
python
dotnet
node
react
redis
sqlalchemy
```

Technology tags are intentionally allowed. They provide a cheap cross-cutting query such as “show everything related to Python” without maintaining a separate Technology View or duplicate technology map.

Example:

```text
tag: python
```

may collect Python Technology Core knowledge plus Python manifestations stored under Concurrency, I/O, Networking, Data, Testing, and other engineering Areas.

Tags answer:

> What knowledge do I want to retrieve together across canonical locations?

They do **not** replace:
- Area/nested-Area/Concept ownership;
- Technology Core canonical ownership where the core exception applies;
- Retention Class;
- priority;
- explicit comparison Knowledge Units.

Avoid tags that merely reproduce operational state such as `CORE`, `important`, `learn-now`, or similar fields already owned elsewhere.

Keep the vocabulary controlled enough to remain useful. A tag may optionally have a curated topic page, but that page does not become canonical owner of the linked Units.

## Comparison Knowledge Units
Comparison is first-class durable knowledge.

When several Units explain analogous, related, or superficially similar models across technologies/areas, a dedicated **comparison Knowledge Unit** may synthesize them.

The comparison Unit:
- links to the compared Units;
- explains shared ideas and important differences;
- may explain what transfers from one known model to another;
- should explicitly record where an analogy breaks when that matters;
- may use free-form prose and examples rather than a rigid relation schema;
- has its own coherent Review Scope when it contains durable knowledge;
- may be tagged with the technologies/topics involved.

A comparison Unit is **not merely a generated view**. It is real knowledge when the act of comparison produces understanding that is not present in the individual Units alone.

### Comparison ownership
A cross-technology comparison inherits canonical ownership from the broader Concept/Area that gives the comparison meaning.

Ordinary case:

```text
Engineering Area / Concept
├── general model
├── .NET manifestation
├── Python manifestation
├── Node manifestation
└── comparison
```

Core-technology exception:

```text
Engineering Area / Concept
├── general model
└── comparison
     ↓ links

Technology Core
├── .NET defining model
├── Node defining model
└── Python defining model
```

Even when compared manifestations live in Technology Core, the cross-technology comparison remains owned by the broader engineering Concept rather than by one of the technologies.

Do not create a global comparison dump if a meaningful broader Concept exists.

A dedicated Comparison View is not required. Comparison Units can be found through the base map, tags, or a simple `knowledge_type = comparison` filter.

## Engineering path vs canonical owner
A Unit can participate in an Engineering Area/nested-Area path for coverage, navigation, comparison, and gap analysis even when the Technology Core exception makes the technology itself the canonical owner of the defining model.

Therefore these are distinct questions:

```text
Where does this knowledge participate in the engineering map?
    → Area / nested-Area path

Who canonically owns the defining explanation?
    → broad engineering Concept by default
    → Technology Core only for a defining language/runtime/framework model
```

Do not duplicate the Unit to satisfy both paths. A technology-owned Unit is linked from the broader engineering path. During migration, a label such as `TECHNOLOGY_CORE_CANDIDATE` is an ownership-classification signal, not a physical-folder instruction.

## General Concept vs technology manifestation
Where useful, a Concept can have .NET/Node/Python/etc. manifestations.

Default ownership rule:
- ordinary technology-specific implementations stay with the broader engineering Concept;
- a technology-defining language/runtime/framework model may stay in Technology Core under the accepted core-technology exception;
- broad Concept maps link to technology-owned defining models when needed;
- technology tags provide cross-cutting retrieval across both locations;
- do not duplicate the same explanation merely to satisfy multiple navigation paths.

## Coverage model
Coverage is multi-dimensional and every status is relative to an explicit scope.

### Status semantics

`COVERED | PARTIAL | MISSING` are assessment results, not file-presence flags:

- `COVERED` — adequacy was explicitly checked against the scoped responsibility/Key Questions;
- `PARTIAL` — some durable evidence exists, but adequacy/completeness is not established;
- `MISSING` — current durable evidence is insufficient for the stated scope, even if adjacent/related Units exist.

Do not infer `COVERED` from Unit count. Do not infer `MISSING` merely from an empty physical folder.

### Structural occupancy is not semantic coverage
A broad nested Area may have zero **primary-owned** Units while one of its responsibilities has partial evidence in Units canonically owned elsewhere. Conversely, a populated nested Area can still contain many `MISSING` responsibilities.

This is expected because primary ownership and evidential support are different relations.

### Responsibility Coverage
Responsibility-first coverage asks what the scope should explain independent of current corpus shape. This is the primary surface for discovering semantic gaps.

### Knowledge Status
When relevant: `CURRENT | OUTDATED | UNCERTAIN | UNRESOLVED`. This axis describes claim/model condition, not coverage amount.

### Manifestation Coverage
Relevant manifestations (for example generic/.NET/Node/Python/browser) can each be assessed independently. A manifestation is included only where it is meaningful. `NOT_APPLICABLE` is not a gap.

Manifestation checking is **secondary to the generic responsibility**: do not require one-to-one framework/tool analogues. A responsibility discovered in one technology should be checked symmetrically in other relevant technologies, including a previously well-covered ecosystem.

### Key-Question Coverage
Key Questions can act as an explainable coverage surface:
- answered/covered;
- partially answered;
- unanswered/missing.

### Comparison Coverage
Important comparisons may be independently `COVERED | PARTIAL | MISSING`. A comparison is normally covered by a coherent comparison Knowledge Unit (or, for trivial cases, by a short comparison section/link), not by the existence of a machine-readable analogy relation.

### Aggregate projections
Area-level roll-ups and nested-Area occupancy tables are useful navigation/summary projections, but they must not silently replace responsibility-level evidence. Coverage claims are always scope-relative.

## Core views
The base knowledge structure itself is **not a view**. It is the canonical knowledge model.

The current system recognizes three views that add distinct operational meaning:

### 1. Coverage & Expansion View
Projects the knowledge map together with:
- semantic coverage;
- Key Questions;
- local Question Inboxes when useful;
- Open Expansion Questions;
- gaps/uncertainty;
- emerging Concepts/nested Areas;
- candidate expansion work and priority context.

This is the main structural planning view: it shows both what exists and the unfinished edges of the map.

### 2. Expansion Map
A lightweight projection of expansion work explicitly selected from Questions, gaps, Concepts, and other targets. It may be completely empty even while coverage gaps and open Questions exist.

It answers:

> What expansion work have I actually selected to do?

Ordering/date is optional. The map does not own the underlying Questions/Concepts; it references them.

### 3. Repetition View
An operational memory-maintenance view over review/repetition state.

It answers:

> What existing knowledge should I reconstruct/review now or soon, and what memory/base problems require attention?

Its detailed behavior belongs to `documentation/principles/retention-repetition.md` and the repetition scheduling policy.

### What is not a separate core view
The following are currently better handled as tags, filters, or ordinary navigation rather than separately maintained views:
- Technology View → use technology tags;
- Tag View → use tag filtering directly;
- Comparison View → filter `knowledge_type = comparison` / relevant tags;
- Performance/Reliability/Quality-specific views → use tags/filters unless a concrete future use case justifies a dedicated projection;
- plain Knowledge View → redundant with the canonical knowledge base itself.

`Inbox / Triage` is a workflow/process surface, **not a view**.

## Canonical ownership: engineering concept vs technology
Physical storage follows semantic ownership, not merely the technology mentioned by the Knowledge Unit.

### Rule

1. **Broad engineering concept owns its implementations**
   when the technology is primarily an implementation/context of that broader concept.

   Example:
   - transaction isolation → Data & Persistence / Transactions;
   - EF Core optimistic concurrency → Data & Persistence / Concurrency;
   - HTTP caching → Networking & Protocols / HTTP.

2. **Technology owns its defining model**
   when the Knowledge Unit primarily explains the technology's own language/runtime/framework model.

   Example:
   - C# generics → C#/.NET;
   - Python decorators → Python;
   - React render model → React;
   - EF Core change tracker → EF Core.

3. **Core-technology manifestation exception**
   if a technology-defining model is also a manifestation of a broader engineering concept, keep one canonical technology-owned Unit and link it into the broader concept map.

   Example:
   - .NET Task/async-await model → .NET, linked from Concurrency & Asynchrony;
   - Node event loop/Promise model → Node, linked from Concurrency & Asynchrony;
   - Python asyncio model → Python, linked from Concurrency & Asynchrony.

4. **Do not duplicate explanations**
   merely to satisfy both technology and engineering navigation.

5. **Physical location is not the only retrieval dimension**
   a Unit may have one canonical owner and still be reachable through tags, ordinary links, comparison Units, filters, and the core views.

## Canonical-home test
Ask in this order:

1. What is the primary subject of the Unit?
2. If the technology name were removed, would the core knowledge still make sense as a broader engineering concept?
3. Is the implementation itself part of the minimum mental model required to understand the technology?
4. Which location minimizes duplication while keeping the semantic owner obvious?

Use the answer to determine canonical storage. Tags and comparison Units provide additional retrieval without changing ownership.

## Inputs are not Knowledge Units
Sources/evidence, raw learning batches, Question Inboxes, and practice observations feed Questions/Knowledge but are not automatically Knowledge Units.

## Stable identity
Knowledge Units and tracked Questions require stable IDs. Concept IDs can be introduced when Concepts need durable references; do not require them prematurely.

## File structure is secondary
After logical acceptance, choose a repository layout with one stable primary location per Unit plus metadata/links/indexes for cross-cutting dimensions. Do not encode the whole graph in folders.
