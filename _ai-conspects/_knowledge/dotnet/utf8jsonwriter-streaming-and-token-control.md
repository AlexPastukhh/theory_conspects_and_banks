# Utf8JsonWriter streaming and token control

Knowledge ID: `dotnet.utf8jsonwriter-streaming-and-token-control`

Topic: `dotnet`

## Purpose

`Utf8JsonWriter` is a forward-only, low-level JSON writer. It writes UTF-8 JSON directly to:

```text
Stream
IBufferWriter<byte>
```

Typical creation:

```csharp
var options = new JsonWriterOptions
{
    Indented = true,
    SkipValidation = false
};

using var writer =
    new Utf8JsonWriter(stream, options);
```

Always flush before consuming the written bytes:

```csharp
writer.Flush();
```

## Structural methods

```csharp
writer.WriteStartObject();
writer.WriteEndObject();

writer.WriteStartArray();
writer.WriteEndArray();
```

Property/value example:

```csharp
writer.WriteStartObject();

writer.WriteString("name", "Ada");
writer.WriteNumber("age", 36);
writer.WriteBoolean("active", true);
writer.WriteNull("middleName");

writer.WriteEndObject();
writer.Flush();
```

Property-name methods can be separated from value methods:

```csharp
writer.WritePropertyName("items");
writer.WriteStartArray();
...
writer.WriteEndArray();
```

## Value categories

The writer provides methods for:

```text
strings and dates
numbers
booleans
null
property names
raw JSON fragments
comments
start/end object and array tokens
```

Use raw JSON methods only when the fragment is already trusted and valid. Bypassing validation with untrusted input can produce invalid JSON or injection vulnerabilities.

## `JsonEncodedText`

Frequently repeated property names can be pre-encoded:

```csharp
static readonly JsonEncodedText NameProperty =
    JsonEncodedText.Encode("name");

writer.WriteString(NameProperty, "Ada");
```

This can reduce repeated encoding work in hot paths.

## Writing HTTP responses directly

A response can be streamed without creating an intermediate DTO collection:

```csharp
Response.ContentType = "application/json";

await using Stream stream =
    Response.Body;

using var writer =
    new Utf8JsonWriter(stream);

writer.WriteStartArray();

await foreach (var row in rows)
{
    writer.WriteStartObject();
    writer.WriteNumber("id", row.Id);
    writer.WriteString("name", row.Name);
    writer.WriteEndObject();
}

writer.WriteEndArray();
writer.Flush();
```

This can reduce intermediate object/array allocations and support streaming large results.

It is not automatically zero-allocation:

```text
database/provider materialization may allocate
strings still allocate
async infrastructure may allocate
property-name encoding may allocate unless reused
buffers still exist
```

The main benefit is fewer intermediate representation layers.

## Valid use cases

```text
custom JSON shape that does not map cleanly to DTOs
streaming large arrays
writing directly to a response or buffer
strict control over property order
canonical output for hashing/signing
avoiding intermediate DOM/DTO graphs
special gateway or low-level protocol code
```

For ordinary object serialization, `JsonSerializer` is usually simpler and less error-prone.

## Serializer object walking

With:

```csharp
JsonSerializer.Serialize(writer, value);
```

the serializer walks the object graph according to metadata and serialization rules.

With manual writer calls, the application explicitly chooses every token and property.

Analogy:

```text
JsonSerializer
    a general recipe-driven object graph serializer

Utf8JsonWriter
    manual token-by-token plating
```

Manual writing offers control, but increases code volume and the risk of malformed output.

## Hashing and signing

For deterministic hashing/signing, output must be canonical according to the chosen protocol:

```text
stable property order
stable number formatting
stable escaping
no irrelevant whitespace differences
well-defined handling of nulls
well-defined Unicode normalization when required
```

Simply using `Utf8JsonWriter` does not by itself create a standard canonical JSON format; the caller must define and enforce the canonicalization rules.

## Testing

Test both syntax and semantics:

```csharp
byte[] bytes = buffer.WrittenSpan.ToArray();

using JsonDocument document =
    JsonDocument.Parse(bytes);

Assert.Equal(
    "Ada",
    document.RootElement
        .GetProperty("name")
        .GetString());
```

Also test exact bytes when property order or canonical output matters.

## Decision guide

```text
Known stable schema
    DTO + JsonSerializer

Read-only inspection
    JsonDocument / JsonElement

Mutable JSON tree
    JsonNode / JsonObject / JsonArray

Low-level streaming or exact token control
    Utf8JsonWriter
```

## Checklist

```text
[ ] dispose JsonDocument
[ ] clone JsonElement when it must outlive its document
[ ] check ValueKind before type-specific getters
[ ] use TryGetProperty for optional fields
[ ] prefer DTOs for stable public contracts
[ ] use JsonNode only when mutation is required
[ ] distinguish compile-time object from runtime JsonElement
[ ] validate raw JSON before WriteRawValue
[ ] flush Utf8JsonWriter
[ ] define canonicalization rules explicitly for hashing/signing
[ ] test writer output by parsing it back
```

## What should be recallable

- Which destinations and token methods does `Utf8JsonWriter` expose?
- Why must output be flushed, and when is direct response writing useful?
- Why is low-level writing neither automatically zero-allocation nor automatically canonical?
- Which safety and testing rules apply to raw fragments, hashing, and signing?

## Related knowledge

- `dotnet.jsonnode-mutable-dom`
- `aspnet-core.response-body-shapes-and-streaming-output`

## Sources

- Workspace: `_ai-conspects/jsondocument, jsonnode, jsonelement, utf8jsonwriter/`
- Authoritative processed source: `regions/R01R02R03R04R05-json-dom-utf8writer-final-v001.md`, R05 complete plus `Decision guide` and `Checklist`
- Original SVG: `source/jsondocument, jsonnode, jsonelement, utf8jsonwriter.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
