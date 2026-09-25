# Change Log — v10

Relative to v9:

1. Reduced the view architecture to three core views:
   - Coverage & Expansion View;
   - Expansion Plan;
   - Repetition View.
2. Removed the redundant `Knowledge View` idea: the canonical knowledge structure is the base itself.
3. Removed the need for separately maintained Technology/Tag/Comparison views; technology/topic retrieval now defaults to tags/filters.
4. Explicitly allowed technology tags such as `python`, `dotnet`, `node`, and `react`.
5. Preserved Technology Core only as a canonical-ownership exception, not as a reason to maintain a duplicate technology map.
6. Added local Question Inboxes at Area/nested-Area/Concept level for uncertain placement.
7. Added durable Key Questions as statements of what an Area/nested Area/Concept is expected to explain.
8. Simplified Question context: `origin`, `related_to`, `likely_expands`, and notes are optional hints rather than mandatory graph edges.
9. Clarified answer integration: durable results go to canonical Knowledge/Comparison/Concept/Area locations; the Question keeps references/history.
10. Defined Coverage & Expansion as one structural projection combining map, coverage, questions, gaps, and growth edges.
11. Defined Expansion Plan as the separate temporal/actionable projection of growth work.
12. Defined Repetition View with `Today`, `Upcoming`, `Attention`, and `History` and one queue separating ACTIVE formative from STABLE retention semantics.
13. Clarified that comparison Knowledge Units may participate in repetition, while views/tags/plans do not.
14. Explicitly classified Capture/Triage and similar activities as workflows/processes, not views.
15. Preserved Software Engineering Map v3 taxonomy, while marking its older multi-view suggestions as superseded by the v10 system-level view principle.
