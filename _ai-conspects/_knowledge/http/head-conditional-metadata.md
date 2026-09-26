# HEAD requests, validators, and representation metadata

Knowledge ID: `http.head-conditional-metadata`

Topic: `http`

HEAD selects the same representation as GET but the server must not send content. Status and representation metadata should correspond to GET, though fields known only while generating content may be omitted.

A cheap metadata projection can support 404, ETag/Last-Modified, and conditional evaluation without loading or serializing the representation. The validator must change whenever the selected representation changes; timestamps can have precision/rapid-update weaknesses. GET and HEAD should share validator logic.

`Content-Length` on HEAD must be the exact number of octets GET would send, never an estimate. Omit it when exact calculation would defeat the optimization. Conditional HEAD is valid, but conditional GET is usually better for revalidation because a changed representation returns immediately instead of requiring HEAD then GET. `If-None-Match` requires parsed entity tags, wildcard support, and weak comparison.

## What should be recallable

- Explain the core model of **HEAD requests, validators, and representation metadata** without opening the Unit.
- Reconstruct this Unit-grounded rule: HEAD selects the same representation as GET but the server must not send content.
- Reconstruct this Unit-grounded rule: A cheap metadata projection can support 404, ETag/Last-Modified, and conditional evaluation without loading or serializing the representation.
- Reconstruct this Unit-grounded rule: `Content-Length` on HEAD must be the exact number of octets GET would send, never an estimate.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources

- Workspace: `_ai-conspects/HEAD REQUEST/`
- Processed source: `04-source-preserving-corrected-transcript-v003.md`, complete corrected transcript
