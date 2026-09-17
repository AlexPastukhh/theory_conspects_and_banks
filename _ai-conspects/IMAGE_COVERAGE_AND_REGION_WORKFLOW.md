# Image Coverage and Region Completion Workflow

Generated: 2026-06-01 21:36:06 UTC

## Core rule

No image may disappear, but no mapping file may decide final boundaries.

The review ledger exists to prevent forgetting images. It is not authoritative.

## Required workflow

For every region:

```text
1. Start from heading/topic and seed images.
2. Pull candidates from review ledger.
3. Re-scan nearby x/y coordinates.
4. Re-scan vertical roads/columns.
5. Re-scan parallel columns.
6. Check visually close images even if no arrows point to them.
7. Label candidate type precisely.
8. Read candidate images enough to judge semantic fit.
9. Include/exclude/reassign with reasons.
10. Update region file coverage section.
11. Update ledger/status.
```

## Nearby image rule

Every visually/coordinate-close image must be checked by meaning.

No arrow is required for a nearby image to be considered a candidate.

But `nearby` means visually local to the current cluster/road/parallel column.

Do not call a screenshot nearby merely because it is in the same y-band or close in source order.

## Candidate review rule

Candidate lists are useful for large conspects.

Use candidate categories:

```text
same-column-continuation
parallel-column-continuation
visually-close-local-neighbor
distant-same-band-safety-check
semantic-cross-check
excluded-with-reason
reassigned-with-reason
```

## Completion rule

A region cannot be `completed` merely because:

```text
Stage2 said so
the ledger suggested candidates
a region box ended
nearest label changed
a screenshot was UNASSIGNED
```

It is completed only after explicit boundary review in the region transcript.
