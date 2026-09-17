# HttpClient request content types and representation costs

Knowledge ID: `dotnet.httpclient-request-content-and-representation`

Topic: `dotnet`

## Choose `HttpContent` from the value that already exists

`HttpRequestMessage.Content` owns the request body and content headers such as `Content-Type`, `Content-Length`, and `Content-Encoding`. Request-level headers such as `Authorization` and `Accept` belong to `HttpRequestMessage.Headers`.

The durable selection rule is representation-first:

| Existing value | Typical content | Typical server contract |
|---|---|---|
| DTO/object | `JsonContent` | JSON `[FromBody]` / formatter |
| prebuilt text or JSON string | `StringContent` | text reader or JSON formatter |
| complete `byte[]` | `ByteArrayContent` | raw request body |
| stream / large file | `StreamContent` | raw stream |
| scalar form fields | `FormUrlEncodedContent` | `[FromForm]` |
| files plus fields | `MultipartFormDataContent` | `[FromForm]` + `IFormFile` |

`JsonContent` avoids first manufacturing a whole JSON string. `StringContent` is appropriate when the exact text already exists, but a large JSON string adds a UTF-16 representation before UTF-8 bytes are sent. `ByteArrayContent` starts from a fully materialized payload. `StreamContent` can transmit progressively from a file or producer stream; wrapping a `MemoryStream` does not make the underlying data non-buffered.

Disposing `StreamContent` disposes the underlying stream. Keep request/content/stream ownership alive until the send operation has consumed the body.

## Forms and files

`FormUrlEncodedContent` is for percent-encoded scalar form fields, not nested JSON or file parts. `MultipartFormDataContent` carries independent parts and is the normal file-upload shape when files and metadata travel together.

JSON can carry binary data only through a text representation such as Base64. Base64 is roughly one-third larger before the rest of the JSON/HTTP overhead and often keeps both encoded and decoded representations in memory. It can be reasonable for small binary values tightly coupled to JSON metadata; normal or large files should use multipart or a raw streaming endpoint.

Legacy `ObjectContent` belongs to older ASP.NET Web API formatter stacks; modern `HttpClient` code normally uses the content types above.

## FormUrlEncodedContent request example

### S-016 — HttpClient equivalent for FormUrlEncodedContent.

```text
HttpClient equivalent for FormUrlEncodedContent.

Visible:
- Dictionary<string,string> with username/password.
- `new FormUrlEncodedContent(form)`
- `PostAsync("/account/login", content)`.

Meaning:
For application/x-www-form-urlencoded requests from HttpClient, use FormUrlEncodedContent; it sets the correct body format and content type.
```

## What should be recallable

- Which header collection owns `Content-Type`?
- Why is `JsonContent` different from serializing to a string first?
- Why does `StreamContent(new MemoryStream(...))` not prove source streaming?
- Which content type fits an already materialized `byte[]`?
- When should form-url-encoded, multipart, and Base64-in-JSON be chosen?
- Who owns the stream passed to `StreamContent`?

## Related knowledge

- `dotnet.httpcontent-media-type-charset-and-content-encoding`
- `dotnet.httpclient-body-length-framing-and-compression`
- `aspnet-core.request-body-binding-raw-access-and-replay-buffering`

## Sources

- Workspace: `_ai-conspects/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer/`
- Authoritative semantic transcript: `14-full-transcript.md`
- Closure audit: `15-coverage-audit.md`
- Exact source: `source/ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` (present on the checked branch)
- Source regions: R01 and R05
- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R01R02-httpclient-testing-create-jsonpatch-base-usage.md`, request-content and representation material
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
- Workspace: `_ai-conspects/MEDIA TYPES OF REQUESTS/`
- Authoritative processed source: `regions/MEDIA-R02-json-body-frombody-input-formatters.md`, S-016
- Original source identity: `MEDIA TYPES OF REQUESTS.svg` (named by `01-stage0-boundary-review.md`; not physically resolvable in the current workspace/branch).
