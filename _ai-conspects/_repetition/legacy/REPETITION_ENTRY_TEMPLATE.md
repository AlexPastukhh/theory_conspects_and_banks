> **Migration status:** transitional legacy operational artifact for the pre-CS5 repetition/storage model. Target semantics are owned under `documentation/principles/` and `documentation/policies/`; do not silently reinterpret legacy state as v11 state. See `documentation/migration/CURRENT-MIGRATION-STATE.md`.

# Repetition Entry Template

Status: transitional active legacy history template for the pre-CS5 repetition schema

Use this template for `_repetition/history/<topic>/<unit>.md`.

Do not create a history file before the first actual review.

## Suggested file header

```markdown
# Repetition — <Knowledge ID>

Unit: `_ai-conspects/_knowledge/<topic>/<unit>.md`
Source status: <OK | CHECK_BEFORE_REVIEW | REBUILD_REQUIRED | UNKNOWN>
Review priority: <HIGH | NORMAL | LOW | UNASSESSED>

## Current state

Learning state: <NOT_REVIEWED | WEAK | RECOVERING | STABLE>
Last review: <YYYY-MM-DD or —>
Last final recall: <0–4 or —>
Completed gap: <number of complete days or —>
Next review: <YYYY-MM-DD or —>
Next type: <CALIBRATION | FULL | TARGETED | QUESTIONS_ONLY | SOURCE_REPAIR>
Next scope: <whole unit / sections / question IDs>
Open questions:
- <question IDs or —>
```

## Append-only review entry

```markdown
## Review — <YYYY-MM-DD>

Type: <CALIBRATION | FULL | TARGETED | QUESTIONS_ONLY | SOURCE_REPAIR>
Scope: <whole unit or explicit subset>
Planned gap: <1 | 5 | 10 | 20 | 30 | 60 | 90 | 180 | baseline>
Actual elapsed gap: <complete days or baseline>

### Source preflight

Knowledge ID resolved: YES | NO
Unit path: <path>
Source status: <status>
Provenance checked: YES | NO
Reason: <not required / status / observed inconsistency>
Source problems found:
- <problem or none>

### Recall before looking at source

Could recall:
- <item>

Could not recall:
- <item>

Uncertain or confused:
- <item>

Provisional recall score: <0–4>

### Checked findings

- <MEMORY_GAP | SOURCE_GAP | NEW_QUESTION> — <finding>

### Deferred questions and clarifications

- <Q-id — short title>
- <none>

### Result

Final recall score: <0–4 or N/A for SOURCE_REPAIR>
Learning state: <NOT_REVIEWED | WEAK | RECOVERING | STABLE>
Consecutive unhinted fours: <number>
Next gap: <complete days>
Next review: <YYYY-MM-DD>
Next type: <type>
Next scope: <scope>
Override reason: <reason or —>
```

## Classification rule

```text
MEMORY_GAP
  authoritative material existed, but was not reconstructed correctly;

SOURCE_GAP
  unit/provenance was incomplete, ambiguous or contradictory;

NEW_QUESTION
  review exposed a useful question not required by the current recall contract.
```

A source gap must not lower recall merely because the checked material was incomplete. A memory gap must not trigger source repair without evidence of a source problem.
