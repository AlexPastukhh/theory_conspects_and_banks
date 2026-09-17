# React Context provider identity and splitting

Knowledge ID: `react.context-provider-identity-and-splitting`

Topic: `react`

Consumers subscribe to the nearest provider. When `value` changes by `Object.is`, every consumer of that context is eligible to rerender; React does not track which fields were read, and context updates bypass `React.memo` consumers.

Memoize provider object values when unrelated renders would create new identity. Stabilize callback members first; raw state setters and reducer `dispatch` are already stable. Split frequently changing state from stable actions when their consumers have different update needs:

```tsx
const removePageError = useCallback(() => {
  setPageError(undefined);
}, []);

const value = useMemo(
  () => ({ pageError, setPageError, removePageError }),
  [pageError, removePageError],
);
```

```tsx
<DispatchContext.Provider value={dispatch}>
  <StateContext.Provider value={state}>{children}</StateContext.Provider>
</DispatchContext.Provider>
```

Do not split every field; selector stores/libraries fit large frequently changing graphs. Place providers at the lowest common lifetime boundary. Context may expose React Query data, but consumers can often use the original query hook directly.

Use `undefined` as a missing-provider sentinel and a custom hook that throws, producing a non-optional return and centralized error. Domain commands may be safer than exposing raw setters. Server/client boundaries constrain stateful providers.

Provider placement also defines state lifetime. State survives ordinary rerenders while the provider instance remains mounted, but resets when a different route branch replaces it, a changed `key` forces remount, conditional rendering removes it, or the application root is recreated. Put the provider above the route boundary when child pages must share the state; put it inside a branch when navigation should reset it naturally.

## Sources
- Workspace: `_ai-conspects/context/`; processed source: `regions/final-transcript.md`
- Additional workspace: `_ai-conspects/usecontext/`; processed source: `03-full-combined-final-transcript.md`
- Workspace: `_ai-conspects/react render + useEffect/`; authoritative processed source: `01-final-transcript.md`, R03
- Original SVG: `source/react render + useEffect.svg`
