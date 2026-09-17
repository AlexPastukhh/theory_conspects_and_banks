# TransformStream pipelines, buffering, and flush

Knowledge ID: `javascript.transformstream-pipelines-and-flush`

Topic: `javascript`

## `pipeThrough()` connects a middle stage

`readable.pipeThrough(transform)` connects a readable source to a transform and returns the transform's readable output. It does not mutate the original stream object into a different type.

A transform has:

- a writable side that receives upstream chunks;
- a readable side that emits transformed chunks.

That makes pipelines composable:

```text
bytes
→ decoded text
→ complete lines
→ parsed records
```

Multiple `pipeThrough()` calls can express those stages without one monolithic read loop.

## One input chunk does not imply one output chunk

A `TransformStream` can be created with `transform` and `flush` callbacks:

```js
new TransformStream({
  transform(chunk, controller) {
    // consume one input chunk
    // controller.enqueue(...) zero, one, or many times
  },
  flush(controller) {
    // finish buffered state after upstream ends
  }
});
```

`transform(chunk, controller)` may emit:

- several output chunks from one input chunk;
- no output yet because only a partial frame is available;
- one output assembled from state accumulated across several input chunks.

A class wrapper is optional; it is useful only when reusable configuration or state deserves its own abstraction.

## Buffer only the incomplete state you need

A transform may intentionally retain bounded state such as incomplete UTF-8 data, a partial line, or an unfinished application message. Streaming does not mean literally zero retained data.

A line splitter demonstrates the pattern:

```js
function createLineSplitter() {
  let buffer = "";

  return new TransformStream({
    transform(chunk, controller) {
      buffer += chunk;
      const lines = buffer.split("\n");
      buffer = lines.pop() ?? "";

      for (const line of lines) {
        controller.enqueue(line);
      }
    },

    flush(controller) {
      if (buffer) controller.enqueue(buffer);
    }
  });
}
```

`flush(controller)` runs after the writable side has ended and no more input will arrive. It can emit a permitted final partial line, finish parser state, or validate that no incomplete frame remains.

Unbounded parser state defeats an important memory benefit of streaming. A transform should also make its input and output chunk types clear.

## Lifecycle and error propagation

Piping connects lifecycle and failure behavior across the chain. Transform errors reject downstream piping and normally propagate through the connected stream graph.

Pipe options can deliberately prevent close, abort, or cancel propagation, but those options should be used only when that lifecycle break is intentional.

## Text decoding is a separate stage

`TextDecoderStream` is one transform stage that converts byte chunks into decoded text while preserving decoder state across multibyte UTF-8 boundaries. Its output chunks are still arbitrary text chunks, so framing remains another responsibility.

## What should be recallable

- What does `pipeThrough()` return, and does it mutate the original readable?
- What are the writable and readable sides of a transform for?
- Why can one input chunk produce zero, one, or many output chunks?
- What state belongs in a bounded transform buffer?
- When does `flush()` run, and what kinds of final work belong there?
- How do failures and close/abort/cancel normally propagate through a pipe?
- Why is text decoding separate from message framing?

## Related knowledge

- `javascript.text-encoding-and-stream-framing`
- `javascript.incremental-streaming-and-ndjson`
- `javascript.writablestream-pipeto-and-sink-lifecycle`

## Sources

- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R04 for the decoder-stage boundary and R05
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
