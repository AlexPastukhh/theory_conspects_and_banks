# JsonDocument and JsonElement read-only DOM

Knowledge ID: `dotnet.jsondocument-jsonelement-readonly-dom`

Topic: `dotnet`

## `JsonDocument`

`JsonDocument` is the read-only document owner for parsed JSON.

```csharp
using JsonDocument document =
    JsonDocument.Parse(json);

JsonElement root = document.RootElement;
```

Important properties:

```text
read-only DOM
optimized for inspection
owns pooled/native parsing state
implements IDisposable
RootElement is a JsonElement view over the document
```

Dispose the document when it is no longer needed:

```csharp
using var document = JsonDocument.Parse(json);
```

A `JsonElement` obtained from `RootElement` normally depends on the document lifetime. When an element must outlive the document, clone it:

```csharp
JsonElement detached;

using (var document = JsonDocument.Parse(json))
{
    detached = document.RootElement.Clone();
}
```

## `JsonElement`

`JsonElement` is a lightweight, read-only view of one JSON value.

It can represent:

```text
object
array
string
number
true
false
null
undefined
```

Inspect the kind before reading:

```csharp
if (element.ValueKind == JsonValueKind.Object)
{
    // object operations
}
```

Typed getters include:

```csharp
element.GetString();
element.GetInt32();
element.GetInt64();
element.GetDecimal();
element.GetDouble();
element.GetBoolean();
element.GetDateTime();
element.GetGuid();
```

A getter is a runtime assertion about the JSON type. Calling the wrong getter throws. For defensive code, check `ValueKind` or use `TryGet...` methods where available.

## Accessing properties

```csharp
JsonElement name =
    root.GetProperty("name");

string? value = name.GetString();
```

Safer lookup:

```csharp
if (root.TryGetProperty("name", out JsonElement name))
{
    string? value = name.GetString();
}
```

Object and array enumeration:

```csharp
foreach (JsonProperty property in root.EnumerateObject())
{
    Console.WriteLine(property.Name);
    Console.WriteLine(property.Value);
}

foreach (JsonElement item in root.EnumerateArray())
{
    Console.WriteLine(item);
}
```

Array helpers:

```csharp
int length = array.GetArrayLength();
JsonElement first = array[0];
```

## Parsing and deserialization

Use `JsonDocument.Parse` when a full document owner is useful:

```csharp
using var document = JsonDocument.Parse(json);
JsonElement root = document.RootElement;
```

A standalone element can also be produced through the framework's direct element parsing/deserialization APIs. When compatibility across target frameworks matters, `JsonDocument.Parse(...).RootElement.Clone()` is an explicit and portable pattern.

Both `JsonDocument` and `JsonElement` integrate with `JsonSerializer`:

```csharp
MyDto? dto =
    element.Deserialize<MyDto>();

JsonElement element =
    JsonSerializer.SerializeToElement(value);
```

## `JsonElement` versus `JsonDocument`

They share the same read-only DOM model, but their roles differ:

```text
JsonDocument
    owns parsed storage
    exposes RootElement
    disposable

JsonElement
    struct view of one value
    can refer to root or a nested value
    not independently disposable
```

Using `JsonElement` does not automatically mean that no pooled parsing storage exists. The framework still needs storage for parsed metadata. What changes is the API surface and ownership visible to the caller.

## `JsonProperty`

`JsonProperty` represents one name/value pair while enumerating a JSON object:

```csharp
foreach (JsonProperty property
         in element.EnumerateObject())
{
    string name = property.Name;
    JsonElement value = property.Value;
}
```

It is not a mutable dictionary entry. To modify object properties, use `JsonObject`/`JsonNode`.

## What should be recallable

- Which object owns parsed JSON storage, and when must a `JsonElement` be cloned?
- How do `ValueKind`, typed getters, property lookup, and object/array enumeration work?
- How do `JsonDocument`, `JsonElement`, and `JsonProperty` differ?

## Related knowledge

- `dotnet.jsonnode-mutable-dom`
- `aspnet-core.json-dom-model-binding-and-dynamic-values`

## Sources

- Workspace: `_ai-conspects/jsondocument, jsonnode, jsonelement, utf8jsonwriter/`
- Authoritative processed source: `regions/R01R02R03R04R05-json-dom-utf8writer-final-v001.md`, R01 `JsonDocument` through `Parsing and deserialization`; R02 `JsonElement versus JsonDocument` and `JsonProperty`
- Original SVG: `source/jsondocument, jsonnode, jsonelement, utf8jsonwriter.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
