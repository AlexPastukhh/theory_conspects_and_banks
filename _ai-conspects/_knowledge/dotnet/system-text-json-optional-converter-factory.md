# System.Text.Json Optional<T> converter factory

Knowledge ID: `dotnet.system-text-json-optional-converter-factory`

Topic: `dotnet`

## Three-state model

PATCH-style input needs to distinguish omission, explicit null, and a concrete value. `Optional<T>` stores `IsSet` plus `Value`; its default struct value is unset, while constructing it sets `IsSet=true` even for null.

```text
{}                         -> IsSet=false, Value=default
{"displayName": null}      -> IsSet=true,  Value=null
{"displayName": "Ada"}     -> IsSet=true,  Value="Ada"
```

## Why a converter factory

`Optional<T>` is an open generic family. `JsonConverterFactory.CanConvert` accepts only generic types whose definition is `Optional<>`. `CreateConverter` extracts the inner type, closes `OptionalJsonConverter<T>` with `MakeGenericType`, constructs it, and returns it as `JsonConverter`.

`Activator.CreateInstance` is clear for a parameterless converter. `ConstructorInfo.Invoke` gives explicit signature/argument control and supports constructor-delegate caching. Reflection happens while serializer converter metadata is built/used, not for every token in the ordinary converter loop.

```text
OptionalJsonConverterFactory : JsonConverterFactory
  CanConvert(Type)
  CreateConverter(Type, JsonSerializerOptions)

OptionalJsonConverter<T> : JsonConverter<Optional<T>>
  Read(ref Utf8JsonReader, Type, JsonSerializerOptions)
  Write(Utf8JsonWriter, Optional<T>, JsonSerializerOptions)
```

Register the factory globally or on the relevant `JsonSerializerOptions`.

## Reader and missing-property mechanics

When `Read` begins, `Utf8JsonReader` is positioned at the property value. For `JsonTokenType.Null`, return a constructed `Optional<T>(default)` so `IsSet=true`. Otherwise delegate the inner value to `JsonSerializer.Deserialize<T>(ref reader, options)` and wrap it.

Do not manually call `reader.Read()` after normal value delegation; the serializer owns advancement unless this converter explicitly owns more tokens.

Most importantly, a property converter is not invoked when the JSON property is absent. Default DTO construction therefore leaves `Optional<T>` unset. Missing and null remain distinct without special object scanning.

## Writer and application boundary

For `IsSet=true`, delegate the wrapped value to `JsonSerializer.Serialize`. For `IsSet=false`, a value converter cannot remove a property name the object serializer already chose to write. True omission requires a type-level converter, metadata/`ShouldSerialize`, another output shape, or a design that never serializes unset PATCH DTOs. Writing null for unset loses the distinction.

Application code updates only supplied values:

```csharp
if (dto.DisplayName.IsSet)
    entity.DisplayName = dto.DisplayName.Value;
```

Validate a value only when supplied, plus domain cross-field rules. Decide whether explicit null is valid for non-nullable `T`; reuse the same serializer options for inner values; avoid recursive conversion of the outer type; and test all three states plus required/source-generated metadata behavior.

## What should be recallable

- How does the default struct value encode property omission?
- How does a factory recognize and construct closed `Optional<T>` converters?
- Why is explicit null constructed rather than returned as an unset default?
- Who owns reader advancement after inner deserialization?
- Why can a value converter not omit an already selected property name?
- Which three states and validation paths must tests cover?

## Sources

- Workspace: `_ai-conspects/jsonconverter/`
- Authoritative processed source: `regions/R01R02-jsonconverter-optional-final.md`, sections 1–9
- Original SVG: `source/jsonconverter.svg`
