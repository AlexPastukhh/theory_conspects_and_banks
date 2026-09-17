# ASP.NET Core media-type formatters and 406/415

Knowledge ID: `aspnet-core.media-type-formatters-and-406-415`

Topic: `aspnet-core`

## Response direction: `Accept`, `[Produces]`, and 406

`[Produces]` is response metadata/constraint. `Accept` expresses client preference; a registered output formatter serializes the object and must actually support the selected media type.

```text
object -> output formatter -> response body
Accept + Produces metadata + formatter support -> response Content-Type
```

`[Produces]` does not create XML/custom formatters or validate request bodies. Splitting one resource into plain, friendly, or hypermedia representations can be useful when each is a distinct contract and action metadata should document it.

ASP.NET Core can fall back to JSON for an unsupported `Accept` by default. With strict `ReturnHttpNotAcceptable`, a specific request for an unavailable representation returns `406 Not Acceptable`.

Parse one request `Content-Type` with `MediaTypeHeaderValue.TryParse`. A real `Accept` header is a comma-separated preference list, so manual negotiation must use `MediaTypeHeaderValue.TryParseList` and evaluate all alternatives and q-values. Applying the single-value parser to the whole list is the wrong abstraction.

Keep malformed syntax separate from a supported-types miss:

```text
malformed media type/list
    -> policy may return 400 Bad Request

valid Accept value, but no output formatter can produce it
    -> 406 Not Acceptable under strict negotiation
```

`Accept` normally does not select the controller action. Routing selects the action, the action can execute and return an object, and result execution then negotiates and selects the output formatter. An unsupported response representation may therefore be discovered only after the action has run.

An MVC exception or result filter that supplies an `ObjectResult` remains inside this formatter pipeline. The same error object can become JSON or XML according to `Accept`, registered formatters, and `[Produces]`/`ObjectResult.ContentTypes`. By contrast, middleware that writes JSON directly must own its output policy instead of assuming MVC will negotiate it. A result filter must replace/wrap the object before result execution; after `next()`, negotiation and serialization may already be complete.

## Request direction: `Content-Type`, `[Consumes]`, and 415

`[Consumes]` constrains accepted request media types and participates in action selection; an input formatter deserializes the body.

```text
body + Content-Type -> input formatter -> model
Consumes metadata  -> action candidate allowed for that type
```

Two distinct gates can produce failure: `[Consumes]` may prevent selecting the route/verb candidate, or the selected action may have no formatter capable of reading the media type. Missing required `Content-Type`, unsupported formatter types, and no matching media-specific action normally produce `415 Unsupported Media Type`.

Two same-route/same-verb actions can be disambiguated by vendor content type. Use custom `IActionConstraint` only for specialized action-selection logic beyond the built-in media-type rule. `[Consumes]` itself does not deserialize or register formatters.

Both `[Produces]` and `[Consumes]` also contribute supported response/request media types to OpenAPI/Swagger metadata.

## Directional diagnostic

```text
406 -> requested response representation unavailable
       inspect Accept, Produces, output formatters

415 -> submitted request representation unsupported
       inspect Content-Type, Consumes, input formatters/action selection
```

Status Code Pages or Problem Details can make bodyless failures actionable by naming the status, safe path/context, relevant header, and supported types when known. Do not leak formatter internals or claim an exact cause when selection is ambiguous.

A centralized status-code endpoint can map `/status-code/406` and `/status-code/415` to a reason phrase and the same safe Problem Details policy instead of duplicating diagnostics at every action.

## Browser headers and cache correctness

Browsers often send broad `Accept` lists (`text/html`, XML, images, `*/*`). Framework defaults may treat browser headers specially; `RespectBrowserAcceptHeader=true` makes MVC honor them fully and can change the selected representation.

When one URL returns different bodies based on `Accept`, include `Vary: Accept`. Negotiation chooses a representation; `Vary` tells caches that the choice is part of identity.

## Media-type endpoint diagnostics and examples

### S-037 — [Consumes] attribute.

```text
[Consumes] attribute.

Visible:
- `[Consumes("application/json")]`
- `[Consumes("multipart/form-data")]`
- controls/declares what request content types the action accepts.

Meaning:
Use [Consumes] to restrict and document expected request Content-Type, especially when overloads/actions could otherwise be ambiguous.
```

### S-038 — [Produces] attribute.

```text
[Produces] attribute.

Visible:
- `[Produces("application/json")]`
- maybe response media type.

Meaning:
[Produces] is about response content type/documentation, not request body parsing. It belongs to output formatting/metadata.
```

### S-039 — Consumes vs Produces.

```text
Consumes vs Produces.

Visible contrast:
- Consumes = request Content-Type.
- Produces = response Content-Type / Accept negotiation/documentation.

Meaning:
Do not confuse inbound and outbound media type metadata. Content-Type describes what is sent; Accept describes what response client wants.
```

### S-040 — 415 Unsupported Media Type.

```text
415 Unsupported Media Type.

Visible:
- Happens when request Content-Type is not supported by endpoint/input formatter.
- Example: sending text/plain or form data to an action expecting JSON.

Meaning:
415 is usually a media-type/binder/formatter mismatch before your action logic runs.
```

### S-041 — 406 Not Acceptable.

```text
406 Not Acceptable.

Visible:
- Related to Accept header and response format negotiation.
- Server cannot produce requested media type.

Meaning:
406 is about response negotiation, not request body parsing. It can be enabled by returning 406 when Accept cannot be satisfied.
```

### S-042 — 400 Bad Request.

```text
400 Bad Request.

Visible:
- Bad JSON / validation / model state errors.
- Body parses to wrong shape or fails validation.

Meaning:
400 is after the server accepted the media type but could not bind/validate the request successfully.
```

### S-043 — Swagger/OpenAPI requestBody.

```text
Swagger/OpenAPI requestBody.

Visible:
- OpenAPI shows content types under requestBody/content.
- multipart/form-data schema for files.
- application/json schema for JSON DTOs.

Meaning:
Swagger metadata should reflect real endpoint behavior. If docs say JSON but endpoint expects form data, client generation/testing will be wrong.
```

### S-044 — Endpoint examples.

```text
Endpoint examples.

Visible:
- Controller/minimal API examples with attributes.
- Different endpoints for JSON vs multipart/raw.

Meaning:
Separate endpoints or explicit Consumes metadata can make API contracts clearer than one ambiguous action trying to accept everything.
```

### S-045 — Debugging checklist.

```text
Debugging checklist.

Visible list:
- Check client Content-Type.
- Check request body shape.
- Check action attributes: FromBody/FromForm.
- Check [Consumes].
- Check formatters/model binding.

Meaning:
Most media type bugs are mismatches among body format, Content-Type header, and server binding path.
```

### S-046 — Accept header debugging.

```text
Accept header debugging.

Visible:
- Accept: application/json
- Accept: text/plain
- response output format.

Meaning:
If request reaches action but response type is unexpected, inspect Accept and output formatters rather than input formatter logic.
```

### S-047 — Minimal APIs / endpoint metadata.

```text
Minimal APIs / endpoint metadata.

Visible:
- Minimal API can document/consume/produce content types through metadata helpers.
- Body binding still depends on parameter shape/content type.

Meaning:
The same media-type concepts apply in minimal APIs: request body binding, metadata, and response negotiation.
```

### S-048 — Practical mismatch examples.

```text
Practical mismatch examples.

Visible:
- Client sends multipart but action expects [FromBody] JSON DTO.
- Client sends JSON but action expects [FromForm].
- Client sends octet-stream but action expects byte[] through unsupported formatter.

Meaning:
When you see 415/400, first compare body media type with action parameter source and registered formatters.
```

### S-049 — Final rule summary.

```text
Final rule summary.

Visible summary:
- Content-Type chooses request parser.
- Accept chooses desired response.
- [FromBody] uses input formatters.
- [FromForm] uses form binding.
- [Consumes]/[Produces] document/restrict endpoint behavior.

Meaning:
The central model is: body bytes + Content-Type + action parameter source determine request binding; Accept + output formatters determine response media type.
```

## What should be recallable

- Which roles belong to metadata, headers, and input/output formatters in each direction?
- Why does `[Produces]` not enable a missing serializer?
- How can `[Consumes]` disambiguate actions without deserializing the body?
- Which diagnostic chain distinguishes 406 from 415?
- What changes when MVC respects broad browser Accept headers?
- Why is `Vary: Accept` separate from negotiation?

## Sources

- Workspace: `_ai-conspects/produces-consumes-input-output-formatters-406-415-vary-accept/`
- Authoritative processed source: `regions/R01-produces-output-formatters-accept-negotiation.md` through `regions/R04-vary-accept-browser-accept-header-policy.md`
- Original SVG: `source/produces-consumes-input-output-formatters-406-415-vary-accept.svg`
- Workspace: `_ai-conspects/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON/`
- Authoritative processed source: `01-final-transcript.md`, R01–R04
- Original SVG: `source/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg`
- Workspace: `_ai-conspects/filters/`
- Authoritative processed source: `regions/R01-main-filters-theory-ordering-exception-di-factories.md`, S-003, S-028, S-049, S-072-S-073, S-076, S-079, S-084, S-087, S-089
- Original SVG: `source/filters.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, sections 1-3 and 6-8, with exact evidence in `11-exact-canvas-text-transcript-v002.md` and `12-screenshot-evidence-cards-v002.md`
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
- Workspace: `_ai-conspects/MEDIA TYPES OF REQUESTS/`
- Authoritative processed source: `regions/MEDIA-R04-endpoints-consumes-produces-errors.md`, S-037–S-049
- Original source identity: `MEDIA TYPES OF REQUESTS.svg` (named by `01-stage0-boundary-review.md`; not physically resolvable in the current workspace/branch).
