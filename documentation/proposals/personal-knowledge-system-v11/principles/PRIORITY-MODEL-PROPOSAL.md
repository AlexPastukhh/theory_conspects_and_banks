# Priority Model — proposal v6

Status: proposal.

## Goal
Decide cheaply and consistently:
- what to learn first;
- how deeply;
- which Questions to defer;
- what deserves practice;
- what should be more available from memory.

## Four dimensions

### Leverage
How much understanding improves reasoning/work elsewhere. Includes foundationality, transferability, connection/dependency value.

### Consequence
Cost of misunderstanding/ignoring/misapplying it. Includes decision impact, failure/security cost, late-discovery cost, blast radius.

### Usefulness
Likelihood the owner will need it in the **current planning context / horizon**. Includes frequency, current goals, foreseeable use, and personal relevance.

Usefulness is not an intrinsic timeless property of a Knowledge Unit. The same knowledge may be HIGH in one work/learning period and MEDIUM/LOW in another.

### External Recoverability
How cheaply and reliably a correct answer can be recovered **and verified** externally. Includes source availability/reliability/stability, ease of verification, and cost of detecting plausible-but-wrong output. "AI can answer" alone is not high recoverability.

## Derived decisions
The dimensions are inputs, not one universal score.

### Expansion Priority
What should be learned/resolved first? Primarily Leverage + Consequence + Usefulness, moderated by Recoverability.

### Required Depth
How deeply should it be understood? Primarily Leverage + Consequence + Usefulness. Do not create a hidden fifth "complexity" dimension; complexity matters only through its real effects on these dimensions.

### Retention Input
How valuable is ready memory availability? Leverage + Consequence + Usefulness + inverse External Recoverability. The Retention owner maps this to a Retention Class.

## Scale
Default qualitative scale: `HIGH | MEDIUM | LOW`. Add numbers only if real use proves necessary.


## Planning context / horizon
Every priority assessment is interpreted relative to a current planning context.

A context may include:
- active Domains/Areas;
- current or expected technology stacks;
- current learning goals;
- foreseeable work horizon;
- relevant personal constraints.

Prefer one shared current context per Domain/learning period rather than copying the same context into every Knowledge Unit.

Reassess Usefulness when the context changes materially. Do not treat changing Usefulness as evidence that the underlying knowledge became semantically less important.

## Questions
Question appearance does not imply immediate research. Work dispositions are `PURSUE_NOW | DEFER | DISCARD | NEEDS_CLARIFICATION`.

## Learning State independence
`ACTIVE` does not mean high priority; `STABLE` does not mean low priority. Priority is effort/value; Learning State is model maturity.

## Domain interpretation
Domains may explain how the four dimensions manifest (e.g. production blast radius, accessibility) but should not create competing universal models without evidence.

## Reassessment triggers
Reassess when the planning context/goals change materially, External Recoverability changes materially, content is substantially rewritten, or practice/review shows the previous assessment was wrong. Avoid constant recalculation.

## Validation evidence
The first real-corpus validation over 22 representative current Knowledge Units did not reveal a recurring fifth priority dimension.

It did reveal two design requirements now reflected in the proposals:
- Usefulness must be interpreted relative to an explicit planning context/horizon;
- heterogeneous retention needs inside one Unit are primarily a Knowledge Unit / Review Scope boundary problem, not a reason to add priority dimensions.

See `appendices/PRIORITY-MODEL-REAL-CORPUS-VALIDATION-v1.md`.
