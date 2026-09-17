# Pending promises and external completion

Knowledge ID: `javascript.pending-promises-and-external-completion`

Topic: `javascript`

The `Promise` constructor executor runs synchronously. Capturing `resolve`/`reject` creates a promise whose settlement is owned by a later event:

```js
let resolveReady;
let rejectReady;

const ready = new Promise((resolve, reject) => {
  resolveReady = resolve;
  rejectReady = reject;
});

socket.addEventListener("open", () => resolveReady());
socket.addEventListener("error", error => rejectReady(error));
await ready;
```

Calling a resolver schedules reactions as microtasks; it does not run all `then`/`await` continuations inline. Only the first settlement wins. Later resolve/reject attempts are ignored, but event listeners, timers, and captured values still need cleanup.

An externally completed promise needs an owner and lifecycle: who settles it, what error rejects it, how cancellation/timeout removes registrations, and what happens when the underlying component closes first. Otherwise it can remain pending forever and retain waiters and referenced state. A pending promise by itself does not keep the event loop alive in every runtime, so “still pending” is not a process-lifetime guarantee.

Semaphores use this mechanism internally: a queued acquire stores a resolver and `release` completes the oldest pending promise. Prefer a small abstraction that owns the queue/state rather than scattering “deferred” resolvers through application code.

## Sources

- Workspace: `_ai-conspects/semaphoreslim for ts js, pending promise without resolve/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R03 and R05
- Original SVG: `source/semaphoreslim for ts js, pending promise without resolve.svg`
