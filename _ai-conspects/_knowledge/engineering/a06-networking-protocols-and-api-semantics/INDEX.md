# A06 — Networking, Protocols & API Semantics

This index is a physical/navigation projection. Finer semantic placement remains in the semantic hierarchy.

## API Contracts & Resource Semantics

### Area-owned Units

- [`http.api-root-document-discovery` — API root document and link discovery](api-contracts-and-resource-semantics/api-root-document-discovery.md)
- [`http.api-versioning-and-deprecation` — API versioning and deprecation](api-contracts-and-resource-semantics/api-versioning-and-deprecation.md)
- [`http.canonical-resource-identities-and-lookup-routes` — Canonical resource identities and lookup routes](api-contracts-and-resource-semantics/canonical-resource-identities-and-lookup-routes.md)
- [`aspnet-core.createdat-route-generation` — CreatedAt route generation for creation endpoints](api-contracts-and-resource-semantics/createdat-route-generation.md)
- [`aspnet-core.hateoas-link-generation-and-resource-envelopes` — HATEOAS link generation and resource envelopes](api-contracts-and-resource-semantics/hateoas-link-generation-and-resource-envelopes.md)
- [`aspnet-core.paged-list-query-and-consistency` — Paged-list query execution and consistency](api-contracts-and-resource-semantics/paged-list-query-and-consistency.md)
- [`http.problem-details-public-error-contracts` — Problem Details as a public error contract](api-contracts-and-resource-semantics/problem-details-public-error-contracts.md)
- [`aspnet-core.problem-details-writers-context-and-metadata` — Problem Details writers, context, and endpoint metadata](api-contracts-and-resource-semantics/problem-details-writers-context-and-metadata.md)
- [`aspnet-core.public-sorting-property-mapping` — Public sorting and property mapping](api-contracts-and-resource-semantics/public-sorting-property-mapping.md)
- [`aspnet-core.status-code-pages-and-problem-details` — Status Code Pages and Problem Details responses](api-contracts-and-resource-semantics/status-code-pages-and-problem-details.md)

### Technology Core links

- [`aspnet-core.dynamic-data-shaping` — ASP.NET Core dynamic data shaping](../../technology-core/aspnet-core/dynamic-data-shaping.md)
- [`aspnet-core.collection-filter-search-query-composition` — Collection filtering and search query composition](../../technology-core/aspnet-core/collection-filter-search-query-composition.md)

## HTTP Semantics

### Area-owned Units

- [`http.accept-negotiation-ranking-and-selection` — Accept negotiation ranking and deterministic selection](http-semantics/accept-negotiation-ranking-and-selection.md)
- [`aspnet-core.json-xml-formatters-and-default-order` — ASP.NET Core JSON/XML formatters and default order](http-semantics/json-xml-formatters-and-default-order.md)
- [`http.authentication-headers` — Authentication credentials and challenges](http-semantics/authentication-headers.md)
- [`http.browser-cookie-delivery-and-security` — Browser cookie delivery and security](http-semantics/browser-cookie-delivery-and-security.md)
- [`javascript.etag-write-precondition-lifecycle` — Browser ETag lifecycle for write preconditions](http-semantics/etag-write-precondition-lifecycle.md)
- [`http.browser-header-controls-and-cors-visibility` — Browser-controlled headers and CORS visibility](http-semantics/browser-header-controls-and-cors-visibility.md)
- [`http.client-server-roles-listening-and-request-flow` — Client/server roles, listening endpoints, and HTTP flow](http-semantics/client-server-roles-listening-and-request-flow.md)
- [`http.content-disposition-filenames` — Content-Disposition behavior and safe filenames](http-semantics/content-disposition-filenames.md)
- [`http.cookie-and-set-cookie` — Cookie and Set-Cookie header models](http-semantics/cookie-and-set-cookie.md)
- [`http.cookie-scope-and-secure-prefixes` — Cookie host scope, path, names, and secure prefixes](http-semantics/cookie-scope-and-secure-prefixes.md)
- [`http.cookie-session-vs-jwt-credentials` — Cookie sessions versus JWT credentials](http-semantics/cookie-session-vs-jwt-credentials.md)
- [`http.creation-responses-and-operation-resources` — Creation responses and operation resources](http-semantics/creation-responses-and-operation-resources.md)
- [`http.head-conditional-metadata` — HEAD requests, validators, and representation metadata](http-semantics/head-conditional-metadata.md)
- [`http.cache-validation-headers` — HTTP cache freshness, storage, and validation](http-semantics/cache-validation-headers.md)
- [`http.content-coding-direction-and-negotiation` — HTTP content coding direction and negotiation](http-semantics/content-coding-direction-and-negotiation.md)
- [`http.dotnet-header-representation` — HTTP header ownership and .NET representations](http-semantics/dotnet-header-representation.md)
- [`dotnet.httpclient-body-length-framing-and-compression` — HttpClient body length, transfer framing, and compression](http-semantics/httpclient-body-length-framing-and-compression.md)
- [`dotnet.httpclient-handler-pipelines-and-transport-configuration` — HttpClient handler pipelines and transport configuration](http-semantics/httpclient-handler-pipelines-and-transport-configuration.md)
- [`dotnet.httpclient-request-content-and-representation` — HttpClient request content types and representation costs](http-semantics/httpclient-request-content-and-representation.md)
- [`dotnet.httpclient-request-replayability-and-retries` — HttpClient request replayability and retries](http-semantics/httpclient-request-replayability-and-retries.md)
- [`dotnet.httpclient-requests-responses-and-ownership` — HttpClient requests, responses, and ownership](http-semantics/httpclient-requests-responses-and-ownership.md)
- [`dotnet.httpclient-response-streaming` — HttpClient response buffering and progressive streaming](http-semantics/httpclient-response-streaming.md)
- [`dotnet.httpclientfactory-client-and-handler-lifetimes` — HttpClientFactory client and handler lifetimes](http-semantics/httpclientfactory-client-and-handler-lifetimes.md)
- [`dotnet.httpcontent-media-type-charset-and-content-encoding` — HttpContent media type, charset, and content encoding](http-semantics/httpcontent-media-type-charset-and-content-encoding.md)
- [`http.hypermedia-links-and-representation-negotiation` — Hypermedia links and representation negotiation](http-semantics/hypermedia-links-and-representation-negotiation.md)
- [`javascript.url-encoding-components` — JavaScript URL and component encoding](http-semantics/url-encoding-components.md)
- [`http.last-modified-revalidation-and-freshness` — Last-Modified revalidation and freshness](http-semantics/last-modified-revalidation-and-freshness.md)
- [`http.location-header` — Location header semantics](http-semantics/location-header.md)
- [`dotnet.named-and-typed-httpclient-configuration` — Named and typed HttpClient configuration](http-semantics/named-and-typed-httpclient-configuration.md)
- [`http.options-and-cors-preflight` — OPTIONS and browser CORS preflight](http-semantics/options-and-cors-preflight.md)
- [`http.put-patch-and-update-preconditions` — PUT, PATCH, representations, and update preconditions](http-semantics/put-patch-and-update-preconditions.md)
- [`http.rate-limit-responses-and-retry-after` — Rate-limit responses and Retry-After](http-semantics/rate-limit-responses-and-retry-after.md)
- [`http.rest-constraints-resource-and-method-semantics` — REST constraints, resource contracts, and method semantics](http-semantics/rest-constraints-resource-and-method-semantics.md)
- [`http.sse-event-stream-reconnection` — SSE event framing, retry, and reconnection](http-semantics/sse-event-stream-reconnection.md)
- [`dotnet.streaming-gzip-httpcontent` — Streaming gzip JSON with custom HttpContent](http-semantics/streaming-gzip-httpcontent.md)
- [`axios.typed-client-boundaries` — Typed Axios clients and runtime boundaries](http-semantics/typed-client-boundaries.md)
- [`http.vary-representation-cache-keys` — Vary and representation cache keys](http-semantics/vary-representation-cache-keys.md)
- [`http.vary-origin-cache-variants` — Vary: Origin and CORS cache variants](http-semantics/vary-origin-cache-variants.md)

### Technology Core links

- [`aspnet-core.json-patch-formatters-and-content-negotiation` — ASP.NET Core JSON Patch formatters and content negotiation](../../technology-core/aspnet-core/json-patch-formatters-and-content-negotiation.md)
- [`aspnet-core.media-type-formatters-and-406-415` — ASP.NET Core media-type formatters and 406/415](../../technology-core/aspnet-core/media-type-formatters-and-406-415.md)
- [`aspnet-core.semantic-media-types-and-formatter-contracts` — ASP.NET Core semantic media types and formatter contracts](../../technology-core/aspnet-core/semantic-media-types-and-formatter-contracts.md)
- [`aspnet-core.cache-control-headers-responsecache-attribute-and-middleware` — Cache-Control headers, ResponseCacheAttribute, and Response Caching middleware](../../technology-core/aspnet-core/cache-control-headers-responsecache-attribute-and-middleware.md)
- [`aspnet-core.cors-middleware-preflight` — CORS middleware and preflight handling](../../technology-core/aspnet-core/cors-middleware-preflight.md)
- [`axios.adapters-progress-and-streaming` — Axios adapters, progress, and streaming](../../technology-core/axios/adapters-progress-and-streaming.md)
- [`axios.files-and-query-serialization` — Axios files, binary responses, and query serialization](../../technology-core/axios/files-and-query-serialization.md)
- [`axios.interceptor-lifecycle-status-and-token-refresh` — Axios interceptor lifecycle, status policy, and token refresh](../../technology-core/axios/interceptor-lifecycle-status-and-token-refresh.md)
- [`axios.payload-transforms-and-interceptor-boundaries` — Axios payload transforms and interceptor boundaries](../../technology-core/axios/payload-transforms-and-interceptor-boundaries.md)
- [`axios.request-configuration-and-instance-defaults` — Axios request configuration and instance defaults](../../technology-core/axios/request-configuration-and-instance-defaults.md)

## Network & Transport Foundations

### Area-owned Units

- [`dotnet.clientwebsocket-options-and-connection-state` — ClientWebSocket options and connection state](network-and-transport-foundations/clientwebsocket-options-and-connection-state.md)
- [`architecture.forward-and-reverse-proxy-roles` — Forward and reverse proxy roles](network-and-transport-foundations/forward-and-reverse-proxy-roles.md)
- [`architecture.reverse-proxy-central-routing-and-policy` — Reverse-proxy central routing and policy](network-and-transport-foundations/reverse-proxy-central-routing-and-policy.md)
- [`architecture.reverse-proxy-edge-tls-isolation-and-offload` — Reverse-proxy edge TLS, isolation, and offload](network-and-transport-foundations/reverse-proxy-edge-tls-isolation-and-offload.md)
- [`dotnet.sockets-http-handler-connection-pooling-and-proxies` — SocketsHttpHandler connection pooling, proxies, and primary-handler ownership](network-and-transport-foundations/sockets-http-handler-connection-pooling-and-proxies.md)
- [`dotnet.sockets-http-handler-response-upload-and-tls-options` — SocketsHttpHandler response, upload, and TLS options](network-and-transport-foundations/sockets-http-handler-response-upload-and-tls-options.md)
- [`http.websocket-message-framing` — WebSocket message framing across server and browser APIs](network-and-transport-foundations/websocket-message-framing.md)
- [`http.websocket-upgrade-subprotocols-and-application-contracts` — WebSocket upgrade, subprotocols, and application contracts](network-and-transport-foundations/websocket-upgrade-subprotocols-and-application-contracts.md)
- [`aspnet-core.yarp-routes-clusters-and-destinations` — YARP routes, clusters, and destinations](network-and-transport-foundations/yarp-routes-clusters-and-destinations.md)
