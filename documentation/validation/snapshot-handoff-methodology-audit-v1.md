# Snapshot Handoff / Methodology Audit v1

Status: validation evidence, not a semantic owner.

## Goal

Test whether a fresh chat receiving only this snapshot can recover the current methodology/state without relying on prior conversation context.

## Problems found and corrected

1. Root/agent guidance still described semantic mapping as unfinished even though hierarchy v3 exists.
2. `documentation/README.md` contained duplicate domain links and did not state a strict authority order between current owners, projections, validation history, proposals and legacy files.
3. `KNOWLEDGE-MAP.md` was stale relative to hierarchy v3: it still linked v2 and omitted/renamed nodes introduced by the responsibility-first refinement.
4. `Subarea` could be misread as a fixed second-level entity rather than an alias for recursively nested `Area`.
5. Coverage `responsibility` could be misread as a new ontology entity or as one-to-one with a Subarea/Concept.
6. `MISSING/PARTIAL/COVERED` could be misread as folder/file-presence statuses rather than scope-relative adequacy assessments.
7. `SUBAREA_COVERAGE_STATE.csv` could be confused with semantic completeness even though it is primarily an occupancy projection.
8. The 30-row manifestation matrix could be mistaken for a complete Python/Node/.NET curriculum.
9. `TECHNOLOGY_CORE_CANDIDATE` could be mistaken for a physical move instruction or a second canonical copy.
10. Current migration history incorrectly risked implying that no Knowledge Unit body had ever changed; CS5-prep actually normalized Review Scope in 170 Units.
11. Cross-technology analogy needed an explicit responsibility-first boundary so agents do not manufacture one-to-one EF Core/SQLAlchemy/etc. mappings.
12. `SUBAREA_COVERAGE_STATE.csv` reused semantic `PARTIAL/MISSING` vocabulary for a primary-occupancy projection. It now uses `HAS_PRIMARY_EVIDENCE / NO_PRIMARY_EVIDENCE` so occupancy cannot be mistaken for responsibility coverage.
13. `concept_label` and `responsibility_family` could be mistaken for fully materialized ontology nodes. Current docs now state that they are local/grouping labels unless independently promoted/normalized.
14. Hierarchy v3 carries v1/v2 migration provenance columns beside current placement columns; the schema contract now identifies which fields are current versus historical/audit-only.
15. Responsibility coverage carries `candidate_evidence_*` beside accepted `evidence_*`; candidate matches are now explicitly non-authoritative and do not upgrade `MISSING`.

## Corrections applied

Updated current navigation/agent contract, universal principles, ontology, Coverage/Expansion semantics, relevant Use Cases, planning-layer documentation, Software Engineering domain docs, and current migration state.

No Knowledge Unit body, physical Knowledge path, legacy repetition state, or initial-wave queue was changed by this audit.

## Expected fresh-agent interpretation

A fresh agent should now be able to state correctly that:

- current hierarchy = Software Engineering hierarchy v3;
- `Subarea` = recursive nested Area;
- 576/576 Units have clear logical Area/nested-Area paths and explicit Review Scopes;
- physical topic folders are non-authoritative;
- responsibility coverage and hierarchy occupancy are distinct; `SUBAREA_COVERAGE_STATE.csv` uses occupancy-only `HAS_PRIMARY_EVIDENCE / NO_PRIMARY_EVIDENCE`;
- hierarchy `concept_label` and responsibility `responsibility_family` are labels/groupings, not automatically materialized canonical ontology nodes;
- 183 generic responsibilities are the main semantic coverage checklist (101 PARTIAL / 82 MISSING / 0 COVERED asserted); accepted `evidence_ids` and non-authoritative `candidate_evidence_ids` must not be conflated;
- 30 manifestation rows are only a selected cross-runtime baseline;
- responsibility-first gap discovery precedes technology analogy;
- Technology Core is an ownership exception, not duplicate storage;
- repetition is still legacy/transitional until CS5 cutover;
- historical validation/proposal artifacts do not override current owners;
