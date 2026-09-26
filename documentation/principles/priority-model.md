# Priority Model

Status: current semantic owner.

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
Ask how valuable ready memory availability is: Leverage + Consequence + Usefulness + inverse External Recoverability. The Retention owner maps that input to the desired retention treatment for the Review Scope.

For the current personal system, the Repetition Map is intended to cover essentially the durable corpus at different strengths rather than only a small selected subset. Priority therefore helps distinguish **how strongly and how often** a Scope should be revisited, not whether low-priority knowledge ceases to matter. Easy-to-recover or low-leverage material can fall to `RECOGNITION` or `MAP_ONLY` rather than being dropped from the map.

Do not assign a class mechanically from a single legacy priority field. The four dimensions plus the actual Review Scope and current planning context are decision inputs, not a formula. Retention Class is a qualitative/advisory flag: the owner may assign or change it by judgment, and AI may recommend a class without turning that recommendation into a mandatory score or transition rule.

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

## Domain interpretation
Domains may explain how the four dimensions manifest (e.g. production blast radius, accessibility) but should not create competing universal models without evidence.

## Reassessment triggers
Reassess when the planning context/goals change materially, External Recoverability changes materially, content is substantially rewritten, or practice/review shows the previous assessment was wrong. Avoid constant recalculation.

## Validation evidence
The first real-corpus validation over 22 representative current Knowledge Units did not reveal a recurring fifth priority dimension.

It did reveal two design requirements now reflected in the current model:
- Usefulness must be interpreted relative to an explicit planning context/horizon;
- heterogeneous retention needs inside one Unit are primarily a Knowledge Unit / Review Scope boundary problem, not a reason to add priority dimensions.

See `documentation/validation/priority-model-real-corpus-validation-v1.md`.
