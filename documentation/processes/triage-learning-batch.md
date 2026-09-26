# PROCESS-TRIAGE-LEARNING-BATCH

Status: current supporting Process; not a standalone Use Case.

## Trigger
A raw learning batch has reached its delayed triage/materialization point.

## Result
Every meaningful item receives an explicit disposition without treating the raw batch itself as permanent knowledge.

Typical dispositions:
- `DISCARD` — noise/duplicate/transient detail;
- `QUESTION` — create/merge a tracked Question and route to Expansion;
- `SOURCE` — preserve as evidence or route to source-conspect/materialization;
- `KNOWLEDGE_CANDIDATE` — verify and integrate into an existing/new Knowledge Unit;
- `UNRESOLVED` — preserve uncertainty rather than guessing.

## Process
1. Reopen the raw batch with context/provenance.
2. Remove exact duplicates/noise.
3. Verify claims that may become durable knowledge.
4. Route substantial source transcription/visual extraction to `UC-SOURCE-CREATE-CONSPECT` when needed.
5. Extract/merge Questions and route them through `UC-KNOWLEDGE-PLAN-EXPANSION`.
6. For accepted durable knowledge, call `PROCESS-INTEGRATE-VERIFIED-KNOWLEDGE`.
7. Preserve unresolved claims/questions explicitly.
8. Record affected Knowledge IDs, Question IDs, and source references for traceability.
9. For each newly created/materially reshaped durable Review Scope, perform the D+2 retention handoff: assess/update Retention Class when useful, register/update the Repetition Map item, and choose a sensible next review date from the actual materialization date using current context/retention guidance.
10. Treat this D+2 work as the first learning/review contact, but do not invent a blind-recall score or Recall State evidence.
11. Close the raw batch once outputs are handed to their canonical owners.

## Ownership boundary
This Process does not own:
- Question lifecycle after handoff;
- Knowledge Unit content after integration;
- Priority dimensions or Retention Class semantics;
- repetition interval formulas.

It applies the current owners at the D+2 handoff point.

## Migration compatibility
Until CS5 migrates repetition storage, do not fabricate target Retention Class, Recall State, review history, or interval values in legacy files. If the target retention decision cannot yet be represented truthfully in legacy storage, preserve the evidence/need for CS5 rather than pretending it already exists.
