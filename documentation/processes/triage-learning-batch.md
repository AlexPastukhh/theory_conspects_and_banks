# PROCESS-TRIAGE-LEARNING-BATCH

Status: current supporting Process; not a standalone Use Case.

## Trigger
A raw learning batch has reached its delayed triage/materialization point.

## Result
Every meaningful item in the batch receives an explicit next disposition without treating the raw batch itself as permanent knowledge.

Typical dispositions:
- `DISCARD` — noise/duplicate/transient project detail;
- `QUESTION` — create/merge a tracked Question and route to expansion planning;
- `SOURCE` — preserve as evidence or route to source-conspect/materialization workflow;
- `KNOWLEDGE_CANDIDATE` — verify and integrate into an existing/new Knowledge Unit;
- `UNRESOLVED` — preserve uncertainty rather than guessing.

The batch records output references and can then close; Questions/Knowledge Units own their future lifecycle.

## Process
1. Reopen the raw batch with its context/provenance.
2. Remove exact duplicates/noise.
3. Verify claims that may become durable knowledge.
4. Route substantial source transcription/visual extraction to `UC-SOURCE-CREATE-CONSPECT` when needed.
5. Extract/merge Questions and route them through `UC-KNOWLEDGE-PLAN-EXPANSION`.
6. For accepted durable knowledge, call `PROCESS-INTEGRATE-VERIFIED-KNOWLEDGE`.
7. Preserve unresolved claims/questions explicitly.
8. Record affected Knowledge IDs, Question IDs, and source references on the batch for traceability.
9. For newly created/materially reshaped `ACTIVE` Units, register the default first FORMATIVE review due date in the common review/repetition state according to the active inbox workflow.
10. Close the batch once its outputs are handed to their canonical owners.

## Ownership boundary
This Process does not own:
- Question lifecycle after handoff;
- Knowledge Unit content after integration;
- Learning State semantics;
- Retention Class;
- repetition interval calculation.


## Migration compatibility

Current independently tracked expansion Questions belong in `_ai-conspects/_planning/QUESTIONS.csv` with semantic placement/context. Legacy `_ai-conspects/_repetition/QUESTIONS_BACKLOG.md` may still be used only where the pre-CS5 review workflow requires compatibility storage; it is not current expansion authority.

Until CS5 migrates repetition storage, any review scheduling written by this Process must use only the truthful fields supported by the current legacy implementation; do not invent target-state values.
