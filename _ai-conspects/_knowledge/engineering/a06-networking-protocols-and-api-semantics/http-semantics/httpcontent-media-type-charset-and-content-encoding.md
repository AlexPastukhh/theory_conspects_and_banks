# HttpContent media type, charset, and content encoding

Knowledge ID: `dotnet.httpcontent-media-type-charset-and-content-encoding`

Topic: `dotnet`

Three body descriptors solve different problems:

```text
Content-Type              -> media format, e.g. application/json
Content-Type ... charset  -> character encoding for textual media
Content-Encoding          -> additional transformation such as gzip
```

Most request bodies need a meaningful media type. JSON, XML, plain text, generic/specific binary, URL-encoded form, and multipart bodies use their corresponding types.

```text
JSON       -> application/json
XML        -> application/xml
plain text -> text/plain
binary     -> application/octet-stream or a specific type such as image/png
form       -> application/x-www-form-urlencoded
multipart  -> multipart/form-data
```

## Which `HttpContent` knows its headers?

`StringContent(text, Encoding.UTF8, "application/json")` sets encoding/media type. `JsonContent.Create(dto)` serializes and supplies JSON headers. `FormUrlEncodedContent` supplies its form type. `MultipartFormDataContent` creates both multipart type and boundary; overwriting that header without retaining the boundary breaks the body contract.

`ByteArrayContent` and `StreamContent` know bytes, not meaning, so normally set their media type:

```csharp
var content = new ByteArrayContent(bytes);
content.Headers.ContentType =
    new MediaTypeHeaderValue("application/pdf");
```

The deciding question is whether the selected content implementation already knows the representation, not whether the payload happens to be bytes or a stream.

## Charset belongs to text

`charset=utf-8` is a parameter of textual `Content-Type`; it does not apply to PDF, images, ZIP, or other non-text binaries. `StreamContent`/`ByteArrayContent` have no encoding constructor because text encoding happened before those bytes existed. If the bytes contain text, set media type and optional charset explicitly.

Modern JSON normally uses UTF-8 and commonly works with `application/json` alone. An explicit charset can help strict/legacy peers and non-JSON text. `JsonContent` owns JSON serialization; unusual charset requirements are more directly expressed by explicitly serialized `StringContent`.

## Content coding is not charset

`Content-Encoding: gzip` is correct only when the body bytes were actually compressed. Setting the header on uncompressed bytes makes the request invalid. The media type remains the underlying representation:

```text
Content-Type: application/json
Content-Encoding: gzip
```

## What should be recallable

- How do Content-Type, charset, and Content-Encoding differ?
- Which common `HttpContent` implementations set their media type automatically?
- Why must a multipart boundary not be discarded?
- Why do raw stream/byte contents normally need a manual media type?
- When is charset relevant, and when has encoding already happened?
- What failure does a false gzip header create?

## Sources

- Workspace: `_ai-conspects/when need to add content type, encoding/`
- Authoritative processed source: `regions/R01R02-content-type-charset-content-encoding-final.md`, R01–R02
- Original SVG: `source/when need to add content type, encoding.svg`
