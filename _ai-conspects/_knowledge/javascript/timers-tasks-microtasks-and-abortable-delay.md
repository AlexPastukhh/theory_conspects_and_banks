# JavaScript timers, tasks, microtasks, and abortable delay

Knowledge ID: `javascript.timers-tasks-microtasks-and-abortable-delay`

Topic: `javascript`

`setTimeout` asks the host to make a callback eligible after at least a delay; it does not block a JavaScript thread and does not guarantee exact execution time. The callback runs as a later task when the event loop is available. Resolving a promise from that callback queues promise continuations as microtasks, which run before the next task after the current task completes.

```js
const delay = (ms, signal) => new Promise((resolve, reject) => {
  if (signal?.aborted) return reject(signal.reason);

  const timer = setTimeout(() => {
    cleanup();
    resolve();
  }, ms);

  const onAbort = () => {
    clearTimeout(timer);
    cleanup();
    reject(signal.reason);
  };

  const cleanup = () => signal?.removeEventListener("abort", onAbort);
  signal?.addEventListener("abort", onAbort, { once: true });
});
```

Cleanup must cover both normal completion and abort and should settle once. A timer handle alone is not awaitable; the promise bridges the host callback into async control flow.

Typical ordering is:

```js
console.log("sync");
Promise.resolve().then(() => console.log("microtask"));
setTimeout(() => console.log("timer task"), 0);
```

The logs are `sync`, `microtask`, then `timer task` (assuming no other host work). Single-threaded execution does not prevent async races: operations interleave at `await`/task boundaries, which is why explicit queues, semaphores, cancellation, and ownership still matter.

## Sources

- Workspace: `_ai-conspects/semaphoreslim for ts js, pending promise without resolve/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R04-R05
- Original SVG: `source/semaphoreslim for ts js, pending promise without resolve.svg`
