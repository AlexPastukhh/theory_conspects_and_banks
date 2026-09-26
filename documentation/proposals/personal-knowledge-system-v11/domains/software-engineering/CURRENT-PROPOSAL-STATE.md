# Software Engineering — current proposal state

Status: **historical proposal/provenance wrapper; current logical owner is `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`**.

Current logical map:
- [`../../../../domains/software-engineering/KNOWLEDGE-MAP.md`](../../../../domains/software-engineering/KNOWLEDGE-MAP.md)

Seed/provenance map:
- `proposals/map-v3/SOFTWARE-ENGINEERING-MAP-PROPOSAL-v3.md`

Current structural direction:
- all 15 Engineering root Areas from Map v3 survived validation; the current recursive nested-Area frame is owned by `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`;
- Technology Core is an exception-aware parallel ownership layer, not a copy of every Area;
- ordinary technology manifestations normally stay under their broader engineering Concept;
- defining language/runtime/framework models may stay in Technology Core;
- tags provide cross-cutting topic **and technology** retrieval (`python`, `dotnet`, `node`, `caching`, etc.);
- cross-technology comparison Knowledge Units live with the broader Concept they compare and may link to technology-owned core Units;
- no mandatory pairwise analogy-relation graph;
- Questions may live in local Area/nested-Area/Concept inboxes and become Open Expansion or durable Key Questions;
- the system-level core view model is Coverage & Expansion, Expansion Plan, and Repetition.

## View-model supersession note

Map v3 contains an earlier section proposing several cross-cutting logical views (Quality Attributes, Performance, Reliability, and others).

The taxonomy and cross-cutting concerns remain useful, but the current system principle is simpler:

- do not maintain those as separate views by default;
- represent/retrieve them through tags/filters/ordinary links unless a concrete future use case proves a dedicated view necessary;
- a separate Technology View is not required; technology tags provide cross-cutting retrieval while Technology Core governs canonical ownership for defining technology models.

## Corpus validation evidence

### CS2 pilot

- [`../../../../validation/software-engineering-map-pilot-v1.md`](../../../../validation/software-engineering-map-pilot-v1.md)
- [`../../../../validation/software-engineering-map-pilot-v1.csv`](../../../../validation/software-engineering-map-pilot-v1.csv)

The 102-ID pilot returned `PASS WITH BOUNDARY CLARIFICATIONS` and found no need for a sixteenth top-level Area.

### CS3 provisional full map

Historical pre-resolution evidence:

- [`../../../../validation/software-engineering-full-semantic-map-v1.md`](../../../../validation/software-engineering-full-semantic-map-v1.md)
- [`../../../../validation/software-engineering-full-semantic-map-v1.csv`](../../../../validation/software-engineering-full-semantic-map-v1.csv)
- [`../../../../validation/review-scope-and-boundary-worklist-v1.csv`](../../../../validation/review-scope-and-boundary-worklist-v1.csv)

That pass mapped all 576 IDs but deliberately retained boundary/review-scope work.

### Pre-hierarchy resolved full map (historical)

- [`../../../../validation/software-engineering-full-semantic-map-v2.md`](../../../../validation/software-engineering-full-semantic-map-v2.md)
- [`../../../../validation/software-engineering-full-semantic-map-v2.csv`](../../../../validation/software-engineering-full-semantic-map-v2.csv)
- [`../../../../validation/review-scope-and-boundary-resolution-v2.csv`](../../../../validation/review-scope-and-boundary-resolution-v2.csv)

That pass closed placement/Review-Scope blockers but still used provisional flat Concept labels. The later hierarchy pass is now current.

No recurring subject in the complete current corpus justified a sixteenth top-level Area. The hierarchy pass later moved one dev-tooling Unit into A14; A14 is therefore `PARTIAL`, though still a major coverage gap.

Technology Core remains an explicit ownership mode: the current mapping has 317 Technology Core candidates and 259 Area-owned Units.

The 15-Area frame survived the hierarchy review. Current recursive nested-Area assignment and its audit live in `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`, `documentation/validation/software-engineering-semantic-hierarchy-v2.csv`, and `documentation/validation/software-engineering-subarea-structure-audit-v2.md`. v1 is historical evidence only: semantic review corrected keyword/classifier false positives before the hierarchy gate was accepted. This still does **not** force a final physical folder layout or controlled tag vocabulary.

## CS4 operational projection

Coverage / Questions / Expansion is operational over the semantic map:

- [`../../../../../_ai-conspects/_planning/COVERAGE_AND_EXPANSION.md`](../../../../../_ai-conspects/_planning/COVERAGE_AND_EXPANSION.md)
- [`../../../../../_ai-conspects/_planning/COVERAGE_STATE.csv`](../../../../../_ai-conspects/_planning/COVERAGE_STATE.csv)
- [`../../../../../_ai-conspects/_planning/QUESTIONS.csv`](../../../../../_ai-conspects/_planning/QUESTIONS.csv)
- [`../../../../../_ai-conspects/_planning/EXPANSION_PLAN.md`](../../../../../_ai-conspects/_planning/EXPANSION_PLAN.md)

Coverage remains conservative and question-driven; Unit counts prove presence, not completeness.

## Next migration use

The semantic-map, Review Scope, and recursive hierarchy gates are now closed. The next migration step is **CS5 repetition cutover**.

Physical Knowledge Unit moves remain optional and are not a prerequisite.
