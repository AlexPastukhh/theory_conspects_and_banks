# PROCESS-INTEGRATE-VERIFIED-KNOWLEDGE

Status: current supporting Process; not a standalone Use Case.

## Trigger
Content is verified enough to accept as durable knowledge.

## Result
Knowledge is integrated into the appropriate semantic destination without unnecessary duplication, with provenance/coverage effects preserved and with the authoritative Review Scope returned to the caller.

## Process
1. Identify Domain / Area / Concept context.
2. Search existing Knowledge Units for semantic overlap/duplicates.
3. Decide whether to extend, merge, create a Unit, or only update relation/coverage because knowledge is already represented.
4. Apply Knowledge Structure / Ontology contract.
5. Preserve provenance where required.
6. Update indexes/coverage representation where applicable.
7. Establish or update the explicit authoritative Review Scope.
8. Return the changed Knowledge ID / Review Scope to the calling workflow.
9. If the caller is the D+2 learning-triage workflow, that caller performs the retention handoff: priority/Retention Class assessment, Repetition Map entry/update, and next-date scheduling.
10. Never treat content integration itself as successful memory recall; do not invent scores, Recall State transitions, intervals, or historical reviews.

## Ownership boundary
This Process does not own Unit shape, ontology, priority dimensions, Retention Class semantics, scheduling rules, or Expansion planning.

## Migration compatibility
Until CS5 converts repetition storage, preserve truthful legacy data. Do not fabricate target repetition fields merely because a Unit was integrated. The D+2 workflow may establish the intent/evidence needed for a future target map entry even when legacy physical storage cannot yet represent it cleanly.

Physical topic folders remain transitional. Canonical Area/nested-Area ownership must be read from the current domain map/hierarchy, not inferred from the current path.
