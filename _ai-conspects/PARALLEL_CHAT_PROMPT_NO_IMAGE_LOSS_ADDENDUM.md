# Addendum Prompt - No-image-loss and Candidate Review

Use this addendum for any chat processing Excalidraw conspects.

```text
Do not trust old Stage2 region assignments as final boundaries.

Also do not blindly trust the new coverage/review ledger.
The ledger is a checklist so images are not forgotten; it is not a source of truth.

Candidate review is good for large conspects, but every candidate must be labeled precisely:
- same-column-continuation
- parallel-column-continuation
- visually-close-local-neighbor
- overlap/stacking-candidate
- distant-same-band-safety-check
- semantic-cross-check
- excluded-with-reason
- reassigned-with-reason

Nearby means visually local to the same cluster/road/column or adjacent parallel column.
Nearby does not mean merely same y-band, close source order, or same zoom screenshot.

Before closing a region:
- review ledger candidates;
- re-scan nearby coordinates;
- re-scan vertical roads/columns;
- re-scan parallel columns;
- check visually close images even if no arrows point to them;
- read candidates enough to judge semantic fit;
- include/exclude/reassign with explicit reasons.

No image may disappear.
If a nearby image belongs to a previous region, update that previous region instead of forcing it into the current one.
```
