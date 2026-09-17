# Render snapshots, batching, and memoization

Knowledge ID: `react.render-snapshots-batching-and-memoization`

Topic: `react`

A function component executes whenever React renders it. Helpers called in JSX execute immediately; `onClick={handleClick()}` calls during render, whereas `onClick={handleClick}` defers to the event. Render must be pure, and a render is not the same as a DOM commit—React may abandon work. Development Strict Mode may repeat calculations to expose impurity.

`useCallback` stabilizes a function identity and `useMemo` caches a pure computed value; neither prevents their own component from rendering. When a parent renders, React normally evaluates its children again; `React.memo` can skip a child only when the relevant prop-equality boundary holds. Fresh objects/functions defeat shallow prop equality, while context and child state can still rerender a memoized child. Keep state close to its consumers and prefer composition over blanket memoization. Cached values are optimizations, not semantic storage, and incomplete dependencies create stale closures.

Each render observes a fixed state snapshot. A setter requests later work; subsequent statements in the same handler—and async callbacks created by that render—still see the captured value. Batched `setCount(count + 1)` calls request the same next value, while functional updates compose and can remove a captured-state dependency from a memoized callback:

```tsx
setCount(previous => previous + 1);
setCount(previous => previous + 1);
```

Functional updater functions must remain pure because React may evaluate them more than once in development. Replace object/array state rather than mutating its snapshot; keep derivable values out of state. Refs hold mutable current data but do not request renders.

An external store owns state/listeners; React owns rendering/subscription lifecycle. A naive effect subscription can miss changes between render and effect and tear under concurrency. `useSyncExternalStore` supplies the supported bridge. Stable snapshots, selectors, equality, and exact cleanup determine rerender scope; notification schedules work but does not itself define the rendered result.

## Sources
- Workspace: `_ai-conspects/react state and rerenders, store subscriptions/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
