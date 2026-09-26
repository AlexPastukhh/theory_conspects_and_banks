# Software Engineering Full Semantic Map — v2

Status: current validated corpus mapping for migration work; still not a final physical-layout prescription.

## Result

All current **576 / 576** Knowledge IDs have one primary Software Engineering Area/Concept placement and one resolved ownership kind.

```text
placement
  CLEAR                         576

owner kind
  AREA                          259
  TECHNOLOGY_CORE_CANDIDATE     317
  AMBIGUOUS                       0
```

No new top-level Area was required. `A14 Software Lifecycle & Engineering Practice` still has no current primary Unit; this remains a corpus coverage gap rather than evidence that the Area should be removed.

The authoritative row-level projection is:

- [`software-engineering-full-semantic-map-v2.csv`](software-engineering-full-semantic-map-v2.csv)

The previous v1 map remains historical validation evidence for the unresolved state before this pass.

## Boundary resolution

The previous worklist contained:

```text
BOUNDARY_REVIEW                30
UNIT_BOUNDARY_REVIEW            4
```

All 34 were reviewed.

The general resolution rule was:

```text
one primary semantic home
+ alternative Areas as ordinary links / tags / context
≠ duplicate canonical ownership
```

Notable resolutions:

- `aspnet-core.forwarded-headers-and-client-ip-trust` → `A12`; proxy/header mechanics remain an `A06` link.
- `dotnet.timezone-conversion-json-and-model-binding` → `A04`; JSON/model-binding remain `A05/A07` links.
- `dotnet.xor-semantics-and-collection-equality` → `A01`, Technology Core candidate; the body is coherent around XOR/equality/hash alternatives. The stale `cancellation` word was removed from the Unit title.
- `javascript.binary-storage-arraybuffer-typedarrays-and-blob` → `A05`, Technology Core candidate; one binary-representation model spans raw storage, views and browser file-like data.
- `react.transitions-suspense-and-query-cancellation` → `A08`, Technology Core candidate; the coherent scope is the boundary between UI scheduling/Suspense visibility and transport cancellation.

The detailed before/after worklist is:

- [`review-scope-and-boundary-resolution-v2.csv`](review-scope-and-boundary-resolution-v2.csv)

## Review Scope normalization

Before this pass:

```text
explicit Review Scope                  406
derivation required                    161
repair required                          6
unit-boundary review required            3
```

After this pass:

```text
explicit authoritative Review Scope    576
missing                                  0
```

For the 161 derivation cases, the new inline scope was generated only from existing Unit prose. The scope adds no new knowledge claim; it selects the existing model, rules and boundaries that the learner is responsible for reconstructing.

Six dense/repair cases received manually normalized scopes from their existing body:

- BFF token storage/refresh;
- CSS animation;
- mobile viewport units;
- stacking contexts;
- Regex reuse/compilation/timeouts;
- Redis expiring counters/distributed throttling.

Three previous unit-boundary blockers received explicit coherent scopes without splitting the Knowledge ID:

- XOR/equality;
- ArrayBuffer/typed arrays/Blob;
- React transitions/Suspense/query cancellation.

Every Knowledge Unit now contains exactly one:

```text
## What should be recallable
```

section.

## Representation boundary

This pass did **not**:

- move a Knowledge Unit file;
- change a Knowledge ID;
- create a new top-level Area;
- migrate `REPETITION_STATE.csv`;
- reinterpret legacy `NOT_REVIEWED`;
- assign Retention Class;
- perform a recall assessment.

The corrected XOR Unit title already matches the unchanged legacy `REPETITION_STATE.csv` display label. Knowledge ID and file path remain unchanged.

## Gate

```text
Review Scope gate        PASS
Unit-boundary gate       PASS
semantic placement gate PASS
physical-move gate       NOT REQUIRED
```

The corpus is now ready for **CS5 repetition cutover**, subject to the CS5 policy/state migration checks.
