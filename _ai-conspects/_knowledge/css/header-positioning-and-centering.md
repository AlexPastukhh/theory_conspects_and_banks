# CSS header positioning and centering

Knowledge ID: `css.header-positioning-and-centering`

Topic: `css`

`fixed` leaves normal flow and is normally viewport-relative; give it explicit inline constraints because auto width may shrink to content. A robust page-header pattern uses a full-width fixed outer box (`inset-inline: 0`) and a centered inner container with `width: min(100% - 2rem, 72rem)` and `margin-inline: auto`. Reserve the removed height with page padding/spacer, and add background and `z-index`.

A floating fixed/absolute box can center itself with `left: 50%`, `transform: translateX(-50%)`, and a constrained width. `left` positions its left edge at center; the transform moves it back by half its own width. Auto margins for positioned boxes need a definite equation such as both inline edges plus an appropriate width.

`sticky` remains in flow, reserves space, and sticks only after a threshold such as `top: 0`, within its nearest relevant scroll ancestor and containing-block bounds. Unexpected ancestor `overflow`, a short container, missing threshold, or stacking/background can make it appear broken. In flex layouts, default cross-axis stretch may affect width; use a constrained width with `align-self: center` or suitable auto margins.

Choose sticky for an in-flow persistent page header, fixed for a viewport overlay, and absolute for a local component overlay that scrolls with its containing block. Sticky/max-width can work directly when a full-width background is unnecessary; use fixed outer plus centered inner when the background must span the viewport.

## Sources
- Workspace: `_ai-conspects/header max width, sticky,fixed/`
- Processed source: `01-final-transcript.md`, complete transcript
