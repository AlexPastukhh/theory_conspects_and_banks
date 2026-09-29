# Knowledge Layer Rules

Status: active production-migration protocol

Scope: extracting independently reviewable knowledge units from the source-preserving workspaces under `_ai-conspects/`.

## 0. Content-preservation invariant

Knowledge migration is a semantic partition of the authoritative learning content, not a summarization pass.

For one source workspace, the union of its knowledge units must preserve approximately all meaningful learning content from the authoritative processed source. A learner must not need to reopen the full transcript to recover a caveat, API limitation, important distinction, meaningful example or code mechanic, failure mode, performance tradeoff, lifecycle detail, subtle semantic, or the reason behind a rule that belonged to the unit.

Preferred operations are:

```text
CUT source-grounded material by meaning
MOVE it into the appropriate unit
CONSOLIDATE only exact or genuinely redundant repetition
REORDER for a coherent independent explanation
LIGHTLY NORMALIZE wording and formatting
```

Do not compress the material into a short recap, rewrite it from memory, or replace concrete mechanics with a list of keywords. Longer content-preserving units are preferable to short lossy units. A unit may be 30, 80, or 150 lines when its semantic boundary requires that much material.

The source workspace remains unchanged and is still the source of truth.

## 1. Architecture and ownership

```text
source SVG / screenshots
    -> processed conspect workspace
    -> canonical Knowledge Unit
    -> Engineering Area / Technology Core navigation
    -> repetition by Knowledge ID
```

The layers have different ownership:

```text
_ai-conspects/<workspace>/
  = source-preserving processed representation and evidence;

_ai-conspects/_knowledge/engineering/<area>/<broad-nested-area>/<unit>.md
  = Area-owned independently reviewable learning unit;

_ai-conspects/_knowledge/technology-core/<technology>/<unit>.md
  = technology-owned defining language/runtime/framework/library unit;

_ai-conspects/_knowledge/engineering/<area>/INDEX.md
  = broad Area navigation, including links to relevant Technology Core Units;

_ai-conspects/_knowledge/technology-core/<technology>/INDEX.md
  = Technology Core navigation for one technology/ecosystem;

_ai-conspects/_knowledge/INDEX.md
  = physical-navigation entry point for Engineering Areas and Technology Core;

<workspace>/KNOWLEDGE_REGISTRY.md
  = coverage map from one source conspect to knowledge units.
```

Knowledge extraction must not delete, replace, rename, or rewrite the source SVG, transcript, audit, manifest, or evidence files.

## 2. Migration cadence

Production migration remains gradual:

```text
one conspect
-> review boundaries and coverage
-> adjust rules when evidence requires it
-> next conspect
```

Process an explicitly selected batch of one or more workspaces per migration iteration. Batch size is an execution choice, not permission to merge workspace audits: resolve and verify every workspace independently. Reduce the batch size whenever source quality, semantic overlap, or unresolved claims make the full batch unsafe to complete.

Do not change the repetition system during an ordinary knowledge migration.

## 3. Choose a source workspace

Before extraction:

1. inspect the current branch and worktree;
2. read the current processing, source-availability, source-of-truth, audit, and repetition rules;
3. resolve the workspace's authoritative processed transcript and audit status;
4. resolve the original SVG only through repository evidence;
5. prefer a source whose textual representation is trustworthy enough for learning;
6. inspect existing knowledge topics and units before creating anything.

Do not silently upgrade an uncertain or incomplete transcript into trusted knowledge.

## 4. Knowledge-unit boundary

A knowledge unit has one coherent central model that can be recalled independently in roughly 5–15 minutes.

It should be:

- understandable without reopening the complete source conspect;
- large enough to include its necessary examples, caveats, and comparisons;
- small enough to receive an independent repetition schedule later;
- named by stable meaning rather than by source position.

Source structure is evidence, not the target taxonomy:

```text
source region / heading != knowledge unit
```

Depending on meaning:

- one source region may become one unit;
- several source sections may be combined into one unit;
- one source region may be split across several units;
- one workspace may contribute units to several topics.

Do not create a unit for every example, edge case, syntax detail, screenshot, heading, or region.

## 5. Canonical routing

Route each durable Unit by semantic ownership, not by source workspace or historical `Topic:` value.

Default case: a broader engineering concept owns ordinary implementations. Store the Unit under the matching Engineering Area and its first durable broad nested Area.

Technology Core exception: when the Unit's main subject is a defining language/runtime/framework/library model, store it under `technology-core/<technology>/`. If that defining model is also relevant to a broad engineering concept, keep one canonical technology-owned Unit and link to it from the Engineering Area navigation; do not duplicate the learning body.

The historical `Topic:` field and Knowledge ID prefix remain stable identity/provenance metadata. They are not physical routing commands.

Mixed-topic workspaces must still route every Unit by its central model. A source about one ecosystem can therefore contribute Units to several Engineering Areas and to Technology Core.

Do not redesign the ontology preemptively. Use the current domain map and hierarchy, preserve filenames/Knowledge IDs unless a deliberate semantic migration requires otherwise, and treat physical folders as representation of canonical ownership rather than a second ontology.

## 6. Stable identity and duplicate prevention

Every unit requires an explicit identifier:

```text
Knowledge ID: <topic>.<semantic-name>
Topic: <topic>
```

Knowledge IDs must be lowercase, meaningful, unique, and independent of temporary source numbering or file location.

Before creating a unit:

1. search the global Knowledge Index, Area/Technology Core indexes, and unit files for semantic matches;
2. distinguish a related concept from a duplicate concept;
3. if the same unit exists, extend it with verified source knowledge and provenance;
4. update every affected registry;
5. do not create numbered duplicates such as `concept-2`.

When overlap is real but incomplete, keep the concepts separate and add an explicit related-knowledge reference rather than merging aggressively.

## 7. Source-grounded content

Knowledge units are extracted from the workspace's checked processed material. Do not silently fill source gaps with general model knowledge.

A unit should normally contain:

```text
title
Knowledge ID
Topic
core model
important details and source-backed examples when useful
what should be recallable
related knowledge when it clarifies a boundary
sources/provenance
```

Provenance must identify at least:

- the source workspace;
- the authoritative processed file;
- the relevant section or region when available;
- the original SVG path when reliably established by repository evidence.

The `What should be recallable` section is a verification contract: every listed recall item must be fully answerable from the body of that same unit. It must not merely name details removed during extraction.

Preserve source-backed examples when they demonstrate syntax, object shape, control flow, state transitions, ownership boundaries, or a failure condition. Consolidate examples only when they teach the same mechanic without losing a distinct claim.

Do not copy processing status, screenshot inventory, OCR mechanics, manifests, or audit bookkeeping into learning content.

## 8. No silent omission

Every substantial source claim or meaningful area must have an auditable disposition. Section-level routing alone is insufficient when a rich section contains several independently checkable claims.

If a source statement is not carried into a unit because it appears disputed, incorrect, ambiguous, unsupported, or outside the intended boundary, do not omit it silently. Record it in the workspace `KNOWLEDGE_REGISTRY.md` with an explanation.

Use the existing coverage states:

```text
MAPPED
  -> represented in a new unit;

MERGED
  -> incorporated into an already existing unit;

NON_LEARNING
  -> processing/evidence metadata rather than material for repetition;

UNRESOLVED
  -> a meaningful claim cannot yet be classified or safely extracted.
```

A disputed or potentially erroneous learning claim remains `UNRESOLVED` until its source is corrected or its disposition is explicitly decided. `NON_LEARNING` must not be used merely to hide uncertainty.

An area routed to another unit or topic is still `MAPPED` or `MERGED`; its destination must be named.

## 9. Per-workspace coverage registry

Every migrated workspace requires `KNOWLEDGE_REGISTRY.md` containing:

- source workspace and authoritative processed source;
- original SVG identity when reliable;
- every meaningful source area;
- destination Knowledge ID, topic, and file;
- one coverage state per area;
- boundary decisions that are not obvious;
- summary counts for `MAPPED`, `MERGED`, `NON_LEARNING`, and `UNRESOLVED`.

The registry answers whether meaningful knowledge was lost. It is not the navigation index for a whole topic.

Coverage must be checked at claim level. The registry may group closely related claims in one row, but each row must name enough concrete content to verify that the destination unit actually contains it. Statements such as "section mapped" or "all screenshots represented" do not prove knowledge preservation by themselves.

Zero `UNRESOLVED` is desirable but must never be achieved by silently dropping or misclassifying uncertain material.

## 10. Index updates

For each affected canonical owner, update the appropriate navigation index:

```text
_ai-conspects/_knowledge/engineering/<area>/INDEX.md
_ai-conspects/_knowledge/technology-core/<technology>/INDEX.md
```

Area indexes list Area-owned Units and may also link to Technology Core Units whose semantic placement belongs to that Area. Technology Core indexes list the canonical technology-owned Units. Do not duplicate a Unit merely to make it visible from both surfaces.

Update `_ai-conspects/_knowledge/INDEX.md` when a new root navigation surface is introduced. The global index points to Engineering Areas and Technology Core; it is not a 576-row registry.

## 11. Completion check

Before finishing one migration:

1. confirm every workspace selected for the iteration was processed and audited independently;
2. confirm original source/evidence files were not altered by the migration;
3. confirm all Knowledge IDs are unique;
4. confirm every topic and unit link resolves;
5. review possible semantic duplicates;
6. perform the coverage pass, including explicit omissions;
7. report all `UNRESOLVED` items;
8. check that unit boundaries follow meaning rather than headings;
9. confirm repetition state was not mass-created or migrated;
10. inspect the scoped diff and avoid unrelated changes.

Also perform a loss audit:

1. compare each unit body against its routed source claims;
2. confirm caveats, edge cases, examples with unique mechanics, limitations, failure modes, tradeoffs, lifecycle details, and explanations of why were retained;
3. confirm every recall item is answered in the same unit;
4. confirm every intentional exclusion is explicit in the registry;
5. reject a superficially complete registry when its units strongly compress a rich transcript.

Existing units are not automatically trusted. Audit and repair them only when comparison with their authoritative source demonstrates concrete information loss. Preserve their Knowledge ID, topic, path, and registry identity when the semantic boundary is still valid; add source-grounded material rather than redesigning taxonomy without need.

Batch processing does not relax these requirements. Every workspace in a batch still requires separate source resolution, semantic partitioning, duplicate search, full content-preservation review, registry update, coverage check, and unresolved-item check.

## 12. Validated boundary patterns

The first three migrations demonstrate supported patterns, not templates that must be copied:

```text
set js
  source regions approximately match knowledge units;

headers
  several source sections and regions are regrouped by meaning;

options requ
  one source workspace contributes to both http and aspnet-core.
```

Future migrations must derive boundaries from their own source content.
