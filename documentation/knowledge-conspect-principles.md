# Knowledge Unit Principles

Status: current repository-specific principles for creating/changing durable Knowledge Units.

Universal identity/ownership semantics are defined by [Knowledge Structure & Ontology](principles/knowledge-structure-ontology.md).

## Unit boundary

A Knowledge Unit is one coherent durable model that can be independently reviewed/explained. Its boundary follows meaning, not screenshot count, file length, source section, technology folder, or collection day.

One source may produce several Units; one Unit may use several verified sources.

## Stable identity and canonical home

- preserve a stable unique Knowledge ID;
- search for semantic overlap before creating another Unit;
- extend/merge when the same durable model already exists;
- choose one canonical semantic home;
- current physical topic path may remain transitional and is not by itself final ownership;
- add tags/ordinary links for cross-cutting retrieval instead of duplicating the explanation.

## Body and Review Scope

The body must support the Unit's Review Scope. Preserve the important causal model, mechanics, boundaries, failure modes, trade-offs, and representative examples needed to reconstruct that scope.

`What should be recallable` is an accepted current representation of Review Scope, but the semantic contract is the scope itself, not the exact heading.

If one file contains materially heterogeneous retention/review needs, revisit the Unit/Review Scope boundary rather than averaging incompatible needs into one schedule.

## Provenance

Separate:

- exact source/evidence;
- source-preserving normalization;
- durable personal knowledge;
- interpretation/hypothesis;
- unresolved Question.

Do not add plausible model knowledge as verified fact without suitable evidence when provenance is required. Existing source workspace rules and `KNOWLEDGE_LAYER_RULES.md` remain specialized support for whole-source materialization.

## Questions and durable answers

A Question is not automatically a Knowledge Unit. A checked answer is integrated into the canonical Knowledge destination: update an existing Unit, create a new Unit, create a comparison Unit, refine Concept/Area structure, or decide that no durable knowledge is needed.

The current `_ai-conspects/_planning/QUESTIONS.csv` is the operational registry for independently tracked expansion Questions. Legacy `_repetition/QUESTIONS_BACKLOG.md` may still exist for compatibility with the pre-CS5 review workflow, but it is not current expansion authority.

## Learning / repetition transition

New or materially reshaped knowledge uses target `ACTIVE/STABLE` semantics conceptually, but the current pre-CS5 repository must not fabricate those fields inside legacy `REPETITION_STATE.csv`. Until CS5 cutover, use only the truthful legacy operational storage contract and record migration needs explicitly.

Content change never proves recall and must never create synthetic review history, scores, or intervals.

## Quality invariant

For material admitted from a source scope, meaningful claims must remain recoverable from the resulting canonical knowledge or explicitly unresolved/non-learning disposition. Index/count equality alone is not proof of no-loss.
