# Root error lifetime and route clearing

Knowledge ID: `react.root-error-lifetime-and-route-clearing`

Topic: `react`

A root error banner needs explicit ownership and lifetime. Keep global/session failures at the root, but page, form, loader, and validation errors local so unmounting clears them naturally. Structured display data is safer than storing raw `Error` objects, and concurrent operations may need IDs so an older success cannot clear a newer failure.

Clear on dismissal, successful retry, or navigation—not on every render. For uncontrolled links and browser navigation:

```tsx
const location = useLocation();
const { clearRootError } = useRootError();

useEffect(() => {
  clearRootError();
}, [location.key, clearRootError]);
```

Depend on the route signal that matches the requirement. If only pathname changes should clear the error, derive `pathname` and depend on it; a location key can represent each navigation entry more broadly.

When your handler owns navigation, clear first and then navigate; the route effect can remain a fallback. `useEffect` runs after paint and may allow a one-frame flash. `useLayoutEffect` clears before paint but blocks it, so use it only when the flash is materially harmful.

Do not introduce an effect merely to react to state that the same click just changed. Keep action-owned sequencing in the handler:

```tsx
const onNavigate = (to: string) => {
  clearRootError();
  navigate(to);
};
```

State setters are stable. Memoize an inline `clearRootError` with `useCallback` if consumers depend on its identity; optionally memoize the context value or split state/actions contexts to reduce rerenders. A custom hook should return the actual context value and fail clearly outside its provider. Route keys or boundaries can intentionally reset subtrees, but forced remounting should not compensate for wrong ownership.

A route-level error boundary is the natural owner for loader and render failures scoped to that route. Route-specific containers and styles can stay with the page, while nested layouts share common chrome without absorbing every page's state and layout responsibilities.

## Sources
- Workspace: `_ai-conspects/react root error, trigger useeffect on route change/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/react render + useEffect/`
- Authoritative processed source: `01-final-transcript.md`, R01
- Original SVG: `source/react render + useEffect.svg`
