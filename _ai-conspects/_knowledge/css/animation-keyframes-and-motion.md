# CSS animation keyframes and motion

Knowledge ID: `css.animation-keyframes-and-motion`

Topic: `css`

Transitions interpolate after a property/state change; animations can start independently, contain multiple stages, repeat, alternate, pause, and retain keyframe presentation. The animation shorthand orders name, duration, timing, delay, iteration count, direction, fill mode, and play state. Duration defaults to zero.

`normal/reverse/alternate/alternate-reverse` control direction. `forwards` retains the final presented keyframe without rewriting underlying CSS; `backwards` applies the initial keyframe during delay; `both` combines them. `from/to` equal `0%/100%`; percentage stages add intermediate states. Comma-separated animations align property-list entries by position.

Listen for `animationstart`, `animationiteration`, `animationend`, and `animationcancel`, and remove listeners on disposal. Prefer compositor-friendly `transform`/`opacity` over layout-heavy geometry; use `will-change` sparingly. Respect `prefers-reduced-motion` while preserving essential state communication.

## Sources
- Workspace: `_ai-conspects/animation keyframes/`
- Processed source: `regions/final-transcript.md`, complete transcript
