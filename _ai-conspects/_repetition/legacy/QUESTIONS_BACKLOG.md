> **Migration status:** transitional legacy operational artifact for the pre-CS5 repetition/storage model. Target semantics are owned under `documentation/principles/` and `documentation/policies/`; do not silently reinterpret legacy state as v11 state. See `documentation/migration/CURRENT-MIGRATION-STATE.md`.

# Questions and Clarifications Backlog

Status: transitional active legacy question registry; not the target canonical Question owner

Scope: questions, clarifications, source gaps and future-unit candidates discovered during recall or materialization.

## Rules

- Every substantial item receives a stable ID such as `Q-20260903-001`.
- The complete canonical record lives here.
- Review histories and learning batches reference the ID instead of duplicating the record.
- Every item names one or more related Knowledge IDs, or explicitly states that no unit exists yet.
- The default for a non-blocking discovery during review is `DEFERRED`.
- Only `INTEGRATED` items automatically become future review material.
- A checked answer does not enter a knowledge unit without source/provenance suitable for that layer.

## Types

```text
QUESTION
  a testable knowledge question;

CLARIFICATION
  current wording or boundary needs a clearer checked explanation;

SOURCE_GAP
  evidence/provenance is incomplete or contradictory;

NEW_UNIT_CANDIDATE
  useful material appears outside the semantic boundary of existing units.
```

## Statuses

```text
OPEN
  ready for investigation;

DEFERRED
  intentionally parked until its review date or weekly triage;

RESOLVED
  answer/evidence checked, but not automatically part of repetition;

INTEGRATED
  accepted into named unit scope and future reviews;

DISCARDED
  duplicate, obsolete, unsupported or not useful.
```

## Triage policy

Investigate immediately only when the item is necessary to:

- judge the current recall accurately;
- resolve a safety-critical misconception;
- decide whether the current unit/source is trustworthy.

Otherwise capture it in under two minutes and continue the scheduled session. Review deferred items during the weekly maintenance block or on `Review no earlier than`.

## Records

<!--
Use this shape:

## Q-YYYYMMDD-NNN

Type: QUESTION | CLARIFICATION | SOURCE_GAP | NEW_UNIT_CANDIDATE
Status: DEFERRED
Created: YYYY-MM-DD
Review no earlier than: YYYY-MM-DD | weekly triage
Importance: LOW | MEDIUM | HIGH

Related Knowledge IDs:
- <topic.unit-id>
- <NONE — candidate has no existing unit>

Origin:
- Review: <date + history path>
- Learning batch: <batch ID or —>

Question or clarification:
<exact wording>

Why it appeared:
<memory gap, ambiguity, contradiction, extension, curiosity>

Resolution:
<checked answer or —>

Checked sources:
- <source or —>

Disposition:
- Integrated scope: <Knowledge IDs/sections or —>
- Follow-up review: <date/scope or —>
-->
