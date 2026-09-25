# Consolidation / Consistency Notes

This v11 package supersedes earlier generated proposal packages from this conversation.

Key fixes:
1. Restored the explicit daily inbox lane: D0 collect → D+2 triage/materialize → D+8 first formative review.
2. Kept `UC-LEARNING-CAPTURE-BATCH` generic while making daily inbox the default personal workflow.
3. Updated Review UC so `ACTIVE` formative review and `STABLE` retention review no longer conflict.
4. Introduced separate `Recall State` so old WEAK/RECOVERING/STABLE memory semantics no longer collide with new `Learning State = ACTIVE/STABLE`.
5. Removed pseudo-class `CORE_CANDIDATE`; `UNDECIDED` is absence of assigned Retention Class, not another class.
6. Added one authoritative scheduling proposal with the existing useful interval ladder and score rules.
7. Removed duplicate simulation ownership; v6 has one end-to-end appendix.
8. Kept Concept distinct from Knowledge Unit and Questions attached to the knowledge map.
9. Kept Priority as the only owner of priority dimensions; Retention consumes its output.
10. Made integration hand off to learning/retention state without pretending new knowledge was already recalled.
11. Replaced semantic `Subarea` dependency with nestable Areas.
12. Changed expansion planning disposition `UNRESOLVED` to `NEEDS_CLARIFICATION`; unresolved is primarily an outcome after attempted resolution, not a planning decision.

13. Capture UC now owns only D0 capture/registration; D+2 semantic triage is a separate supporting process, keeping Situation/Result/Process boundaries cleaner.
14. ACTIVE formative and STABLE retention reviews share one review/repetition queue but use different scoring semantics.
15. Batch lifecycle ends after triage/handoff; it does not become a second owner of Unit/Question/review lifecycle.


16. Real-corpus Priority validation (22 representative Units) retained the four-dimension model; no recurring fifth dimension was required.
17. `Usefulness` is now explicitly relative to a current planning context/horizon rather than treated as an intrinsic timeless property.
18. Heterogeneous retention needs inside one Unit are treated first as a Knowledge Unit / Review Scope boundary issue; retention must not be averaged across materially different main content.
19. Scheduling now explicitly applies to the authoritative scheduled Review Scope, not automatically to every detail stored in the Unit file.


20. Canonical knowledge ownership is now explicit:
    - broad engineering concepts own their technology-specific implementations when the technology is primarily an implementation/context;
    - technology directories own defining language/runtime/framework mental models;
    - technology-defining manifestations of broader concepts remain canonical in the technology and are linked into the engineering map;
    - duplicate explanations across both locations are prohibited.

21. Cross-cutting tags are now explicit:
    - tag = logical topic grouping across canonical locations;
    - tags do not replace Area/Subarea, Technology, state, retention, or priority.

22. Comparison knowledge is now explicit:
    - substantial comparison is a real Knowledge Unit;
    - it is owned by the broader Concept being compared;
    - technology-core manifestations may remain physically elsewhere and be linked;
    - no mandatory analogue relation graph is required.

23. The analogy Use Case keeps its intent but no longer requires a shared relation vocabulary.
    Transfer, partial analogy, different solutions, misleading similarity, and non-equivalence are explained in ordinary comparison prose; no pairwise relation graph is required.

24. Software Engineering Map v3 is preserved as the latest best domain proposal, not final ontology.

25. The view model is intentionally reduced to three core projections:
    - Coverage & Expansion;
    - Expansion Plan;
    - Repetition.
    The canonical knowledge base is not itself a view.

26. Technology/topic/comparison navigation no longer requires separately maintained views:
    - technology and topic association use tags/filters;
    - comparison files are ordinary Knowledge Units discoverable by location/tags/type filter;
    - Technology Core remains only a canonical-ownership rule for defining technology models.

27. Technology tags are now explicitly valid (`python`, `dotnet`, `node`, `react`, etc.).
    This supersedes v9 wording that discouraged tags duplicating technology metadata.

28. Question placement is simplified:
    - Questions normally live where they most likely expand the map;
    - uncertain placement uses a local Area/nested-Area/Concept Question Inbox;
    - `origin`, `related_to`, `likely_expands`, and notes are optional context, not mandatory graph edges.

29. Key Questions are durable semantic responsibilities of Areas/nested Areas/Concepts.
    Open Expansion Questions are temporary growth work. A Question may evolve into a Key Question without requiring a rigid state machine.

30. Durable answers are integrated into canonical Knowledge/Comparison/Concept/Area locations.
    The Question does not become the canonical owner of its answer and may retain integration references after resolution.

31. Coverage & Expansion combines structural map, coverage, Questions, gaps, and growth edges.
    Expansion Plan adds time/order without moving or duplicating those semantic objects.

32. Repetition View now has an explicit operational shape (`Today / Upcoming / Attention / History`) and remains separate from Expansion Plan.
    Comparison Knowledge Units can be repeated; views/tags/plans cannot become repetition subjects merely by existing.

33. Capture/Triage, Question processing, Knowledge integration, and review execution are workflows/processes, not views.

34. Software Engineering Map v3 remains the latest taxonomy proposal, but its older suggestion of multiple cross-cutting views is superseded at the system level by the v10 minimal-view rule. The cross-cutting concerns themselves remain useful as tags/filters/analysis dimensions.

35. Repetition Scheduling Policy no longer owns a global daily-work order.
    - it schedules FORMATIVE/STABLE review work only;
    - Capture/Triage and Expansion Plan retain independent due/order semantics;
    - no global daily scheduler is part of the current model.

36. `UC-KNOWLEDGE-PLAN-EXPANSION` now explicitly owns optional temporal/order placement into Expansion Plan after semantic placement and priority are known.
    It does not coordinate Expansion against Repetition or Capture/Triage.

37. Local Question Inbox terminology is normalized to `Area / nested Area / Concept`.

38. Key Question identity is intentionally lightweight:
    - a defining local Key Question may exist without its own Question ID;
    - stable independent identity is required when the Question itself needs planning, lifecycle/history, references, priority, or resolution tracking.

39. The end-to-end simulation is updated to exercise v11 concepts: local Question Inbox, Coverage & Expansion, Expansion Plan, comparison-unit ownership, answer integration, and parallel Repetition.

