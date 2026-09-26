# Personal Knowledge System Migration Plan — v1

> **Current correction (superseding both the earlier `ACTIVE/STABLE` design and the later over-sparse correction):** current owners do not use a universal Knowledge Unit maturity state. Current personal retention policy aims to keep essentially all durable Review Scopes visible in the Repetition Map, with `CORE | WORKING | RECOGNITION | MAP_ONLY` used as qualitative/advisory retention flags rather than a rigid state machine. D+2 materialization is the first learning/review contact and map-entry/update point; for important CORE knowledge five clear days is a useful default next active-recall interval, while manual date choice from context/workload remains normal. Historical sections below remain provenance; follow `CURRENT-MIGRATION-STATE.md`, `CS5-REPETITION-CUTOVER-ANALYSIS.md`, `../principles/retention-repetition.md`, and `../policies/repetition-scheduling-policy.md` where they differ.

Status: migration plan/provenance based on the original checked snapshot and accepted target methodology. Historical counts/wording in later sections describe the state at planning time. **`CURRENT-MIGRATION-STATE.md` is authoritative for the current snapshot whenever they differ.**

Source snapshot:
`theory_conspects_and_banks-main (3).zip`

Target:
transition the current repository toward the accepted v11 Personal Knowledge System model without losing existing Knowledge IDs, provenance, knowledge content, or future repetition continuity.

## Execution progress

```text
CS1  canonical universal methodology             COMPLETE
CS2  102-ID semantic-map pilot                   COMPLETE
CS3  full 576-ID provisional semantic map        COMPLETE
CS4  Coverage / Questions / Expansion            COMPLETE
CS5 preparation: Review Scope + boundaries       COMPLETE
CS5 structural prep: recursive nested Areas       COMPLETE
CS5 structure semantic review                     COMPLETE
CS5 responsibility-first coverage refinement      COMPLETE
CS5 snapshot handoff/methodology audit             COMPLETE
CS5  repetition cutover                           NEXT
CS6  physical representation decision            PENDING / optional
CS7  legacy cleanup + final consistency audit    PENDING
```

Current resolved pre-CS5 state:

```text
Knowledge IDs                  576 / 576
primary semantic homes         576 CLEAR
explicit Review Scope          576 / 576
recursive nested-Area paths    576 / 576
ambiguous owner kind           0
legacy repetition state        unchanged
```

---

## 1. Initial checked state (source snapshot)

The source snapshot initially had:

- 576 unique Knowledge IDs;
- 0 duplicate Knowledge IDs;
- 576 rows in `REPETITION_STATE.csv`;
- no meaningful existing review history;
- all current repetition rows are effectively uncalibrated / not reviewed;
- 406 Knowledge Units already expose an explicit recall contract / `What should be recallable`;
- 170 Knowledge Units do not yet expose an explicit Review Scope;
- the v11 target methodology already exists in-repository as a proposal;
- the Software Engineering Map v3 is still a proposal, not yet a final ontology.

Important consequence:

> this is a good migration point because semantic structure and repetition rules can be changed before substantial review history accumulates.

---

## 2. Migration principles

### 2.1 Semantic migration before physical migration

Do not start by moving the 576 Knowledge Unit files.

First determine:

- canonical semantic ownership;
- Area / nested Area / Concept;
- technology context;
- tags;
- Review Scope;
- ambiguity / repair needs.

Physical file layout is a later representation decision.

```text
semantic ownership
≠ physical folder
```

### 2.2 Preserve Knowledge ID identity

A file move or semantic reclassification must not create a new Knowledge ID.

```text
same durable knowledge
→ same Knowledge ID
```

### 2.3 Do not infer ACTIVE from NOT_REVIEWED

Legacy:

```text
NOT_REVIEWED
```

does not imply:

```text
ACTIVE
```

These mean different things.

Target distinction:

```text
Learning State
  ACTIVE / STABLE

Recall State
  UNCALIBRATED / observed recall state

Retention Class
  CORE / WORKING / RECOGNITION / MAP_ONLY
```

A mature Knowledge Unit can be:

```text
STABLE + UNCALIBRATED
```

### 2.4 Review Scope is required before normal repetition

The new repetition model reviews:

```text
Knowledge ID
+
Review Scope
```

Therefore the 170 Units without explicit Review Scope must be audited before full repetition cutover.

### 2.5 Software Engineering Map v3 must be validated on the real corpus

Do not promote Map v3 to final ontology before a stratified pilot over existing Knowledge IDs.

### 2.6 Preserve useful legacy source/provenance mechanics

Existing source-workspace migration rules such as:

- claim-level no-loss;
- `MAPPED / MERGED / NON_LEARNING / UNRESOLVED`;
- source preservation;
- `KNOWLEDGE_REGISTRY`;
- loss auditing;

remain useful supporting mechanics.

They may move under the newer `UC-KNOWLEDGE-MATERIALIZE-SOURCE` ownership model rather than being discarded.

---

# 3. Target operational model

## Canonical knowledge

```text
Domain
└── Area
    └── nested Area / Concept
        ├── Key Questions
        ├── Knowledge Units
        ├── Comparison Units
        ├── Open Expansion Questions
        └── local Question Inbox
```

Cross-cutting access:

```text
tags
├── python
├── dotnet
├── node
├── caching
├── cancellation
└── ...
```

Core operational views:

```text
1. Coverage & Expansion
2. Expansion Plan
3. Repetition
```

Capture/Triage remains a workflow, not a View.

There is no current global scheduler ranking:

```text
Capture/Triage
Expansion
Repetition
```

against one another.

---

# 4. Migration sequence

```text
PHASE 1
Canonical universal methodology

        ↓

PHASE 2
Software Engineering semantic-map pilot
80–120 IDs
NO FILE MOVES

        ↓
      GATE
Validate / refine Map v3

        ↓

PHASE 3
Full 576-ID semantic mapping
+ Review Scope normalization

        ↓

PHASE 4
Coverage / Questions / Expansion operationalization

        ↓

PHASE 5
Repetition cutover

        ↓

PHASE 6
Physical representation decision
optional

        ↓

PHASE 7
Legacy cleanup + final consistency audit
```

---

# 5. ChangeSet plan

## CS1 — Canonicalize accepted universal methodology

Goal:

Make the accepted v11 universal methodology the current canonical methodology without migrating the 576 Knowledge Units or repetition state yet.

### Work

Canonicalize the accepted current meaning for:

- Use Cases;
- universal principles;
- knowledge ontology;
- priority model;
- Questions / Coverage / Expansion;
- tags / comparisons / views;
- retention / repetition semantics;
- capture / triage;
- verified knowledge integration;
- source materialization.

Update the functional/navigation surfaces:

- root `README.md`;
- `documentation/use-case-registry.md`;
- repository-work principles;
- knowledge-conspect principles;
- relevant current owner files.

### Important boundary

Do not simply copy the entire proposal package into current authority.

Classify proposal artifacts by role:

```text
semantic owner
supporting process
policy
domain proposal
example
changelog/history
audit/consistency note
```

Only current semantic owners become operational authority.

### Preserve

Keep useful specialized source/image/provenance rules where still valid.

### Do not do yet

- no Knowledge Unit moves;
- no 576-ID semantic remapping;
- no repetition state conversion;
- no final adoption of Software Engineering Map v3.

### Acceptance

- one current universal methodology;
- one current Use-Case registry;
- no competing current repetition methodologies;
- proposal/history files do not compete with current semantic owners;
- 576 Knowledge Units remain untouched;
- existing repetition state remains untouched;
- Software Engineering Map v3 remains a working proposal.

---

## CS2 — Semantic-map pilot

Goal:

Validate the Software Engineering ontology and ownership rules against the real corpus.

### Sample

Select approximately 80–120 Knowledge IDs, stratified across major current topics, including at least:

- .NET;
- ASP.NET Core;
- EF Core;
- JavaScript;
- React;
- HTTP;
- Architecture;
- Security;
- SQL Server;
- smaller topics where useful.

### For each sampled Knowledge ID record

```text
Knowledge ID
canonical Area
nested Area / Concept
canonical-owner type
technology context
tags
Review Scope status
ambiguity / repair issue
```

### Test explicitly

- Are the 15 Areas sufficient?
- Is canonical ownership natural?
- Does the Technology Core exception work?
- Do tags replace the need for separate Technology Views?
- Are comparison ownership rules natural?
- Are any Areas being used as catch-alls?
- Are repeated Concepts appearing under multiple Areas?
- Are there Units whose boundaries are themselves wrong?

### Do not do

- no physical file moves;
- no mass metadata rewrite across all 576 IDs.

---

## GATE — Validate / refine Software Engineering Map

The pilot is successful only if the map works without forcing knowledge into unnatural homes.

Review:

```text
canonical-owner ambiguities
repeated Concepts
catch-all Areas
Technology Core ambiguity
cross-cutting retrieval through tags
comparison ownership
missing Concepts / nested Areas
```

Possible outcomes:

```text
Map v3 accepted with minor refinement
Map v3 revised
ownership rules revised
technology-core boundary revised
```

Do not continue to full mapping while major ambiguity remains.

---

## CS3 — Full 576-ID semantic mapping

Goal:

Create complete authoritative semantic mapping for the current corpus.

For every Knowledge ID determine:

```text
Knowledge ID
Domain
Area
nested Area / Concept
canonical semantic owner
technology context
tags
Review Scope status
migration notes
```

### Review Scope audit

Classify every Unit as:

```text
REVIEW_SCOPE_EXPLICIT
REVIEW_SCOPE_DERIVABLE
REVIEW_SCOPE_REPAIR_REQUIRED
UNIT_BOUNDARY_REVIEW_REQUIRED
```

The 170 currently lacking explicit recall scope must be resolved through this pass.

### Acceptance

```text
input Knowledge IDs = 576
mapped Knowledge IDs = 576
unowned = 0
duplicate canonical ownership = 0
```

Every Unit must have a usable Review Scope or an explicit repair disposition.

No physical move is required for CS3.

---

## CS4 — Operationalize Coverage / Questions / Expansion

Goal:

Make structural growth of the knowledge base operational.

### Coverage & Expansion

Create projection over the canonical map showing:

- existing knowledge;
- `COVERED / PARTIAL / MISSING`;
- Key Questions;
- Open Expansion Questions;
- local Question Inboxes;
- emerging Concepts / nested Areas;
- expansion directions.

Example:

```text
Cancellation                         PARTIAL

Key Questions
✓ What is cooperative cancellation?
✓ How is cancellation propagated?
? Who owns cancellation lifetime?
? How does structured concurrency affect ownership?

Existing knowledge
✓ general cancellation model
✓ .NET manifestation
✓ Node manifestation

Missing
- Python manifestation
- structured concurrency interaction
```

### Question model

Question placement:

```text
Area / nested Area / Concept
├── Key Questions
├── Open Expansion Questions
└── Question Inbox
```

Simple defining Key Questions do not require a standalone Question ID.

Independent Question identity is needed when the Question itself needs:

- planning;
- lifecycle/history;
- references;
- priority;
- resolution tracking.

### Expansion Plan

`UC-KNOWLEDGE-PLAN-EXPANSION` may place selected expansion work into:

```text
Today
Tomorrow
Later
specific date / simple order
```

Semantic ownership remains in Coverage & Expansion.

---

## CS5 structural preparation — Recursive Area / nested-Area hierarchy

Goal:

Turn the old Map v3 Subarea completeness checklist plus the resolved 576-ID mapping into an operational recursive domain hierarchy before repetition cutover.

Rules:

```text
Subarea = nested Area
Area may contain nested Area
nested Area may contain further nested Area
Concept remains distinct from Area
```

The pass must not promote every provisional Concept into an Area. Promote/retain a nested Area when it gives a stable semantic boundary for multiple Concepts/Units, Key Questions, or coverage responsibility. Durable empty nodes may remain when the domain model requires them even if the current corpus has no Unit there.

Acceptance:

```text
Knowledge IDs with root Area            576 / 576
Knowledge IDs with nested-Area path     576 / 576
root Areas                              15
physical Knowledge Unit moves            0
repetition-state changes                  0
```

Concrete nested-area placement is also a second-level audit of the root Area assignment: if a Unit cannot fit naturally into a real nested Area, reassess the root instead of inventing a fake Subarea.

Current realization: `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`.

## CS5 — Repetition cutover

Goal:

Replace the legacy repetition model with the accepted v11 model after semantic mapping and Review Scope readiness.

### Target state axes

```text
Learning State
  ACTIVE
  STABLE

Retention Class
  CORE
  WORKING
  RECOGNITION
  MAP_ONLY

Recall State
  UNCALIBRATED
  observed recall state
```

### Migration rule

For each existing Unit:

```text
if knowledge model + Review Scope are coherent
→ Learning State = STABLE
→ Recall State = UNCALIBRATED

if knowledge model itself is still being formed/repaired
→ Learning State = ACTIVE
```

Do not mechanically map:

```text
NOT_REVIEWED → ACTIVE
```

### Retention assignment

Assign independently:

```text
CORE
WORKING
RECOGNITION
MAP_ONLY
```

If not yet decided:

```text
UNDECIDED
```

may be used as a migration state until reviewed.

Do not derive retention mechanically from legacy `ReviewPriority`.

### Repetition object

```text
Knowledge ID
+
Review Scope
```

### Interval ladder

Retain the accepted clear-day ladder:

```text
1 → 5 → 10 → 20 → 30 → 60 → 90 → 180
```

### Initial wave

Legacy `INITIAL_WAVE_QUEUE.csv` should stop being architectural authority.

Its purpose becomes naturally representable as:

```text
STABLE
+
Recall State = UNCALIBRATED
```

which means a calibration review is still required.

### Finding routing

```text
MEMORY_GAP
→ repetition

KNOWLEDGE_BASE_GAP
→ Coverage & Expansion

NEW_QUESTION
→ Questions / Coverage & Expansion
```

No global repetition-owned daily scheduler should rank repetition against Triage or Expansion.

---

## CS6 — Physical representation decision

Goal:

Decide whether physical file movement is useful after semantic mapping is complete.

This is deliberately not assumed.

Possible outcomes:

### A — no mass moves

Keep existing physical topic folders and use:

- canonical mapping;
- indexes;
- tags;
- links;
- generated/query views.

### B — partial moves

Move only paths where physical location materially harms ownership/navigation.

### C — broad reorganization

Only if a concrete use case proves it is worth the migration cost.

### Invariant

```text
physical move
≠ new Knowledge ID
```

Any physical migration must preserve:

- Knowledge ID;
- body;
- provenance;
- links;
- Review Scope;
- repetition state;
- semantic mapping.

---

## CS7 — Legacy cleanup and consistency audit

Goal:

Remove obsolete operational artifacts only after the new system has replaced their responsibility.

Candidates include:

- old initial-wave machinery;
- old daily study plan;
- old repetition policy;
- old global Questions backlog model;
- old areas-priority map;
- generated apply/manifests/audits;
- permission-test files;
- superseded dashboards.

Classify before removal:

```text
still authoritative
→ retain

historical evidence
→ preserve/archive

generated obsolete
→ delete

temporary/test artifact
→ delete
```

### Final checks

- no duplicate semantic owners;
- no conflicting current policies;
- all 576 Knowledge IDs still present exactly once;
- all canonical mappings resolve;
- Review Scopes are usable;
- repetition state matches current Knowledge IDs;
- Coverage & Expansion references valid concepts/questions;
- tags do not replace canonical ownership;
- comparison Units have correct broader Concept ownership;
- source/provenance evidence remains reachable or explicitly limited.

---

# 6. Critical migration gates

## Gate A — after CS1

Question:

> Is there exactly one current universal methodology and one functional Use-Case entry?

If no, do not begin semantic mapping.

## Gate B — after CS2 pilot

Question:

> Does the Software Engineering map naturally classify real knowledge without forcing ownership?

If no, revise the map before all-576 mapping.

## Gate C — after CS3

Question:

> Are all 576 IDs mapped uniquely and do all Units have a usable Review Scope or explicit repair disposition?

If no, do not cut repetition over.

## Gate D — after CS5

Question:

> Can repetition operate exclusively from Knowledge ID + Review Scope + new state axes without relying on legacy initial-wave/daily-order semantics?

If no, keep legacy mechanism until the missing migration rule is resolved.

## Gate E — before CS7 cleanup

Question:

> Has every legacy artifact's responsibility been replaced or intentionally retained as history/evidence?

If no, do not delete it.

---

# 7. What we intentionally do NOT decide yet

The following are intentionally deferred:

- final physical folder structure;
- whether all 576 files should ever move;
- final controlled tag vocabulary;
- final ontology commitment beyond the current validated working frame;
- final UI/storage representation for Coverage & Expansion;
- final UI/storage representation for Expansion Plan;
- retention class for every Unit before semantic review;
- whether a higher-level combined daily dashboard is useful.

These are not missing requirements. They are decisions whose evidence comes from later migration phases.

---

# 8. Immediate next action

Proceed with:

```text
CS5 — Repetition cutover
```

Prerequisite gates are now closed:

- all 576 Knowledge IDs have one current primary semantic home;
- all 576 Knowledge Units have an explicit authoritative Review Scope;
- semantic boundary and Unit-boundary work is resolved;
- Coverage / Questions / Expansion is already operational;
- legacy `REPETITION_STATE.csv` and `INITIAL_WAVE_QUEUE.csv` remain untouched, so the state transition can still be performed without inventing history.

The CS5 implementation pass must:

1. define the target repetition-state schema;
2. classify current Units as `STABLE + UNCALIBRATED` versus genuinely `ACTIVE` from knowledge maturity, not from legacy `NOT_REVIEWED`;
3. assign Retention Class independently from legacy `ReviewPriority`;
4. migrate all 576 rows without inventing recall scores, dates, intervals, or history;
5. make calibration eligibility representable without `INITIAL_WAVE_QUEUE.csv` as architectural authority;
6. update current repetition views/tooling to target semantics;
7. preserve legacy artifacts only as transition/history until the cutover is validated.

Physical Knowledge Unit movement remains outside CS5.
