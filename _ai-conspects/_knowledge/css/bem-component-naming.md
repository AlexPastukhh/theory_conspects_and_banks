# BEM component naming and Sass organization

Knowledge ID: `css.bem-component-naming`

Topic: `css`

BEM names independent blocks (`card`), meaningful parts (`card__title`), and API variants (`card--compact`, `card__title--muted`). Modifiers complement the base class. A documented `is-active` convention may represent transient state. Name by responsibility, avoid chained element names and mixed separators.

Flat class selectors keep specificity low and decouple CSS from DOM depth. Blocks should work in different containers; parent layout classes/mixes handle external placement. Do not make every node a block or encode every data value as a modifier.

In Sass, `&__element` and `&--modifier` construct flat names; do not mirror the DOM through deep nesting. Keep block rules together, split only when navigation improves, and keep shared tokens/utilities outside component names. Multiple block classes can compose on one node. Prefer mixins/utilities over coupled `@extend` chains and inspect compiled selectors.

## Sources

- Workspace: `_ai-conspects/BEM/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
