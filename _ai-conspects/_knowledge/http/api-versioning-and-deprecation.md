# API versioning and deprecation

Knowledge ID: `http.api-versioning-and-deprecation`

Topic: `http`

APIs evolve in functionality, business rules, and resource representations. Prefer compatible evolution; hypermedia can evolve available behavior and media types can negotiate representation changes without freezing duplicate endpoint sets forever.

When a breaking version is necessary, common selectors are:

```text
URI path     /api/v1/authors
query        /api/authors?api-version=v1
header       api-version: v1
media type   versioned vendor representation
```

URI versions are explicit/cache-friendly but change the address. Query versions keep a stable path but are less visible. Header versions preserve the URI but complicate debugging and cache keys. Media-type versions align with representation changes but require stronger negotiation support. Pick one strategy and apply it consistently.

Breaking changes include removing/renaming a field, changing its type or meaning, changing default sort/page behavior, and tightening validation so formerly valid input fails.

The operating policy matters more than the selector. Announce deprecation, publish a sunset date, keep the old version for a defined period, and provide a migration guide. `Deprecation` and `Sunset` response headers can communicate the timeline. ASP.NET API Versioning supports URI-segment, query, and header schemes and can report supported versions.

## What should be recallable

- Which API changes can break clients beyond a simple field removal?
- What trade-offs distinguish path, query, header, and media-type versioning?
- Which operational promises belong in a deprecation policy?
- How do `Deprecation` and `Sunset` support migration?

## Sources

- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R05-versioning-deprecation.md`
- Original SVG: `source/REST API BASICS.svg`
