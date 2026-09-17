# Fullscreen modal overlay and accessible backdrop

Knowledge ID: `css.fullscreen-modal-overlay`

Topic: `css`

## Robust overlay structure

A deeply nested component pseudo-element is fragile as an application-wide modal backdrop because it remains constrained by ancestor containing blocks, stacking contexts, and clipping. Prefer a dedicated overlay element rendered near the document root or into a portal container.

Use a deliberate application layer:

```css
.modal-backdrop {
  position: fixed;
  inset: 0;
  z-index: var(--layer-modal-backdrop);
}
```

Place the dialog above the backdrop within the same planned overlay context. A documented layer token is more reliable than an arbitrary enormous `z-index` inside a nested context.

## Modal interaction and accessibility

A dark rectangle is not a complete modal. While it is open:

- lock background scrolling;
- trap focus inside the dialog;
- make background content inert or otherwise inaccessible;
- after close, restore focus to the element that opened it.

A real backdrop node is preferable when the backdrop needs click handling, transitions, or accessibility state.

## When a pseudo-element is sufficient

A pseudo-element can provide local decorative dimming when its owner already occupies the correct top-level layer. It should not be used to simulate a portal or to bypass an ancestor stacking context.

Test nested transforms because they can change fixed positioning behavior. Also test mobile viewport behavior rather than assuming desktop `position: fixed; inset: 0` covers every browser state correctly.

## What should be recallable

- Why a root-level element or portal is more robust than a deeply nested pseudo-element for application modals.
- How fixed geometry, a deliberate overlay context, and documented layer tokens compose the visual layer.
- Scroll locking, focus trapping/restoration, background inertness, and why a dark backdrop alone is incomplete.
- When local pseudo-element dimming remains appropriate and which transform/mobile caveats require testing.

## Sources

- Workspace: `_ai-conspects/pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el/`
- Processed source: `04-full-combined-final-transcript.md`, R03 with R01–R02 constraints
- Original SVG: `source/pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el.svg`
