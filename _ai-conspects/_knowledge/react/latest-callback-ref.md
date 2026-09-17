# Stable subscriptions with the latest callback ref

Knowledge ID: `react.latest-callback-ref`

Topic: `react`

A render-created callback changes identity and may capture current props/state. Including it in an effect correctly can recreate a subscription; omitting it can call stale logic. A ref separates stable external registration from the latest callback:

```tsx
function useLatest<T>(value: T) {
  const ref = useRef(value);
  ref.current = value;
  return ref;
}

const callbackRef = useLatest(onMessage);

useEffect(() => {
  const handler = (event: MessageEvent) => callbackRef.current(event);
  source.addEventListener("message", handler);
  return () => source.removeEventListener("message", handler);
}, [source]);
```

The ref object is stable; updating `.current` does not render. Render-time assignment is appropriate when predictable and read only by later callbacks. Effect assignment has a timing gap; layout effect is only for genuinely synchronous post-DOM needs. Cleanup must remove the exact registered handler.

Use this when one long-lived external handler must execute current logic and re-registration is expensive/lossy. Do not hide truly reactive dependencies or a changing source in refs. Reading `.current` during render does not subscribe to changes, and mutations must not influence concurrent rendered output. Prefer framework effect-event APIs or tested library hooks when available.

## Sources
- Workspace: `_ai-conspects/useRef to avoid including into deps array, to avoid rerenders or bad recreations/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
