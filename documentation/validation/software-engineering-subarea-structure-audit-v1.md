# Software Engineering Subarea Structure Audit v1


> Superseded as current structure evidence by `software-engineering-subarea-structure-audit-v2.md`; retained for migration history.

Status: historical validation evidence from the first hierarchy pass; superseded by v2.

## Goal

Use the old Map v3 Subarea plan as a seed, but test and reshape it against all 576 current Knowledge Units instead of copying its flat list mechanically.

## Result

- Knowledge Units assigned: **576 / 576**.
- Top-level Areas retained: **15**.
- Broad nested Areas defined: **79**.
- Occupied broad nested Areas: **54**.
- Occupied concrete nested-area paths: **104**.
- Top-level Area corrections discovered by concrete placement: **52**.
- Knowledge Unit files moved: **0**.
- Knowledge Unit bodies edited by this hierarchy pass: **0**.
- Repetition state edited: **0**.

## Why the old v3 list changed

The v3 list was primarily a completeness checklist. Many bullets were too fine-grained to be useful as siblings in a navigation tree. This pass groups them recursively. Examples:

- old A09 bullets such as SARGability, query plans, cardinality and index selection now sit under `Query Performance & Indexing → Indexing, Query Shape & Cost`;
- old A03 task/future/promise/coroutine and scheduling concerns are separated into `Async Execution & Scheduling`, while cancellation and synchronization remain sibling nested Areas;
- old A14/A15 responsibilities remain in the map even where corpus evidence is nearly absent, preventing corpus bias;
- browser/platform APIs that had been rule-mapped into A01 now live under A08/A05/A03 according to their actual semantic responsibility.

## Top-level corrections found

Concrete Subarea placement exposed rule-based false positives in v2. The correction principle was: if a Unit cannot be placed naturally under a concrete nested Area of its assigned root Area, reassess the root rather than inventing a fake Subarea.

- `aspnet-core.custom-route-constraints`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Routing & Endpoint Selection`
- `aspnet-core.endpoint-matching-phases-and-route-precedence`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Routing & Endpoint Selection`
- `aspnet-core.exception-handler-features`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Middleware, Filters & Request Context`
- `aspnet-core.form-and-multipart-request-binding`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Binding, Validation & Error Handling`
- `aspnet-core.hateoas-link-generation-and-resource-envelopes`: `A07` → `A06` — `API Contracts & Resource Semantics > Resources, Errors, Discovery & Evolution`
- `aspnet-core.httpcontext-features`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Middleware, Filters & Request Context`
- `aspnet-core.httpcontext-items`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Middleware, Filters & Request Context`
- `aspnet-core.imemorycache-expiration-invalidation-and-stampede`: `A07` → `A09` — `Caching & Derived State > Freshness, Invalidation & Coordination`
- `aspnet-core.json-patch-formatters-and-content-negotiation`: `A07` → `A06` — `HTTP Semantics > Representation Negotiation & Transfer`
- `aspnet-core.media-type-formatters-and-406-415`: `A07` → `A06` — `HTTP Semantics > Representation Negotiation & Transfer`
- `aspnet-core.razor-layouts-viewdata-tempdata-tag-helpers-and-fragments`: `A08` → `A07` — `Server Rendering & MVC > Razor, Views & Server-Rendered UI`
- `aspnet-core.razor-service-injection`: `A06` → `A07` — `Server Rendering & MVC > Razor, Views & Server-Rendered UI`
- `aspnet-core.request-body-binding-raw-access-and-replay-buffering`: `A06` → `A07` — `Request Pipeline & Endpoint Execution > Binding, Validation & Error Handling`
- `aspnet-core.response-body-shapes-and-streaming-output`: `A06` → `A07` — `Service Concerns > Cross-Cutting Application Integrations`
- `aspnet-core.semantic-media-types-and-formatter-contracts`: `A07` → `A06` — `HTTP Semantics > Representation Negotiation & Transfer`
- `aspnet-core.totp-enrollment-and-verification`: `A07` → `A12` — `Identity & Access > Identity Lifecycle, MFA & Recovery`
- `aspnet-core.view-component-partial-updates`: `A08` → `A07` — `Server Rendering & MVC > Razor, Views & Server-Rendered UI`
- `aspnet-core.view-components-server-rendered-widgets`: `A08` → `A07` — `Server Rendering & MVC > Razor, Views & Server-Rendered UI`
- `dotnet.cryptographic-randomness-and-unbiased-ranges`: `A01` → `A12` — `Cryptography & Credential Protection > Randomness, Hashing, Keys & Tokens`
- `dotnet.datetime-offset-kind-conversion-and-arithmetic`: `A01` → `A04` — `Time & Clocks > Civil Time, Instants & Scheduling`
- `dotnet.finalizer-lifecycle-costs-and-failure-boundaries`: `A01` → `A04` — `Memory & Resource Lifecycle > Deterministic & Native Resource Ownership`
- `dotnet.fluentvalidation-collections-children-and-polymorphism`: `A01` → `A07` — `Request Pipeline & Endpoint Execution > Binding, Validation & Error Handling`
- `dotnet.hexadecimal-byte-representation`: `A01` → `A05` — `Data Representation > Binary Representation & Buffers`
- `dotnet.identity-sentinels-and-transferable-ids`: `A12` → `A01` — `Values, Types & Contracts > Values, Identity, Equality & Conversion`
- `dotnet.incremental-text-decoding`: `A01` → `A05` — `Data Representation > Text, Unicode & Culture`
- `dotnet.stringreader-line-processing-and-memory`: `A04` → `A05` — `I/O & Streaming > Streams, Buffering & Incremental I/O`
- `dotnet.totp-secret-generation-and-base32-encoding`: `A05` → `A12` — `Cryptography & Credential Protection > Randomness, Hashing, Keys & Tokens`
- `javascript.browser-download-navigation-and-blob-urls`: `A01` → `A08` — `Browser Platform > Storage, Navigation & Cross-Context Communication`
- `javascript.browsing-contexts-popups-and-targets`: `A01` → `A08` — `Browser Platform > Storage, Navigation & Cross-Context Communication`
- `javascript.byte-values-and-endianness`: `A01` → `A05` — `Data Representation > Binary Representation & Buffers`
- `javascript.collation-sort-vs-search`: `A01` → `A05` — `Data Representation > Text, Unicode & Culture`
- `javascript.cross-window-postmessage-security`: `A01` → `A08` — `Browser Platform > Storage, Navigation & Cross-Context Communication`
- `javascript.dataview-offsets-and-binary-layouts`: `A01` → `A05` — `Data Representation > Binary Representation & Buffers`
- `javascript.eventsource-client-lifecycle`: `A01` → `A08` — `Browser Platform > Browser Networking APIs`
- `javascript.fetch-requestinit-and-request-object`: `A01` → `A08` — `Browser Platform > Browser Networking APIs`
- `javascript.fetch-response-contract-and-wrapper-policy`: `A01` → `A08` — `Browser Platform > Browser Networking APIs`
- `javascript.intl-collator`: `A01` → `A05` — `Data Representation > Text, Unicode & Culture`
- `javascript.promise-all-concurrency-and-outcomes`: `A01` → `A03` — `Async Execution & Scheduling > Tasks, Promises & Async Execution`
- `javascript.readable-stream-consumption-and-tee`: `A01` → `A05` — `I/O & Streaming > Streams, Buffering & Incremental I/O`
- `javascript.readable-stream-producers-backpressure-and-cancellation`: `A01` → `A05` — `I/O & Streaming > Streams, Buffering & Incremental I/O`
- `javascript.set-basics`: `A12` → `A01` — `Collections, Iteration & Query Semantics > Collection Models & Operations`
- `javascript.svg-getbbox-geometry`: `A01` → `A08` — `Browser Platform > DOM, SVG & Geometry APIs`
- `javascript.symbol-identity-and-registry`: `A12` → `A01` — `Values, Types & Contracts > Values, Identity, Equality & Conversion`
- `javascript.timers-tasks-microtasks-and-abortable-delay`: `A01` → `A03` — `Async Execution & Scheduling > Event Loops, Queues & Runtime Scheduling`
- `javascript.vite-development-proxy-and-spa-orchestration`: `A01` → `A14` — `Developer Workflow & Tooling > Development Servers & Local Integration`
- `javascript.web-storage-api`: `A01` → `A08` — `Browser Platform > Storage, Navigation & Cross-Context Communication`
- `javascript.web-storage-events-and-failures`: `A01` → `A08` — `Browser Platform > Storage, Navigation & Cross-Context Communication`
- `javascript.web-workers-messaging-and-module-loading`: `A01` → `A08` — `Browser Platform > Workers & Platform Execution`
- `javascript.websocket-client-lifecycle-backpressure-and-reconnect`: `A01` → `A08` — `Browser Platform > Browser Networking APIs`
- `javascript.writablestream-pipeto-and-sink-lifecycle`: `A01` → `A05` — `I/O & Streaming > Pipelines, Segmented I/O & Framing`
- `react.recaptcha-v2-v3-widget-and-token-lifecycle`: `A08` → `A12` — `Application & Browser Security > Browser Trust, Injection & Abuse Boundaries`
- `react-query.testing-with-queryclient-and-msw`: `A08` → `A13` — `Testing Strategy & Tooling > Framework Testing, Doubles & Assertions`

## Important boundary consequences

- `Set`/`Symbol` identity is language/value semantics, not Security & Identity.
- cryptographic randomness and TOTP secret generation are security/credential knowledge, not generic language/data representation.
- ASP.NET endpoint matching, HttpContext, binding and exception-pipeline mechanics belong to Application & Service Engineering rather than protocol semantics.
- HATEOAS/media-type/content-negotiation semantics remain protocol/API-owned even when implemented through ASP.NET.
- browser storage, browsing contexts, Fetch/XHR/EventSource/WebSocket client lifecycle and Web Workers belong to Client/Browser/UI; stream mechanics themselves remain I/O-owned.
- Vite dev-server/proxy orchestration is lifecycle/tooling knowledge and gives A14 its first current primary Unit.

## Remaining limits

- `working_concept_label` is still a working Concept label; this pass does not claim the Concept vocabulary is final.
- Empty nested Areas are not automatically `MISSING` at every leaf; coverage quality still requires Key Questions/responsibility checks.
- No stable IDs are assigned to nested Areas yet. Paths are sufficient until a real use case requires independent Area identity across renames.
- The hierarchy is logical only; physical folder representation remains a later optional decision.
