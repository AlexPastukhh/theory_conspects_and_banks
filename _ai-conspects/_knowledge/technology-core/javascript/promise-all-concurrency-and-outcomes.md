# Promise.all concurrency and outcomes

Knowledge ID: `javascript.promise-all-concurrency-and-outcomes`

Topic: `javascript`

Async work normally starts when its function is called; `await` only waits. Start independent calls first, then coordinate them. `Promise.all` preserves input order, treats plain values as fulfilled, fulfills empty input with `[]`, and rejects on the first observed rejection without cancelling work already running.

```js
const promises = ids.map(id => loadItem(id));
const items = await Promise.all(promises);
```

`allSettled` preserves order and returns per-item fulfilled/rejected records. Passing uncalled functions does nothing. Cancellation requires cooperation such as `AbortController`; large sets need concurrency limiting to avoid overload.

## What should be recallable

- Explain the core model of **Promise.all concurrency and outcomes** without opening the Unit.
- Reconstruct this Unit-grounded rule: Async work normally starts when its function is called; `await` only waits.
- Reconstruct this Unit-grounded rule: `allSettled` preserves order and returns per-item fulfilled/rejected records.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/promise.all/`
- Processed source: `01-final-transcript.md`, complete transcript
