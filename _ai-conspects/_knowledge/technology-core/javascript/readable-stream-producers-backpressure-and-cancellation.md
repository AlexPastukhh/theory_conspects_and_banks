# ReadableStream producers, backpressure, and cancellation

Knowledge ID: `javascript.readable-stream-producers-backpressure-and-cancellation`

Topic: `javascript`

## Producer callbacks and controller operations

A custom `ReadableStream` can define an underlying source with `start`, `pull`, and `cancel`.

- `start(controller)` runs once when the stream is created. It fits initialization, wiring an event source, starting a timer, or enqueuing a small amount of eager data.
- `pull(controller)` runs when the stream wants more data according to its queue and high-water mark. It fits lazy sources such as paged APIs, async iterators, file readers, or generated upload chunks.
- `cancel(reason)` is the producer cleanup hook when the consumer stops.
- `controller.enqueue(chunk)` publishes data.
- `controller.close()` completes normally.
- `controller.error(error)` fails the stream.

An eager `start()` producer can overfill the internal queue if it creates data faster than consumers can process it. A `pull()` producer can wait for demand and create one item at a time.

## Backpressure is a demand signal, not packet control

The readable side tracks an internal queue, and `controller.desiredSize` exposes a demand signal. `pull()` lets application code defer construction of future chunks until downstream capacity is available.

That can reduce application-side buffering, but it does not mean one `pull()` call maps to one network packet. Backpressure crosses multiple layers: stream queues, Fetch internals, the transport, proxies, and the server can all buffer independently.

## Bridge an async iterator into a stream

```js
const encoder = new TextEncoder();
const iterator = getItemsAsync()[Symbol.asyncIterator]();

const body = new ReadableStream({
  async pull(controller) {
    const { value, done } = await iterator.next();

    if (done) {
      controller.close();
      return;
    }

    controller.enqueue(
      encoder.encode(JSON.stringify(value) + "\n")
    );
  },

  async cancel(reason) {
    console.log("cancelled", reason);
    await iterator.return?.();
  }
});
```

Calling or awaiting `iterator.return()` gives an owned async iterator a chance to execute its cleanup path, including `finally`. The same reversal rule applies to timers, readers, sockets, subscriptions, workers, and event listeners: cancellation should undo the producer setup.

Do not enqueue new chunks after the controller has been closed or errored.

## Streaming request bodies

A `ReadableStream` can be used conceptually as a request body so JavaScript produces chunks while an upload is in progress. In the browser Fetch model represented by the source, the streaming upload uses `duplex: "half"`:

```js
await fetch("/upload", {
  method: "POST",
  body,
  duplex: "half"
});
```

The receiving server still observes ordinary HTTP request-body bytes. It can read, bind, or deserialize those bytes according to its normal server-side model.

Streaming the request body does not prove zero buffering end to end. Browser, proxy, transport, and server layers may still buffer ahead.

## What should be recallable

- When is `start()` preferable, and when is `pull()` preferable?
- What do `enqueue`, `close`, and `error` do?
- What does `desiredSize` indicate, and what does it not guarantee?
- Why should stream cancellation propagate to owned resources such as an async iterator?
- Why can demand-driven production reduce JavaScript memory without controlling packet boundaries?
- What browser Fetch option accompanies the streaming request-body model in this source?

## Related knowledge

- `javascript.readable-stream-consumption-and-tee`
- `javascript.async-generators-and-cancellation`
- `javascript.generator-finally-cleanup`
- `javascript.incremental-streaming-and-ndjson`

## Sources

- Workspace: `_ai-conspects/pipethrough,transformstream,pipeto,writablestream, readablestream/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R01 streaming-request-body claims and R03
- Original SVG: `source/pipethrough,transformstream,pipeto,writablestream, readablestream.svg`
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 upload-progress boundary and R03 `ReadableStream` request body with `duplex: "half"`
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
