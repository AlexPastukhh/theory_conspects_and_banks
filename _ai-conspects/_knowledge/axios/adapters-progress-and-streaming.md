# Axios adapters, progress, and streaming

Knowledge ID: `axios.adapters-progress-and-streaming`

Topic: `axios`

## Adapter choice determines transport capabilities

Streaming and progress behavior depend on the active Axios adapter and the platform. Browser XHR exposes upload/download progress events. The fetch adapter can expose a `ReadableStream` when the runtime and Axios version support streaming.

Adapter capabilities therefore cannot be assumed to be identical across browsers, Node versions, Axios versions, or transport implementations.

## XHR progress and progressive NDJSON parsing

Axios maps browser XHR progress events to `onUploadProgress` and `onDownloadProgress`.

- `loaded` is the number of bytes transferred so far.
- `total` may be unavailable when Content-Length is missing or the transfer is chunked.
- Upload progress is especially useful for FormData or large request bodies.
- Download progress counts bytes received from the server.
- A UI percentage should be updated only when a usable total is known.

For NDJSON over XHR, one progressive approach reads the growing response text and remembers how much text has already been consumed. Only complete newline-delimited JSON records are parsed. An incomplete trailing line stays buffered for the next progress callback.

This is progressive parsing over a growing response buffer; it is not a true stream-reader API.

## Fetch adapter streaming

When the fetch adapter exposes the response as a stream, the caller can use a reader and decode text incrementally. Chunk boundaries still do not define NDJSON records, so an incomplete line must survive across chunks.

The source pattern is:

```ts
const response = await axios.get("/events", {
  adapter: "fetch",
  responseType: "stream",
  signal
});

const reader = response.data.getReader();
const decoder = new TextDecoder();
let buffer = "";

for (;;) {
  const { value, done } = await reader.read();
  if (done) break;
  buffer += decoder.decode(value, { stream: true });
  // split complete NDJSON lines; preserve incomplete tail
}
```

This is the cleaner streaming model when the runtime and Axios version expose a response stream.

## Cancellation and progress boundaries

`signal` integrates Axios with AbortController and supersedes the older CancelToken API in the represented model.

Cancellation should abort the transfer and stop further UI updates. Progress callbacks describe transport progress only: 100% uploaded does not mean the server has finished processing the request.

## What should be recallable

- Why do Axios progress and streaming capabilities depend on the selected adapter?
- What do `loaded` and possibly missing `total` mean for progress UI?
- How can XHR progressively parse NDJSON without a true stream-reader API?
- Why must incomplete NDJSON text remain buffered across progress callbacks or stream chunks?
- What changes when the fetch adapter exposes a `ReadableStream`?
- Why should cancellation stop both the transfer and later UI updates?
- Why is upload completion not the same as server-side processing completion?
- Why must adapter behavior be checked against browser, Node, and Axios-version support?

## Related knowledge

- `javascript.xhr-lifecycle-progress-and-streaming`
- `javascript.readable-stream-consumption-and-tee`
- `javascript.incremental-streaming-and-ndjson`
- `javascript.text-encoding-and-stream-framing`
- `axios.interceptor-lifecycle-status-and-token-refresh`

## Sources

- Workspace: `_ai-conspects/axios/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, cancellation/progress material in R02 and streaming/progress material in R03 excluding the `validateStatus` routing claim
- Original SVG identity recorded by Stage0: `source/axios.svg` (not physically present under the workspace `source/` directory on the current branch)
- Workspace: `_ai-conspects/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison/`
- Authoritative processed source: `01-final-transcript.md`, R01 progress comparison and R02 progressive Fetch reader model
- Original SVG: `source/FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg`
