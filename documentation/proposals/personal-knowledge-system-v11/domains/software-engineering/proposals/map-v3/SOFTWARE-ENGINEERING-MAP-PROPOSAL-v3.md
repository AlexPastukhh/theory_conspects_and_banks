# Software Engineering Knowledge Map — Proposal v3

Status: **proposal for review**, not adopted ontology.

This version performs a second audit from additional angles:

- the current repository's 19 knowledge registries / 576 Knowledge IDs;
- the existing repository coverage audit;
- SWEBOK v4.0a and ACM/IEEE-CS CS2023;
- ISO/IEC 25010:2023 product-quality characteristics;
- Google SRE material for production readiness, release engineering, SLOs, incident response, configuration and automation;
- OWASP SAMM and NIST SSDF for secure-software-development lifecycle coverage;
- CS2023 Specialized Platform Development to detect web-only bias.

These references are omission/boundary detectors, not an ontology to copy.

---

# 1. Structural changes from v2

The second audit does **not** justify another top-level Area. The 15-Area structure is retained.

It does justify four naming/boundary refinements:

1. `Programming Models & Language Concepts`
   → **Programming Models & Language Semantics**
   - keeps language-independent semantic models here;
   - moves compiler/runtime/toolchain mechanics to A04;
   - moves text encoding/representation to A05;
   - moves general clock/time runtime foundations to A04.

2. `Networking, HTTP & API Semantics`
   → **Networking, Protocols & API Semantics**
   - HTTP remains the strongest current protocol family, but not the ontology center.

3. `Backend & Service Applications`
   → **Application & Service Engineering**
   - avoids assuming all non-client software is a web backend;
   - includes services, workers, scheduled/batch applications and command-line/service-host patterns where meaningful.

4. `Frontend, Browser & UI Engineering`
   → **Client, Browser & UI Engineering**
   - browser/web remains the strongest current manifestation;
   - desktop/mobile/other client platforms are conditional manifestations rather than ontology gaps by default.

The audit also adds an explicit **Quality Attributes logical view** and clearer canonical-boundary rules for recurring concepts such as caching, configuration, performance and production diagnosis.

---

# 2. Proposed Software Engineering Areas

```text
SOFTWARE ENGINEERING

A01 Programming Models & Language Semantics
A02 Algorithms & Data Structures
A03 Concurrency & Asynchrony
A04 Runtime, Operating Systems, Memory & Resources
A05 Data Representation, Serialization & I/O
A06 Networking, Protocols & API Semantics
A07 Application & Service Engineering
A08 Client, Browser & UI Engineering
A09 Data & Persistence
A10 Distributed Systems & Resilience
A11 Architecture & Design
A12 Security & Identity
A13 Testing, Debugging & Quality Engineering
A14 Software Lifecycle & Engineering Practice
A15 Observability, Operations & Delivery
```

Technology Core remains a parallel semantic branch, governed by the already accepted canonical-ownership rule.

---

# 3. Revised Areas and Subareas

## A01 — Programming Models & Language Semantics

Purpose: transferable programming/language ideas, with technology-defining syntax/type/runtime models remaining in Technology Core when appropriate.

### Core Subareas

- Values, identity, equality and mutability
- Variables, binding, scope and lifetime
- Functions, closures and callable abstractions
- Control flow
- Type systems: static/dynamic, nominal/structural
- Type inference, narrowing and refinement
- Generics / parametric polymorphism
- Subtyping, interfaces, protocols and contracts
- Algebraic/discriminated data modeling
- Nullability / optionality / absence
- Object, prototype and composition models
- Functional programming concepts
- Immutability and state-transition modeling
- Iteration, iterators, generators and lazy evaluation
- Events, callbacks and observer-style interaction
- Error / exception / result models
- Modules, namespaces and package-level code organization
- Reflection, metadata and metaprogramming
- Language evaluation / expression semantics
- Name resolution and module/import semantics
- API / abstraction design at code level
- Cross-language concept comparison

### Important current gaps

- coherent scope/closure/prototype/module foundations for JavaScript;
- Python object/type/protocol model;
- general comparison of exception/result/error models;
- broader language-semantics comparison without duplicating runtime/toolchain material;
- cross-language conceptual mapping.

---

## A02 — Algorithms & Data Structures

### Core Subareas

- Asymptotic complexity and cost reasoning
- Arrays / sequences
- Linked structures
- Stacks / queues / deques
- Sets / maps / hash tables
- Hashing and collision concepts
- Trees / binary trees
- Balanced trees
- Heaps / priority queues
- Tries
- Graph representation
- Graph traversal
- Searching
- Sorting
- Selection / order statistics
- Recursion
- Divide and conquer
- Greedy techniques
- Dynamic programming
- Backtracking
- Sliding window / two-pointer techniques
- Prefix / cumulative techniques
- Bit manipulation / bitmasking
- String algorithms
- Randomized / probabilistic techniques
- Algorithm correctness reasoning
- Space/time trade-offs

### Current state

Dedicated evidence is very small; current `algorithms` has only two rolling-window/bitmask units. Technology collection APIs do not substitute for this Area.

---

## A03 — Concurrency & Asynchrony

### Core Subareas

- Concurrency vs parallelism
- Asynchronous execution
- Tasks / futures / promises / coroutines
- Event loops and scheduling queues
- Threads and thread pools
- Processes and workers as concurrency mechanisms
- Cancellation
- Deadlines and timeouts
- Structured concurrency
- Mutual exclusion
- Semaphores
- Condition variables / signaling
- Atomics
- Memory visibility / ordering
- Happens-before reasoning
- Race conditions
- Deadlocks
- Livelocks / starvation
- Fairness
- Thread safety / reentrancy
- Producer-consumer models
- Channels / async queues
- Bounded concurrency
- Work scheduling
- Parallel decomposition
- Fan-out / fan-in
- Backpressure
- Async streams
- Async failure aggregation / propagation
- Resource ownership across concurrent work

### Current evidence

Strong in .NET and meaningful in browser JavaScript. Node-specific event-loop/libuv behavior and Python asyncio/thread/process behavior remain major gaps.

### Added in v2

`memory visibility / ordering`, `happens-before`, `deadlock/starvation/fairness`, `deadlines/timeouts`, and `structured concurrency` were underrepresented in v1.

---

## A04 — Runtime, Operating Systems, Memory & Resources

Purpose: execution substrate below application frameworks.

### Runtime Subareas

- Runtime vs compiler vs SDK/toolchain
- Interpreter / VM / JIT / AOT concepts
- Process lifecycle
- Program startup / shutdown
- Environment variables and process environment
- Signals / termination semantics
- Native/runtime boundary
- Foreign-function / unmanaged interop
- Compilation/JIT/AOT pipeline and runtime loading
- Linking/loading/module-resolution boundaries at runtime

### Operating-system Subareas

- Processes
- Threads
- Scheduling fundamentals
- System calls
- User mode / kernel mode
- File descriptors / handles
- Filesystem APIs and paths
- Files / directories / metadata
- Permissions / ownership basics
- Pipes and local IPC
- Shared memory concepts
- Virtual memory
- Memory mapping
- Page/cache concepts at useful engineering depth
- Device/I/O abstraction at high level

### Memory / resource Subareas

- Allocation
- Stack vs heap
- Garbage collection
- Reference counting
- Reachability / roots
- Object lifetime
- Deterministic cleanup
- Finalization
- Resource ownership
- RAII/context/dispose-style models
- Native resource handles
- Pooling
- Buffer ownership
- Memory safety
- References / spans / views
- Layout / alignment
- Pinning
- Memory leaks / resource leaks
- Runtime profiling and memory diagnostics

### Time / clock foundations

- Wall-clock vs monotonic time
- Timers and timer resolution
- Instants / durations
- Local time / timezone / UTC
- DST ambiguity / invalid local time
- Scheduling against clocks
- Clock drift at single-system level

### Major gaps

Most OS/process/filesystem/system-call concepts are not coherently represented today. They are particularly important for Node/Python/server understanding.

---

## A05 — Data Representation, Serialization & I/O

### Data representation

- Bits / bytes
- Numeric binary representation at practical depth
- Endianness
- Character sets / Unicode
- UTF encodings
- Locale / collation / culture-sensitive text semantics
- Text normalization where relevant
- Binary-to-text encodings
- Structured data representation
- In-memory vs wire representation

### Parsing / serialization

- Parsing boundaries
- Serialization / deserialization
- JSON models
- Schema-driven formats
- Serialization compatibility
- Versioning/evolution of serialized data
- Forward/backward compatibility of data contracts
- Validation at representation boundaries
- Binary serialization formats
- Compression

### I/O

- Stream abstraction
- Buffered vs unbuffered I/O
- Partial reads / writes
- Framing
- Delimiters vs length-prefixing
- Incremental decoding
- Backpressure in I/O pipelines
- Seekable vs sequential access
- File I/O
- Network I/O as an I/O manifestation
- Pipes / segmented buffers
- Zero-copy / copy minimization concepts
- Browser streams
- Transform pipelines

### Gaps added in v2

- serialization compatibility/evolution;
- file I/O as an explicit subarea;
- framing strategies as a first-class model;
- zero-copy/copy-cost reasoning.

---

## A06 — Networking, Protocols & API Semantics

### Network and protocol foundations

- Layering / protocol stack
- IP addressing / ports
- Routing fundamentals
- DNS
- TCP connection model
- UDP model
- Connection establishment / teardown
- Reliability / ordering at transport layer
- Flow and congestion concepts at useful depth
- NAT at practical depth
- Sockets
- Connection pooling
- Protocol framing/state-machine concepts
- Protocol negotiation/versioning
- Keep-alive
- Proxies / reverse proxies
- Load balancers
- Gateways / middleboxes

### Secure transport

- TLS purpose/model
- Certificates / trust chain at application-developer depth
- TLS termination
- HTTPS boundaries

### HTTP

- HTTP request / response
- Methods
- Safety / idempotency
- Status codes
- Headers
- Representation metadata
- Content negotiation
- Content coding
- Cookies
- Cache freshness / validators / Vary
- Conditional requests
- Range / partial transfer where relevant
- HTTP connection/version concepts (HTTP/1.1, HTTP/2, HTTP/3) at model level

### API semantics

- Resource modeling
- REST constraints
- Creation/update/delete semantics
- Pagination
- Filtering/sorting/search contracts
- Error contracts / Problem Details
- Versioning / evolution / deprecation
- Idempotency keys
- Hypermedia / discovery
- OpenAPI / machine-readable contracts
- RPC concepts
- gRPC
- GraphQL — CONDITIONAL
- WebSocket
- SSE
- Webhooks
- Webhook delivery, signatures and retry semantics
- API compatibility/governance
- Client retries/replayability boundary

### Major gaps

TCP/DNS/socket fundamentals, coherent TLS model, gRPC, webhooks, protocol-version reasoning and API idempotency are not yet coherently represented.

---

## A07 — Application & Service Engineering

### Application / host lifecycle

- Application/process host lifecycle
- Long-running services / daemons
- Background workers
- Batch jobs
- Command-line applications where application architecture matters
- Startup / shutdown / graceful termination

### Request/application lifecycle

- Request context
- Request pipeline
- Routing / endpoint selection
- Middleware / interception
- Binding / parsing input
- Validation
- Application error handling
- Response construction
- Streaming responses
- Cancellation propagation

### Composition / configuration

- Dependency injection / dependency composition
- Lifetime/scoping
- Configuration
- Feature flags — GAP
- Secrets consumption boundary (security ownership elsewhere)
- Environment-specific behavior

### Service concerns

- API application structure
- Background/in-process work
- Scheduling recurring work
- Durable jobs boundary
- Work queues / scheduler integration boundary
- Rate limiting integration
- Application caching integration
- Health endpoint integration
- OpenAPI integration
- Localization / internationalization server concerns
- File upload/download handling
- Multi-tenancy application boundary — PARTIAL/GAP
- Server-side rendering / templating where applicable
- Application-level plugin/extension boundaries — CONDITIONAL

### Technology manifestations

- ASP.NET Core — strong
- Node backend framework — GAP
- Python backend framework — GAP

### Added in v2

Feature flags, application host lifecycle, file transfer, recurring jobs and multi-tenancy boundary.

---

## A08 — Client, Browser & UI Engineering

### Client-platform families

- Web/browser clients — current strong target
- Desktop clients — CONDITIONAL
- Mobile clients — CONDITIONAL
- Embedded/industrial UI clients — CONDITIONAL
- Platform capability / lifecycle differences

### Browser platform

- Browser execution model
- DOM
- Event propagation
- Browsing contexts
- Navigation/history
- URL model
- Browser storage
- Workers
- Cross-context communication
- File/browser APIs
- Browser networking APIs
- Browser rendering pipeline at useful depth
- Canvas/SVG/graphics/media APIs — CONDITIONAL

### Markup / accessibility

- Semantic HTML
- Forms semantics
- Accessibility tree
- Keyboard interaction
- Focus management
- ARIA
- Accessible dynamic UI
- Internationalization / localization
- Bidirectional text where relevant

### CSS / visual implementation

- Cascade / specificity / inheritance
- Box model
- Formatting/layout concepts
- Positioning
- Flexbox
- Grid
- Stacking contexts
- Overflow / scrolling
- Responsive design
- Media/container queries
- Typography basics
- Animation / motion
- Reduced-motion/accessibility implications

### Application UI

- Component models
- Rendering / rerendering
- State
- Effects / subscriptions
- Routing
- Forms / validation
- Local client state
- Server state / cache
- Optimistic UI
- Error/loading states
- Persistence / hydration
- UI architecture / design systems
- Client-side platform integration and lifecycle
- Frontend performance
- Code splitting / loading
- Offline/PWA — CONDITIONAL

### HCI/software-side concerns

- Feedback / system status
- Error prevention/recovery
- Interaction consistency
- Basic usability principles

Visual/design craft can remain in a separate Design domain; this Area owns software implementation and interaction-system concepts.

---

## A09 — Data & Persistence

### Data modeling

- Relational model
- Relational algebra at useful depth
- Entity/relationship modeling
- Keys
- Constraints
- Normalization
- Denormalization trade-offs
- Null semantics
- Referential integrity
- Data invariants
- Temporal/history models
- Soft delete / archival

### SQL / query

- Query logical processing
- Projection/filtering
- Joins
- Grouping/aggregation
- Subqueries
- Set operations
- Window functions
- CTEs
- DML
- Stored procedures / database-side logic
- Query parameterization

### Query performance

- Index structures/concepts
- Index selection
- SARGability
- Query plans
- Cardinality/selectivity
- Cost estimation concepts
- Statistics
- Query diagnosis workflow

### Transactions / consistency

- ACID
- Transaction boundaries
- Isolation levels
- Locking / MVCC
- Anomalies
- Savepoints
- Deadlocks
- Optimistic concurrency
- Version tokens
- Retry interaction

### Storage / database systems

- Database files/storage basics
- Buffer/cache concepts
- Connection/session lifecycle
- Pooling
- Replication — primary ownership A10, DB manifestation here
- Backup/restore — operations link A15
- Schema migration/evolution

### Data-access / ORM

- Data-access abstractions
- Unit of Work
- Identity map / tracking
- Query translation
- Materialization
- Mapping
- Relationships
- Change tracking
- Persistence lifecycle
- Migration tooling
- Raw SQL boundary
- Bulk operations

### Caching / derived state

- Cache-aside / read-through / write-through concepts
- Cache key design
- Expiration / freshness
- Invalidation
- Derived/materialized data
- Local vs shared cache
- Cache consistency trade-offs

General cache semantics live here.
HTTP cache behavior remains A06; client/server-state cache manifestations remain A08; distributed cache coordination remains A10.

### Data processing

- Batch data pipelines
- Stream-processing concepts
- ETL / ELT at conceptual depth
- Data validation / quality checks
- Search/indexing systems
- Data lifecycle / retention concepts

### Other data models

- Key-value
- Document
- Column-family
- Graph databases
- Search engines
- Time-series — CONDITIONAL

### Major gaps

Relational fundamentals, normalization, plan/cardinality diagnosis, storage-engine basics and non-relational comparison remain weaker than EF Core/SQL Server specifics.

---

## A10 — Distributed Systems & Resilience

### Distributed-systems foundations

- Partial failure
- Network partitions
- Latency
- Failure detection
- Clocks and time in distributed systems
- Ordering
- Logical clocks / causality at conceptual depth
- Consistency models
- Replication
- Quorums
- Leader election
- Consensus at conceptual depth
- CAP / PACELC as decision models
- Sharding / partitioning
- Rebalancing
- Service discovery
- Load balancing
- Stateless/stateful scaling

### Messaging

- Queues
- Pub/Sub
- Streams/logs
- Consumer groups
- Delivery semantics
- Duplicate delivery
- Ordering guarantees
- Poison messages / DLQ
- Backpressure
- Message schema/evolution

### Workflow / consistency patterns

- Idempotency
- Retry safety
- Outbox
- Inbox / deduplication
- Saga
- Compensating actions
- Distributed transactions
- Eventual consistency
- Event-driven integration
- Event sourcing — CONDITIONAL

### Resilience

- Timeouts
- Retries / backoff / jitter
- Circuit breakers
- Bulkheads / failure isolation
- Bulkheads
- Rate limiting
- Load shedding
- Hedging
- Single-flight
- Cache stampede
- Distributed locks / leases
- Graceful degradation
- Cascading-failure prevention
- Dependency failure budgets / isolation
- Health/failover relation

### Major gaps

This Area remains one of the biggest expansion opportunities: current evidence is fragmented and most messaging/consistency/consensus topics are absent.

---

## A11 — Architecture & Design

### Design fundamentals

- Modularity
- Cohesion
- Coupling
- Dependency direction
- Abstraction
- Encapsulation
- Information hiding
- Composition
- Separation of concerns
- Interfaces/boundaries
- Invariants
- State-transition design

### Domain/application design

- Entities / value objects
- Associations
- Aggregates
- Domain services
- Application services
- Domain events
- Repository boundary concepts
- Transaction/application boundaries

### Architectural styles

- Layered architecture
- Ports & Adapters / Hexagonal
- Clean Architecture
- Modular monolith
- Microservices
- Event-driven architecture
- Pipe/filter
- Client-server
- BFF
- CQRS
- Vertical Slice
- Serverless — CONDITIONAL

### Architecture reasoning

- Quality attributes as design drivers
- Functional suitability
- Performance efficiency
- Compatibility / interoperability
- Reliability / availability / recoverability
- Maintainability / modifiability / testability
- Flexibility / adaptability / scalability
- Interaction capability where architecture-relevant
- Safety where applicable

- Trade-off analysis
- Architecture decision records
- Evolutionary architecture
- Dependency / component diagrams
- Architecture evaluation
- Boundary discovery
- Build-vs-buy / managed-service decisions

### Design patterns

- Pattern literacy
- Creational / structural / behavioral patterns only where they improve reasoning
- Anti-patterns
- Refactoring-to-pattern trade-offs

### Added in v2

Quality attributes, ADRs, architecture evaluation, evolutionary architecture, event-driven architecture and pattern literacy.

---

## A12 — Security & Identity

### Security foundations

- Assets
- Trust boundaries
- Threats / attack surface
- Defense in depth
- Least privilege
- Secure defaults
- Input/output trust
- Security invariants

### Identity / access

- Authentication
- Authorization
- Access-control models
- Sessions
- Cookies
- Tokens
- OAuth
- OIDC
- PKCE
- JWT
- Key rotation
- MFA
- TOTP
- Passkeys/WebAuthn
- Account recovery
- Federation

### Application security

- Injection
- XSS
- CSRF
- CORS boundaries
- SSRF
- Path traversal
- File upload risks
- Command execution boundaries
- Unsafe deserialization
- Open redirects
- Request smuggling concepts where relevant
- Rate/abuse controls
- Bot/automation controls

### Browser/platform security

- Same-origin model
- CSP
- Trusted Types
- postMessage
- Cross-origin isolation
- Clickjacking / embedding
- Secure cookie behavior
- Browser storage security

### Cryptography / keys

- Hashing
- Password hashing/KDF
- MAC/HMAC
- Encryption
- Digital signatures
- Randomness
- Key generation
- Key storage
- Key rotation
- Certificates / PKI concepts
- TLS link to A06

### Secure software lifecycle

- Security requirements
- Secure design / architecture review
- Secure coding / defensive programming
- Secure build and development environment
- Security verification / testing strategy
- Vulnerability discovery / triage / remediation
- Vulnerability disclosure / response
- Software/component provenance
- Security release/update lifecycle

### Security engineering

- Threat modeling
- Security requirements
- Secrets management
- Security logging/audit
- Vulnerability management
- Dependency/supply-chain security
- SBOM / provenance
- Security testing
- Hardening
- Database security
- Privacy/compliance — CONDITIONAL

### Major gaps

Threat modeling, secrets, generic cryptography/key management, supply chain and vulnerability-management workflow.

---

## A13 — Testing, Debugging & Quality Engineering

### Testing strategy

- Testing purpose / confidence model
- Test levels
- Unit / integration / system / E2E
- Test pyramid/trophy as heuristics
- Isolation boundaries
- Test doubles
- Fixtures/test data
- Test environment strategy
- Determinism
- Flakiness

### Test design techniques

- Equivalence partitioning
- Boundary-value analysis
- State-transition testing
- Decision tables
- Combinatorial/pairwise concepts
- Error guessing
- Risk-based testing

### Specialized testing

- Async/concurrency testing
- Contract testing
- Property-based testing
- Fuzzing
- Mutation testing
- Snapshot/visual regression
- Performance/load/stress testing
- Fault-injection / chaos testing
- Reliability/recovery testing
- Compatibility/interoperability testing
- Security testing
- Database testing
- Browser/UI testing

### Coverage / quality

- Code coverage interpretation
- Branch/path coverage concepts
- Static analysis
- Linters/type checks
- Complexity/maintainability signals
- Quality gates
- Defect/root-cause analysis
- Technical debt signals

### Debugging / diagnosis

- Reproduction
- Hypothesis-driven debugging
- Logs/traces/debuggers
- Breakpoints/watch/step models
- Stack traces
- Dumps
- Profiling
- Benchmarking / microbenchmark methodology
- Performance investigation workflow
- Binary search / minimization
- Race-condition debugging
- Production-vs-local diagnosis boundaries

### Reviews

- Code review
- Design review
- Inspection/checklist techniques

### Major gaps

Nearly all general testing strategy, debugging methodology, coverage/quality and non-framework testing techniques.

---

## A14 — Software Lifecycle & Engineering Practice

Purpose: own how software changes from need → implementation → evolution. This was missing in v1.

### Requirements / problem definition

- Problem framing
- Stakeholders/users
- Functional requirements
- Nonfunctional / quality requirements
- Constraints
- Acceptance criteria
- Requirement prioritization
- Requirement conflicts
- Requirement validation
- Traceability at useful depth

### Construction practice

- Small/iterative changes
- Code organization
- Naming/readability
- Refactoring
- Technical debt
- Backward compatibility
- API evolution
- Deprecation
- Migration planning
- Feature flags as change-control technique
- Documentation
- Examples / executable documentation

### Source / configuration management

- Version-control mental model
- Commits
- Branching
- Merging
- Rebasing
- Conflict resolution
- Tags/releases
- Baselines
- Configuration items
- Change control
- Semantic/versioning concepts
- Dependency/version management
- Lockfiles

### Maintenance / evolution

- Corrective maintenance
- Adaptive maintenance
- Perfective maintenance
- Preventive maintenance
- Legacy-system change
- Safe migrations
- Compatibility
- Rollback planning
- Technical-debt management
- Obsolescence / dependency upgrades

### Developer workflow / tooling

- Development environments
- Local reproducibility
- Build-system concepts
- Package/dependency workflows
- IDE/editor/debugger role boundaries
- Automation scripts/tooling
- Monorepo/workspace concepts — CONDITIONAL

### Development process

- Iterative development
- Feedback loops
- Agile concepts without ritual memorization
- Work decomposition
- Definition of done
- Risk-driven sequencing
- Documentation/decision capture
- Team handoff/collaboration practices
- Estimation / uncertainty communication
- Technical communication / design documents
- Software licensing / open-source obligations
- Professional / ethical constraints

### Engineering economics / decision basics

- Cost of change
- Opportunity cost
- Build vs buy
- Total cost of ownership
- Technical risk
- Reversibility of decisions

### Boundary with A15

A14 owns **source/change lifecycle**.
A15 owns **running/releasing/operating systems**.

---

## A15 — Observability, Operations & Delivery

### Reliability objectives

- Service indicators / SLIs
- Service objectives / SLOs
- Error budgets
- Availability/reliability targets
- User-visible vs internal reliability signals

### Observability

- Structured logging
- Log levels / event design
- Correlation IDs
- Metrics
- Metric types
- Tracing
- Distributed tracing
- OpenTelemetry
- Context propagation
- Dashboards
- Alerting
- Symptom vs cause signals
- White-box vs black-box monitoring
- SLI / SLO / error budgets
- Observability cost/cardinality

### Health / reliability operations

- Health checks
- Liveness
- Readiness
- Dependency health
- Graceful shutdown
- Startup sequencing
- Capacity planning
- Saturation
- Load shedding operational view
- Backup / restore
- Disaster recovery
- Business continuity concepts
- Failover

### Automation / operational configuration

- Operational configuration design
- Configuration validation
- Configuration versioning
- Safe rollout / rollback
- Hermetic/reproducible configuration concepts
- Automation
- Toil identification / reduction

### Release engineering / delivery

- Build pipelines
- Artifact production
- Reproducible / hermetic builds
- Artifact identity / immutability
- Artifact promotion between environments
- CI
- CD
- Environments
- Configuration injection
- Secrets delivery
- Database migration deployment
- Release strategies
- Rolling deployment
- Blue/green
- Canary
- Rollback
- Feature rollout
- Artifact provenance
- Release readiness / production-readiness review

### Infrastructure/platform

- Containers
- Images
- Registries
- Container networking/storage basics
- Orchestration
- Kubernetes concepts — CONDITIONAL
- Infrastructure as Code
- Cloud service models
- Serverless/platform services — CONDITIONAL
- Reverse proxy/ingress operational role

### Production operations

- Incident response
- Triage
- Runbooks
- On-call concepts
- Postmortems
- Production debugging
- Change/incident correlation
- Operational ownership
- External dependency readiness / failure planning
- Cost/capacity awareness

### Major gaps

This remains the weakest high-value Area in the existing corpus.

---

# 4. Cross-cutting logical views

These should be generated from canonical knowledge rather than becoming duplicate top-level Areas.

## Quality Attributes view

Use a stable vocabulary influenced by ISO/IEC 25010:

- Functional suitability
- Performance efficiency
- Compatibility / interoperability
- Interaction capability
- Reliability
- Security
- Maintainability
- Flexibility / adaptability / scalability
- Safety when applicable

The attributes participate in:
- A14 requirements;
- A11 architecture trade-offs;
- A13 verification;
- A15 production measurement.

## Performance Engineering view

Connect:
- A04 runtime/memory profiling;
- A05 copy/I/O cost;
- A06 network latency/throughput;
- A08 client rendering/load performance;
- A09 query/index/storage performance;
- A10 distributed latency/capacity;
- A13 benchmarking/load testing;
- A15 capacity/production metrics.

Performance remains a view because a single physical `Performance` Area would duplicate most of the system.

## Reliability view

Connect A03 cancellation/timeouts, A10 resilience/distributed failure, A13 reliability testing and A15 SLO/incident/operations.

## Other cross-cutting views

- Scalability
- Maintainability / technical debt
- Compatibility / evolution
- Accessibility
- Privacy / compliance
- Cost
- Failure modes
- AI-assisted development

---
# 5. Important omissions intentionally NOT promoted to top-level Areas

## Mathematics / statistics

Important foundations, especially for algorithms, performance, security, data and ML, but likely better as a separate foundational Domain or supporting foundation rather than expanding the Software Engineering map now.

## Hardware / computer architecture

CPU/cache/assembly/hardware organization matter for systems/performance work, but can remain a future `Computer Systems` foundation unless actual corpus pressure justifies bringing it into Software Engineering.

## Specialized platforms

Desktop, mobile, embedded/industrial, games and similar constrained platforms are valid technology/platform manifestations. They should not be declared global gaps until one becomes an active target. Their shared engineering concepts still map into the existing Areas.

## AI / Machine Learning Engineering

Important but currently no corpus evidence and it has a large independent ontology. Treat as a future Area/domain when it becomes an active target rather than forcing it into this map now.

## Product / visual design

User research, visual design and product design can remain in the separate Design domain. Software-facing HCI/accessibility/interactions remain A08.

---

# 6. Highest-confidence additions / corrections from the second audit

The following were not represented clearly enough in v2:

- explicit separation of language semantics (A01) from runtime/toolchain mechanics (A04);
- wall-clock vs monotonic time and timer foundations (A04);
- protocol framing/version negotiation beyond HTTP (A06);
- non-web application forms: workers, batch, daemons, CLI application architecture (A07);
- desktop/mobile/other client platforms as conditional manifestations (A08);
- general caching / derived-state semantics with one canonical home (A09);
- batch/stream data pipelines and search/indexing systems (A09);
- bulkheads, graceful degradation and cascading-failure prevention (A10);
- explicit quality-attribute vocabulary and a generated Quality Attributes view;
- secure-development lifecycle: security requirements, secure build, vulnerability response and provenance (A12);
- chaos/recovery/compatibility testing and benchmarking methodology (A13);
- development environments, local reproducibility, package/build workflow and professional/legal constraints (A14);
- SLI/SLO/error budgets, toil/automation, operational configuration and production-readiness review (A15);
- reproducible/hermetic build and artifact-promotion concepts (A15).

The second audit did **not** find a repeated omission requiring a sixteenth Area.

---

# 7. Canonical boundary rules for high-friction concepts

| Concept | Canonical owner | Important secondary links |
|---|---|---|
| Process/thread primitive | A04 Runtime/OS | A03 when used for concurrency |
| Lock/semaphore/task coordination | A03 Concurrency | A04 technology/runtime manifestation |
| Stream/framing/encoding | A05 Data Representation & I/O | A06 when transported over network |
| HTTP/protocol semantics | A06 Networking/Protocols | A07 server integration |
| Request pipeline/middleware | A07 Application & Service | A06 HTTP context |
| General caching / derived state | A09 Data & Persistence | A06 HTTP cache; A08 UI/server-state; A10 distributed cache |
| Distributed cache coherence/locking | A10 Distributed Systems | A09 cache/data semantics |
| Application configuration consumption | A07 Application & Service | A15 operational rollout |
| Source/configuration management | A14 Lifecycle | A15 release/deploy |
| Operational configuration rollout | A15 Operations | A14 version/change management |
| Quality attribute | logical view / A11 reasoning | A14 requirement; A13 verification; A15 measurement |
| Controlled debugging/testing | A13 Testing/Debugging | A15 production incident diagnosis |
| Production incident/troubleshooting | A15 Operations | A13 debugging techniques |
| Security-specific lifecycle | A12 Security | A14/A15 process integrations |

This table is important: overlap should usually be solved with canonical ownership + links, not duplicate Units.

---

# 8. Recommendation for next iteration

The map is now broad enough to start **sample mapping**, but still not the full 576-ID migration.

Recommended next validation:

1. Map a stratified sample of ~80–120 current Knowledge IDs across all major registries.
2. Record canonical Area/Subarea, Technology Core ownership, secondary links and ambiguity.
3. Count:
   - units that fit cleanly;
   - units needing split/review-scope changes;
   - units with ambiguous ownership;
   - important Subareas with zero evidence.
4. Only if ambiguity is low enough, generate the complete 576-ID semantic map.

The remaining design questions are now mostly boundary questions rather than completeness questions:

- Is A07 `Application & Service Engineering` the right home for CLI/batch/worker application patterns?
- Does A08 need any non-web client knowledge in the near-term target, or only conditional placeholders?
- Is A09 the right canonical home for general caching/derived state?
- Should time/clock foundations stay in A04, with distributed clocks in A10?
- Are Quality Attributes sufficiently represented as a logical view rather than a top-level Area?
- Does A14 contain too much professional/process material for the intended personal knowledge system, or is that breadth useful?

