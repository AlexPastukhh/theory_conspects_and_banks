# CS5 Repetition Cutover Design Audit — v1

Status: superseded historical validation evidence; not a semantic owner. Verified snapshot facts remain evidence, but the `ACTIVE | STABLE` blocker and later sparse/opt-in assumptions are superseded. See `cs5-retention-map-methodology-audit-v4.md` and `../migration/CURRENT-MIGRATION-STATE.md`.

## Scope

Validated the current snapshot before changing repetition data/schema, and checked which legacy facts can and cannot support target-state decisions.

## Verified invariants

```text
REPETITION_STATE rows                     576
INITIAL_WAVE_QUEUE rows                   576
semantic hierarchy v3 rows                576
unique Knowledge IDs in each              576
ID set equality across all three          PASS
all legacy LearningState=NOT_REVIEWED     PASS
all initial-wave Status=NOT_REVIEWED      PASS
legacy review evidence fields empty       PASS
initial-wave CompletedOn empty            PASS
legacy NextType=CALIBRATION               576 / 576
legacy NextScope=whole unit               576 / 576
hierarchy placement_status=CLEAR          576 / 576
hierarchy Review Scope explicit           576 / 576
state File paths exist                    576 / 576
exactly one inline Review Scope heading   576 / 576
```

Legacy `ReviewPriority` distribution:

```text
HIGH         18
UNASSESSED  558
```

No target Retention Class can be inferred mechanically from that distribution without violating the current Priority/Retention owners.

## Evidence-supported conclusions

There is no historical repetition evidence requiring interval/history translation. The safe deterministic facts are identity, Review Scope continuity, and absence-of-history facts.

The snapshot does **not** establish that legacy `NOT_REVIEWED` means target `ACTIVE`; it also does not, merely from the repetition projections, establish that every Unit is `STABLE`. Explicit Review Scope and semantic placement are necessary structural prerequisites but are not by themselves Learning State evidence.

Accordingly, the current evidence supports an **unresolved CS5 classification problem**, not a particular pending-state representation.

## Representation boundary

A temporary migration disposition/ledger may prove useful for genuinely unresolved residual cases, but it is not selected by this audit. Such a representation should be chosen only after:

1. defining the repository-supported Learning State classification procedure;
2. applying it as far as current evidence permits;
3. measuring the remaining unresolved set;
4. comparing minimal temporary representations for that remainder.

Migration-only representation must not be promoted into permanent repetition semantics.

## Pre-application verdict

The semantic placement and Review Scope prerequisites for CS5 are satisfied. No corpus-structure blocker was found.

A **methodological design blocker remains before state/schema cutover**: the repository still needs an explicit, owner-consistent procedure for assigning `ACTIVE | STABLE` to existing Units and a decision for any residual unresolved cases.

Repetition data/schema remains unchanged.
