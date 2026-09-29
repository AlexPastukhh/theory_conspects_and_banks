# ASP.NET Core response and output caching policies

Knowledge ID: `aspnet-core.response-and-output-caching-policies`

Topic: `aspnet-core`

## Two server caching layers

`ResponseCachingMiddleware` implements HTTP response-cache semantics. It follows request/response headers such as `Cache-Control`, `Vary`, and validators and primarily helps with publicly cacheable representations. `[ResponseCache]` emits policy headers; it does not by itself store responses on the API server. Server storage requires `AddResponseCaching()` and `UseResponseCaching()`. MVC cache profiles centralize repeated duration/policy header settings and are referenced by controllers.

Because Response Caching follows HTTP semantics, request directives such as `no-cache` or `max-age=0` can force validation rather than letting an application policy ignore the client. Browser, CDN, reverse-proxy, and middleware caches can all participate in this protocol.

`OutputCacheMiddleware` stores generated server output under application policy. It controls eligibility, lookup, storage, expiration, key variation, locking, tags, and invalidation even when clients do not cooperate with cache headers.

For an API or SPA backend that must retain final application control over reuse instead of honoring client cache directives as the storage decision, Output Cache is generally the better server-side layer.

Setup combines `AddOutputCache(...)`, named fluent policies or `IOutputCachePolicy`, `UseOutputCache()`, and endpoint/controller metadata.

## Global options, policy builders, and defaults

`OutputCacheOptions` controls middleware-wide settings. The source examples show default expiration of 60 seconds, maximum eligible body size of 64 MB, total store budget of 100 MB, path case sensitivity, and `ApplicationServices` for framework/policy service access rather than ordinary service lookup.

`AddPolicy` accepts a named builder, a policy instance, or a builder with `excludeDefaultPolicy: true`. Normal builders compose with the conservative built-in policy; excluding it deliberately replaces the eligibility, lookup, locking, variation, and storage protections.

The default policy caches successful 200 responses to GET/HEAD, rejects authenticated requests and responses that set cookies, supplies default freshness, and varies by query keys unless narrowed. `Cache()` starts with normal behavior; `NoCache()` opts out.

Builder operations include:

```text
Expire
SetVaryByQuery / Header / RouteValue / Host
SetCacheKeyPrefix
VaryByValue
Tag
With
SetLocking
```

`QueryKeys = "*"` means all query keys only for that API. `With(...)` is a request predicate, not a key dimension. `SetCacheKeyPrefix` communicates namespace/partitioning; `VaryByValue` adds a request-derived dimension such as tenant, device class, or feature bucket.

Route-value or host variation can duplicate dimensions already present in the normal key, but can still make a custom policy's intent explicit. `SetLocking` controls request coalescing so concurrent misses can avoid generating the same response simultaneously.

## Identity, privacy, and variation

A stored response is shared by every request that maps to the same key. Missing variation can serve the wrong route, language, representation, tenant, or user. Header/query/route/host variation is useful only when it corresponds to a real content dimension; high-cardinality or user-specific dimensions usually make whole-response caching unsafe or ineffective.

Do not treat “no `Set-Cookie` response header” as proof of anonymity. Content can depend on `User`, session, tenant, profile, or permissions. Personalized endpoints should normally opt out unless every content-changing dimension is safely represented and the privacy consequences are explicit.

## Policy context, store, and tags

`OutputCacheContext` exposes independent controls:

```text
EnableOutputCaching
AllowCacheLookup
AllowCacheStorage
AllowLocking
CacheVaryByRules
Tags
ResponseExpirationTimeSpan
ResponseTime
```

Independence permits normal read/write, lookup-only, storage-only, or disabled behavior.

`IOutputCacheStore` is the middleware's byte-oriented get/set/evict abstraction, not the usual application API for serving payloads manually. Prefer policies and public abstractions unless store-level coupling is intentional.

Tags group entries for invalidation; they do not create keys or variants. `EvictByTagAsync` invalidates a group. A product response might carry `product-details`, `product-details:{id}`, and an optional language tag. Assign tags through `Tag(...)` or early policy execution; late mutation may occur after persistence metadata was captured.

## Validators

Output Cache can compare request validators with a cached representation and answer 304. Merely emitting an ETag does not make arbitrary application code perform comparison. When bypassing middleware, application code owns validator logic. Store the full 200 representation, not a generated 304 bodyless protocol response.

Without Output Cache or explicit conditional-request logic, assigning `Response.GetTypedHeaders().ETag` only emits the header; it does not make ASP.NET Core compare a later `If-None-Match` request. Output Cache can perform that comparison and return `304` from a fresh cached entry without executing the endpoint.

Short server TTL plus ETag/Last-Modified lets browsers and CDNs revalidate cheaply. Revalidation against a cached ETag checks that cached representation, not current database state; force endpoint execution when current data must be re-read.

## What should be recallable

- How do ResponseCaching, `[ResponseCache]`, and Output Cache differ?
- Which safety rules disappear when a policy excludes the default?
- How do `With`, key prefix, variation, and tags affect different parts of caching?
- Why is absence of `Set-Cookie` insufficient to prove shareability?
- Which independent behaviors do the `OutputCacheContext` flags permit?
- What can Output Cache revalidate, and when must application code query current data?

## Sources

- Workspace: `_ai-conspects/outputcache, response cache comparison/`
- Authoritative processed source: `regions/R01-outputcache-responsecache-policies-etags-final.md`, `R02-middleware-options-default-policy-builder-variation.md`, and `R03-custom-policy-store-tags-context-responsecache-etag.md`
- Original SVG: `source/outputcache, response cache comparison.svg`
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R06-http-caching-validators.md`, ASP.NET Core response-caching claims
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS/`
- Authoritative processed source: `regions/R01R07-cache-control-response-caching-etag-full-coverage-v001.md`, R06 and R07
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/ETAG, e tag/`
- Authoritative processed source: `01-final-transcript.md`, R01
- Original SVG: `source/ETAG, e tag.svg`
