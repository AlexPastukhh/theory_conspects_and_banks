# UC-KNOWLEDGE-ORGANIZE-DOMAIN — Organize Domain Understanding

## Situation
A domain or part of it contains fragmented knowledge, unclear boundaries, mixed abstraction levels, weak relationships, or is only beginning to take shape.

The need is primarily to improve the structure of understanding and expose semantic responsibilities/gaps, not necessarily to research every missing fact.

## Result
A more coherent and useful personal model of the domain:
- scope is clearer;
- meaningful recursive Areas and Concepts are visible;
- important relationships are explicit;
- general responsibilities are distinguished from concrete technology manifestations;
- known coverage and gaps are visible independently of current corpus occupancy;
- useful personal mental models are preserved.

The structure is allowed to evolve as understanding improves.

## Process
1. Define the scope being organized.
2. Gather relevant existing knowledge.
3. Identify durable domain responsibilities: what this scope should explain even if current knowledge is absent.
4. Identify meaningful Concepts and concept families from both domain semantics and existing knowledge.
5. Establish useful Area boundaries and recursive nesting. Do not force uniform depth; `Subarea` is simply a nested Area.
6. Keep responsibilities separate from ontology nodes: create/refine an Area or Concept only when a stable semantic boundary/subject exists, not merely because a checklist row exists.
7. Separate structural uncertainty from missing content.
8. Check relevant technology manifestations after the generic responsibility is clear; use cross-technology comparison to expose reverse gaps without forcing one-to-one tool analogues.
9. Resolve structural uncertainty inside this Use Case.
10. Route missing knowledge to `UC-KNOWLEDGE-PLAN-EXPANSION`; do not automatically create a tracked Question for every gap.
11. Update the domain representation and coverage projections.
12. Do not automatically research every discovered gap.

## Boundary
This Use Case answers:

> How should what is known and expected-to-be-known be organized, and where are the meaningful structural/coverage gaps?

It does not require filling all discovered gaps, and it does not equate existing Unit count with completeness.
