# React Strict Mode and effect cleanup

Knowledge ID: `react.strict-mode-effect-cleanup`

Topic: `react`

React Strict Mode is a development-only diagnostic tool. It exposes impure rendering and unsafe side effects; it does not create the underlying lifecycle bug.

```text
Strict Mode is not the bug. It reveals the bug.
```

An effect that changes external state without undoing it is fragile:

```typescript
useEffect(() => {
  document.body.style.overflow = "hidden";
}, []);
```

If the component unmounts or is mounted again, the global body style can remain stale. Preserve the prior state and restore it from cleanup:

```typescript
useEffect(() => {
  const previous = document.body.style.overflow;
  document.body.style.overflow = "hidden";

  return () => {
    document.body.style.overflow = previous;
  };
}, []);
```

Do not depend on an empty dependency array meaning “once forever.” Effects can run again after dependency changes, unmount/remount, conditional rendering, navigation, a changed parent key, Suspense or concurrent retries, and later refactoring.

Treat an effect as synchronization with something outside React:

```text
setup external state to match the current React state
-> clean up the old external state before replacement or removal
```

Effects that create external side effects should be safe to run, clean up, and run again.

## Render, commit, paint, and effect instances

A function component runs during render. Render must stay pure: the same props, state, and context should produce the same JSX description without subscriptions, storage writes, DOM mutation, timers, or network calls. A normal passive effect follows commit and paint:

```text
initial mount:     render -> commit -> paint -> setup
dependency change: render -> commit -> paint -> previous cleanup -> new setup
unmount:                                                cleanup
```

The cleanup belongs to the preceding effect instance. Effects are appropriate for synchronizing browser/DOM APIs, event listeners, timers, subscriptions, observers, sockets, imperative widgets, storage, and data fetching when another layer does not own it.

```tsx
useEffect(() => {
  const onResize = () => synchronizeSize();
  window.addEventListener("resize", onResize);
  return () => window.removeEventListener("resize", onResize);
}, []);
```

Do not use an effect for state that can be derived during render. Storing `fullName` and setting it from an effect after `firstName` or `lastName` changes creates a second source of truth and an extra render; compute the string directly instead.

## Stale closures

An effect callback closes over the render that created it. An interval registered with `[]` therefore keeps the initial `count`:

```tsx
useEffect(() => {
  const id = setInterval(() => console.log(count), 1000);
  return () => clearInterval(id);
}, []);
```

Choose the repair by intent: include the reactive value and recreate the effect, use a functional state update such as `setCount(current => current + 1)`, store a deliberately latest mutable value in a ref, or redesign the effect so it does not need the value. Do not return arbitrary values from an effect—return either nothing or the cleanup function.

`useLayoutEffect` runs after DOM commit but before paint and blocks painting. Prefer `useEffect`; use the layout form only for required synchronous measurement or when a visible intermediate frame is materially unacceptable.

## What should be recallable

- Why Strict Mode reveals rather than causes an unsafe-effect bug.
- Why an effect may execute again even outside Strict Mode.
- How setup and cleanup form one synchronization contract.
- How to preserve and restore global state in a representative effect.
- Which phases surround passive-effect setup and cleanup.
- Why derived values normally belong in render rather than an effect.
- Which distinct remedies address a stale closure.
- When `useLayoutEffect` is justified despite blocking paint.

## Sources

- Workspace: `_ai-conspects/react strict mode/`
- Authoritative reconstructed source: `regions/R01-strict-mode-effect-cleanup-final-transcript-v001.md`, complete transcript
- Original SVG: `source/react strict mode.svg`
- Workspace: `_ai-conspects/react render + useEffect/`
- Authoritative processed source: `01-final-transcript.md`, R02 and R04
- Original SVG: `source/react render + useEffect.svg`
