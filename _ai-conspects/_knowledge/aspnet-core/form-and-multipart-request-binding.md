# Form and multipart request binding

Knowledge ID: `aspnet-core.form-and-multipart-request-binding`

Topic: `aspnet-core`

Form media types use the form-binding path rather than the JSON input-formatter path. The following source-preserved cases define when to choose URL-encoded form data, multipart data, files, boundaries, and `[FromForm]`.

### S-001 — What is multipart/form-data?

```text
What is multipart/form-data?

Visible:
- multipart/form-data is an HTTP request body format.
- The body is split into multiple parts.
- Each part has its own headers and content.
- Typical use: text fields plus one or more files in one POST/PUT request.

Meaning:
Use multipart/form-data when the client must send files plus metadata in one request body.
```

### S-002 — FormUrlEncodedContent vs multipart/form-data.

```text
FormUrlEncodedContent vs multipart/form-data.

Visible:
- FormUrlEncodedContent is classic HTML form submission.
- Browser default form without file upload is usually application/x-www-form-urlencoded.
- With enctype="multipart/form-data", browser sends multipart.
- ASP.NET Core usually binds x-www-form-urlencoded and multipart through form binding, not JSON input formatters.

Meaning:
Use x-www-form-urlencoded for simple key/value form data. Use multipart/form-data when files or mixed parts are involved.
```

### S-006 — Multipart use cases.

```text
Multipart use cases.

Visible:
Use multipart/form-data when sending:
1. file plus metadata in one request.
2. multiple files in one request.
3. mixed pieces like profile photo, ID scan, proof of address.

Meaning:
Multipart is not just “file upload”; it is a container for several body parts with potentially different content.
```

### S-008 — Classic HTML form default.

```text
Classic HTML form default.

Visible:
- HTML form with method post.
- Without enctype multipart, browser sends application/x-www-form-urlencoded.
- Fields become key/value pairs.

Meaning:
If a classic form posts simple inputs and no files, x-www-form-urlencoded is the normal media type.
```

### S-011 — Server action examples for form and login.

```text
Server action examples for form and login.

Visible code:
- `[HttpPost("account/login")]`
- `[Consumes("application/x-www-form-urlencoded")]`
- action with `[FromForm] LoginForm form`
- form fields like Username.

Meaning:
For form-urlencoded or multipart form posts, use [FromForm] binding and optionally [Consumes] to document/restrict the media type.
```

### S-012 — Mixed content types inside multipart.

```text
Mixed content types inside multipart.

Visible:
- multipart can include an application/json part and one or more files.
- Parts can have different Content-Type values.

Meaning:
Multipart is the way to send mixed body data such as JSON metadata plus file bytes in a single request.
```

### S-014 — Boundary parameter.

```text
Boundary parameter.

Visible:
- Boundary is a unique marker used to separate parts in a multipart request body.
- It is like a delimiter.
- Header example has `boundary=abc123`.

Meaning:
In multipart/form-data, boundary is required so the server can split the raw body into individual parts.
```

### S-019 — Raw multipart body shape.

```text
Raw multipart body shape.

Visible:
- `--abc123`
- headers for part 1
- content for part 1
- `--abc123`
- headers/content for part 2
- final boundary ends with `--`.

Meaning:
Multipart body is literally a sequence of parts separated by boundary lines.
```

### S-022 — Who sets the boundary?

```text
Who sets the boundary?

Visible:
- Browser form submissions.
- MultipartFormDataContent in .NET.
- FormData in JavaScript.

Meaning:
You almost never hand-write the multipart boundary; the HTTP client library generates it and includes it in Content-Type.
```

### S-025 — Form media-type branch.

```text
Form media-type branch.

Visible topic:
- application/x-www-form-urlencoded
- multipart/form-data
- [FromForm]
- form fields and files

Meaning:
This starts the form branch: form media types are not JSON and are usually handled by form binding in ASP.NET Core.
```

### S-026 — application/x-www-form-urlencoded shape.

```text
application/x-www-form-urlencoded shape.

Visible:
- classic key/value pairs.
- body looks like `name=value&age=20`.
- good for simple HTML forms and login-style data.
- no file content.

Meaning:
Use x-www-form-urlencoded when the body is simple flat form fields, not files or nested/mixed binary content.
```

### S-027 — [FromForm] with form-urlencoded.

```text
[FromForm] with form-urlencoded.

Visible code:
- action parameter with `[FromForm]`.
- login or form DTO fields.
- Content-Type: application/x-www-form-urlencoded.

Meaning:
[FromForm] reads values from submitted form data. For simple fields, both browser forms and FormUrlEncodedContent can feed this path.
```

### S-028 — multipart/form-data shape.

```text
multipart/form-data shape.

Visible:
- body has multiple parts.
- each part has Content-Disposition.
- file parts have filename and content type.
- boundary separates parts.

Meaning:
Multipart is a container format for form fields and binary file parts in the same request.
```

### S-029 — IFormFile upload.

```text
IFormFile upload.

Visible code:
- controller action receives `[FromForm] IFormFile file`.
- maybe additional `[FromForm]` fields.
- endpoint consumes multipart/form-data.

Meaning:
IFormFile binding is for multipart file uploads. It is not for application/json or raw octet-stream uploads.
```

### S-030 — Multiple files.

```text
Multiple files.

Visible:
- `List<IFormFile>` or `IFormFile[]`.
- field name must match the form field.
- multipart request can include repeated file fields.

Meaning:
For multiple file upload, multipart/form-data can carry several file parts under the same or different field names.
```

### S-031 — Metadata + file in multipart.

```text
Metadata + file in multipart.

Visible:
- fields like title/description.
- file part.
- DTO + IFormFile or separate parameters.

Meaning:
When a request needs file plus text metadata, multipart/form-data is usually the natural media type.
```

### S-032 — JSON plus file problem.

```text
JSON plus file problem.

Visible idea:
- If you send JSON body and file together, plain application/json cannot carry a file part as a separate stream.
- Use multipart/form-data and include JSON metadata as a part/string or model binder custom logic.

Meaning:
One request body has one top-level media type. Mixed file + JSON metadata normally means multipart, not two independent bodies.
```

### S-033 — Postman / browser client settings.

```text
Postman / browser client settings.

Visible:
- In Postman use form-data for files.
- Browser FormData automatically sets multipart boundary.
- Do not manually set boundary incorrectly.

Meaning:
Let the client library create the multipart Content-Type including boundary. Manual header mistakes often break server parsing.
```

### S-034 — Form binding vs body input formatter.

```text
Form binding vs body input formatter.

Visible:
- [FromForm] uses form readers/model binding.
- [FromBody] uses input formatters like JSON.
- Different pipelines.

Meaning:
A parameter source matters. A form request should normally bind with [FromForm], while JSON uses [FromBody].
```

### S-035 — When multipart is wrong.

```text
When multipart is wrong.

Visible warnings:
- If body is one raw file only, application/octet-stream can be simpler.
- If body is pure JSON, application/json is simpler.
- Multipart is for mixed parts / file form.

Meaning:
Do not use multipart automatically for every POST. Pick it when the body is truly multi-part.
```

### S-036 — Multipart size/security notes.

```text
Multipart size/security notes.

Visible:
- file size limits.
- request size limits.
- streaming large files.
- temp storage / memory implications.

Meaning:
Multipart upload endpoints still need limits and streaming/storage decisions. IFormFile is convenient but can involve buffering.
```

## What should be recallable

- When should a request use URL-encoded form data, multipart data, JSON, or one raw byte stream?
- How do `[FromForm]`, `IFormFile`, multipart boundaries, and repeated file fields fit together?
- Why should a browser or client library generate the multipart boundary?
- What are the buffering, size-limit, temporary-storage, and streaming concerns for multipart uploads?

## Related knowledge

- `aspnet-core.action-parameter-binding-sources`
- `aspnet-core.request-body-binding-raw-access-and-replay-buffering`
- `dotnet.httpclient-request-content-and-representation`

## Sources

- Workspace: `_ai-conspects/MEDIA TYPES OF REQUESTS/`
- Authoritative processed source: `regions/MEDIA-R01-content-type-accept-media-type-basics.md`, S-001–S-002, S-006, S-008, S-011–S-012
- Authoritative processed source: `regions/MEDIA-R02-json-body-frombody-input-formatters.md`, S-014, S-019, S-022
- Authoritative processed source: `regions/MEDIA-R03-form-urlencoded-multipart-fromform-files.md`, S-025–S-036
- Original source identity: `MEDIA TYPES OF REQUESTS.svg` (named by `01-stage0-boundary-review.md`; not physically resolvable in the current workspace/branch).
