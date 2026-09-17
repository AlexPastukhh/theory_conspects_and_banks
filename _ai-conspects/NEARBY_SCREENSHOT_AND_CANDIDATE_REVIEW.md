# Nearby Screenshot and Candidate Review Rules

Generated: 2026-06-01 21:36:06 UTC

## Direction check

Goal:
Use candidate review without creating false "nearby" claims.

Now:
R01 v002 showed that candidate review is useful, but S-008 was wrongly described as nearby even though it is a distant right-side status block.

This rule:
Defines what "nearby screenshot" means and how candidate types should be named.

## Definition: nearby screenshot

A screenshot is `nearby` only when it is visually local to the current area.

Nearby can mean:

```text
same local cluster
same vertical road/column with reasonable continuation gap
adjacent parallel column under the same heading/topic
overlapping or touching local bounding area
small spatial gap relative to screenshot size
connected by clear visual layout or semantic continuation
```

Nearby does **not** mean:

```text
same y-band but far away on x-axis
close source_id order
same rough canvas height
nearest label coincidence
same exported batch
visible somewhere on the same screen zoom
```

## Candidate categories

Use explicit candidate types:

```text
seed-source
same-column-continuation
parallel-column-continuation
visually-close-local-neighbor
overlap/stacking-candidate
distant-same-band-safety-check
semantic-cross-check
excluded-with-reason
reassigned-with-reason
```

## Large conspect rule

For genuinely large conspects, candidate lists are good and expected.

But they must separate:

```text
real nearby candidates
distant safety candidates
semantic cross-checks
```

A distant safety candidate should not be called nearby.

## Example from React Query R01

```text
S-008 = distant same-band safety check, not nearby.
Reason: right-side statuses/fetchStatus/isLoading/isFetching block; different heading/topic; visually separate cluster.
```
