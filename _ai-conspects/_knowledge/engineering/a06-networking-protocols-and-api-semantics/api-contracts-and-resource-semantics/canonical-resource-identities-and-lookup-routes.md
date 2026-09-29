# Canonical resource identities and lookup routes

Knowledge ID: `http.canonical-resource-identities-and-lookup-routes`

Topic: `http`

A resource should normally have one stable API identity URL:

```http
GET /api/clients/{clientId}
```

The canonical URI is the address used for self links, generated links, cache identity, bookmarks and documentation. It also gives a client-side identity map one stable key for the resource.

## Alternate keys are lookup helpers

A client may need to discover the same resource through another unique key:

```http
GET /api/clients/by-email/{email}
GET /api/clients/by-external-id/{externalId}
```

These routes answer “how can I find this resource by another key?” They do not need to create additional official identities for the same resource.

One response shape returns the representation while preserving its canonical self link:

```json
{
  "id": "10",
  "name": "Alex",
  "_links": {
    "self": "/api/clients/10"
  }
}
```

For a GET lookup, the source also permits redirecting to the canonical route with `302` or `307`:

```text
GET /api/clients/by-email/alex@example.com
-> /api/clients/10
```

In either form, alternate discovery ends at one stable identity contract.

## Cost of several official URLs

If every lookup URI is treated as an equal canonical address, operational identity fragments:

```text
cache entries split
bookmarks diverge
self links become inconsistent
generated clients cannot choose one stable identity
authorization and observability rules become harder to reason about
```

This is different from exposing deliberately scoped collection or child routes. Whether a child needs a parent path depends on its identity, tenancy, ownership and security boundary. If a globally unique child is addressed at a top-level URI, a nested alias must not silently ignore the parent or claim containment that the query does not enforce.

## Route-design boundary

```text
canonical identity route
    stable official address for one resource

alternate-key lookup
    discovery mechanism that returns or redirects to canonical identity

parent-scoped route
    identity or access scope whose parent-child relation must be enforced
```

Do not confuse a convenient lookup key with a second identity, or a decorative parent identifier with an enforced scope.

## What should be recallable

- What makes a route the canonical identity for a resource?
- Why are email and external-ID routes normally lookup helpers?
- How can a lookup response preserve canonical identity without redirecting?
- Which systems become inconsistent when one resource has several official URLs?
- How does an alternate lookup differ from a parent-scoped child route?
- Why must a nested alias enforce its parent rather than ignore it?

## Related knowledge

- `aspnet-core.nested-resource-route-design`
- `aspnet-core.createdat-route-generation`
- `http.hypermedia-links-and-representation-negotiation`
- `http.rest-constraints-resource-and-method-semantics`

## Sources

- Workspace: `_ai-conspects/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED/`
- Authoritative processed source: `01-final-transcript.md`, R01 through R03
- Identical regional transcript: `regions/R01R02R03-routing-route-design-final-v001.md`
- Original SVG: `source/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg`
