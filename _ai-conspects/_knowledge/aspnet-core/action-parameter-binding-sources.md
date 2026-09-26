# Action parameter binding sources

Knowledge ID: `aspnet-core.action-parameter-binding-sources`

Topic: `aspnet-core`

Binding attributes make the action contract explicit:

- `[FromBody]`: request body through an input formatter, commonly JSON;
- `[FromForm]`: form-urlencoded or multipart data, including `IFormFile`;
- `[FromHeader]`, `[FromQuery]`, and `[FromRoute]`: header, query, and matched route values;
- `[FromServices]`: dependency injection rather than request data.

An external name can differ from the parameter, for example `[FromHeader(Name = "X-Correlation-Id")]`.

With `[ApiController]`, complex DTOs are usually inferred from body, form-file types from form, names matching route tokens from route, and other simple values from query. Use explicit attributes when the source is ambiguous or should be visible to readers/OpenAPI.

Only one body-bound parameter should normally consume the forward-only body; combine several body values into one DTO. `[FromForm]` is for form/multipart input, not JSON, and `[FromServices]` is for services, not user input. Binding selects/converts input; validation follows it, while authorization is separate.

## What should be recallable

- Explain the core model of **Action parameter binding sources** without opening the Unit.
- Reconstruct this Unit-grounded rule: An external name can differ from the parameter, for example `[FromHeader(Name = "X-Correlation-Id")]`.
- Reconstruct this Unit-grounded rule: With `[ApiController]`, complex DTOs are usually inferred from body, form-file types from form, names matching route tokens from route, and other simple values from query.
- Reconstruct this Unit-grounded rule: Only one body-bound parameter should normally consume the forward-only body; combine several body values into one DTO.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/BINDING SOURCE ATTRIBUTES/`
- Processed source: `regions/R01-final-coverage-transcript.md`, complete transcript
- Workspace: `_ai-conspects/binding-source-attributes/`
- Authoritative processed source: `regions/R01-binding-source-attributes.md`, BSA-S001–BSA-S003 visible content
- Original source identity: `BINDING SOURCE ATTRIBUTES.svg` (uploaded source; no tracked physical SVG in this workspace)
