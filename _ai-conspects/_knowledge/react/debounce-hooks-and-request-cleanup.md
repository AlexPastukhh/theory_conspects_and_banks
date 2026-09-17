# React debounce hooks and request cleanup

Knowledge ID: `react.debounce-hooks-and-request-cleanup`

Topic: `react`

Debounce waits for a quiet interval and emits the latest value once. Unlike `useDeferredValue`/transitions, it is a timer policy and can intentionally suppress intermediate search, validation, persistence, or analytics work.

```tsx
function useDebouncedValue<T>(value: T, delayMs: number) {
  const [debounced, setDebounced] = useState(value);

  useEffect(() => {
    const id = window.setTimeout(() => setDebounced(value), delayMs);
    return () => window.clearTimeout(id);
  }, [value, delayMs]);

  return debounced;
}
```

Timeline for a 300 ms delay:

```text
type A -> timer A
100 ms: type AB -> cancel A, timer AB
100 ms: type ABC -> cancel AB, timer ABC
300 ms quiet -> emit ABC once
```

The effect that uses the debounced value owns request cleanup. Abort the previous request and still protect against stale completion when the client/operation cannot guarantee abort:

```tsx
useEffect(() => {
  const controller = new AbortController();
  let active = true;

  fetch(`/api/search?q=${encodeURIComponent(debounced)}`, {
    signal: controller.signal,
  })
    .then(r => r.json())
    .then(data => { if (active) setResults(data); })
    .catch(error => { if (error.name !== "AbortError") throw error; });

  return () => {
    active = false;
    controller.abort();
  };
}, [debounced]);
```

Debounce changes when work starts; it does not make expensive rendering interruptible. Transitions/deferred values change render scheduling; they do not wait for quiet time. The techniques can be combined when both network frequency and UI responsiveness need control.

A debounced value and a debounced callback solve different problems: the former publishes lagging state, while the latter postpones an operation directly. Keep the delay stable when possible; because it is an effect dependency, changing it restarts the timer just like changing the source value.

## Sources

- Workspace: `_ai-conspects/useTransition full flow, usedebounce, useDefferedvalue/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R05-R06
- Original SVG: `source/useTransition full flow, usedebounce, useDefferedvalue.svg`
