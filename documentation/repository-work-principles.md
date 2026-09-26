# Repository Work Principles

Status: current repository-specific principles.

Scope: repository form, semantic ownership, source/knowledge/question/memory boundaries, migration compatibility, and change invariants. Universal knowledge semantics live under `documentation/principles/`.

## Navigation and authority

- root `README.md` is structural entry;
- `documentation/README.md` maps methodology/guidance;
- `documentation/use-case-registry.md` is the functional entry;
- selected Use Case owns Situation / Result / Process;
- universal principles/policies own shared semantics;
- specialized source/image rules remain supporting mechanics;
- `documentation/migration/CURRENT-MIGRATION-STATE.md` owns temporary migration boundaries.

A proposal, index, generated report, legacy dashboard, or physical folder never becomes semantic authority merely because it is convenient to navigate.

## Layer boundaries

```text
Sources / Evidence
  preserve what external material actually contains

Knowledge
  canonical durable personal model

Questions / Coverage / Expansion
  growth state and planning objects

Memory / Repetition
  observed recall and scheduling state

Views
  projections over canonical knowledge/state, not owners
```

Sources, Knowledge, Questions, and Memory must not be collapsed into one record merely for convenience.

Current planning-layer physical projection:

```text
_ai-conspects/_planning/
  = operational Coverage / tracked Question / Expansion Plan state;
  = not a second semantic owner and not a global scheduler.
```

## Canonical knowledge identity

- Knowledge ID is stable identity.
- Every durable explanation has one canonical semantic home.
- Physical path is representation, not the sole semantic owner.
- Current topic folders intentionally remain during migration; current Area/nested-Area ownership must be read from the current domain map/hierarchy rather than inferred from folders.
- Tags provide cross-cutting retrieval and never create a second canonical owner.
- Comparison knowledge is a real Knowledge Unit when the comparison itself contains durable understanding.

## Source/provenance compatibility

Existing source-workspace mechanics remain valid where applicable:

- `CURRENT_SOURCE_OF_TRUTH.md` names the actual processed authority for a workspace;
- `KNOWLEDGE_REGISTRY.md` may record claim-level materialization only after real distribution;
- `MAPPED / MERGED / NON_LEARNING / UNRESOLVED` remain useful specialized dispositions;
- generated counts/status never prove semantic no-loss;
- original evidence is not rewritten merely to simplify the knowledge layer;
- text does not require fake visual coverage; visual material uses `image-conspect-principles.md`.

`UC-KNOWLEDGE-MATERIALIZE-SOURCE` is now the capability owner for accountable source-to-knowledge materialization; legacy source rules support it.

## Historical instruction boundary

Legacy source-processing artifacts may remain useful evidence or supporting mechanics, but their historical execution context is not current repository authority. In particular, old instructions that name paths such as `C:\Users\alexa\obs`, retired branches, historical ZIP/apply transport, or other environment-specific commands must not be executed merely because the file is present.

```text
legacy process/evidence text
+ historical path / branch / transport command
≠ current executable repository instruction
```

Reuse the underlying semantic/source-processing rule only when it is still valid under the current Use Case and current repository/source context. Revalidate any concrete path, branch, script, ZIP/apply command, or mutation instruction before execution.

## Coverage interpretation boundary

Repository representation must not collapse semantic structure and coverage evidence:

- the domain hierarchy answers where knowledge belongs;
- broad nested-Area occupancy is only a structural/primary-owner signal;
- responsibility coverage answers what the domain is expected to explain;
- manifestation coverage checks relevant technology-specific realizations;
- a gap does not need its own entity or Question ID unless planning/lifecycle requires one.

`MISSING` / `PARTIAL` / `COVERED` are scope-relative assessment results, not file-presence flags.

## Repetition transition boundary

The methodology migration has **not yet** converted `REPETITION_STATE.csv` or existing review history; that cutover belongs to CS5.

Target semantics are owned by:

- `principles/retention-repetition.md`;
- `policies/repetition-scheduling-policy.md`.

Existing `_ai-conspects/_repetition/*` policy/dashboard/inbox/backlog files remain transitional operational artifacts for the legacy state until CS5. They must not be interpreted as the target ontology, and legacy values must not be silently converted to `ACTIVE/STABLE`, Retention Class, or Recall State.

## Integrity invariants

- one current owner per Use Case;
- one stable Knowledge ID per durable Unit;
- no duplicate canonical semantic ownership;
- no invented review, score, interval, Learning State, Retention Class, or Recall State;
- review findings must distinguish memory failure from knowledge-base/source gaps;
- source claims and provenance must remain recoverable;
- scoped checks must not be presented as global audits;
- unrelated files remain untouched;
- commit/push/mass cleanup require their own explicit authorization.

## Published vs local evidence

Current `.gitignore` excludes some source workspaces and visual assets from Git. A published clone therefore may contain Knowledge/Memory layers without the local source evidence. A path reference does not prove that source evidence is currently available or re-verified.
