# Source of Truth Policy for Conspect Processing

Generated: 2026-06-01 21:14:24 UTC

## Critical distinction

The new review ledger is **not** a new source of truth.

It is a checklist/work queue to make sure every image remains visible to the process.

## Authoritative sources

Authoritative:

```text
original full.svg / source bundle
materialized images/contact sheets actually read visually
per-region Coverage / boundary review
verified region transcript
explicit include/exclude/reassign decisions made after visual/semantic review
```

## Non-authoritative / heuristic

Not authoritative:

```text
old Stage2 region_id
old nearest-label mapping
old region boxes
UNASSIGNED status
new review ledger provisional decisions
candidate lists before visual review
```

## Rule

```text
No mapping file can close a region.
Only visual/semantic boundary review can close a region.
```

A ledger may suggest candidates, but every region must still recheck:

```text
nearby coordinates
vertical roads/columns
parallel columns
overlapping or visually close screenshots
UNASSIGNED or unreviewed images
semantic fit after reading
```
