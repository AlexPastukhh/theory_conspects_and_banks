# System.Text.Json configuration in ASP.NET Core

Knowledge ID: `aspnet-core.system-text-json-configuration`

Topic: `aspnet-core`

## Controllers and Minimal APIs have separate option paths

MVC controller input/output formatters use `AddJsonOptions`:

```csharp
builder.Services.AddControllers().AddJsonOptions(o =>
{
    o.JsonSerializerOptions.PropertyNamingPolicy = JsonNamingPolicy.CamelCase;
    o.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
    o.JsonSerializerOptions.DefaultIgnoreCondition =
        JsonIgnoreCondition.WhenWritingNull;
    o.JsonSerializerOptions.PropertyNameCaseInsensitive = true;
    // o.JsonSerializerOptions.ReferenceHandler = ReferenceHandler.IgnoreCycles;
    // o.JsonSerializerOptions.WriteIndented = true;
});
```

Minimal APIs configure `Microsoft.AspNetCore.Http.Json.JsonOptions` through `ConfigureHttpJsonOptions`, modifying `o.SerializerOptions`. A mixed application often configures both because one registration does not guarantee identical behavior in the other pipeline.

Naming policy affects JSON property names, the converter writes enums as strings, case-insensitive matching affects input, null-ignore affects output, cycle handling changes reference behavior/payload shape, and indentation is normally disabled in production.

## Null versus default omission

`WhenWritingNull` omits reference/nullable properties whose value is null. It does not mutate the C# object: a `UserDto` with `Email = null` still has that value, but the JSON contains only `id` and `name`.

Without null omission, the output includes the property:

```json
{
  "id": 1,
  "name": "Sam",
  "email": null
}
```

With `WhenWritingNull`, the same object is written as:

```json
{
  "id": 1,
  "name": "Sam"
}
```

Only the serialized document changes; the object's `Email` property remains `null`.

`WhenWritingDefault` is broader and may omit `0`, `false`, and default structs. Obsolete `IgnoreNullValues` should be replaced with `DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull` when null-only omission is intended.

## Formatter configuration is separate

Serializer options shape JSON. MVC formatters determine supported media types and negotiation:

```csharp
builder.Services.AddControllers(options =>
{
    options.ReturnHttpNotAcceptable = true;
})
.AddMvcOptions(options =>
{
    var output = options.OutputFormatters
        .OfType<SystemTextJsonOutputFormatter>().First();
    output.SupportedMediaTypes.Add(
        MediaTypeHeaderValue.Parse("application/vnd.myapp+json"));

    var input = options.InputFormatters
        .OfType<SystemTextJsonInputFormatter>().First();
    input.SupportedMediaTypes.Add(
        MediaTypeHeaderValue.Parse("application/vnd.myapp+json"));
});
```

`ReturnHttpNotAcceptable` enables 406 behavior for unsupported `Accept`; vendor JSON must be registered on both relevant input and output formatters when both directions use it.

## What should be recallable

- Separate controller and Minimal API option-registration paths.
- Effects of naming, enum, null, input-case, cycle, and indentation settings.
- `WhenWritingNull` versus `WhenWritingDefault`, object immutability, and obsolete `IgnoreNullValues`.
- How the concrete before/after JSON differs while the C# object remains unchanged.
- Serializer options versus formatter media-type/406 configuration.

## Sources

- Workspace: `_ai-conspects/SYSTEM.TEXT.JSON SER SER/`
- Processed source: `02-source-preserving-transcript-v002.md`, S-001–S-006
- Original SVG: `source/SYSTEM.TEXT.JSON SER SER.svg`
- Workspace: `_ai-conspects/FULL CONTENT NEG + VALIDATION FLOW/`
- Authoritative processed source: `13-corrected-study-transcript-v002.md`, section 2, with exact evidence in `11-exact-canvas-text-transcript-v002.md` R01 and `12-screenshot-evidence-cards-v002.md`, S-135-S-136
- Original SVG: `source/FULL CONTENT NEG + VALIDATION FLOW.svg`
