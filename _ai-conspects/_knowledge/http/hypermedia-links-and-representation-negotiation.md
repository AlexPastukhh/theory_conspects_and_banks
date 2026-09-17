# Hypermedia links and representation negotiation

Knowledge ID: `http.hypermedia-links-and-representation-negotiation`

Topic: `http`

Hypermedia controls describe transitions currently available for a resource. Instead of requiring a client to construct every URI and encode the whole workflow in advance, the server supplies discoverable actions with each representation. It can omit actions forbidden by state or permissions, reducing URI and workflow coupling while allowing links to evolve on the server.

A link carries `href`, semantic `rel`, and, in the source course's representation, `method`. `method` is useful course-specific metadata, not a universal link-format field. Prefer registered relations such as `self`, `next`, `prev`, `first`, `last`, `collection`, `item`, and `up`. If an API emits `previous`, document it as its own course/custom relation. Stable documented domain relations such as `reserve-course` are valid; name intent rather than repeating an HTTP verb. For an archived resource, expose `restore` instead of a generic update link when that is the real transition.

Hypermedia does not remove documentation: clients still need request schemas, response possibilities, relation meaning, and preconditions.

Paging often uses both display metadata (`totalCount`, `pageSize`, `currentPage`, `totalPages`) and control links (`self`, `previous`, `next`). Item links describe each resource; collection-level `self`/`first`/`previous`/`next`/`last` links control the page. A generated page link preserves current filters, search, sorting, field selection, and page size while changing only page number. Links can live in an envelope such as `{ value, links }`; putting metadata in an `X-Pagination` response header is a separate representation choice and cross-origin script must have that header exposed.

Links are machine-facing affordances, but links alone do not complete a REST contract. Clients still need a stable relation vocabulary, schemas, error behavior, authorization rules, and precondition contracts such as `If-Match`. Hypermedia also has adoption costs: larger representations, additional documentation, and clients that must understand relations.

Siren, HAL, JSON-LD, JSON:API, and OData provide existing conventions rather than requiring a private envelope.

## Negotiating semantic representations

`application/json` describes serialization format, not whether a representation is plain or carries hypermedia. Vendor media types can distinguish the contracts:

```text
application/vnd.marvin.author+json
application/vnd.marvin.author.hateoas+json
```

The client selects through `Accept`; the response identifies both format and semantic representation.

## What should be recallable

- How do hypermedia links reflect current state and permissions?
- Which fields and naming rules define a stable link relation?
- Why does HATEOAS still require documentation?
- Which query state must pagination links preserve?
- Why can two JSON bodies require different media types?

## Related knowledge

- `http.api-root-document-discovery`
- `http.vary-representation-cache-keys`

## Sources

- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R04-data-shaping-hateoas-content-negotiation.md`, HATEOAS/format claims
- Original SVG: `source/REST API BASICS.svg`
- Workspace: `_ai-conspects/hateoas/`
- Authoritative processed source: `regions/R01R06-hateoas-full-coverage-v001.md`, R01-R06
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/PAGING/`
- Authoritative processed source: `01-final-transcript.md`, R03
- Original SVG: `source/PAGING.svg`
- Workspace: `_ai-conspects/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON/`
- Authoritative processed source: `01-final-transcript.md`, R03
- Original SVG: `source/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg`
