# Vary and representation cache keys

Knowledge ID: `http.vary-representation-cache-keys`

Topic: `http`

`Vary` tells caches which request headers select representations of one URL. It neither provides freshness nor makes a response cacheable. Typical dimensions are `Accept`, `Accept-Encoding`, and `Accept-Language`; tenant headers belong only when they genuinely select safe public variants.

For example, a response compressed only when the request contains `Accept-Encoding: gzip` needs `Vary: Accept-Encoding`; otherwise a cache can serve compressed bytes to a client that did not select them. The same wrong-variant mechanism applies to language, semantic media type, and reflected CORS origin.

Missing dimensions can serve the wrong format, language, version, or tenant representation. High-cardinality dimensions reduce hit rate; `Cookie` or `Authorization` approaches cache-per-user and is risky. Query strings are already in the URL. `Vary: *` effectively prevents ordinary shared reuse. Prefer shared response caching for anonymous public GETs and private/no-store, validation, or application caching for personalized responses.

## Sources

- Workspace: `_ai-conspects/vary header/`
- Processed source: `02-full-combined-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R06-http-caching-validators.md`, `Vary` dimensions/cardinality
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/produces-consumes-input-output-formatters-406-415-vary-accept/`
- Authoritative processed source: `regions/R04-vary-accept-browser-accept-header-policy.md`
- Original SVG: `source/produces-consumes-input-output-formatters-406-415-vary-accept.svg`
- Workspace: `_ai-conspects/cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS/`
- Authoritative processed source: `regions/R01R07-cache-control-response-caching-etag-full-coverage-v001.md`, R05
- Original SVG: `source/source-complete-v001.svg`
