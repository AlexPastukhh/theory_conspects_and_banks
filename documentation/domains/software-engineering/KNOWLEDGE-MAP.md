# Software Engineering Knowledge Map

Status: current logical domain map after semantic structure review. This remains the semantic authority; CS6 now materializes a deliberately shallow physical projection under `engineering/` and `technology-core/` without encoding the full ontology depth.

## Structural rule

A practical Subarea is simply a nested `Area`; nested Areas may contain further nested Areas. Depth is evidence-driven, not fixed. A Knowledge Unit may therefore sit under one broad nested Area when no durable lower Area is justified.

```text
Software Engineering
└── Area
    ├── Concept / Knowledge Unit
    └── nested Area
        ├── Concept / Knowledge Unit
        └── nested Area (only when justified)
```

Technology Core remains an ownership exception: a Unit can be canonically technology-owned while still receiving an Engineering Area/nested-Area path for coverage, comparison, and navigation.

## Provenance and current evidence

- Seed: historical `Software Engineering Map Proposal v3` Subareas.
- First hierarchy pass: `software-engineering-semantic-hierarchy-v1.csv` (superseded as current assignment after semantic audit).
- Current machine-readable assignment: [`../../validation/software-engineering-semantic-hierarchy-v3.csv`](../../validation/software-engineering-semantic-hierarchy-v3.csv).
- Current structure audit: [`../../validation/software-engineering-subarea-structure-audit-v2.md`](../../validation/software-engineering-subarea-structure-audit-v2.md).

## Current hierarchy

Counts in parentheses are current primary Knowledge Units. `0` is meaningful: the node remains a semantic responsibility/coverage gap rather than disappearing from the map. Lower nested Areas are shown only when they are currently justified by a multi-Unit semantic cluster; a singleton Concept does not automatically become another Area.

### A01 — Programming Models & Language Semantics (95)

- **Values, Types & Contracts** (46)
  - String & Scalar Semantics (14)
  - Type Systems, Refinement & Contracts (22)
  - Values, Identity, Equality & Conversion (10)
- **Functions, Control & Interaction** (7)
  - Control, Generators & Cleanup (2)
  - Events & Callbacks (3)
  - Functions & Callables (2)
- **Collections, Iteration & Query Semantics** (31)
  - Collection Models & Operations (16)
  - Iteration & Lazy Evaluation (7)
  - Query & Sequence Semantics (8)
- **Objects, Composition & Metaprogramming** (10)
  - Reflection, Metadata & Expression Models (10)
- **Expressions & Evaluation** (0)
- **Modules & API Abstractions** (1)

### A02 — Algorithms & Data Structures (2)

- **Complexity & Correctness** (0)
- **Data Structures** (0)
- **Algorithmic Techniques** (2)
  - Sliding Window & Rolling State (2)

### A03 — Concurrency & Asynchrony (21)

- **Async Execution & Scheduling** (7)
  - Event Loops, Queues & Runtime Scheduling (2)
  - Tasks, Promises & Async Execution (5)
- **Cancellation & Time Bounds** (4)
  - Cancellation & Propagation (4)
- **Synchronization & Memory Ordering** (6)
  - Atomics, Signaling & Mutual Exclusion (4)
  - One-Time Initialization & Publication (2)
- **Work Coordination & Backpressure** (4)
  - Producer-Consumer & Channels (2)

### A04 — Runtime, Operating Systems, Memory & Resources (20)

- **Runtime & Toolchain** (1)
- **Runtime & OS Execution** (0)
- **Memory & Resource Lifecycle** (12)
  - Allocation, GC & Reachability (3)
  - Deterministic & Native Resource Ownership (4)
  - Memory Views, Layout & Pooling (5)
- **Time & Clocks** (7)
  - Civil Time, Instants & Scheduling (7)

### A05 — Data Representation, Serialization & I/O (46)

- **Data Representation** (13)
  - Binary Representation & Buffers (5)
  - Text, Unicode & Culture (8)
- **Parsing, Validation & Serialization** (17)
  - JSON Models (2)
  - Parsing & Pattern Processing (8)
  - Serialization, Schemas & Boundary Validation (7)
- **I/O & Streaming** (16)
  - Pipelines, Segmented I/O & Framing (6)
  - Streams, Buffering & Incremental I/O (10)

### A06 — Networking, Protocols & API Semantics (69)

- **Network & Transport Foundations** (9)
  - Connections, Proxies & Gateways (4)
  - Realtime & Stateful Protocols (3)
  - TLS & Secure Transport (2)
- **HTTP Semantics** (48)
  - Browser, Cookie & Authentication Boundaries (8)
  - Caching & Conditional Requests (7)
  - HTTP Client & Transport Semantics (15)
  - Representation Negotiation & Transfer (8)
  - Request, Response & Metadata (9)
- **API Contracts & Resource Semantics** (12)
  - Collection Query, Pagination & Shaping (4)
  - Resources, Errors, Discovery & Evolution (8)

### A07 — Application & Service Engineering (59)

- **Application Host & Lifecycle** (0)
- **Request Pipeline & Endpoint Execution** (33)
  - Binding, Validation & Error Handling (12)
  - Middleware, Filters & Request Context (11)
  - Routing & Endpoint Selection (10)
- **Composition & Configuration** (6)
  - Configuration & Options (5)
- **Service Concerns** (10)
  - Application Caching Integration (3)
  - Streaming & Long-Lived Connections (5)
- **Server Rendering & MVC** (10)
  - MVC Application Model & Conventions (3)
  - Razor, Views & Server-Rendered UI (7)

### A08 — Client, Browser & UI Engineering (92)

- **Browser Platform** (14)
  - Browser Networking APIs (5)
  - Storage, Navigation & Cross-Context Communication (6)
- **UI Composition & Rendering** (12)
  - Effects, Lifecycles & Subscriptions (5)
  - Rendering, Scheduling & Concurrency (3)
  - State, Context & External Stores (3)
- **Client Data & State** (42)
  - Local State Stores (6)
  - Persistence & Hydration (4)
  - Routing & Data Loading (7)
  - Server State & Cache Lifecycle (23)
  - Server State, Connectivity & Cache Updates (2)
- **Forms & Validation** (10)
  - Client Form State & Validation (10)
- **CSS & Visual Implementation** (13)
  - Layout & Responsive Geometry (6)
  - Stacking, Overflow & Scrolling (3)
  - Styling, Selectors & Component Conventions (3)
- **Accessibility & Interaction** (1)

### A09 — Data & Persistence (102)

- **Data Modeling & Integrity** (2)
  - Schemas, Keys, Constraints & Invariants (2)
- **Query Semantics & SQL** (12)
  - Relational Querying & Database-Side Logic (9)
  - Relational Querying & Shaping (3)
- **Query Performance & Indexing** (11)
  - Indexing, Query Shape & Cost (11)
- **Transactions & Concurrency** (13)
  - Transactions, Isolation & Recovery (13)
- **Data Access & ORM** (48)
  - Commands & Interception (3)
  - Context Lifetime & Configuration (3)
  - Mapping & Model Configuration (18)
  - ORM/Data-Access Model (2)
  - Query Translation & Materialization (10)
  - Tracking & Persistence Lifecycle (11)
- **Caching & Derived State** (5)
  - Freshness, Invalidation & Coordination (5)
- **Storage & Database Systems** (5)
  - Connections & Sessions (2)
- **Data Processing & Search** (3)
  - Bulk & Batch Data Movement (2)
- **Other Data Systems** (3)
  - Key-Value Stores & Command Models (3)

### A10 — Distributed Systems & Resilience (11)

- **Distributed Foundations & Scaling** (2)
  - Service Boundaries, State & Scaling (2)
- **Messaging & Delivery** (0)
- **Coordination & Consistency** (2)
  - Distributed Cache, Locks & Coordination (2)
- **Distributed Workflows & Consistency Patterns** (0)
- **Resilience & Traffic Control** (7)
  - Rate Limiting & Throttling (2)
  - Retries, Hedging & Strategy Composition (5)

### A11 — Architecture & Design (5)

- **Design Fundamentals** (2)
  - Abstraction, Encapsulation & Invariants (2)
- **Domain & Boundary Design** (2)
  - Domain Boundaries & Ownership (2)
- **Architectural Styles** (0)
- **Architecture Reasoning** (1)
- **Design Patterns** (0)

### A12 — Security & Identity (46)

- **Security Foundations** (0)
- **Identity & Access** (28)
  - Authentication, Federation & Session/Token Models (20)
  - Authorization & Access Control (3)
  - Identity Lifecycle, MFA & Recovery (5)
- **Application & Browser Security** (10)
  - Browser Trust, Injection & Abuse Boundaries (10)
- **Cryptography & Credential Protection** (5)
  - Randomness, Hashing, Keys & Tokens (5)
- **Secure Software Lifecycle** (0)
- **Security Architecture** (3)
  - Trust Boundaries & Enforcement Placement (3)

### A13 — Testing, Debugging & Quality Engineering (6)

- **Testing Strategy & Tooling** (5)
  - Framework Testing, Doubles & Assertions (4)
- **Test Design Techniques** (0)
- **Specialized Testing** (0)
- **Coverage & Quality** (0)
- **Debugging & Diagnosis** (1)
- **Reviews** (0)

### A14 — Software Lifecycle & Engineering Practice (1)

- **Requirements & Problem Definition** (0)
- **Construction & Change Practice** (0)
- **Source & Configuration Management** (0)
- **Maintenance & Evolution** (0)
- **Developer Workflow & Tooling** (1)
- **Development Process & Technical Communication** (0)
- **Engineering Economics & Decision Basics** (0)

### A15 — Observability, Operations & Delivery (1)

- **Reliability Objectives** (0)
- **Observability** (0)
- **Reliability Operations** (1)
- **Automation & Operational Configuration** (0)
- **Release Engineering & Delivery** (0)
- **Infrastructure & Platform** (0)
- **Production Operations** (0)

## Interpretation

- Broad nested Areas are durable semantic responsibilities, seeded from Map v3 and corrected against the real corpus.
- A narrower nested Area is materialized only when it represents a stable multi-Unit cluster; singleton Concepts do not force another taxonomy level.
- Empty broad nodes are retained when the domain model says the responsibility exists; they remain explicit expansion targets.
- CS6 physical representation is now materialized: Area-owned Units live under `_knowledge/engineering/<area>/<broad-nested-area>/`, while defining technology models live under `_knowledge/technology-core/<technology>/`. Area indexes link to relevant Technology Core Units instead of duplicating them.
- `CLEAR` means one primary logical path is currently selected; it does not mean the Unit has no secondary relationships or tags.
