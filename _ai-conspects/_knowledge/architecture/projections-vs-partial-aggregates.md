# Projections versus partially initialized aggregates

Knowledge ID: `architecture.projections-vs-partial-aggregates`

Topic: `architecture`

Partial selection is safe when a repository returns an explicitly limited DTO, anonymous projection, read model, or custom query result. The anti-pattern is returning a behavior-bearing domain entity while silently omitting state required by its invariants.

A partial aggregate can expose behavior that assumes missing state, fail later, mislead maintainers, and blur query projections with aggregate roots. Constructors alone are not sufficient: persistence materialization, alternate/private constructors, reflection, or post-construction field population may create state differently.

Make the contract explicit:

- return named summary/read-model types for limited queries;
- use a query service or CQRS read side;
- keep projections from exposing domain behavior;
- load enough state before invoking aggregate behavior;
- prevent incomplete aggregates from escaping the repository.

`GetStudentSummary(...)` may safely return course and grade in a summary. Returning a `Student` with only a few fields while enrollment, eligibility, or invariant methods remain callable is dangerous.

## What should be recallable

- Partial projection versus partial aggregate.
- Invariant and delayed-failure risks.
- Why constructors do not alone guarantee safe materialization.
- Explicit query contracts and full aggregate loading.

## Sources

- Workspace: `_ai-conspects/partially initialized antipattern and possible partial inits inside repositories/`
- Processed source: `01-final-transcript.md`, complete transcript
- Preserved screenshots and SVG remain authoritative for exact wording.
