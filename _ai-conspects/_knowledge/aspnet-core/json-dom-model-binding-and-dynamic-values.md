# JSON DOM model binding and dynamic runtime values

Knowledge ID: `aspnet-core.json-dom-model-binding-and-dynamic-values`

Topic: `aspnet-core`

## DTO constructor binding

`System.Text.Json` can create a DTO through:

```text
a public parameterless constructor plus writable members
a suitable parameterized constructor whose parameters bind to members
a constructor explicitly selected with JsonConstructor
```

Constructor parameter names must match the serializable members according to serializer binding rules. A registration DTO and a server-error DTO can therefore deserialize differently even when both look like ordinary classes.

## `ProblemDetails.Extensions`

`ProblemDetails.Extensions` is commonly represented as:

```csharp
IDictionary<string, object?>
```

After JSON deserialization, an `object` value may actually be a `JsonElement` at runtime:

```csharp
if (problemDetails.Extensions.TryGetValue(
        "errors",
        out object? value)
    && value is JsonElement errorsElement)
{
    var errors =
        errorsElement.Deserialize<List<ValidationError>>();
}
```

The compile-time type is `object`; the runtime value depends on the JSON shape and serializer behavior.

## Controller model binding

ASP.NET Core can bind JSON request bodies to DOM types:

```csharp
[HttpPost]
public IActionResult Post(
    [FromBody] JsonElement body)
{
    return Ok();
}
```

```csharp
[HttpPost]
public IActionResult Post(
    [FromBody] JsonDocument body)
{
    return Ok();
}
```

```csharp
[HttpPost]
public IActionResult Post(
    [FromBody] JsonNode? body)
{
    return Ok();
}
```

Choose the type according to the operation:

```text
JsonElement
    read one JSON value
    lightweight read-only access
    no explicit document variable in the action signature

JsonDocument
    explicit owner/lifetime
    inspect RootElement
    useful when document ownership is meaningful

JsonNode
    mutable tree
    add, remove or replace JSON before forwarding/returning it

DTO
    stable known schema
    validation, documentation and compile-time types
```

For a stable API contract, a DTO is usually clearer than a raw DOM. DOM binding is useful for variable payloads, gateways, extensions, partial inspection and generic infrastructure.

## Serialization bridge

All DOM types can bridge to typed objects:

```csharp
MyDto? dto =
    element.Deserialize<MyDto>();

MyDto? dto =
    node.Deserialize<MyDto>();

JsonNode? node =
    JsonSerializer.SerializeToNode(value);

JsonElement element =
    JsonSerializer.SerializeToElement(value);
```

This is useful when only part of a payload is dynamic.

## Runtime values and `object`

When deserializing into:

```csharp
Dictionary<string, object?>
```

JSON values are not automatically transformed into arbitrary application classes. Nested values commonly appear as `JsonElement`.

Therefore:

```csharp
object value = dictionary["payload"]!;
```

may require:

```csharp
if (value is JsonElement element)
{
    ...
}
```

Use pattern matching because `is` checks the runtime type:

```csharp
if (value is JsonElement element)
{
    // runtime assertion succeeded
}
```

## What should be recallable

- How can ASP.NET Core bind a request body to DOM types, and when is a DTO clearer?
- Which constructor shapes can `System.Text.Json` use for DTO creation?
- Why can an `object`-typed extension or dictionary value be a `JsonElement` at runtime?
- How do DOM values bridge to typed DTOs and back?

## Related knowledge

- `dotnet.jsondocument-jsonelement-readonly-dom`
- `dotnet.jsonnode-mutable-dom`

## Sources

- Workspace: `_ai-conspects/jsondocument, jsonnode, jsonelement, utf8jsonwriter/`
- Authoritative processed source: `regions/R01R02R03R04R05-json-dom-utf8writer-final-v001.md`, R01 `DTO constructor binding` and `ProblemDetails.Extensions`; R02 `Controller model binding`; R03 `Serialization bridge` and `Runtime values and object`
- Original SVG: `source/jsondocument, jsonnode, jsonelement, utf8jsonwriter.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
