# Pseudo-element positioning, stacking, and clipping

Knowledge ID: `css.pseudo-element-positioning-and-stacking`

Topic: `css`

## Generated box and containing block

A `::before` or `::after` pseudo-element is generated as a child-like box of its originating element. Set `content` when it needs a generated box, then position it against an intentional containing block.

For a local covering layer:

```css
.component {
  position: relative;
}

.component::before {
  content: "";
  position: absolute;
  inset: 0;
}
```

The absolute box covers its containing block, not automatically the viewport. `position: fixed; inset: 0` normally covers the viewport, but an ancestor transform can establish a different containing block for fixed descendants. Viewport units can size a box but do not fix containing-block or stacking problems.

A pseudo-element cannot be reparented into another DOM element or portal root. Its placement remains tied to the originating element.

## Stacking-context boundary

A pseudo-element cannot escape a stacking context created by its owner or an ancestor. Its `z-index` is compared inside that context; even a huge value cannot outrank a sibling context whose parent layer already wins.

Common context triggers include opacity, transform, filter, isolation, and positioned elements with a non-`auto` `z-index`.

To diagnose a layer that remains underneath:

1. walk from the pseudo-element owner toward the root;
2. list every stacking-context ancestor;
3. compare the first ancestor contexts that are siblings;
4. remove accidental context triggers or move overlay responsibility higher in the DOM.

Negative `z-index` can place the pseudo-element behind its owner's own background, so it is not a universal escape mechanism.

## Clipping is a separate problem

Overflow, masks, clip paths, and containment can clip the box independently of `z-index`. Diagnose stacking and clipping separately: raising a layer cannot escape an ancestor clip.

Set pointer-event behavior deliberately. A decorative layer may need `pointer-events: none`; an interactive backdrop needs intentional hit testing and is often better represented by a real element.

## What should be recallable

- How `content`, absolute/fixed positioning, `inset`, and containing blocks determine pseudo-element geometry.
- Why viewport sizing does not solve transformed containing blocks or stacking.
- Why a child-like pseudo-element cannot escape its ancestor stacking context and how to diagnose competing contexts.
- How clipping, negative `z-index`, and pointer events differ from ordinary stacking order.

## Sources

- Workspace: `_ai-conspects/pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el/`
- Processed source: `04-full-combined-final-transcript.md`, R01–R02
- Original SVG: `source/pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el.svg`
