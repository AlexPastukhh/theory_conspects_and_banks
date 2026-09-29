# SVG geometry with getBBox

Knowledge ID: `javascript.svg-getbbox-geometry`

Topic: `javascript`

`getBBox()` returns the smallest axis-aligned rectangle containing an SVG graphics element's rendered geometry in its current SVG user coordinate system:

```js
const node = document.querySelector(".inner-search-container .link-primary svg");
if (node instanceof SVGGraphicsElement) {
  const { x, y, width, height } = node.getBBox();
  console.log({ x, y, width, height });
}
```

`querySelector` may return `null`; narrow the expected SVG type and measure only after its geometry exists. `getBBox()` answers relationships inside SVG user coordinates. `getBoundingClientRect()` returns a viewport-relative CSS rectangle for aligning HTML with the visible result. Transforms, scrolling, scaling, and nested coordinate systems make them different.

The basic box is driven by geometry and fill. Stroke, markers, clipping, filters, and optional bounding-box options need separate consideration. Measure the group, path, text, or other graphics element whose combined geometry is required. Zero dimensions may be valid. Hidden, detached, or not-yet-laid-out content may not match its final state, and the box is not the exact shape outline.

## What should be recallable

- Null-safe SVG narrowing and `x/y/width/height` extraction.
- User coordinates versus viewport CSS coordinates.
- Geometry, lifecycle, zero-size, and axis-aligned-box caveats.

## Sources

- Workspace: `_ai-conspects/svg/`
- Processed source: `02-full-combined-final-transcript.md`, complete transcript
- Original SVG and extracted evidence remain in the workspace.
