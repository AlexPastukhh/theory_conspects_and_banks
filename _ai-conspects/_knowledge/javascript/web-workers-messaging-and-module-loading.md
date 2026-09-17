# Web Workers, messaging, and module-relative loading

Knowledge ID: `javascript.web-workers-messaging-and-module-loading`

Topic: `javascript`

## Main thread and worker boundary

Normal page JavaScript, DOM work, layout/paint coordination, and most event callbacks run on the browser main thread. Long synchronous work blocks responsiveness. A Web Worker moves isolated JavaScript execution into a worker global scope, but it does not share the page DOM.

Communication crosses an explicit message boundary:

```js
const worker = new Worker(
  new URL("./worker.js", import.meta.url),
  { type: "module" }
);

worker.postMessage(input);
worker.onmessage = event => render(event.data);
worker.onerror = event => report(event.error ?? event.message);

// when the owner is done
worker.terminate();
```

Inside the worker, `self.onmessage` receives work and `self.postMessage` returns a result. Worker-side error handling can recover or return a structured failure; page-side `worker.onerror` observes unexpected worker failure.

Payloads use structured-clone and transfer rules rather than arbitrary shared mutable objects. Workers suit isolated CPU-heavy work, but startup, serialization or transfer, coordination, and the worker's own memory make them a poor automatic optimization for small tasks. Their lifetime is owned: terminate them from the page or close them from the worker when no longer needed.

## Module-relative worker URLs

`import.meta.url` is the current ES module's URL. It makes `new URL("./worker.js", import.meta.url)` relative to the importing module rather than the current document URL. A plain `"./worker.js"` can break when the page base path, module location, emitted hash, or deployment layout changes.

`{ type: "module" }` gives the worker ES-module semantics, including `import`. The `new URL(..., import.meta.url)` shape also exposes the worker dependency to modern bundlers so they can emit and rewrite it as a separate asset. Runtime and build-tool support still determine the final URL.

Static imports, dynamic `import()`, and `new Worker(...)` are different operations: they have different return values and lifecycles. `import.meta.url` is an ES-module facility, not a universal CommonJS replacement.

## What should be recallable

- Why does long synchronous page code affect responsiveness?
- What state can a worker access, and how does it exchange data with the page?
- Where should message errors and unexpected worker failures be handled?
- Why can worker overhead outweigh its benefit for small tasks?
- Why is `new URL(..., import.meta.url)` safer for module workers than a document-relative string?

## Sources

- Workspace: `_ai-conspects/server browser threads,memory, webworkers , runtime vs compiler , es/`
- Authoritative processed source: `regions/R01-browser-main-thread-web-workers-messaging-errors-and-lifecycle.md` and `regions/R04-import-meta-url-es-module-worker-urls-and-bundler-safe-loading.md`
- Original SVG: `source/server browser threads,memory, webworkers , runtime vs compiler , es.svg`
