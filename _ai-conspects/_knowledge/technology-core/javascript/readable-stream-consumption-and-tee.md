# ReadableStream consumption, locking, and tee branching

Knowledge ID: `javascript.readable-stream-consumption-and-tee`

Topic: `javascript`

## Core model

A `ReadableStream` represents data that becomes available as chunks over time. It separates the producer from the consumer and exposes stream-level operations such as locking, cancellation, piping, async iteration, and deliberate branching.

For browser Fetch, `response.body` is commonly a byte-oriented `ReadableStream`; its chunks are typically `Uint8Array` values.

The Fetch promise resolves when response headers are available, not necessarily after the whole body arrives. `response.json()`, `text()`, and `blob()` consume and materialize their complete representations, while reading `response.body` lets application code process progressively. That does not imply zero buffering in the browser, network, or proxy layers.

## Consume with a reader

`getReader()` locks the stream to one reader until that lock is released. Repeated `read()` calls return objects shaped like `{ value, done }`:

```js
const reader = response.body.getReader();

for (;;) {
  const { value, done } = await reader.read();
  if (done) break;
  consume(value);
}
```

A download-progress counter can add `value.byteLength` for every received chunk.

A stream can also be consumed sequentially with async iteration:

```js
for await (const chunk of response.body) {
  console.log(chunk);
}
```

Both forms consume the stream's chunks over time; a stream is not an automatically replayable collection.

## `tee()` branches one source

`tee()` creates two readable branches that receive the same logical sequence of chunks:

```js
const [displayBranch, cacheBranch] = response.body.tee();
```

The original network source is still read once. The browser must retain data that one branch has not consumed yet. If one branch is much slower, the faster branch can continue driving source progress while unread data accumulates for the slower branch.

That makes `tee()` useful for moderate cases such as displaying a response while also caching it, but not a free replay mechanism for arbitrarily large bodies.

## Operational boundaries

- A readable stream is single-consumption unless it is explicitly branched or recreated.
- `tee()` only partially propagates backpressure because unread branch data can accumulate.
- Chunk boundaries are stream/transport boundaries, not application message boundaries.
- Branching does not prove that every browser, proxy, or transport layer buffers nothing.

## What should be recallable

- What does `getReader()` lock, and what does `read()` return?
- How does `for await...of` consume a readable stream?
- What exactly does `tee()` duplicate, and what remains a single underlying source?
- Why can a slow `tee()` branch increase buffering?
- Why is a `ReadableStream` not automatically replayable?

## Related knowledge

- `javascript.readable-stream-producers-backpressure-and-cancellation`
- `javascript.text-encoding-and-stream-framing`

## Sources

- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R01
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 download progress and R02 Fetch completion/reader model
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
