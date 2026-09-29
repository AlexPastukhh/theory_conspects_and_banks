# Creation responses and operation resources

Knowledge ID: `http.creation-responses-and-operation-resources`

Topic: `http`

A synchronous create normally completes before responding and returns:

```http
HTTP/1.1 201 Created
Location: /widgets/123
Content-Type: application/json

{ "id": 123, "name": "example" }
```

`Location` identifies a real retrievable URI for the created resource or result resource. The body is optional and can carry the new representation. Do not invent an address that no GET endpoint resolves.

## Several resources and one Location header

One header cannot point to several independent item URIs. A multi-create contract can instead choose:

- a real collection/subset URI;
- a batch-result resource URI;
- a collection URI plus created items with per-item self links in the body.

A sensible preference is a stable first-class batch/collection resource, then a real query URI selecting the created IDs, then a collection URI with per-item links. A comma-separated route segment is acceptable only when the API deliberately defines and documents that address.

For a completed synchronous bulk request:

```text
201 Created
Location: URI of collection/subset/batch result available now
body: created items and their self links
```

Define all-or-nothing versus partial success explicitly. Transactional all-or-nothing behavior is simpler when the contract does not define per-item failures.

## Asynchronous bulk work

Long-running creation should create an operation/status resource immediately:

```http
POST /authors/bulk

HTTP/1.1 202 Accepted
Location: /bulk-operations/7f2d
```

```text
1. client submits bulk input
2. server stores an operation record
3. server returns 202 and the operation Location
4. client polls that URI
5. the operation exposes progress and final resource IDs/links
```

The operation can contain:

```text
operationId, status
submittedAt, startedAt, completedAt
totalCount, succeededCount, failedCount
items, errors
```

with states such as `Queued`, `Running`, `Succeeded`, `Failed`, and `PartiallySucceeded`.

```text
201 Created -> creation finished during the request; resource/result is available
202 Accepted -> work was accepted but continues; Location identifies status/operation
```

Do not return `201` merely because unfinished background work was accepted. A bulk endpoint must also define transaction versus partial success, idempotency, duplicates, validation, cancellation, retry, result retention, and per-item correlation.

## What should be recallable

- What do status, Location, and optional body communicate in a completed create?
- Why must every Location URI be resolvable?
- What can one Location identify when several independent resources are created?
- How do synchronous `201` and asynchronous `202` creation differ?
- Why is an operation/status record a first-class resource?
- Which partial-success, retry, and retention policies must a bulk contract define?

## Related knowledge

- `http.location-header` — why Location semantics depend on the response status.
- `aspnet-core.createdat-route-generation` — generating creation URIs from application routing.

## Sources

- Workspace: `_ai-conspects/CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT/`
- Authoritative processed source: `01-final-transcript.md`, R01 through R03 (HTTP and bulk-resource semantics)
- Original SVG: `source/CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT.svg`
