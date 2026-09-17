# Flex item shrinking and basis

Knowledge ID: `css.flex-item-shrink-and-basis`

Topic: `css`

Although `flex-shrink` defaults to 1, a row item's `min-width: auto` can clamp it at min-content width. Put `min-width: 0` on the item that must shrink; use `min-height: 0` for the analogous column case. Choose wrapping/clipping/ellipsis on the inner text without hiding content that must remain accessible.

`flex` combines grow, shrink, basis: `1` commonly means `1 1 0%`, `auto` means `1 1 auto`, `none` means `0 0 auto`, and the initial value is `0 1 auto`. Zero basis distributes from equal starts; auto uses main-size/content. Negative free space is weighted by shrink factor × base size, then min/max constraints clamp results.

Equal-width controls need equal bases (`flex: 1 1 0`) plus `min-width: 0`, not merely equal grow. Fixed sides use `0 0 width`; a center uses `1 1 auto` plus zero min width. Gap sits outside distributed widths. Account for wrapping, zoom/localization, and responsive stacking.

## Sources
- Workspace: `_ai-conspects/flex item ,flex shrinking/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
