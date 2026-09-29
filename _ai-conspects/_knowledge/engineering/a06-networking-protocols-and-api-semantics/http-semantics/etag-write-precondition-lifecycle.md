# Browser ETag lifecycle for write preconditions

Knowledge ID: `javascript.etag-write-precondition-lifecycle`

Topic: `javascript`

Browsers and caches may automatically retain a response validator and later send `If-None-Match` while revalidating a cached GET. That behavior depends on cache policy, method, browser cache state, and fetch options. It does not automatically protect a later API mutation: browser JavaScript owns the optimistic-concurrency `If-Match` lifecycle.

For PUT, PATCH, or DELETE:

```text
GET the resource
    -> read its ETag response header
    -> keep resource and validator in the edit state
    -> send the validator later as If-Match
    -> handle 412 or 428
    -> after success, replace the stored validator with the new response ETag
```

```javascript
const response = await fetch("/api/products/5");
const product = await response.json();
const etag = response.headers.get("ETag");

const update = await fetch("/api/products/5", {
  method: "PATCH",
  headers: {
    "Content-Type": "application/json-patch+json",
    "If-Match": etag
  },
  body: JSON.stringify(patchDocument)
});

if (update.status === 412 || update.status === 428) {
  // Handle the failed or missing precondition.
}
```

The validator can live beside the resource in component state, an edit model, or a client-side cache. In React, keeping the resource and ETag together in state is usually simplest. Setting ETag state triggers a render like other state updates; a ref can avoid a render when the validator is purely request metadata.

Cross-origin JavaScript can read the `ETag` response header only when CORS exposes it:

```csharp
policy.WithExposedHeaders("ETag");
```

Same-origin code can normally read it under the Fetch API rules.

Keep the two validator questions distinct:

```text
If-None-Match on GET
    Can the cached representation be reused?

If-Match on PUT/PATCH/DELETE
    May this mutation be applied to the expected current version?
```

Automatic cache revalidation of a GET does not carry the validator into a later write. For stale-overwrite protection, use correctly quoted strong ETags, require `If-Match`, preserve the validator with the edit, handle missing and failed preconditions, and keep the database concurrency check behind the HTTP comparison.

## What should be recallable

- Why does automatic browser cache validation not protect API writes?
- What state must an SPA preserve between its read and mutation?
- When should the client replace the stored ETag?
- Why must CORS expose `ETag` for cross-origin JavaScript?
- How do `If-None-Match` and `If-Match` ask different questions?

## Related knowledge

- [[../http/cache-validation-headers]]
- [[../http/put-patch-and-update-preconditions]]
- [[../ef-core/rowversion-http-etag-concurrency]]

## Sources

- Workspace: `_ai-conspects/ETAG, e tag/`
- Authoritative processed source: `01-final-transcript.md`, R04
- Original SVG: `source/ETAG, e tag.svg`
