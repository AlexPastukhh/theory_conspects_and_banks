# HTTP content coding direction and negotiation

Knowledge ID: `http.content-coding-direction-and-negotiation`

Topic: `http`

Response compression and request compression are separate directions:

```text
response: client Accept-Encoding -> server Content-Encoding -> client decodes
request:  client compresses body -> Content-Encoding -> server decodes
```

Response-compression support does not imply request decompression. Cacheable compressed variants normally need `Vary: Accept-Encoding`. Multiple codings are removed in reverse application order: `Content-Encoding: gzip, br` decodes Brotli, then gzip. Unsupported request codings should return 415.

Compress sufficiently large text payloads when network savings justify CPU/latency. Avoid recompressing media/archive formats already compressed. `SocketsHttpHandler.AutomaticDecompression` yields decoded response bytes to application code.

## What should be recallable

- Explain the core model of **HTTP content coding direction and negotiation** without opening the Unit.
- Reconstruct this Unit-grounded rule: Response-compression support does not imply request decompression.
- Reconstruct this Unit-grounded rule: Compress sufficiently large text payloads when network savings justify CPU/latency.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources

- Workspace: `_ai-conspects/compression,decompression,request,response/`
- Processed source: `FINAL_TRANSCRIPT.md`, complete integrated transcript
- Workspace: `_ai-conspects/when need to add content type, encoding/`
- Authoritative processed source: `regions/R01R02-content-type-charset-content-encoding-final.md`, Content-Encoding-versus-charset claims
- Original SVG: `source/when need to add content type, encoding.svg`
- Workspace: `_ai-conspects/primary httphandler optoins, socket/`
- Authoritative processed source: `01-final-transcript.md`, section 2 (`AutomaticDecompression` response direction and decoded bytes)
- Original SVG: `source/primary httphandler optoins, socket.svg`
