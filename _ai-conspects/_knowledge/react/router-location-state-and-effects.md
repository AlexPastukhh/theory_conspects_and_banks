# React Router location state and effects

Knowledge ID: `react.router-location-state-and-effects`

Topic: `react`

`useLocation` subscribes a component to the rendered router location. It requires router context and returns `pathname`, query `search` (including `?`), fragment `hash` (including `#`), transient navigation `state`, and history-entry `key`. Change it through navigation APIs, not mutation.

Use route params for path segments and normalize trailing slashes/basename according to router configuration. Parse simple queries with `URLSearchParams`; repeated/typed values need conventions. Changing query parameters creates a new location and can trigger loaders or effects. Hash is not sent to the server. State may disappear on reload/direct entry, so handle absence and never trust it with secrets.

Location changes rerender consumers, and the location object's identity may change when only one field changes. Derive the specific field needed and key effects to relevant fields unless every navigation matters. Clean timers/subscriptions and expect Strict Mode development repeats. Test under `MemoryRouter` or a memory data router with `initialEntries`; prefer route configuration to manual pathname switches. `useLocation` does not replace route params or loader data.

## What should be recallable

- Explain the core model of **React Router location state and effects** without opening the Unit.
- Reconstruct this Unit-grounded rule: `useLocation` subscribes a component to the rendered router location.
- Reconstruct this Unit-grounded rule: Use route params for path segments and normalize trailing slashes/basename according to router configuration.
- Reconstruct this Unit-grounded rule: Location changes rerender consumers, and the location object's identity may change when only one field changes.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/uselocation/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
