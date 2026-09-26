# Software Engineering Responsibility Catalog

Status: current responsibility-first coverage checklist. It complements the logical Area/nested-Area map; it is not a second ontology and does not require one Area node per responsibility.

## Purpose

The hierarchy answers **where knowledge belongs**. This catalog answers **what the domain is expected to explain even when no Knowledge Unit exists yet**. Missing responsibilities therefore remain visible instead of disappearing with the current corpus.

Coverage states are conservative: `PARTIAL` means some durable evidence exists; `MISSING` means no current evidence is sufficient for the stated generic responsibility. This pass intentionally asserts no `COVERED` responsibilities yet.

Machine-readable projection: [`../../../_ai-conspects/_planning/RESPONSIBILITY_COVERAGE.csv`](../../../_ai-conspects/_planning/RESPONSIBILITY_COVERAGE.csv).

Cross-runtime manifestation projection: [`../../../_ai-conspects/_planning/MANIFESTATION_COVERAGE.csv`](../../../_ai-conspects/_planning/MANIFESTATION_COVERAGE.csv).

## Responsibility-first rule

```text
Area / nested Area
└── durable responsibility
    ├── generic model
    └── relevant technology manifestations
```

A technology manifestation may reveal a missing generic responsibility, and a responsibility discovered in one technology must be checked symmetrically against other relevant technologies. `NO_USEFUL_DIRECT_EQUIVALENT` remains a valid result; the matrix is not a demand for one-to-one framework analogues.

## Summary

| Area | Responsibilities | PARTIAL | MISSING |
|---|---:|---:|---:|
| `A01` — Programming Models & Language Semantics | 15 | 10 | 5 |
| `A02` — Algorithms & Data Structures | 10 | 1 | 9 |
| `A03` — Concurrency & Asynchrony | 13 | 12 | 1 |
| `A04` — Runtime, Operating Systems, Memory & Resources | 13 | 7 | 6 |
| `A05` — Data Representation, Serialization & I/O | 11 | 8 | 3 |
| `A06` — Networking, Protocols & API Semantics | 14 | 10 | 4 |
| `A07` — Application & Service Engineering | 11 | 8 | 3 |
| `A08` — Client, Browser & UI Engineering | 13 | 12 | 1 |
| `A09` — Data & Persistence | 13 | 13 | 0 |
| `A10` — Distributed Systems & Resilience | 11 | 5 | 6 |
| `A11` — Architecture & Design | 9 | 3 | 6 |
| `A12` — Security & Identity | 12 | 8 | 4 |
| `A13` — Testing, Debugging & Quality Engineering | 12 | 2 | 10 |
| `A14` — Software Lifecycle & Engineering Practice | 11 | 1 | 10 |
| `A15` — Observability, Operations & Delivery | 15 | 1 | 14 |

## Checklist

### A01 — Programming Models & Language Semantics

- `PARTIAL` **Values, identity, equality, mutability and conversion** — `Values, Types & Contracts` — evidence: 28
- `MISSING` **Variables, binding, scope and lifetime** — `Values, Types & Contracts`
- `PARTIAL` **Functions, closures and callable abstractions** — `Functions, Control & Interaction` — evidence: 8
- `PARTIAL` **Control flow, generators and cleanup semantics** — `Functions, Control & Interaction` — evidence: 3
- `PARTIAL` **Type systems, inference, narrowing, generics and contracts** — `Values, Types & Contracts` — evidence: 54
- `PARTIAL` **Nullability, optionality and absence models** — `Values, Types & Contracts` — evidence: 1
- `PARTIAL` **Object, prototype and composition models** — `Objects, Composition & Metaprogramming` — evidence: 16
- `PARTIAL` **Collections, iteration, lazy evaluation and sequence semantics** — `Collections, Iteration & Query Semantics` — evidence: 34
- `PARTIAL` **Events, callbacks and observer-style interaction** — `Functions, Control & Interaction` — evidence: 5
- `MISSING` **Error, exception and result-value models** — `Errors & Failure Semantics`
- `MISSING` **Modules, namespaces, imports and name resolution** — `Modules & API Abstractions`
- `PARTIAL` **Reflection, metadata and metaprogramming** — `Objects, Composition & Metaprogramming` — evidence: 10
- `MISSING` **Expression and evaluation semantics** — `Expressions & Evaluation`
- `PARTIAL` **API and abstraction design at code level** — `Modules & API Abstractions` — evidence: 1
- `MISSING` **Cross-language conceptual comparison** — `Cross-Language Semantics`

### A02 — Algorithms & Data Structures

- `MISSING` **Asymptotic complexity and cost reasoning** — `Complexity & Correctness`
- `MISSING` **Linear, hash-based and queue/deque data structures** — `Data Structures`
- `MISSING` **Trees, heaps, tries and priority structures** — `Data Structures`
- `MISSING` **Graph representation and traversal** — `Data Structures`
- `MISSING` **Searching, sorting and selection** — `Algorithmic Techniques`
- `MISSING` **Recursion and divide-and-conquer** — `Algorithmic Techniques`
- `MISSING` **Greedy, dynamic-programming and backtracking techniques** — `Algorithmic Techniques`
- `PARTIAL` **Sliding-window, prefix, bit and string techniques** — `Algorithmic Techniques` — evidence: 2
- `MISSING` **Randomized and probabilistic techniques** — `Algorithmic Techniques`
- `MISSING` **Algorithm correctness and space/time trade-offs** — `Complexity & Correctness`

### A03 — Concurrency & Asynchrony

- `PARTIAL` **Concurrency versus parallelism and execution ownership** — `Concurrency Foundations` — evidence: 4
- `PARTIAL` **Async execution and tasks/futures/promises/coroutines** — `Async Execution & Scheduling` — evidence: 11
- `PARTIAL` **Event loops, scheduling queues and work scheduling** — `Async Execution & Scheduling` — evidence: 2
- `PARTIAL` **Threads, thread pools, processes and workers** — `Threads, Processes & Parallelism` — evidence: 3
- `PARTIAL` **Cancellation, deadlines and timeouts** — `Cancellation & Time Bounds` — evidence: 4
- `PARTIAL` **Structured concurrency and async failure propagation** — `Structured Concurrency & Failure` — evidence: 1
- `PARTIAL` **Mutual exclusion, semaphores and signaling** — `Synchronization & Memory Ordering` — evidence: 6
- `PARTIAL` **Atomics, memory visibility, ordering and happens-before** — `Synchronization & Memory Ordering` — evidence: 7
- `MISSING` **Race conditions, deadlocks, starvation and fairness** — `Synchronization & Memory Ordering`
- `PARTIAL` **Producer-consumer, channels and async queues** — `Work Coordination & Backpressure` — evidence: 2
- `PARTIAL` **Bounded concurrency and backpressure** — `Work Coordination & Backpressure` — evidence: 5
- `PARTIAL` **Parallel decomposition, fan-out and fan-in** — `Threads, Processes & Parallelism` — evidence: 1
- `PARTIAL` **Resource ownership across concurrent work** — `Structured Concurrency & Failure` — evidence: 2

### A04 — Runtime, Operating Systems, Memory & Resources

- `PARTIAL` **Runtime, compiler, interpreter, VM, SDK, JIT and AOT model** — `Runtime & Toolchain` — evidence: 2
- `MISSING` **Process lifecycle, startup/shutdown, environment and signals** — `Runtime & OS Execution`
- `MISSING` **OS processes, threads, scheduling and system calls** — `Runtime & OS Execution`
- `MISSING` **Filesystem, paths, handles/descriptors and permissions** — `Runtime & OS Execution`
- `MISSING` **Local IPC, pipes and shared memory** — `Runtime & OS Execution`
- `MISSING` **Virtual memory, memory mapping and page/cache concepts** — `Runtime & OS Execution`
- `PARTIAL` **Allocation, stack/heap, GC, reference counting and reachability** — `Memory & Resource Lifecycle` — evidence: 4
- `PARTIAL` **Deterministic cleanup, finalization and resource ownership** — `Memory & Resource Lifecycle` — evidence: 4
- `PARTIAL` **Memory safety, references/views, layout, alignment and pinning** — `Memory & Resource Lifecycle` — evidence: 12
- `PARTIAL` **Pooling and buffer ownership** — `Memory & Resource Lifecycle` — evidence: 5
- `PARTIAL` **Native/runtime boundary and FFI/unmanaged interop** — `Runtime & OS Execution` — evidence: 6
- `PARTIAL` **Wall/monotonic clocks, timers, instants, zones and scheduling** — `Time & Clocks` — evidence: 7
- `MISSING` **Runtime profiling and memory diagnostics** — `Memory & Resource Lifecycle`

### A05 — Data Representation, Serialization & I/O

- `PARTIAL` **Bits, bytes, numeric binary representation and endianness** — `Data Representation` — evidence: 15
- `PARTIAL` **Unicode, encodings, culture, collation and normalization** — `Data Representation` — evidence: 16
- `PARTIAL` **Structured data and in-memory versus wire representation** — `Data Representation` — evidence: 36
- `PARTIAL` **Parsing boundaries and boundary validation** — `Parsing, Validation & Serialization` — evidence: 21
- `PARTIAL` **JSON and schema-driven data models** — `Parsing, Validation & Serialization` — evidence: 9
- `MISSING` **Serialization compatibility, versioning and evolution** — `Parsing, Validation & Serialization`
- `MISSING` **Binary serialization and compression** — `Parsing, Validation & Serialization`
- `PARTIAL` **Streams, buffering and partial reads/writes** — `I/O & Streaming` — evidence: 18
- `PARTIAL` **Framing, delimiters, length-prefixing and incremental decoding** — `I/O & Streaming` — evidence: 18
- `MISSING` **File I/O and seekable versus sequential access** — `I/O & Streaming`
- `PARTIAL` **Pipelines, backpressure and copy-minimization/zero-copy** — `I/O & Streaming` — evidence: 7

### A06 — Networking, Protocols & API Semantics

- `MISSING` **IP addressing, ports, routing and DNS** — `Network & Transport Foundations`
- `MISSING` **TCP/UDP connection, ordering, reliability and teardown** — `Network & Transport Foundations`
- `PARTIAL` **Sockets and connection pooling** — `Network & Transport Foundations` — evidence: 5
- `PARTIAL` **NAT, proxies, load balancers, gateways and middleboxes** — `Network & Transport Foundations` — evidence: 10
- `PARTIAL` **TLS, certificates, trust chain and termination** — `Network & Transport Foundations` — evidence: 2
- `PARTIAL` **HTTP requests, methods, status codes and headers** — `HTTP Semantics` — evidence: 57
- `PARTIAL` **Representation metadata, negotiation and content coding** — `HTTP Semantics` — evidence: 17
- `PARTIAL` **Cookies, caching, validators, ranges and HTTP version model** — `HTTP Semantics` — evidence: 15
- `PARTIAL` **Resources, REST semantics, CRUD and idempotency** — `API Contracts & Resource Semantics` — evidence: 16
- `PARTIAL` **Pagination, filtering, sorting and search contracts** — `API Contracts & Resource Semantics` — evidence: 4
- `PARTIAL` **Error contracts, versioning, deprecation and discovery** — `API Contracts & Resource Semantics` — evidence: 8
- `MISSING` **Machine-readable contracts, RPC and gRPC** — `API Contracts & Resource Semantics`
- `PARTIAL` **Realtime protocols: WebSocket and SSE** — `Network & Transport Foundations` — evidence: 4
- `MISSING` **Webhooks, signatures, delivery and retry semantics** — `API Contracts & Resource Semantics`

### A07 — Application & Service Engineering

- `MISSING` **Application/process host lifecycle, startup and graceful shutdown** — `Application Host & Lifecycle`
- `MISSING` **Long-running services, workers, batch and command applications** — `Application Host & Lifecycle`
- `PARTIAL` **Request context, middleware/interception and pipeline** — `Request Pipeline & Endpoint Execution` — evidence: 13
- `PARTIAL` **Routing, binding, validation, error handling and response construction** — `Request Pipeline & Endpoint Execution` — evidence: 29
- `PARTIAL` **Streaming responses and cancellation propagation** — `Service Concerns` — evidence: 5
- `PARTIAL` **Dependency composition, DI and lifetime/scoping** — `Composition & Configuration` — evidence: 4
- `PARTIAL` **Configuration, feature flags and environment-specific behavior** — `Composition & Configuration` — evidence: 6
- `MISSING` **Recurring work, durable jobs and scheduler/queue integration** — `Service Concerns`
- `PARTIAL` **Rate-limit, cache, health and OpenAPI application integration** — `Service Concerns` — evidence: 3
- `PARTIAL` **Localization, file transfer, multi-tenancy and plugin boundaries** — `Service Concerns` — evidence: 1
- `PARTIAL` **Server rendering, MVC and templating** — `Server Rendering & MVC` — evidence: 18

### A08 — Client, Browser & UI Engineering

- `PARTIAL` **Browser execution model, DOM, events and browsing contexts** — `Browser Platform` — evidence: 1
- `PARTIAL` **Navigation, URL, storage, workers and cross-context communication** — `Browser Platform` — evidence: 10
- `PARTIAL` **Browser networking, file/platform APIs and rendering pipeline** — `Browser Platform` — evidence: 10
- `PARTIAL` **Semantic HTML, forms, accessibility tree, keyboard, focus and ARIA** — `Markup, Accessibility & Interaction` — evidence: 2
- `PARTIAL` **CSS cascade, box model, layout, positioning, flex and grid** — `CSS & Visual Implementation` — evidence: 26
- `PARTIAL` **Stacking, overflow, responsive design, typography and motion** — `CSS & Visual Implementation` — evidence: 10
- `PARTIAL` **Component models, rendering, state, effects and subscriptions** — `UI Composition & Rendering` — evidence: 72
- `PARTIAL` **Routing, forms and data loading** — `Client Data & State` — evidence: 37
- `PARTIAL` **Local/server state, cache and invalidation** — `Client Data & State` — evidence: 34
- `PARTIAL` **Optimistic UI and error/loading state** — `Client Data & State` — evidence: 11
- `PARTIAL` **Persistence, hydration and offline behavior** — `Client Data & State` — evidence: 5
- `PARTIAL` **Frontend performance, code splitting and loading** — `UI Composition & Rendering` — evidence: 3
- `MISSING` **Feedback, error recovery, interaction consistency and usability** — `Markup, Accessibility & Interaction`

### A09 — Data & Persistence

- `PARTIAL` **Relational model, entities, keys and relationships** — `Data Modeling & Integrity` — evidence: 30
- `PARTIAL` **Normalization, constraints, null semantics, invariants and history models** — `Data Modeling & Integrity` — evidence: 3
- `PARTIAL` **SQL logical processing, joins, grouping, windows, CTEs and DML** — `Query Semantics & SQL` — evidence: 8
- `PARTIAL` **Indexes, SARGability, plans, cardinality, statistics and diagnosis** — `Query Performance & Indexing` — evidence: 27
- `PARTIAL` **Transactions, isolation, locking/MVCC, anomalies and recovery** — `Transactions & Concurrency` — evidence: 13
- `PARTIAL` **Database storage/files, buffer/cache and connection/session lifecycle** — `Storage & Database Systems` — evidence: 5
- `PARTIAL` **Schema migration and evolution** — `Storage & Database Systems` — evidence: 4
- `PARTIAL` **ORM/data-access abstractions, mapping and relationships** — `Data Access & ORM` — evidence: 76
- `PARTIAL` **Unit of Work, identity/tracking and persistence lifecycle** — `Data Access & ORM` — evidence: 12
- `PARTIAL` **Query translation, materialization, raw SQL and bulk operations** — `Data Access & ORM` — evidence: 18
- `PARTIAL` **Caching, freshness, invalidation and derived/materialized state** — `Caching & Derived State` — evidence: 6
- `PARTIAL` **Batch/stream data processing, ETL, search and data-quality checks** — `Data Processing & Search` — evidence: 8
- `PARTIAL` **Non-relational data models: key-value, document, graph and time-series** — `Other Data Systems` — evidence: 3

### A10 — Distributed Systems & Resilience

- `MISSING` **Partial failure, partitions, latency and failure detection** — `Distributed Foundations & Scaling`
- `MISSING` **Distributed time, ordering and causality** — `Distributed Foundations & Scaling`
- `PARTIAL` **Consistency models, replication, quorum, leader election and consensus** — `Coordination & Consistency` — evidence: 2
- `PARTIAL` **Sharding, rebalancing, service discovery and stateful/stateless scaling** — `Distributed Foundations & Scaling` — evidence: 2
- `MISSING` **Queues, pub/sub, streams/logs and consumer groups** — `Messaging & Delivery`
- `MISSING` **Delivery semantics, duplicates, ordering, DLQ and message evolution** — `Messaging & Delivery`
- `MISSING` **Idempotency, outbox, inbox and deduplication** — `Distributed Workflows & Consistency Patterns`
- `MISSING` **Saga, compensation, distributed transactions and eventual consistency** — `Distributed Workflows & Consistency Patterns`
- `PARTIAL` **Timeouts, retries, backoff, circuit breakers and bulkheads** — `Resilience & Traffic Control` — evidence: 6
- `PARTIAL` **Rate limiting, load shedding, hedging, single-flight and stampede prevention** — `Resilience & Traffic Control` — evidence: 8
- `PARTIAL` **Distributed locks/leases, failover and graceful degradation** — `Coordination & Consistency` — evidence: 1

### A11 — Architecture & Design

- `MISSING` **Modularity, cohesion, coupling and dependency direction** — `Design Fundamentals`
- `PARTIAL` **Abstraction, encapsulation, composition and invariants** — `Design Fundamentals` — evidence: 2
- `PARTIAL` **Domain entities, values, aggregates, services, events and repository boundaries** — `Domain & Boundary Design` — evidence: 2
- `MISSING` **Layered, hexagonal/ports-adapters, clean and modular-monolith styles** — `Architectural Styles`
- `MISSING` **Microservices, event-driven, CQRS, vertical slice and serverless styles** — `Architectural Styles`
- `MISSING` **Quality attributes and architecture trade-off analysis** — `Architecture Reasoning`
- `MISSING` **ADRs, evaluation, evolutionary architecture and architecture diagrams** — `Architecture Reasoning`
- `PARTIAL` **Boundary discovery and build-vs-buy/managed-service decisions** — `Architecture Reasoning` — evidence: 2
- `MISSING` **Patterns, anti-patterns and refactoring-to-pattern trade-offs** — `Design Patterns`

### A12 — Security & Identity

- `PARTIAL` **Assets, trust boundaries, threats and attack surface** — `Security Foundations` — evidence: 1
- `MISSING` **Least privilege, secure defaults and security invariants** — `Security Foundations`
- `PARTIAL` **Authentication, sessions, tokens and federation** — `Identity & Access` — evidence: 30
- `PARTIAL` **Authorization and access-control models** — `Identity & Access` — evidence: 7
- `PARTIAL` **MFA, passkeys and account recovery** — `Identity & Access` — evidence: 6
- `PARTIAL` **Injection, XSS, CSRF, SSRF, path/file and deserialization risks** — `Application & Browser Security` — evidence: 10
- `PARTIAL` **Same-origin/CORS, CSP, Trusted Types, clickjacking and browser storage security** — `Application & Browser Security` — evidence: 2
- `PARTIAL` **Hashing/KDF, MAC, encryption, signatures and randomness** — `Cryptography & Credential Protection` — evidence: 5
- `PARTIAL` **Keys, certificates, storage and rotation** — `Cryptography & Credential Protection` — evidence: 1
- `MISSING` **Threat modeling and security requirements** — `Security Architecture`
- `MISSING` **Secure design/coding/build, verification, remediation and security update lifecycle** — `Secure Software Lifecycle`
- `MISSING` **Secrets, security logging/audit, supply-chain/SBOM and hardening** — `Security Architecture`

### A13 — Testing, Debugging & Quality Engineering

- `MISSING` **Testing purpose, confidence model, levels and strategy** — `Testing Strategy & Tooling`
- `PARTIAL` **Isolation, doubles, fixtures, data and environment strategy** — `Testing Strategy & Tooling` — evidence: 5
- `MISSING` **Determinism and flakiness control** — `Testing Strategy & Tooling`
- `MISSING` **Boundary, equivalence, state, decision-table, pairwise and risk-based techniques** — `Test Design Techniques`
- `MISSING` **Contract, property-based, fuzzing and mutation testing** — `Specialized Testing`
- `MISSING` **Concurrency, database, browser/UI and security testing** — `Specialized Testing`
- `MISSING` **Performance/load/stress, chaos and recovery testing** — `Specialized Testing`
- `MISSING` **Coverage interpretation, static analysis, quality gates and maintainability signals** — `Coverage & Quality`
- `PARTIAL` **Reproduction, hypotheses, debugger, traces, stack traces and dumps** — `Debugging & Diagnosis` — evidence: 1
- `MISSING` **Profiling, benchmarking and performance investigation** — `Debugging & Diagnosis`
- `MISSING` **Race-condition and production/local diagnosis boundaries** — `Debugging & Diagnosis`
- `MISSING` **Code review, design review and inspection/checklist techniques** — `Reviews`

### A14 — Software Lifecycle & Engineering Practice

- `MISSING` **Problem framing, stakeholders, functional/nonfunctional requirements and constraints** — `Requirements & Problem Definition`
- `MISSING` **Readable construction, refactoring, documentation and small iterative change** — `Construction & Change Practice`
- `MISSING` **Technical debt, compatibility, API evolution, deprecation, migration and feature flags** — `Construction & Change Practice`
- `MISSING` **Version control, commits, branching, merging, rebasing and conflicts** — `Source & Configuration Management`
- `MISSING` **Configuration items, releases/versioning, dependencies and lockfiles** — `Source & Configuration Management`
- `MISSING` **Maintenance modes, legacy change, upgrades, rollback and obsolescence** — `Maintenance & Evolution`
- `PARTIAL` **Dev environments, reproducibility, build/package/workspace and automation tooling** — `Developer Workflow & Tooling` — evidence: 1
- `MISSING` **Iterative process, work decomposition, definition of done and risk sequencing** — `Development Process & Technical Communication`
- `MISSING` **Decision capture, handoffs, estimation and technical communication** — `Development Process & Technical Communication`
- `MISSING` **Licensing, open-source obligations and professional/ethical constraints** — `Development Process & Technical Communication`
- `MISSING` **Cost of change, opportunity cost, build-vs-buy, TCO, risk and reversibility** — `Engineering Economics & Decision Basics`

### A15 — Observability, Operations & Delivery

- `MISSING` **SLIs, SLOs, error budgets and reliability targets** — `Reliability Objectives`
- `MISSING` **Structured logging and event design** — `Observability`
- `MISSING` **Metrics, metric types and cardinality** — `Observability`
- `MISSING` **Tracing, context propagation and OpenTelemetry** — `Observability`
- `MISSING` **Dashboards, alerting and white/black-box monitoring** — `Observability`
- `MISSING` **Health, liveness/readiness, startup sequencing and graceful shutdown** — `Reliability Operations`
- `PARTIAL` **Capacity, saturation and operational load shedding** — `Reliability Operations` — evidence: 1
- `MISSING` **Backup/restore, disaster recovery and failover** — `Reliability Operations`
- `MISSING` **Operational configuration, validation/versioning, automation and toil reduction** — `Automation & Operational Configuration`
- `MISSING` **Build pipelines, artifacts and reproducible/hermetic builds** — `Release Engineering & Delivery`
- `MISSING` **CI/CD, environments, config/secrets injection and database migration deployment** — `Release Engineering & Delivery`
- `MISSING` **Release strategies, rollback, provenance and production-readiness review** — `Release Engineering & Delivery`
- `MISSING` **Containers, images, registries, orchestration, IaC and cloud/platform models** — `Infrastructure & Platform`
- `MISSING` **Incident response, runbooks, on-call, postmortems and production debugging** — `Production Operations`
- `MISSING` **Operational ownership, cost/capacity and external-dependency readiness** — `Production Operations`

