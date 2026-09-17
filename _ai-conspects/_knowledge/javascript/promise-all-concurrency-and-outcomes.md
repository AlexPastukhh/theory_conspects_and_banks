# Promise.all concurrency and outcomes

Knowledge ID: `javascript.promise-all-concurrency-and-outcomes`

Topic: `javascript`

Async work normally starts when its function is called; `await` only waits. Start independent calls first, then coordinate them. `Promise.all` preserves input order, treats plain values as fulfilled, fulfills empty input with `[]`, and rejects on the first observed rejection without cancelling work already running.

```js
const promises = ids.map(id => loadItem(id));
const items = await Promise.all(promises);
```

`allSettled` preserves order and returns per-item fulfilled/rejected records. Passing uncalled functions does nothing. Cancellation requires cooperation such as `AbortController`; large sets need concurrency limiting to avoid overload.

## Sources
- Workspace: `_ai-conspects/promise.all/`
- Processed source: `01-final-transcript.md`, complete transcript
