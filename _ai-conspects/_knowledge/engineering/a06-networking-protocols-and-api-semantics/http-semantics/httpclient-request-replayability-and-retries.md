# HttpClient request replayability and retries

Knowledge ID: `dotnet.httpclient-request-replayability-and-retries`

Topic: `dotnet`

## A retry must be able to recreate the body

A request body backed by a stream can be one-shot: the stream may be non-seekable or already consumed. A resilience policy cannot make an arbitrary content stream replayable by merely retrying `SendAsync`.

Two durable strategies exist.

### Recreate the request and source per attempt

Create a fresh `HttpRequestMessage`, fresh `HttpContent`, and fresh source stream inside the retry operation. This preserves progressive upload without preloading the entire file.

### Buffer once into replayable data

Read the payload into a stable representation such as `byte[]`, then create new `ByteArrayContent` per attempt. This makes replay straightforward but intentionally pays whole-payload memory cost.

The operation that understands how to recreate the body should own the retry boundary. Delegating handlers remain useful for orthogonal cross-cutting concerns—authorization, correlation headers, logging/redaction, idempotency metadata, or handler configuration—but they cannot generally rewind arbitrary body sources.

## Response streaming changes where failures happen

`ResponseHeadersRead` can return before the whole response body has arrived. Network, decompression, parsing, or I/O failures can therefore happen later during read/copy/deserialization. Cancellation/timeout coverage must include the body-consumption stage, not only acquisition of the response headers.

The detailed response-buffering model is already owned by `dotnet.httpclient-response-streaming`.

## What should be recallable

- Why is a stream-backed request not automatically replayable?
- What must be recreated for each retry attempt?
- What memory tradeoff makes a `byte[]` replayable?
- Why should retry ownership sit around the operation that can rebuild its body?
- Why can failures surface after `ResponseHeadersRead` has returned?

## Related knowledge

- `dotnet.httpclient-response-streaming`
- `dotnet.async-enumerable-replay-and-single-use-streams`
- `dotnet.sockets-http-handler-response-upload-and-tls-options`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R04
