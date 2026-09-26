# Tags, Comparisons & Core Views

Status: current semantic owner.

## Purpose
Keep canonical knowledge storage simple while still supporting cross-cutting retrieval, comparative learning, expansion planning, and repetition.

The system distinguishes:

```text
Canonical knowledge structure
    where knowledge semantically belongs

Technology Core exception
    where technology-defining models canonically belong

Tags / filters
    how distributed knowledge is cheaply retrieved together

Comparison Knowledge Units
    durable synthesized comparison knowledge

Core views
    projections that add distinct operational meaning

Workflows
    actions/processes performed on the system; not views
```

## Tags
A tag is intentionally lightweight.

Use it when knowledge from different canonical locations is useful to retrieve as one logical set.

### Topic example

```text
#caching

A06 Networking / HTTP cache
A08 Client / server-state cache
A09 Data / general cache semantics
A10 Distributed Systems / cache coherence and stampede
Technology Core / Redis, HybridCache, OutputCache
```

### Technology example

```text
#python

Python Technology Core
A03 Concurrency / asyncio cancellation
A05 I/O / Python file-stream manifestation
A09 Data / SQLAlchemy
A13 Testing / pytest
```

Technology tags replace the need for a separately maintained Technology View. They do **not** replace the Technology Core ownership exception.

Avoid tags for information already owned by operational state fields, for example:

```text
ACTIVE
CORE
important
learn-now
```

## Comparison Knowledge Units
A comparison file is a normal Knowledge Unit whose subject is the comparison itself.

Example:

```text
A03 Concurrency & Asynchrony
└── Cancellation
    ├── general-model.md
    └── comparison-dotnet-node-python.md
```

The compared implementation Units may live beside it or, for technology-defining models, in Technology Core.

The comparison remains owned by the broader Concept because that Concept gives the comparison its meaning.

### Comparison content
Comparison Units may be free-form. Useful questions include:
- What shared problem do these models solve?
- What is genuinely common?
- What only looks similar?
- What mental model transfers?
- What must be relearned?
- Where does the analogy break?
- What runtime/platform assumptions differ?
- Does the comparison expose a missing general Concept?

Do not require fixed analogue enums or pairwise relation records unless a future automation use case proves their value.

### Finding comparisons
A dedicated Comparison View is not currently needed.

Use:
- the broader Concept location;
- technology/topic tags;
- ordinary links;
- a simple `knowledge_type = comparison` filter.

## The base is not a view
The canonical structure:

```text
Domain
└── Area
    └── nested Area / Concept
        ├── Key Questions
        └── Knowledge Units
```

is the knowledge base itself. Calling it a `Knowledge View` adds no separate semantics.

## Core view 1 — Coverage & Expansion
This is the main structural planning projection over the knowledge map.

It can show:
- existing Concepts and Knowledge Units;
- semantic coverage (`COVERED / PARTIAL / MISSING`);
- Key Questions and whether they are covered;
- local Question Inboxes;
- Open Expansion Questions;
- uncertain/missing knowledge;
- possible new Concepts/nested Areas;
- priority/context for expansion candidates.

Its defining question is:

> What does the map currently cover, where are its unfinished edges, and where is it trying to grow?

This view may be filtered by tag, Area, technology tag, knowledge type, coverage status, or other metadata. Those filters do not become separate views.

## Core view 2 — Expansion Plan
Expansion Plan is a temporal/actionable projection of selected growth work from the Coverage & Expansion map.

Examples:

```text
Today
├── clarify Python cancellation
└── resolve cache invalidation Question

Tomorrow
└── structured concurrency ownership

Later
├── cache coherence
└── distributed transactions
```

The plan may select:
- Questions;
- gaps;
- Concepts/Areas to establish;
- comparison work;
- source/verification work needed for expansion.

The plan does not own those objects. It references them and adds ordering/time context.

`UC-KNOWLEDGE-PLAN-EXPANSION` may assign this temporal/order placement. Expansion Plan does not globally rank itself against Repetition or Capture/Triage.

## Core view 3 — Repetition
Repetition View is the operational projection of memory-maintenance state.

Recommended subviews:

```text
Repetition
├── Today
├── Upcoming
├── Attention
└── History
```

### Today
One working queue, visibly separated by semantics:

```text
FORMATIVE — ACTIVE
    due formative reconstruction of evolving knowledge

RETENTION — STABLE
    due/overdue calibration or spaced repetition
```

A repeat item is logically:

```text
Knowledge ID
+ authoritative Review Scope
+ review type
+ due state
```

not merely a filename.

### Upcoming
Shows expected future review load without pretending the forecast is a commitment to learn new material.

### Attention
Surfaces conditions that need intervention, for example:
- repeated `MEMORY_GAP`;
- `KNOWLEDGE_BASE_GAP` discovered during review;
- new Questions discovered during review;
- STABLE → ACTIVE returns;
- review scopes that appear too broad;
- overdue items;
- missing retention assignment for otherwise stable reviewable knowledge.

### History
Supports diagnosis of the retention system:
- what was reviewed;
- when;
- review type;
- recall result when applicable;
- findings;
- state/interval changes.

History is not primarily a streak/gamification surface.

### What can repeat
Normal Knowledge Units and comparison Knowledge Units may have Review Scopes and participate in repetition.

A comparison Unit is especially suitable for `CONTRAST` and `TRANSFER` review modes.

`STABLE + MAP_ONLY` receives no scheduled repetition by default.

Generated views, tags, indexes, Roadmaps/Expansion Plans, and navigation pages are not repetition subjects merely because they exist.

## Questions and expansion placement
Questions belong near the place they most likely expand.

When exact placement is unclear:

```text
Area / nested Area / Concept
└── Question Inbox
```

After processing, a Question may:
- remain an Open Expansion Question near an existing Concept;
- become/refine a durable Key Question;
- motivate a new Concept/nested Area;
- resolve into updates/new Knowledge Units/comparison Units;
- be discarded/deferred.

Optional metadata such as `origin` or `likely_expands` helps preserve context, but is not required to form a strict graph.

## Workflows are not views
Do not classify these as views:

```text
Capture / Triage
Question processing
Knowledge integration
Review execution
```

They are workflows/processes. The three core views help decide or execute work, but do not own the workflows.

## Simplicity rule
Prefer:

```text
one canonical Unit
+ ordinary links
+ tags when useful
+ a comparison Unit when comparison itself is valuable
+ one of the three core views only when projection adds operational meaning
```

over parallel maps and maintenance-heavy relation/view structures.
