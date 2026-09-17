# REST constraints, resource contracts, and method semantics

Knowledge ID: `http.rest-constraints-resource-and-method-semantics`

Topic: `http`

## REST constraints

A RESTful system combines six constraints:

- uniform interface: URI-addressed resources, standard HTTP methods, and negotiated representations;
- client–server separation: both sides evolve behind the shared contract;
- statelessness: each request carries the state needed to process it;
- layered system: clients need not know whether an intermediary sits before the origin;
- cacheability: responses state their caching policy;
- optional code on demand: server-supplied executable code can extend a client, though this is uncommon for APIs.

## Public resource contract

Build the external contract from a resource identifier, an HTTP method, and request/response representations. Prefer meaningful nouns and hierarchy:

```text
/api/authors
/api/authors/{authorId}
/api/authors/{authorId}/courses
/api/authors/{authorId}/courses/{courseId}
```

Filtering and sorting are query instructions, not separate resources. An RPC-like operation that has no natural noun can become a subordinate action resource as a deliberate exception. Expose DTOs/public resource models rather than persistence entities so friendly/calculated fields and internal storage remain independently evolvable.

Use plural nouns and HTTP methods for ordinary CRUD instead of action-heavy routes such as `/getClient` or `/createRequest`. A dedicated command route such as `POST /requests/{id}/approve` is justified when approval has its own domain rules, actor, side effects, authorization, or audit trail; do not disguise that workflow as a field update merely to look resource-oriented. Conversely, a documented idempotent state transition may reasonably use `PUT` or `PATCH`.

Optional filters, sorting, and paging normally stay on a collection `GET`. When a search or batch request needs a large structured body, many identifiers, complex validation, or sensitive values that should not appear in URLs and logs, model it explicitly, for example `POST /requests/search` or `POST /requests/bulk`.

## Safety, idempotency, and CRUD

```text
GET, HEAD, OPTIONS -> safe and idempotent
PUT, DELETE        -> idempotent, not safe
POST               -> neither
PATCH              -> not inherently idempotent
```

Safe means the method does not change resource representation; idempotent means repetition has the same intended result.

- Collection GET normally returns a paged collection; item GET returns one resource or 404.
- Item DELETE commonly returns 204 or 404. Whole-collection DELETE is uncommon because its safety/meaning is ambiguous.
- When the server chooses an identifier, POST to the collection and normally return 201, `Location`, and optionally the representation.
- When the client chooses the identifier, PUT to the final URI can create or replace under a documented rule.
- PUT replaces a full representation. PATCH applies a partial change document.
- A missing update target normally returns 404 unless upsert is explicit and defines identity, defaults, required fields, and conflicts.

Collection creation, bulk creation, and nested-resource creation need explicit endpoint semantics rather than accidental route behavior.

Bulk create/update must define all-or-nothing versus best-effort behavior, per-item errors, transaction boundaries, and concurrency such as `ETag`/`If-Match`.

## Richardson maturity model

```text
Level 0 -> HTTP transports RPC calls
Level 1 -> distinct resource URIs
Level 2 -> HTTP methods and status codes carry semantics
Level 3 -> hypermedia controls drive available transitions
```

Level 3 is the strongest REST form, but useful APIs can deliberately stop short of strict REST purity.

## What should be recallable

- What responsibility does each REST constraint add?
- Why are public resource DTOs separate from database entities?
- How do safety and idempotency classify the common methods?
- How do server-selected and client-selected identifiers change creation semantics?
- Which policies must a bulk mutation endpoint make explicit?
- What changes at each Richardson maturity level?

## Sources

- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R01-rest-constraints-methods-validation.md`, REST/resource/method/Richardson claims
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED/`
- Authoritative processed source: `01-final-transcript.md`, R01-R03 (noun routes, domain commands, filtering/search and bulk boundaries)
- Original SVG: `source/ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg`
