# HTTP cache freshness, storage, and validation

Knowledge ID: `http.cache-validation-headers`

Topic: `http`

`Cache-Control` carries directives in both directions. A response describes whether and how its representation may be stored and reused; a request describes what reuse the client is willing to accept. A cache evaluates the applicable request and response constraints together and follows the stricter applicable result, while exact precedence remains directive-specific—there is no single rule that every request directive simply overrides every response directive.

## Request controls

Typical request directives include:

- `max-age=N`: accept an entry no older than the requested freshness bound;
- `max-age=0`: force a current validation path in common reload behavior;
- `min-fresh=N`: require the entry to remain fresh for at least another N seconds;
- `max-stale[=N]`: permit a stale entry, optionally within a bound;
- `no-cache`: require validation before reuse;
- `no-store`: ask participants not to store this exchange;
- `only-if-cached`: do not contact origin; return a cache result or commonly `504`.

A request cannot make an unsafe response public merely by asking for cached data. The response policy still controls storage/shareability.

## Freshness timeline

```http
Cache-Control: public, max-age=60
Date: Tue, 01 Sep 2026 10:00:00 GMT
```

```text
age 0..60 seconds -> fresh: reuse without contacting origin
age >60 seconds   -> stale: validation or another allowed stale policy is required
```

Explicit `max-age` or `Expires` defines freshness. `Expires` is clock-dependent and less expressive. If neither is present, some caches may apply heuristic freshness from fields such as `Last-Modified`; others may not store or reuse the response. Omission is not a reliable policy—emit the intended directives.

`immutable` suits long-lived fingerprinted assets whose bytes never change at the same URL. It says a fresh representation need not be revalidated merely because the user reloads; it does not make a stale entry permanently fresh.

## Freshness and validators are different

Freshness allows reuse without an origin request. Validators make a stale or explicitly revalidated entry cheap to check:

```http
ETag: "orders-v7"
Last-Modified: Tue, 01 Sep 2026 09:55:00 GMT
Cache-Control: public, max-age=60
```

After freshness ends, the client can send:

```http
If-None-Match: "orders-v7"
If-Modified-Since: Tue, 01 Sep 2026 09:55:00 GMT
```

If the selected representation is unchanged, the server returns `304 Not Modified` without the representation body. If it changed, the server returns a new `200` representation and validators. Strong ETags describe byte equivalence; weak validators can describe semantic equivalence.

An ETag is an opaque quoted value such as `"orders-v7"`; a weak validator adds the `W/` prefix, as in `W/"orders-v7"`. When a cache-validation request supplies both `If-None-Match` and `If-Modified-Since`, evaluate the ETag precondition first and use the timestamp only when ETag validation is unavailable. Entity tags are usually more precise than modification timestamps.

`no-cache` permits storage but requires validation before reuse. `no-store` forbids storage. `must-revalidate` prevents a cache from serving a stale entry when it cannot validate, unless another explicit directive permits that behavior.

## Private, shared, and resilient reuse

- `private`: a private user-agent cache may store the response; a shared CDN/proxy must not reuse it.
- `public`: explicitly permits shared-cache storage when the rest of the policy allows it.
- `s-maxage=N`: overrides the shared-cache freshness lifetime without changing the private-cache lifetime.
- `stale-while-revalidate=N`: permits bounded stale serving while refresh happens in the background.
- `stale-if-error=N`: permits bounded stale serving when origin validation/fetch fails.
- `no-transform`: asks intermediaries not to transform the representation.

Authenticated or personalized output must not be marked shared merely to improve hit rate. A missing `public`/`private` directive is ambiguous, not proof that cross-user reuse is safe.

`Vary` is a separate cache-key dimension. A fresh public response can still be wrong when the cache key omits a request header that selects its representation.

## Policy patterns

```http
# Public catalog with cheap validation
Cache-Control: public, max-age=60, s-maxage=300
ETag: "catalog-v42"

# Personalized response
Cache-Control: private, max-age=30
ETag: "profile-v8"

# Sensitive response that must not be retained
Cache-Control: no-store

# Store, but validate every reuse
Cache-Control: no-cache
ETag: "document-v3"

# Stale data must not be served after freshness
Cache-Control: public, max-age=60, must-revalidate

# Resilient shared-cache response
Cache-Control: public, max-age=60, stale-while-revalidate=30, stale-if-error=300
```

For each representation decide:

1. May it be stored?
2. May it be shared across users?
3. How long may it be reused without origin contact?
4. Which validator should make reuse cheap after freshness ends?
5. Which request dimensions belong in the cache key?
6. May bounded stale content be served during revalidation or origin failure?

## What should be recallable

- How do request and response Cache-Control directives answer different questions?
- What happens as a `max-age` entry moves from fresh to stale?
- Why is missing explicit freshness implementation-dependent?
- How do freshness and validators compose into `200`/`304` flows?
- How do `no-cache`, `no-store`, and `must-revalidate` differ?
- What do `private`, `public`, `s-maxage`, `immutable`, and bounded stale directives mean?
- Which six decisions define a response caching policy?

## Sources

- Workspace: `_ai-conspects/headers/`
- Integrated source: `FINAL_TRANSCRIPT.md`, section 7
- Regional evidence: `regions/R03-asp-net-core-header-abstractions-stringvalues-operations-and-common-typed-proper.md`
- Original SVG: `source/headers.svg`
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R06-http-caching-validators.md`
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS/`
- Authoritative processed source: `regions/R01R07-cache-control-response-caching-etag-full-coverage-v001.md`, R01-R07
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/ETAG, e tag/`
- Authoritative processed source: `01-final-transcript.md`, R01
- Original SVG: `source/ETAG, e tag.svg`
