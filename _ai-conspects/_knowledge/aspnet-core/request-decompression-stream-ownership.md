# ASP.NET Core request decompression and stream ownership

Knowledge ID: `aspnet-core.request-decompression-stream-ownership`

Topic: `aspnet-core`

A controlled client serializes JSON through a compression stream and sends `Content-Type: application/json` plus `Content-Encoding: gzip`. Dispose the compressor before sending to finalize trailers/buffers; with `MemoryStream`, use `leaveOpen: true` and rewind.

Server middleware reads coding names, creates decompression wrappers, assigns the outermost wrapper to `Request.Body`, invokes downstream middleware, then restores the original body and disposes only wrappers it created:

```text
framework owns Request.Body
middleware owns its wrappers

leaveOpen: true
dispose wrappers
restore Request.Body
```

A coding registry can map names to `IRequestBodyDecompressor`. Constructor dependencies are resolved when conventional middleware is created; `Invoke`/`InvokeAsync` parameters resolve per request and suit scoped services. `IMiddleware` supports per-request middleware activation.

## Sources

- Workspace: `_ai-conspects/compression,decompression,request,response/`
- Processed source: `FINAL_TRANSCRIPT.md`, request/middleware sections
