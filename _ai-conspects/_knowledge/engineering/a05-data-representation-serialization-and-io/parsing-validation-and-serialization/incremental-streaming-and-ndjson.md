# Incremental streaming, peak memory, and NDJSON

Knowledge ID: `javascript.incremental-streaming-and-ndjson`

Topic: `javascript`

## Streaming primarily changes peak live memory

Streaming does not necessarily reduce the total number of bytes allocated during the lifetime of an operation. Its important memory advantage is often lower **peak live memory**: processed chunks can become unreachable while later chunks are still being produced or received.

That can reduce garbage-collection pressure, temporary memory spikes, tab instability, and the time during which one giant serialized representation must remain alive.

The largest win occurs when the source itself is incremental rather than already materialized as one giant object. Examples from the source include paged APIs, IndexedDB reads, worker output, generated previews, metadata extraction, and other async item sources.

If the complete giant object is already resident in memory, streaming only its serialization does not erase the memory cost of the original object.

## NDJSON gives records an incremental framing model

NDJSON encodes one JSON value per line instead of one giant JSON array. Each item can be serialized independently and sent immediately:

```js
const encoder = new TextEncoder();

const body = new ReadableStream({
  async start(controller) {
    for await (const item of getItemsAsync()) {
      controller.enqueue(
        encoder.encode(JSON.stringify(item) + "\n")
      );
    }
    controller.close();
  }
});
```

The receiver can parse complete lines as they become available instead of waiting for a final array closing bracket.

Transport chunks are not NDJSON records. A chunk can end in the middle of a line, so the receiver must retain an incomplete suffix and parse only complete lines.

## Async producers fit incremental serialization

An async generator or iterator can produce one item at a time. A stream can request or receive an item, serialize it, encode it, and enqueue it without first assembling the full collection.

For tighter demand control, the same producer can be moved from an eager `start()` loop into `pull()` so downstream demand determines when the next iterator item is requested.

## End-to-end buffering remains layered

Incremental JavaScript production improves the memory and latency model, but it does not prove that every later layer is zero-buffering. Stream queues, Fetch/network implementations, proxies, and servers may buffer ahead.

The useful claim is bounded incremental processing at the application level, not a guarantee that bytes are never retained elsewhere.

## What should be recallable

- Why can streaming lower peak live memory without lowering total lifetime allocations?
- When does streaming fail to remove the cost of one giant in-memory source object?
- What framing rule makes NDJSON incrementally parseable?
- Why must an NDJSON receiver still buffer partial lines?
- How do async iterables pair with incremental serialization?
- Why is application-level streaming not proof of zero buffering end to end?

## Related knowledge

- `javascript.readable-stream-producers-backpressure-and-cancellation`
- `javascript.text-encoding-and-stream-framing`
- `javascript.transformstream-pipelines-and-flush`

## Sources

- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R02 and the demand-driven comparison in R03
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R02 NDJSON versus whole-document JSON boundary
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
