# CSS flex centering, axes, and defaults

Knowledge ID: `css.flex-centering-axes-and-defaults`

Topic: `css`

An anchor is inline by default, so assigning `height` does not create the intended clickable box; its visible line box still follows line-height and font metrics. Make navigation links `flex`/`inline-flex` and center their contents. Binary operators in `calc()` require spacing.

```css
.navLink {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 8rem;
  height: calc(var(--header-height) - 2rem);
}
```

`display:flex` creates a block-level flex container; `inline-flex` keeps inline-level outer behavior. Defaults are row main axis, `nowrap`, `justify-content:flex-start`, `align-items:stretch`, `align-content:stretch`, and zero gap. Items default to `flex: 0 1 auto`, `order:0`, and `align-self:auto`.

`justify-content` aligns on the main axis; `align-items` aligns items within each flex line on the cross axis; `align-content` distributes multiple lines and matters only when wrapping produces them. `flex-direction` changes the main axis, `flex-wrap` controls lines, and `gap` separates items. Item-level grow, shrink, basis, order, and align-self control allocation and overrides.

Automatic minimum sizes can stop shrinking at intrinsic content size. Set `min-width:0` or `min-height:0` on the relevant flex child when it must shrink or scroll inside a constrained layout.

## What should be recallable

- Explain the core model of **CSS flex centering, axes, and defaults** without opening the Unit.
- Reconstruct this Unit-grounded rule: An anchor is inline by default, so assigning `height` does not create the intended clickable box; its visible line box still follows line-height and font metrics.
- Reconstruct this Unit-grounded rule: `display:flex` creates a block-level flex container; `inline-flex` keeps inline-level outer behavior.
- Reconstruct this Unit-grounded rule: `justify-content` aligns on the main axis; `align-items` aligns items within each flex line on the cross axis; `align-content` distributes multiple lines and matters only when wrapping produces them.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/flex,centering etc/`
- Processed source: `01-final-transcript.md`, complete transcript
