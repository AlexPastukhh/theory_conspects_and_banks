# PROCESS-INTEGRATE-VERIFIED-KNOWLEDGE

Status: current supporting Process; not a standalone Use Case.

## Trigger
Content is verified enough to accept as durable knowledge.

## Result
Knowledge is integrated into the appropriate semantic destination without unnecessary duplication, with required provenance/relations/coverage effects, and with correct handoff to learning/retention state.

## Process
1. Identify Domain / Area / Concept context.
2. Search existing Knowledge Units for semantic overlap/duplicates.
3. Decide whether to extend, merge, create a Unit, or only update relation/coverage because knowledge is already represented.
4. Apply Knowledge Structure / Ontology contract.
5. Preserve provenance where required.
6. Update relations/indexes/coverage representation.
7. Set/preserve Learning State:
   - new or materially reshaped learnable knowledge normally enters `ACTIVE`;
   - minor verified additions that do not destabilize an existing STABLE scope may remain `STABLE`;
   - trivial map/reference knowledge with no active learning objective may enter `STABLE` directly when Retention policy has already classified it as `MAP_ONLY`.
8. Do not invent a Retention Class merely because content was integrated. Obtain/assign it according to Retention policy when eligible/needed.
9. Never update Repetition State as if new knowledge had already been recalled successfully.

## Ownership boundary
This Process does not own Unit shape, ontology, priority dimensions, retention classes, or scheduling rules.


## Migration compatibility

Until CS5 converts the repository repetition state, integration must preserve the existing legacy storage contract rather than fabricating v11 state fields. New/reshaped knowledge may be semantically recognized as needing stabilization, but do not write invented `ACTIVE/STABLE`, Retention Class, Recall State, review history, or interval values into legacy state. Record only what the current operational storage can truthfully represent and leave explicit migration disposition for CS5.

Physical topic folders remain a transitional representation even though semantic hierarchy v3 is established. Canonical Area/nested-Area ownership must be read from the current domain map/hierarchy, not inferred from the current path.
