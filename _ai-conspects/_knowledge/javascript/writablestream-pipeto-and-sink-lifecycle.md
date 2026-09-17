# WritableStream, pipeTo, and sink lifecycle

Knowledge ID: `javascript.writablestream-pipeto-and-sink-lifecycle`

Topic: `javascript`

## `pipeTo()` terminates a pipeline

`pipeThrough(transform)` connects a middle stage and returns another readable stream. `pipeTo(writable)` connects a terminal sink and returns a promise that reports completion or failure.

A typical graph is:

```text
ReadableStream
→ TransformStream(s)
→ WritableStream
```

Do not ignore the promise returned by `pipeTo()` because it is the completion/error signal for the connected pipeline.

## Writable sink callbacks

A `WritableStream` sink can define:

- `write(chunk)` for each incoming chunk;
- `close()` for successful finalization;
- `abort(reason)` for failure or cancellation cleanup.

```js
const sink = new WritableStream({
  write(chunk) {
    console.log("received", chunk);
  },
  close() {
    console.log("finished");
  },
  abort(reason) {
    console.error("aborted", reason);
  }
});

await readable.pipeTo(sink);
```

The accepted chunk type is part of the sink contract. Depending on preceding stages, it may be bytes, strings, or application objects.

`getWriter()` provides manual access when code needs direct calls to `write`, `close`, or `abort` and explicit coordination with writer readiness.

## Declarative pipe versus manual reader loop

Use a manual `getReader()` loop when the logic needs custom early-stop conditions, unusual branching, detailed per-chunk decisions, or control flow that does not fit a reusable stage.

Use `pipeThrough()` and `pipeTo()` when the intent is composition: connect this source through these transforms into this sink.

The higher-level pipe model usually reduces explicit lock handling, lifecycle mistakes, and duplicated read/write loops. Both approaches can express similar work, but at different abstraction levels.

## Sink examples and cleanup

A writable boundary can represent more than a file:

- append decoded text or parsed events to application/UI state;
- feed media chunks into a processor;
- forward transformed chunks to another upload or storage API;
- record logs, telemetry, notifications, or collaboration events.

When work cannot finish safely:

- cancel the readable when the consumer no longer wants input;
- abort the writable when output must stop with failure;
- if a wrapped async iterator is owned by the pipeline, propagate termination with `iterator.return()` so its cleanup path can run.

## File writing is one concrete sink

In supported, permission-granted environments, a file handle can produce a `FileSystemWritableFileStream` with `createWritable()`, and a Fetch response body can be piped directly to it:

```js
const writable = await fileHandle.createWritable();
await response.body.pipeTo(writable);
```

This allows network bytes to flow to disk without first assembling the whole file in application memory. File-specific writer semantics and capability boundaries are covered separately.

## What should be recallable

- How do `pipeThrough()` and `pipeTo()` differ in position and return value?
- What do `write`, `close`, and `abort` represent for a sink?
- Why is the `pipeTo()` promise important?
- When is a manual reader loop preferable to declarative piping?
- What chunk-type contract must a writable sink define?
- How should readable cancellation and writable abort participate in cleanup?

## Related knowledge

- `javascript.transformstream-pipelines-and-flush`
- `javascript.file-system-access-save-and-streaming`
- `javascript.async-generators-and-cancellation`

## Sources

- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R06
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
