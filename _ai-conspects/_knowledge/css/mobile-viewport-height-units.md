# CSS mobile viewport height units

Knowledge ID: `css.mobile-viewport-height-units`

Topic: `css`

Legacy `100vh` can exceed the currently visible mobile page because browser chrome appears/disappears and some browsers historically resolve it against the largest viewport. Symptoms include clipped bottom controls, unexpected scrolling, jumps, and fixed-header/footer overlap. Viewport sizing does not itself add safe-area padding.

Choose the semantic viewport deliberately:

- `100svh` uses the smallest stable viewport, keeps controls visible, and may leave unused space after browser chrome retracts;
- `100lvh` uses the largest stable viewport for an immersive canvas, so content may sit behind visible chrome;
- `100dvh` follows the current visible viewport and can resize while chrome animates;
- legacy `100vh` remains a useful fallback, with browser/version-dependent behavior.

Prefer `min-height` when content can grow. Add safe-area insets for cutouts/home indicators and test the virtual keyboard and orientation separately:

```css
.full-screen {
  min-height: 100vh;
  min-height: 100dvh;
  padding-bottom: env(safe-area-inset-bottom);
}
```

Dynamic updates can visibly move content and add layout work. A short transition may soften discrete changes but should not delay critical controls; expensive descendants can make repeated viewport updates costly. Stable `svh`/`lvh` values do not animate with browser UI, and content taller than any viewport still needs ordinary document scrolling.

Before modern units, a common fallback measured one percent of `window.innerHeight` and stored it as `--vh`:

```js
function updateViewportUnit() {
  const vh = window.innerHeight * 0.01;
  document.documentElement.style.setProperty("--vh", `${vh}px`);
}

updateViewportUnit();
window.addEventListener("resize", updateViewportUnit);
```

Use `height: calc(var(--vh, 1vh) * 100)`, recalculate for resize/orientation, debounce rapid events, remove listeners at disposal, and avoid `window` during SSR. This workaround adds lifecycle code and possible initial layout shift; prefer progressive CSS enhancement when `svh`/`lvh`/`dvh` meet the design.

## Sources
- Workspace: `_ai-conspects/SVH DVH LVH/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
