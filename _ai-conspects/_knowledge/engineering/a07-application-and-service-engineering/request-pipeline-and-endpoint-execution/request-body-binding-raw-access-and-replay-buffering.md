# Request-body binding, raw access, and replay buffering

Knowledge ID: `aspnet-core.request-body-binding-raw-access-and-replay-buffering`

Topic: `aspnet-core`

## Manual body access is not automatically more memory-efficient

ASP.NET Core JSON model binding already reads request bytes through stream/pipe infrastructure. Replacing `[FromBody]` or a minimal-API DTO parameter with `JsonSerializer.DeserializeAsync(Request.Body)` gives custom control, but if both paths materialize the same DTO graph, the memory shape is broadly the same.

Raw access changes the model when it changes the work:

- copy a large body directly to storage;
- parse NDJSON or custom frames progressively;
- validate signatures/checksums over raw bytes;
- retain partial records across reads;
- stream a large binary section elsewhere instead of embedding it in a DTO;
- decode only fields that are actually needed.

Use `Request.Body` when libraries or operations are naturally stream-based. Use `Request.BodyReader` when segmented framing, delimiters, `ReadOnlySequence<byte>`, or explicit consumed/examined positions are the real problem.

ASP.NET Core owns `Request.Body` and `BodyReader`; ordinary endpoint code should not dispose/complete framework-owned request infrastructure.

## Multiple reads require explicit buffering

Request bodies are normally forward-only from application code's perspective. Middleware that reads before MVC/minimal APIs must call `EnableBuffering()` if downstream code needs to reread, then reset the body position.

`EnableBuffering` is a deliberate cost: data can be buffered in memory up to thresholds and can spill to disk. Use it only when replay is a requirement such as diagnostics, auditing, or signature validation; bound logged size and redact secrets.

## Detect whether a body can exist before validating its media type

`Request.ContentLength > 0` is not a complete body test. HTTP/1.1 chunked transfer and HTTP/2 or HTTP/3 framing can carry a body without a `Content-Length` value. `Request.Body.CanRead` only says that the stream supports reads; it does not prove that bytes are present.

Prefer ASP.NET Core's request-body detection features together with endpoint metadata when middleware must decide whether a body can exist. Keep these stages distinct:

```text
no body / body cannot exist
body with malformed Content-Type syntax
body with valid but unsupported Content-Type
supported Content-Type whose body cannot be deserialized
```

Do not read the body merely to answer this question. A custom probe consumes the forward-only request unless replay buffering and stream-position restoration are handled explicitly.

## Raw octet-stream bodies and the formatter boundary

### S-003 — application/octet-stream for raw bytes.

```text
application/octet-stream for raw bytes.

Visible:
- application/octet-stream means raw binary bytes.
- It is a request or response body that should be treated as uninterpreted bytes.
- Common cases: streaming files, raw uploads, custom binary protocols.

Meaning:
If the request body is just bytes, application/octet-stream is more appropriate than JSON or form media types.
```

### S-004 — Multipart/form-data vs application/octet-stream.

```text
Multipart/form-data vs application/octet-stream.

Visible:
- multipart/form-data when the request has multiple parts, metadata plus files, or several files.
- application/octet-stream when the request body is one raw byte stream.
- Examples: poster with title + file => multipart; raw image bytes only => octet-stream.

Meaning:
Choose multipart for structured multi-part body; choose octet-stream for a single raw payload.
```

### S-007 — Receive raw bytes from client.

```text
Receive raw bytes from client.

Visible:
- application/octet-stream upload case.
- Receive raw bytes from client.

Meaning:
For one raw upload body, avoid form binding and read the body stream or use a raw-body action shape. The client should send Content-Type: application/octet-stream.
```

### S-009 — Do you need to add media types to input formatters?

```text
Do you need to add media types to input formatters?

Visible:
- application/json is handled by JSON input formatter.
- multipart/form-data is handled by form parsing/model binding, not JSON input formatter.
- application/octet-stream is not handled by JSON formatters by default.
- If you expect raw bytes/stream, read Request.Body directly or implement a custom input formatter.

Meaning:
Do not expect MVC JSON input formatters to handle arbitrary media types automatically. Raw bytes often need explicit endpoint logic.
```

### S-010 — Read raw body in controller.

```text
Read raw body in controller.

Visible code:
- Controller route for upload.
- Reads `Request.Body` with stream/file logic.
- Does not rely on model binding to parse JSON/form.

Meaning:
For octet-stream uploads, direct Request.Body reading is a clear path. You own validation, buffering, streaming, and error handling.
```

### S-013 — If application/octet-stream is not added to supported input formatters.

```text
If application/octet-stream is not added to supported input formatters.

Visible:
- If action uses `byte[]` with model binding, unsupported media type can occur.
- Case A: read Request.Body yourself for raw bytes.
- MVC typically checks Content-Type only for model/input formatter paths.

Meaning:
If you bypass input formatters and read Request.Body manually, you avoid formatter matching, but you also lose automatic formatter validation.
```

### S-015 — Custom model binder / custom input formatter route.

```text
Custom model binder / custom input formatter route.

Visible:
- If you want a specific action parameter shape but body is application/octet-stream, you may need a custom binder/input formatter.
- Otherwise copy/read Request.Body manually.

Meaning:
Raw body bytes do not become arbitrary model types automatically. Either use framework extensibility or read/parse the stream yourself.
```

### S-017 — When to use [FromBody] Stream.

```text
When to use [FromBody] Stream.

Visible:
- If you want to process data as a stream.
- Binding a Stream this way can be less common/less explicit than using Request.Body.
- Most raw streaming endpoints use Request.Body directly.

Meaning:
A raw Stream body is a streaming contract; direct Request.Body access is often clearer than model binding.
```

### S-018 — Checking for application/octet-stream.

```text
Checking for application/octet-stream.

Visible:
- You can check `Request.HasJsonContentType()` or Request.ContentType.
- Example checks content type equals application/octet-stream.

Meaning:
When reading Request.Body manually, validate Content-Type yourself if the endpoint only accepts a specific raw body format.
```

### S-020 — Manual octet-stream upload controller.

```text
Manual octet-stream upload controller.

Visible code:
- Route like `/upload-raw`.
- Checks ContentType against application/octet-stream.
- Creates file path.
- Uses `Request.Body.CopyToAsync(fileStream)`.
- Returns filename.

Meaning:
For large raw uploads, stream the request body to a file instead of buffering the whole body in memory.
```

### S-021 — [FromBody] byte[] or Stream case.

```text
[FromBody] byte[] or Stream case.

Visible:
- For application/octet-stream uploads, if you use [FromBody] byte[] or [FromBody] Stream, MVC must choose an input formatter.
- If no formatter supports the Content-Type, 415 can happen before the action runs.
- Practical rule: read Request.Body manually or configure formatter support.

Meaning:
415 often occurs at binding/formatter selection time, not inside your action logic.
```

### S-023 — When to use [FromBody] byte[].

```text
When to use [FromBody] byte[].

Visible:
- Small-ish payloads.
- You are fine buffering the full body in memory.

Meaning:
[FromBody] byte[] is not a streaming upload strategy; it materializes the body. Use only when body size is controlled.
```

### S-024 — [FromBody] byte[] controller example.

```text
[FromBody] byte[] controller example.

Visible code:
- `[ApiController]`
- `[Route("api/[controller]")]`
- action `Post([FromBody] byte[] rawData)`
- returns length / processes raw bytes.

Meaning:
This endpoint shape models the body as a byte array. It is simple, but only safe for small controlled payloads because the whole body is in memory.
```

## What should be recallable

- Why does raw `Request.Body` access not by itself save memory?
- Which workloads materially benefit from raw streaming?
- When is `BodyReader` preferable to `Body`?
- Who owns the request stream and reader?
- Why is `EnableBuffering` needed for middleware rereads?
- What costs does request replay buffering introduce?
- Why are `ContentLength` and `Body.CanRead` insufficient body-presence tests?
- Which body/media-type/deserialization failure stages must remain separate?

## Related knowledge

- `aspnet-core.request-response-streams-and-pipelines`
- `dotnet.pipereader-consumed-examined-and-segmented-framing`
- `dotnet.streamreader-decoding-buffering-and-read-contracts`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source regions: R04 request-buffering section and R07
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, section 8, with exact evidence in `11-exact-canvas-text-transcript-v002.md` R05-R06 and `12-screenshot-evidence-cards-v002.md`
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
- Workspace: `_ai-conspects/MEDIA TYPES OF REQUESTS/`
- Authoritative processed source: `regions/MEDIA-R01-content-type-accept-media-type-basics.md`, S-003–S-004, S-007, S-009–S-010
- Authoritative processed source: `regions/MEDIA-R02-json-body-frombody-input-formatters.md`, S-013, S-015, S-017–S-018, S-020–S-021, S-023–S-024
- Original source identity: `MEDIA TYPES OF REQUESTS.svg` (named by `01-stage0-boundary-review.md`; not physically resolvable in the current workspace/branch).
