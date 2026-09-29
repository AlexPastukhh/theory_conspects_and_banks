# ASP.NET Core JSON/XML formatters and default order

Knowledge ID: `aspnet-core.json-xml-formatters-and-default-order`

Topic: `aspnet-core`

An output formatter serializes an action result into a response and writes its `Content-Type`; an input formatter deserializes a request body according to its `Content-Type`. Formatter registration therefore defines which representation syntaxes MVC can actually read and write.

## JSON choices

The normal ASP.NET Core JSON formatter uses `System.Text.Json`. Add Newtonsoft.Json only when Json.NET-specific behavior is required:

```csharp
builder.Services
    .AddControllers(options =>
    {
        options.ReturnHttpNotAcceptable = true;
    })
    .AddNewtonsoftJson(settings =>
    {
        settings.SerializerSettings.ContractResolver =
            new CamelCasePropertyNamesContractResolver();
    });
```

Adding a formatter extension changes the registered formatter set. Do not assume previous ordering remains unchanged after chaining Newtonsoft or XML configuration.

## XML serializer families

```csharp
builder.Services
    .AddControllers(options =>
    {
        options.ReturnHttpNotAcceptable = true;
    })
    .AddXmlDataContractSerializerFormatters();
```

or:

```csharp
builder.Services
    .AddControllers(options =>
    {
        options.ReturnHttpNotAcceptable = true;
    })
    .AddXmlSerializerFormatters();
```

`DataContractSerializer` and `XmlSerializer` have different model constraints and behavior. Choose the family whose serializer supports the API's models rather than treating the registrations as interchangeable spellings.

## Formatter order is observable API behavior

When the request supplies no usable `Accept` preference, MVC may choose the first suitable output formatter. Adding XML or Newtonsoft can therefore change the default representation if the resulting list places a different formatter first.

A formatter can deliberately be inserted at the front:

```csharp
options.OutputFormatters.Insert(0, formatter);
```

That is an intentional default-policy change. Verify formatter order, missing/broad `Accept`, strict unsupported `Accept`, and response `Content-Type` with integration tests.

`ReturnHttpNotAcceptable = true` returns `406` when no configured output formatter can satisfy an acceptable requested response type. Without strict behavior MVC may fall back to a default formatter.

## Related knowledge

- `aspnet-core.media-type-formatters-and-406-415`
- `aspnet-core.semantic-media-types-and-formatter-contracts`

## What should be recallable

- Which direction belongs to input and output formatters?
- Which JSON formatter is the normal default?
- When is Newtonsoft.Json an intentional addition?
- Why are the two XML formatter families not interchangeable?
- What can happen when no usable `Accept` preference exists?
- Why can adding one formatter extension change the API default?
- Which behavior should formatter-order integration tests verify?

## Sources

- Workspace: `_ai-conspects/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON/`
- Authoritative processed source: `regions/R01R02R03R04-content-negotiation-formatters-final-v001.md`, R01 formatter-family, strictness, ordering, and default-response sections
- Original SVG: `source/CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, section 2, with exact evidence in `11-exact-canvas-text-transcript-v002.md` R01 and `12-screenshot-evidence-cards-v002.md`, S-001-S-002 and S-135-S-137
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
