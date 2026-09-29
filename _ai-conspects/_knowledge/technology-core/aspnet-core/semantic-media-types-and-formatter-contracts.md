# ASP.NET Core semantic media types and formatter contracts

Knowledge ID: `aspnet-core.semantic-media-types-and-formatter-contracts`

Topic: `aspnet-core`

`application/json` identifies JSON syntax; it does not say whether a body is an author, error, full record, friendly subset, or hypermedia representation. When variants are materially different contracts, a semantic vendor media type can name that distinction:

```text
application/vnd.marvin.author.hateoas+json
```

```text
application    top-level type
vnd            vendor tree
marvin         vendor identifier
author         representation name
hateoas        semantic subtype detail
+json          one structured syntax suffix
```

Use one registered suffix. `+hateoas+json` incorrectly treats both semantic detail and syntax as suffixes; put `hateoas` in the subtype name.

## Negotiate semantics, then serialize syntax

One resource can expose:

```text
application/vnd.marvin.author+json
    author without links

application/vnd.marvin.author.hateoas+json
    author with hypermedia links
```

An action can inspect the negotiated subtype and select a DTO/link contract:

```csharp
var includeLinks = parsedMediaType.SubTypeWithoutSuffix
    .EndsWith("hateoas",
        StringComparison.InvariantCultureIgnoreCase);

var primaryMediaType = includeLinks
    ? parsedMediaType.SubTypeWithoutSuffix[
        ..^".hateoas".Length]
    : parsedMediaType.SubTypeWithoutSuffix;

IEnumerable<LinkDto> links = Array.Empty<LinkDto>();
if (includeLinks)
    links = CreateLinksForAuthor(authorId, fields);
```

## Formatter support is separate from endpoint metadata

Returning an object does not make an output formatter support every vendor type. Register each semantic JSON type with the selected JSON formatter:

```csharp
builder.Services.AddControllers(options =>
{
    options.ReturnHttpNotAcceptable = true;

    var json = options.OutputFormatters
        .OfType<SystemTextJsonOutputFormatter>()
        .FirstOrDefault();

    json?.SupportedMediaTypes.Add(
        MediaTypeHeaderValue.Parse(
            "application/vnd.marvin.author+json"));
});
```

When using Newtonsoft, configure its corresponding formatter instead. Adding the supported type does not change JSON serialization; it tells MVC that this formatter may emit JSON labeled with that semantic contract. Without support, result execution cannot find a formatter for the chosen content type.

`[Produces]` documents and can constrain response metadata and contributes to OpenAPI/Swagger, but it does not add formatter capability:

```csharp
[Produces(
    "application/json",
    "application/vnd.marvin.author+json",
    "application/vnd.marvin.author.hateoas+json")]
```

Keep a predictable default such as `application/json` for clients that do not request a semantic type. Document every variant's schema, links, default, version/deprecation behavior, and meaning.

## Semantic request representations

Request `Content-Type` can similarly identify a JSON contract:

```text
application/vnd.marvin.authorforcreation+json
    -> AuthorForCreationDto without date of death

application/vnd.marvin.authorforcreation.withdateofdeath+json
    -> AuthorForCreationWithDateOfDeathDto where the field can be required
```

Separate DTOs can make validation clearer than one type containing every possible field as nullable and implementing complex conditional rules.

The JSON input formatter must advertise the custom content type as a supported media type. Exact registration depends on ASP.NET Core version and formatter package, but conceptually it extends `SystemTextJsonInputFormatter.SupportedMediaTypes`.

`[Consumes]` documents/constrains accepted request media types and participates in endpoint selection; it does not register or perform deserialization itself:

```csharp
[Consumes(
    "application/vnd.marvin.authorforcreation+json")]
```

A single action parameter has one compile-time type. If content type genuinely chooses materially different CLR contracts, choose deliberately among separate `[Consumes]`-constrained actions, a custom input formatter, a discriminated model, an explicit request envelope, or tightly controlled manual deserialization. Ordinary optional fields, validation groups, or endpoint versioning may be simpler when the contracts are not truly distinct.

## Related knowledge

- `aspnet-core.media-type-formatters-and-406-415`
- `http.hypermedia-links-and-representation-negotiation`
- `http.accept-negotiation-ranking-and-selection`

## What should be recallable

- What does `application/json` leave unspecified?
- Which parts make up a vendor media type with `+json`?
- Why is `+hateoas+json` the wrong suffix structure?
- Why must a formatter advertise a vendor media type even when the payload is JSON?
- What does `[Produces]` contribute, and what can it not enable?
- Why retain and document a default representation?
- How can semantic request types make validation contracts clearer?
- What does `[Consumes]` constrain without doing itself?
- Which designs can select different CLR request contracts?

## Sources

- Workspace: `_ai-conspects/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON/`
- Authoritative processed source: `regions/R01R02R03R04-content-negotiation-formatters-final-v001.md`, R03-R04
- Original SVG: `source/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, sections 2-3 and 7, with matching exact native text and screenshot evidence
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
