# Software Engineering Map v3 — corpus pilot v1

Status: validation evidence for CS2. This file does not adopt the Software Engineering Map as final ontology and does not change Knowledge Unit ownership by itself.

Date: 2026-09-25

## Purpose

Test the current 15-Area Software Engineering Map v3 and the accepted canonical-ownership / Technology Core rules against a stratified sample of the real 576-ID corpus before full semantic mapping.

No Knowledge Unit file was moved or edited for this pilot. `REPETITION_STATE.csv` was not changed.

Machine-readable row-level evidence: [`software-engineering-map-pilot-v1.csv`](software-engineering-map-pilot-v1.csv).

## Sample

- sampled Knowledge IDs: **102**;
- current topics represented: **19 / 19**;
- explicit Review Scope in sample: **69 / 102**;
- missing explicit Review Scope: **33 / 102**.

Topic allocation:

- `dotnet`: 15
- `aspnet-core`: 12
- `ef-core`: 10
- `javascript`: 8
- `sql-server`: 7
- `http`: 6
- `react-query`: 6
- `react`: 6
- `typescript`: 5
- `security`: 5
- `architecture`: 5
- `css`: 3
- `react-hook-form`: 3
- `axios`: 2
- `redis`: 2
- `redux`: 2
- `testing`: 2
- `algorithms`: 2
- `sql`: 1

The sample is intentionally topic-stratified rather than statistically random. It is designed to expose ownership boundaries, Technology Core cases, cross-Area Units, and Review Scope gaps.

## Placement result

- clear proposed placement: **85 / 102**;
- cross-Area / ownership boundary needs explicit treatment: **13 / 102**;
- Unit boundary itself likely needs review: **4 / 102**.

Owner-kind result:

- broader engineering Area / Concept: **52**;
- Technology Core candidate: **45**;
- unresolved owner because the current Unit crosses material boundaries: **5**.

Proposed Area distribution:

- `A01`: 13
- `A02`: 2
- `A03`: 4
- `A04`: 1
- `A05`: 7
- `A06`: 14
- `A07`: 2
- `A08`: 21
- `A09`: 19
- `A10`: 3
- `A11`: 2
- `A12`: 11
- `A13`: 2
- `A14`: 0
- `A15`: 1

Absence or low counts in an Area are not automatically ontology defects. This pilot samples the existing corpus, which is known to be weak in Software Lifecycle / Engineering Practice (A14), Operations / Delivery (A15), OS/runtime foundations (A04), and general algorithms (A02).

## Gate findings

### 1. No new top-level Area is justified by this sample

All 102 sampled Units can be discussed within the existing 15-Area model or as Technology Core manifestations linked into those Areas. The pilot found boundary ambiguity, but no recurring subject that clearly requires a sixteenth Area.

This is evidence in favor of retaining the **15-Area top-level structure for the next mapping pass**, not final ontology adoption.

### 2. Technology Core is operationally significant

**45 / 102** sampled Units are reasonable Technology Core candidates. The exception is therefore not a rare escape hatch; CS3 needs an explicit owner-kind field and consistent canonical-home test.

Strong recurring candidate families include:

- C#/.NET defining language/LINQ models;
- ASP.NET Core defining framework models such as MVC application model and Options;
- EF Core defining tracking/mapping/query-translation models;
- JavaScript / TypeScript defining language models;
- React, React Query, Redux, React Hook Form and similar defining client-framework models;
- T-SQL / Redis product-defining language/data-command models.

The broader Area still owns the engineering Concept and links to technology-owned defining models. No duplicate explanation is required.

### 3. CSS exposes a boundary that should be clarified, not a new Area

Map v3 explicitly lists CSS concepts under A08, while the Technology Core rule says defining language/runtime/framework models may be technology-owned. The sampled CSS Units are therefore marked `TECHNOLOGY_CORE_CANDIDATE + AMBIGUOUS_BOUNDARY`.

Recommended interpretation for CS3:

```text
A08 owns client/UI concepts and the map location where CSS manifestations matter.
CSS-defining semantics may remain canonically technology-owned when the Unit primarily explains CSS itself.
A08 links to those Units; do not duplicate them.
```

This interpretation is compatible with the accepted canonical-home test and does not require changing the 15 Areas.

### 4. Cross-Area Units should not be forced into one home when the Unit itself is heterogeneous

The pilot found **4** strong Unit-boundary review cases:

- `dotnet.timezone-conversion-json-and-model-binding` — Unit spans timezone semantics (A04), JSON representation (A05), and model binding (A07); one canonical home is not clean.
- `dotnet.xor-semantics-and-collection-equality` — Unit title combines XOR, cancellation and collection equality; likely heterogeneous Review Scope.
- `javascript.binary-storage-arraybuffer-typedarrays-and-blob` — ArrayBuffer/TypedArray are JS core while Blob is browser platform; the Unit crosses Technology Core, A05 and A08.
- `react.transitions-suspense-and-query-cancellation` — Unit combines React transitions/Suspense with query cancellation; likely crosses React Core, React Query and A03 cancellation.

These should enter CS3 as `UNIT_BOUNDARY_REVIEW_REQUIRED`, not as evidence that the Area map failed. The likely outcomes are split, narrower Review Scope, or one primary owner plus supporting links depending on the actual body.

### 5. Ordinary cross-Area boundaries are manageable with primary ownership + links

Examples found in the pilot include:

- `dotnet.regex-reuse-compilation-and-timeouts` → proposed `A05 / Parsing / text processing`; Regex operational semantics fit text/parsing, but Map v3 has no explicit regex concept; candidate nested Concept may be needed.
- `dotnet.streaming-byte-object-and-memory-models` → proposed `A05 / Streams / buffers / representation`; Primary streaming model fits A05, but memory ownership also touches A04; unit scope may need boundary review.
- `dotnet.string-replacement` → proposed `A05 / Text processing`; Very API-specific string behavior; could stay .NET Core or sit under broader text-processing concept.
- `aspnet-core.distributed-cache-storage-and-invalidation` → proposed `A09 / Caching / derived state`; Storage/expiration/invalidation fit A09; distributed coordination aspects would move to A10 if substantial.
- `aspnet-core.forwarded-headers-and-client-ip-trust` → proposed `A12 / Trust boundaries / proxy identity`; Strong A12 trust-boundary semantics and A06 proxy/header semantics both matter; pilot flags ownership boundary.
- `ef-core.aggregate-version-etag-propagation` → proposed `A09 / Optimistic concurrency / version tokens`; Concurrency/version ownership is A09; HTTP ETag propagation is A06 and should remain a link/boundary, not duplicate owner.
- `sql-server.mars-reader-interleaving-and-yield-points` → proposed `A09 / Connection/session lifecycle`; Database session/reader behavior is A09, with concurrency/yield links to A03.
- `react-query.cache-http-and-browser-boundaries` → proposed `A08 / Server-state cache boundaries`; React Query cache is framework-core, while HTTP/browser cache boundaries belong to A06/A08; comparison content may justify a broader comparison Unit.
- `react-query.websocket-event-driven-cache-updates` → proposed `A08 / Event-driven server-state cache updates`; React Query mechanics are core, but WebSocket/event-driven update semantics link A06/A10/A08.
- `typescript.zod-schema-validation-and-inference` → proposed `A05 / Schema validation / representation boundary`; Zod is a defining library model, while schema validation belongs to A05 representation boundaries.
- `css.animation-keyframes-and-motion` → proposed `A08 / CSS animation / motion`; Map v3 explicitly places CSS under A08, while the technology-core rule can also treat defining CSS semantics as technology-owned; pilot exposes this boundary.
- `css.mobile-viewport-height-units` → proposed `A08 / Responsive layout / viewport units`; Map v3 explicitly places CSS under A08, while the technology-core rule can also treat defining CSS semantics as technology-owned; pilot exposes this boundary.
- `css.stacking-context-hierarchy-and-clipping` → proposed `A08 / Stacking contexts / clipping`; Map v3 explicitly places CSS under A08, while the technology-core rule can also treat defining CSS semantics as technology-owned; pilot exposes this boundary.

The recurring boundaries are expected ones: networking↔security, caching↔distributed coordination, data↔concurrency, representation↔runtime, framework cache↔HTTP/browser cache. They do not currently justify duplicate ownership or new top-level Areas.

### 6. Review Scope gap is material and must remain a CS3 gate

**33 / 102** sampled Units do not expose the explicit `What should be recallable` contract. This is close enough to the known full-corpus gap (170 / 576) to confirm that Review Scope normalization is not an edge cleanup.

CS3 must keep Review Scope status as an independent field and resolve every Unit to one of:

```text
REVIEW_SCOPE_EXPLICIT
REVIEW_SCOPE_DERIVABLE
REVIEW_SCOPE_REPAIR_REQUIRED
UNIT_BOUNDARY_REVIEW_REQUIRED
```

Repetition cutover remains blocked until every Unit has a usable Review Scope or explicit repair disposition.

## Pilot ambiguities / repair candidates

| Knowledge ID | Proposed home | Owner kind | Finding |
|---|---|---|---|
| `dotnet.regex-reuse-compilation-and-timeouts` | `A05 / Parsing / text processing` | `AREA` | Regex operational semantics fit text/parsing, but Map v3 has no explicit regex concept; candidate nested Concept may be needed. |
| `dotnet.streaming-byte-object-and-memory-models` | `A05 / Streams / buffers / representation` | `AREA` | Primary streaming model fits A05, but memory ownership also touches A04; unit scope may need boundary review. |
| `dotnet.string-replacement` | `A05 / Text processing` | `TECHNOLOGY_CORE_CANDIDATE` | Very API-specific string behavior; could stay .NET Core or sit under broader text-processing concept. |
| `dotnet.timezone-conversion-json-and-model-binding` | `A04 / Time / timezone foundations` | `AMBIGUOUS` | Unit spans timezone semantics (A04), JSON representation (A05), and model binding (A07); one canonical home is not clean. |
| `dotnet.xor-semantics-and-collection-equality` | `A01 / Operators / equality` | `AMBIGUOUS` | Unit title combines XOR, cancellation and collection equality; likely heterogeneous Review Scope. |
| `aspnet-core.distributed-cache-storage-and-invalidation` | `A09 / Caching / derived state` | `AREA` | Storage/expiration/invalidation fit A09; distributed coordination aspects would move to A10 if substantial. |
| `aspnet-core.forwarded-headers-and-client-ip-trust` | `A12 / Trust boundaries / proxy identity` | `AMBIGUOUS` | Strong A12 trust-boundary semantics and A06 proxy/header semantics both matter; pilot flags ownership boundary. |
| `ef-core.aggregate-version-etag-propagation` | `A09 / Optimistic concurrency / version tokens` | `AREA` | Concurrency/version ownership is A09; HTTP ETag propagation is A06 and should remain a link/boundary, not duplicate owner. |
| `javascript.binary-storage-arraybuffer-typedarrays-and-blob` | `A05 / Binary representation / buffers` | `AMBIGUOUS` | ArrayBuffer/TypedArray are JS core while Blob is browser platform; the Unit crosses Technology Core, A05 and A08. |
| `sql-server.mars-reader-interleaving-and-yield-points` | `A09 / Connection/session lifecycle` | `AREA` | Database session/reader behavior is A09, with concurrency/yield links to A03. |
| `react-query.cache-http-and-browser-boundaries` | `A08 / Server-state cache boundaries` | `TECHNOLOGY_CORE_CANDIDATE` | React Query cache is framework-core, while HTTP/browser cache boundaries belong to A06/A08; comparison content may justify a broader comparison Unit. |
| `react-query.websocket-event-driven-cache-updates` | `A08 / Event-driven server-state cache updates` | `TECHNOLOGY_CORE_CANDIDATE` | React Query mechanics are core, but WebSocket/event-driven update semantics link A06/A10/A08. |
| `react.transitions-suspense-and-query-cancellation` | `A08 / React concurrent UI / Suspense` | `AMBIGUOUS` | Unit combines React transitions/Suspense with query cancellation; likely crosses React Core, React Query and A03 cancellation. |
| `typescript.zod-schema-validation-and-inference` | `A05 / Schema validation / representation boundary` | `TECHNOLOGY_CORE_CANDIDATE` | Zod is a defining library model, while schema validation belongs to A05 representation boundaries. |
| `css.animation-keyframes-and-motion` | `A08 / CSS animation / motion` | `TECHNOLOGY_CORE_CANDIDATE` | Map v3 explicitly places CSS under A08, while the technology-core rule can also treat defining CSS semantics as technology-owned; pilot exposes this boundary. |
| `css.mobile-viewport-height-units` | `A08 / Responsive layout / viewport units` | `TECHNOLOGY_CORE_CANDIDATE` | Map v3 explicitly places CSS under A08, while the technology-core rule can also treat defining CSS semantics as technology-owned; pilot exposes this boundary. |
| `css.stacking-context-hierarchy-and-clipping` | `A08 / Stacking contexts / clipping` | `TECHNOLOGY_CORE_CANDIDATE` | Map v3 explicitly places CSS under A08, while the technology-core rule can also treat defining CSS semantics as technology-owned; pilot exposes this boundary. |

## CS2 gate result

**PASS WITH BOUNDARY CLARIFICATIONS.**

For the next stage, keep the 15-Area top-level Map v3 structure as the working mapping frame. Do **not** call it final ontology yet. Carry the following explicit rules into CS3:

1. classify every Unit as broader Area ownership, Technology Core candidate, or unresolved/repair-required;
2. use primary-subject canonical ownership plus ordinary links for cross-Area concerns;
3. do not force heterogeneous Units into one canonical home;
4. treat CSS/framework-defining semantics consistently with the Technology Core test;
5. keep Review Scope readiness independent from semantic placement;
6. make no physical file move as part of mapping.

## Next work

Proceed to **CS3 — full 576-ID semantic mapping + Review Scope normalization inventory** using this pilot schema and the clarifications above. Physical representation and repetition-state conversion remain deferred.

