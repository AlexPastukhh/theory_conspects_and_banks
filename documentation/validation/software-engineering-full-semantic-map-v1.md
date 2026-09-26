# Software Engineering — full semantic map v1

Status: CS3 migration/validation evidence. This is the complete 576-ID working semantic map used for staged migration; it does not by itself make Map v3 a final ontology, finalize Technology Core ownership, or change physical Knowledge Unit paths.

Date: 2026-09-25

Machine-readable map: [`software-engineering-full-semantic-map-v1.csv`](software-engineering-full-semantic-map-v1.csv).

Review/boundary worklist: [`review-scope-and-boundary-worklist-v1.csv`](review-scope-and-boundary-worklist-v1.csv).

## Purpose

CS3 maps every current Knowledge ID to one provisional primary Software Engineering home and records ownership kind, candidate tags, placement confidence, and Review Scope readiness. It is a semantic migration map, not a file-move manifest.

The 102 CS2 pilot rows are preserved as reviewed overrides. The remaining corpus was classified using the pilot rules, topic/title semantics, explicit semantic sanity overrides for clear false-positive cases, and a conservative boundary rule: uncertain cases remain in the worklist instead of being forced to `CLEAR`.

## Corpus invariants

- current Knowledge IDs: **576**;
- mapped Knowledge IDs: **576**;
- duplicate Knowledge IDs in the map: **0**;
- current topics represented: **19 / 19**;
- Knowledge Unit files moved: **0**;
- Knowledge Unit bodies edited: **0**;
- `REPETITION_STATE.csv` changed: **no**.

Every row has exactly one `proposed_area`. `BOUNDARY_REVIEW` and `UNIT_BOUNDARY_REVIEW` mean the primary home is provisional and the row remains explicit work; they do not create duplicate canonical ownership.

## Area distribution

| Area | Working primary homes |
|---|---:|
| `A01` — Programming Models & Language Semantics | 119 |
| `A02` — Algorithms & Data Structures | 2 |
| `A03` — Concurrency & Asynchrony | 20 |
| `A04` — Runtime, Operating Systems, Memory & Resources | 19 |
| `A05` — Data Representation, Serialization & I/O | 40 |
| `A06` — Networking, Protocols & API Semantics | 68 |
| `A07` — Application & Service Engineering | 54 |
| `A08` — Client, Browser & UI Engineering | 84 |
| `A09` — Data & Persistence | 104 |
| `A10` — Distributed Systems & Resilience | 10 |
| `A11` — Architecture & Design | 5 |
| `A12` — Security & Identity | 45 |
| `A13` — Testing, Debugging & Quality Engineering | 5 |
| `A14` — Software Lifecycle & Engineering Practice | 0 |
| `A15` — Observability, Operations & Delivery | 1 |

`A14` has no current primary homes in this corpus. This is treated as an existing-corpus coverage gap, not as evidence that A14 is invalid. A15 also remains lightly represented.

## Ownership result

- broader Area / Concept ownership: **257**;
- Technology Core candidate: **314**;
- owner kind remains ambiguous pending Unit-boundary repair: **5**.

Technology Core remains a candidate classification in this migration map. It is intentionally common because the corpus is technology-heavy; the broader Area still owns the engineering Concept and must not duplicate a technology-defining explanation.

## Placement result

- `CLEAR`: **542**;
- `BOUNDARY_REVIEW`: **30**;
- `UNIT_BOUNDARY_REVIEW`: **4**.

The full pass did not discover a recurring subject that requires a sixteenth top-level Area. The main ambiguities remain the same families found in CS2: technology-defining semantics versus broader Concept ownership, representation/runtime, networking/security, caching/distributed coordination, and heterogeneous Units.

### Unit-boundary review cases

- `dotnet.timezone-conversion-json-and-model-binding` → provisional `A04 / Time / timezone foundations`; current Unit crosses material boundaries and must be reviewed before final canonical adoption.
- `dotnet.xor-semantics-and-collection-equality` → provisional `A01 / Operators / equality`; current Unit crosses material boundaries and must be reviewed before final canonical adoption.
- `javascript.binary-storage-arraybuffer-typedarrays-and-blob` → provisional `A05 / Binary representation / buffers`; current Unit crosses material boundaries and must be reviewed before final canonical adoption.
- `react.transitions-suspense-and-query-cancellation` → provisional `A08 / React concurrent UI / Suspense`; current Unit crosses material boundaries and must be reviewed before final canonical adoption.

### Boundary-review cases

- `architecture.bff-token-storage-and-refresh-lifecycle` → provisional `A12 / Token/session architecture`; alternatives/links: `A11`.
- `architecture.client-state-persistence-snapshot-lifecycle` → provisional `A08 / Client state persistence / hydration`; alternatives/links: `A09;A11`.
- `architecture.reverse-proxy-edge-tls-isolation-and-offload` → provisional `A06 / Reverse proxy / TLS edge`; alternatives/links: `A12;A11`.
- `aspnet-core.di-scope-lifetime-and-disposal` → provisional `A07 / DI scope / application resource lifecycle`; alternatives/links: `A04`.
- `aspnet-core.distributed-cache-storage-and-invalidation` → provisional `A09 / Caching / derived state`.
- `aspnet-core.forwarded-headers-and-client-ip-trust` → provisional `A12 / Trust boundaries / proxy identity`.
- `aspnet-core.razor-presentation-security-boundary` → provisional `A12 / Presentation / security enforcement boundary`; alternatives/links: `A08;A07`.
- `axios.files-and-query-serialization` → provisional `A06 / API / routing semantics`; alternatives/links: `A05`.
- `axios.payload-transforms-and-interceptor-boundaries` → provisional `A06 / HTTP client transforms / interceptor boundary`; alternatives/links: `A05`.
- `css.animation-keyframes-and-motion` → provisional `A08 / CSS animation / motion`.
- `css.mobile-viewport-height-units` → provisional `A08 / Responsive layout / viewport units`.
- `css.stacking-context-hierarchy-and-clipping` → provisional `A08 / Stacking contexts / clipping`.
- `dotnet.hybridcache-multi-instance-l1-l2-coherence` → provisional `A10 / Distributed cache coherence`; alternatives/links: `A09`.
- `dotnet.hybridcache-registration-getorcreate-and-single-flight` → provisional `A09 / Caching / single-flight coordination`; alternatives/links: `A10;A03`.
- `dotnet.polly-rate-limiter-strategies-and-partitions` → provisional `A10 / Resilience / rate limiting`; alternatives/links: `A03`.
- `dotnet.regex-reuse-compilation-and-timeouts` → provisional `A05 / Parsing / text processing`.
- `dotnet.streaming-byte-object-and-memory-models` → provisional `A05 / Streams / buffers / representation`.
- `dotnet.string-replacement` → provisional `A05 / Text processing`.
- `dotnet.ticks-unix-time-and-javascript-display` → provisional `A04 / Time / clock representation`; alternatives/links: `A05;A08`.
- `ef-core.aggregate-version-etag-propagation` → provisional `A09 / Optimistic concurrency / version tokens`.
- `javascript.browser-storage-lifetimes-and-security` → provisional `A08 / Browser storage lifecycle`; alternatives/links: `A12`.
- `react-query.cache-http-and-browser-boundaries` → provisional `A08 / Server-state cache boundaries`.
- `react-query.websocket-event-driven-cache-updates` → provisional `A08 / Event-driven server-state cache updates`.
- `redis.expiring-counters-portability-and-distributed-throttling` → provisional `A10 / Distributed throttling / counters`; alternatives/links: `A09`.
- `sql-server.logins-users-roles-and-permissions` → provisional `A12 / Database identity / authorization`; alternatives/links: `A09`.
- `sql-server.mars-reader-interleaving-and-yield-points` → provisional `A09 / Connection/session lifecycle`.
- `typescript.zod-discriminated-union-validation` → provisional `A05 / Schema validation / representation boundary`; alternatives/links: `A01`.
- `typescript.zod-form-input-coercion-and-transforms` → provisional `A05 / Schema validation / representation boundary`; alternatives/links: `A01`.
- `typescript.zod-refinements-and-cross-field-errors` → provisional `A05 / Schema validation / representation boundary`; alternatives/links: `A01`.
- `typescript.zod-schema-validation-and-inference` → provisional `A05 / Schema validation / representation boundary`.

## Review Scope readiness

- `REVIEW_SCOPE_EXPLICIT`: **406**;
- `REVIEW_SCOPE_DERIVATION_REQUIRED`: **161**;
- `REVIEW_SCOPE_REPAIR_REQUIRED`: **6**;
- `UNIT_BOUNDARY_REVIEW_REQUIRED`: **3**.

Therefore **170 / 576** current Units still need Review Scope work before repetition cutover. This is an explicit migration disposition, not an inferred `ACTIVE` state and not a recall assessment.

`REVIEW_SCOPE_DERIVATION_REQUIRED` means the existing Unit appears semantically coherent enough to derive a review contract later, but the contract is not yet authoritative. `REVIEW_SCOPE_REPAIR_REQUIRED` means the semantic boundary/placement requires clarification while deriving it. `UNIT_BOUNDARY_REVIEW_REQUIRED` means the Unit itself likely needs split/restructure or a deliberately narrowed scope.

## Candidate tags

The CSV records lightweight candidate tags from the accepted model (technology + cross-cutting topics). These tags are migration aids, **not a final controlled vocabulary**. Canonical ownership is never inferred from a tag.

## CS3 gate

**PASS FOR CS4 WITH EXPLICIT WORKLIST.**

The gate passes because:

1. all 576 IDs have one provisional primary home;
2. no duplicate Knowledge ID or duplicate primary-home row exists;
3. ambiguous ownership is explicit instead of hidden;
4. every Unit has either an explicit Review Scope or an explicit Review Scope work disposition;
5. no physical file move or repetition-state reinterpretation occurred.

This gate does **not** mean every boundary case is resolved or that repetition can be cut over. The Review Scope worklist remains a blocker for CS5, while CS4 may now build Coverage / Questions / Expansion surfaces from the complete semantic map.

## Next work

Proceed to **CS4 — operationalize Coverage / Questions / Expansion** using this complete map as the corpus projection. Keep the boundary/Review Scope worklist visible. Do not move Knowledge Unit files and do not convert repetition state as part of CS4.
