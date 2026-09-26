# Universal Knowledge Principles

Status: current semantic owner.

## 1. Human-first
The primary consumer is the owner. Optimize first for understanding, navigation, learning, repetition, transfer, and useful personal representation. AI is a tool, not the ontology's primary consumer.

## 2. Universal methodology; domain-specific ontology
Universal rules define knowledge lifecycle, questions, priority, sources, repetition, and view semantics. Each Domain defines its natural ontology and specializations. Do not force Software Engineering categories onto Design or future Domains.

## 3. Completeness is scope-relative
Aim for semantic completeness only within an explicit chosen scope. "Complete" never means all human knowledge.

## 4. Semantic completeness, not documentation duplication
Cover meaningful concepts, mechanisms, distinctions, capabilities, models, trade-offs, failure modes, and comparisons. Do not clone exhaustive volatile reference documentation.

## 5. Coverage != Retention
A Concept/Knowledge Unit may deserve representation without active memorization.

## 6. Obvious != unnecessary
Simple knowledge may still matter for mapping, connections, or cross-technology comparison.

## 7. Priority guides effort, not existence
Priority influences order, depth, practice, repetition strength, and deferral. It should not normally erase semantically meaningful Concepts from the map.

Priority is interpreted relative to a current planning context/horizon; especially Usefulness may change without changing the semantic value of the knowledge itself.

## 8. Personal representation is valuable but not factual authority
Preserve useful personal mental models, analogies, examples, and grouping while keeping formal/current claims and limits explicit where needed.

## 9. Questions are first-class planning objects
Questions can exist before Knowledge Units and are part of how the map grows.

Prefer placing a Question near the Area / nested Area / Concept it most likely expands. When placement is uncertain, use a local Question Inbox at the nearest sensible Area / nested Area / Concept. Keep `origin`, `related_to`, `likely_expands`, and similar details as optional context rather than mandatory graph edges.

## 10. Key Questions define knowledge responsibilities
Areas, nested Areas, and Concepts may carry durable Key Questions: questions that state what that part of the map is expected to explain.

A Key Question does not disappear merely because it has been answered; once covered, it becomes an explainable part of coverage.

A simple defining Key Question may live locally as part of an Area/Concept definition without its own stable Question ID. Give it independent Question identity only when it needs its own planning, lifecycle, references, history, or resolution tracking.

## 11. Answers integrate into canonical knowledge
A resolved Question is not automatically the canonical home of its answer.

Durable results should update/create the appropriate Knowledge Unit, comparison Unit, Concept, or Area. The Question may retain references to those results.

## 12. Comparisons are first-class knowledge
Similarity, difference, transfer, and non-equivalence can be durable knowledge.

When comparison itself creates a useful mental model, represent it as a real comparison Knowledge Unit owned by the broader Concept being compared. Prefer a clear human explanation over a forced machine-readable analogy graph.

Do not force analogies.

## 13. Sources, captured material, knowledge, questions, and memory are different responsibilities
Source existence does not prove integration. Knowledge existence does not prove memory. A Question does not automatically imply a durable claim.

## 14. Capture before premature normalization
Raw learning may first enter a batch/inbox. Collection time is allowed to be messy; semantic verification and partitioning happen later. This protects learning flow from constant note-design overhead.

## 15. Practice is evidence, not automatic knowledge
Practice may reveal durable mechanisms/questions, but project-specific noise should not flood the base.

## 16. Learning/formative work is workflow-owned
Do not introduce a universal state on every Knowledge Unit merely to represent whether learning/formative work is currently happening.

Formative learning may be a normal part of a learning workflow: capture/materialization may schedule a later reconstruction, practice pass, scope check, or related follow-up. That work is owned by the workflow that created it and exists only while that workflow needs it. It does not require every Knowledge Unit to carry a persistent maturity state.

If repeated Use Cases later prove a shared durable field is necessary, add only the narrowest representation those Use Cases require.

## 17. Memory condition is separate from retention intent
Observed recall condition is not Retention Class. Repetition records it separately as Recall State/history.

## 18. Stable identity survives presentation changes
Tracked Knowledge Units and Questions should retain identity through title/path/layout changes.

## 19. Growth is continuous
Organize → surface Questions/gaps → prioritize → learn/compare/practice → integrate → retain/review where useful → reorganize.

## 20. Keep review scopes coherent
Do not average fundamentally different memory needs merely because content currently lives in one file. Prefer a coherent Unit/Review Scope boundary before adding per-claim scheduling complexity.

## 21. Keep structure as simple as Use Cases allow
Do not add entities, statuses, fields, registries, relations, or views without a real use-case need.

## 22. Canonical ownership follows semantic subject
A Knowledge Unit has one canonical semantic home.

- Broad engineering concepts own technology-specific implementations when those implementations are mainly instances of the broader concept.
- A technology owns knowledge that explains its own defining language/runtime/framework model.
- When a technology-defining model is also a manifestation of a broader concept, keep one canonical technology-owned Unit and link it from the broader engineering concept.
- Do not duplicate the same explanation across technology and engineering locations.

Physical location is secondary to semantic ownership and retrieval mechanisms.

## 23. Tags are lightweight cross-cutting retrieval
Use tags for knowledge that is useful to retrieve together across canonical locations.

Tags may represent:
- logical topics such as `caching`, `streaming`, `cancellation`;
- technologies/ecosystems such as `python`, `dotnet`, `node`, `react`.

This avoids maintaining duplicate Technology/Topic maps merely for retrieval. Tags do not change canonical ownership and should not duplicate operational fields such as Retention, Recall State, or Priority.

## 24. Comparison ownership follows the broader concept
Cross-technology comparison knowledge belongs canonically to the broader Concept/Area that makes the comparison meaningful.

Technology-specific manifestations normally live with that broader Concept. When a manifestation is a defining part of the technology itself, it may remain in Technology Core, while the comparison still stays with the broader Concept and links to the technology-owned Unit.

## 25. The canonical base is not a view
Areas → nested Areas → Concepts → Knowledge Units/Key Questions constitute the knowledge structure itself.

Do not invent a `Knowledge View` merely to display the base.

## 26. Maintain only views with distinct operational meaning
The current core view set is intentionally small:

```text
Coverage & Expansion View
Expansion Map
Repetition View
```

- Coverage & Expansion shows the structural map plus coverage, questions, gaps, and growth edges.
- Expansion Map is the lightweight projection of explicitly selected expansion work and may be empty.
- Repetition View is the temporal/actionable projection of what existing knowledge to reconstruct and maintain.

Technology, tags, comparisons, quality attributes, performance, and similar dimensions should default to filters/tags/navigation rather than separately maintained views unless a future use case proves otherwise.

## 27. Workflows are not views
Capture/Triage, Question processing, Knowledge integration, and Review execution are workflows/processes. A view may support a workflow, but the workflow is not itself a projection of the knowledge base.

## 28. Structure and coverage are different questions
A hierarchy answers **where knowledge belongs**. Coverage answers **what a scoped part of the domain is expected to explain and whether current durable knowledge is sufficient**.

Do not derive completeness from folder occupancy, Unit count, or the mere existence of a nested Area. A responsibility may be missing inside a populated Area, and a responsibility may have partial evidence from Units whose primary home is elsewhere.

## 29. Discover gaps responsibility-first, manifestations second
Start completeness analysis from general domain responsibilities, mechanisms, failure modes, decisions, and Key Questions. Then check relevant technology manifestations.

Do not build the ontology by pairing concrete tools one-to-one. A technology comparison can reveal a responsibility that should also be checked in other relevant ecosystems, including the historically dominant one. `NO_USEFUL_DIRECT_EQUIVALENT` / `NOT_APPLICABLE` are valid outcomes.

## 30. Coverage claims are explicit and conservative
`PARTIAL` means some durable evidence exists for an explicit scope, not that the scope is mostly complete. `MISSING` means evidence is insufficient for that explicit scope, not that no related file exists. `COVERED` requires an explicit adequacy judgment against the chosen responsibility/Key Questions.

Coverage projections at different levels (Area roll-up, nested-Area occupancy, responsibility coverage, manifestation coverage) must not be silently treated as the same status.
