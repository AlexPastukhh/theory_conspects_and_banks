# BEM component naming and Sass organization

Knowledge ID: `css.bem-component-naming`

Topic: `css`

BEM names independent blocks (`card`), meaningful parts (`card__title`), and API variants (`card--compact`, `card__title--muted`). Modifiers complement the base class. A documented `is-active` convention may represent transient state. Name by responsibility, avoid chained element names and mixed separators.

Flat class selectors keep specificity low and decouple CSS from DOM depth. Blocks should work in different containers; parent layout classes/mixes handle external placement. Do not make every node a block or encode every data value as a modifier.

In Sass, `&__element` and `&--modifier` construct flat names; do not mirror the DOM through deep nesting. Keep block rules together, split only when navigation improves, and keep shared tokens/utilities outside component names. Multiple block classes can compose on one node. Prefer mixins/utilities over coupled `@extend` chains and inspect compiled selectors.

## What should be recallable

- Explain the core model of **BEM component naming and Sass organization** without opening the Unit.
- Reconstruct this Unit-grounded rule: BEM names independent blocks (`card`), meaningful parts (`card__title`), and API variants (`card--compact`, `card__title--muted`).
- Reconstruct this Unit-grounded rule: Flat class selectors keep specificity low and decouple CSS from DOM depth.
- Reconstruct this Unit-grounded rule: In Sass, `&__element` and `&--modifier` construct flat names; do not mirror the DOM through deep nesting.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources

- Workspace: `_ai-conspects/BEM/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
