# JsonNode mutable DOM

Knowledge ID: `dotnet.jsonnode-mutable-dom`

Topic: `dotnet`

## Read-only inspection versus mutation

Use `JsonDocument`/`JsonElement` when:

```text
the payload is inspected but not modified
only several fields are needed
allocation-sensitive read paths matter
the JSON shape may vary
a DTO would add little value
```

Use `JsonNode` when:

```text
properties must be added or removed
array elements must be inserted or replaced
a gateway patches JSON before forwarding it
a subtree is built dynamically
mutable dictionary/list-like access is useful
```

Example read-only inspection:

```csharp
using var document =
    JsonDocument.Parse(payload);

JsonElement root = document.RootElement;

string? eventType =
    root.GetProperty("eventType").GetString();
```

Example mutable patch:

```csharp
JsonNode? node =
    JsonNode.Parse(payload);

node!["environment"] = "prod";
node["metadata"]!["processedBy"] = "gateway-1";

node.AsObject().Remove("debugInfo");

string output =
    node.ToJsonString();
```

## Node hierarchy

The mutable DOM contains:

```text
JsonNode
├─ JsonObject
├─ JsonArray
└─ JsonValue
```

Parse:

```csharp
JsonNode? root =
    JsonNode.Parse(json);
```

Convert to a specific shape:

```csharp
JsonObject obj = root!.AsObject();
JsonArray array = root["items"]!.AsArray();
```

## Indexers

Object property access:

```csharp
string? name =
    root["user"]?["name"]?
        .GetValue<string>();
```

Array access:

```csharp
JsonArray numbers =
    root["numbers"]!.AsArray();

JsonNode? first = numbers[0];
numbers[1] = 42;
```

Indexers are natural for known shapes, but null checks are still required when the input is untrusted.

## `JsonObject`

Create and mutate:

```csharp
var obj = new JsonObject
{
    ["name"] = "Tom",
    ["age"] = 30
};

obj["age"] = 31;
obj["city"] = "Paris";
obj.Remove("temporary");
```

Useful operations include:

```text
Add
Remove
ContainsKey
TryGetPropertyValue
indexer get/set
Insert
RemoveAt
IndexOf
```

`JsonObject` preserves property order, so positional operations can matter when producing a controlled output shape. JSON object order should not be treated as semantic identity, but it can matter for readability, deterministic output and some signing/canonicalization designs.

Enumerate:

```csharp
foreach ((string key, JsonNode? value) in obj)
{
    Console.WriteLine($"{key}: {value}");
}
```

## `JsonArray`

```csharp
var array = new JsonArray(
    "a",
    "b",
    "c");

array.Add("d");
array.Insert(1, "middle");
array.RemoveAt(0);
array[1] = "changed";
```

`JsonArray` behaves like a mutable list of `JsonNode?` values.

Enumerate:

```csharp
foreach (JsonNode? item in array)
{
    Console.WriteLine(item);
}
```

## `JsonValue`

Create scalar nodes:

```csharp
JsonNode number =
    JsonValue.Create(123)!;

JsonNode text =
    JsonValue.Create("hello")!;
```

Read a strongly typed value:

```csharp
int value =
    number.GetValue<int>();
```

Inspect the JSON kind when necessary:

```csharp
JsonValueKind kind =
    number.GetValueKind();
```

Object and array indexers are meaningful for containers. Treat `JsonValue` as a leaf node.

## Shared operations

Useful `JsonNode` operations include:

```text
ToJsonString
GetValueKind
DeepClone
ReplaceWith
Parent
Root
GetPath
```

Serialize a node:

```csharp
string json =
    node.ToJsonString(
        new JsonSerializerOptions
        {
            WriteIndented = true
        });
```

`ToString()` is a general object representation. `ToJsonString()` explicitly produces JSON text.

## What should be recallable

- When should a mutable `JsonNode` tree replace read-only DOM inspection?
- How do `JsonObject`, `JsonArray`, `JsonValue`, indexers, and shared node operations work?
- Why can property order matter operationally without becoming JSON object identity?
- Why is `ToJsonString()` the explicit serialization operation?

## Related knowledge

- `dotnet.jsondocument-jsonelement-readonly-dom`
- `dotnet.utf8jsonwriter-streaming-and-token-control`

## Sources

- Workspace: `_ai-conspects/jsondocument, jsonnode, jsonelement, utf8jsonwriter/`
- Authoritative processed source: `regions/R01R02R03R04R05-json-dom-utf8writer-final-v001.md`, R03 `Read-only inspection versus mutation`; R04 complete
- Original SVG: `source/jsondocument, jsonnode, jsonelement, utf8jsonwriter.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
