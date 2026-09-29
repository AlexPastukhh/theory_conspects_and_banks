# Content-Disposition behavior and safe filenames

Knowledge ID: `http.content-disposition-filenames`

Topic: `http`

`Content-Disposition` suggests how a user agent presents a response and which filename to use:

```http
Content-Disposition: attachment; filename="report.pdf"
Content-Disposition: inline; filename="report.pdf"
```

`attachment` normally prompts download. `inline` permits in-browser display when the media type and browser policy support it, so rendering also depends on `Content-Type`.

For non-ASCII names, send an RFC-compatible extended parameter alongside an ASCII fallback:

```http
Content-Disposition: attachment; filename="report.pdf";
 filename*=UTF-8''r%C3%A9sum%C3%A9.pdf
```

ASP.NET Core file results normally create attachment disposition when a download filename is supplied:

```csharp
return File(bytes, "application/pdf", "report.pdf");
```

For preview, use the correct media type and inline disposition when needed. File-result overloads differ, so inspect the resulting header rather than treating the filename as cosmetic.

Never copy CR/LF or arbitrary user input into a header. Strip path components, expose only a safe filename, set the correct `Content-Type`, and do not treat disposition as authorization. Separate intentional preview and download endpoints when their policies differ.

Cross-origin JavaScript `fetch()` can read this response header only if CORS exposes it, for example with `Access-Control-Expose-Headers: Content-Disposition`. Allowing request headers is a separate policy dimension. Native browser navigation/download behavior is also separate from script visibility.

## What should be recallable

- Attachment versus inline behavior and the role of `Content-Type`/browser policy.
- ASCII `filename` fallback plus UTF-8 `filename*` encoding.
- ASP.NET Core file-result behavior and why the emitted header should be inspected.
- Header injection/path safety, authorization boundary, and CORS exposure versus native download behavior.

## Sources

- Workspace: `_ai-conspects/content disposition header/`
- Processed source: `regions/R01-final-coverage-transcript.md`, R01
- Original SVG: `source/content disposition header.svg`
- Workspace: `_ai-conspects/content-disposition-header/`
- Authoritative processed source: `regions/R01-content-disposition-header.md`, CDH-S001–CDH-S002 visible content
- Original source identity: `content disposition header.svg` (uploaded source; no tracked physical SVG in this workspace)
- Workspace: `_ai-conspects/CORS/`
- Authoritative processed source: `regions/R03R04R05-policy-builder-headers-middleware.md`, R03
- Original SVG: `source/CORS.svg`
- Workspace: `_ai-conspects/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable/`
- Authoritative processed source: `01-final-transcript.md`, R01-R03 (`inline`/`attachment`, MIME types, ASP.NET Core file responses and browser visibility after fetch)
- Original SVG: `source/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg`
