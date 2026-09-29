# CSS animation keyframes and motion

Knowledge ID: `css.animation-keyframes-and-motion`

Topic: `css`

Transitions interpolate after a property/state change; animations can start independently, contain multiple stages, repeat, alternate, pause, and retain keyframe presentation. The animation shorthand orders name, duration, timing, delay, iteration count, direction, fill mode, and play state. Duration defaults to zero.

`normal/reverse/alternate/alternate-reverse` control direction. `forwards` retains the final presented keyframe without rewriting underlying CSS; `backwards` applies the initial keyframe during delay; `both` combines them. `from/to` equal `0%/100%`; percentage stages add intermediate states. Comma-separated animations align property-list entries by position.

Listen for `animationstart`, `animationiteration`, `animationend`, and `animationcancel`, and remove listeners on disposal. Prefer compositor-friendly `transform`/`opacity` over layout-heavy geometry; use `will-change` sparingly. Respect `prefers-reduced-motion` while preserving essential state communication.

## What should be recallable

- How CSS animations differ from transitions and what animation keyframes add beyond a single state transition.
- The meaning of direction and fill modes, including why `forwards` changes presentation without rewriting underlying CSS.
- Which animation lifecycle events matter and why listeners need cleanup.
- Why `transform`/`opacity`, restrained `will-change`, and `prefers-reduced-motion` matter for performance and accessibility.

## Sources
- Workspace: `_ai-conspects/animation keyframes/`
- Processed source: `regions/final-transcript.md`, complete transcript
