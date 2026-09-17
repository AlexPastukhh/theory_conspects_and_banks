# HttpClient body length, transfer framing, and compression

Knowledge ID: `dotnet.httpclient-body-length-framing-and-compression`

Topic: `dotnet`

## Buffering, known length, and compression are separate questions

For an outbound JSON body distinguish:

1. Did application code pre-materialize the payload?
2. Is the exact outgoing byte count known before transmission?
3. Is the content compressed?

A serialized `string` plus `StringContent` creates a complete text representation and encoded bytes. Serializing directly to a `MemoryStream` avoids the giant UTF-16 string but still buffers the whole payload. `JsonContent` normally lets serialization happen while the HTTP stack copies content, so application code does not first build a full string or memory stream.

## `Content-Length` requires an exact byte count

A sender can announce a length only when it knows the exact serialized byte count. That depends on encoding, escaping, serializer options/converters, formatting, and the final representation. Never estimate `Content-Length`; a wrong value corrupts message framing.

Known byte arrays and seekable/materialized buffers can normally expose their size. Streaming-oriented content may deliberately avoid pre-serializing solely to compute a length.

Under HTTP/1.1, an unknown final length can be represented with chunked transfer framing. Chunk boundaries are transport framing, not application-message or JSON-token boundaries. HTTP/2 and HTTP/3 use their own frame layers; application code must not depend on HTTP/1.1 chunk boundaries.

## Compression is orthogonal to framing

`Content-Encoding: gzip` describes the representation. `Content-Length` or HTTP/1.1 chunked framing describes how the body is delimited for transfer.

Valid combinations include fixed-length uncompressed content, precompressed fixed-length content, or streamed compression with unknown final length. Streaming compression does not inherently require full prebuffering; precompressing to a memory buffer does.

Automatic response decompression can expose decoded bytes to application code even when wire-level length describes the encoded representation.

## What should be recallable

- Why can `JsonContent` lack an up-front byte length?
- Why must an estimated `Content-Length` never be sent?
- What does HTTP/1.1 chunked framing mean to application JSON parsing?
- Why are content coding and transfer framing different dimensions?
- Does streamed compression require buffering the full compressed result?

## Related knowledge

- `dotnet.httpclient-request-content-and-representation`
- `dotnet.streaming-gzip-httpcontent`
- `http.content-coding-direction-and-negotiation`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source region: R02; automatic-decompression boundary also appears in R04
