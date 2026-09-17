# React deferred values and background rendering

Knowledge ID: `react.deferred-value-background-rendering`

Topic: `react`

`useDeferredValue(value)` lets an urgent render commit with the previous deferred value while React attempts the new dependent UI in the background. When that render completes, React commits the newer value. This is useful when the component receives a rapidly changing value but owns an expensive subtree rather than the update that produced the value.

```tsx
const deferredQuery = useDeferredValue(query);
const isStale = query !== deferredQuery;

return (
  <section aria-busy={isStale} style={{ opacity: isStale ? 0.6 : 1 }}>
    <MemoizedResults query={deferredQuery} />
  </section>
);
```

Memoization matters: deferring a value does not make rendering cheap if an unrelated parent render recreates all expensive work. The old UI can be marked stale, but it remains interactive and should not be presented as current without a cue.

Deferred rendering is interruptible/restartable and has no fixed wait. It is not debounce: every latest value is eligible for rendering, and no timer suppresses intermediate network calls. It is not a cache, request cancellation, or a free substitute for virtualization/query optimization.

Use `startTransition` when the component owns the state update and can mark it non-urgent. Use `useDeferredValue` when it receives a value and wants a lagging rendering view.

## Sources

- Workspace: `_ai-conspects/useTransition full flow, usedebounce, useDefferedvalue/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R01-R02
- Original SVG: `source/useTransition full flow, usedebounce, useDefferedvalue.svg`
