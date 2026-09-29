# Reflection fields, properties, and attributes

Knowledge ID: `dotnet.reflection-fields-properties-and-attributes`

Topic: `dotnet`

## Fields

```csharp
FieldInfo[] fields = type.GetFields(flags);
FieldInfo? field = type.GetField("_name", flags);
```

Useful metadata:

```text
Name
FieldType
IsPublic
IsPrivate
IsStatic
IsInitOnly      // readonly
IsLiteral       // const
DeclaringType
```

Read and write values:

```csharp
object? value = field.GetValue(target);
field.SetValue(target, newValue);
```

Static fields use a null target:

```csharp
field.GetValue(null);
```

Respect readonly, literal and runtime-access constraints. Reflection can bypass ordinary encapsulation expectations and should be used deliberately.

## Properties

```csharp
PropertyInfo[] properties =
    type.GetProperties(flags);

PropertyInfo? property =
    type.GetProperty("Name", flags);
```

Useful metadata:

```text
Name
PropertyType
CanRead
CanWrite
GetMethod
SetMethod
DeclaringType
ReflectedType
GetIndexParameters()
```

Read and write:

```csharp
object? value =
    property.GetValue(target);

property.SetValue(target, newValue);
```

A property is implemented through accessor methods. A read-only property has a getter and no setter.

```csharp
MethodInfo? getter = property.GetMethod;
MethodInfo? setter = property.SetMethod;
```

Non-public accessors may require an overload that requests non-public methods, depending on the API used.

### Indexers

An indexer is a property with parameters.

```csharp
ParameterInfo[] indexParameters =
    property.GetIndexParameters();

bool isIndexer =
    indexParameters.Length > 0;
```

Example:

```csharp
public string this[int index]
{
    get => items[index];
    set => items[index] = value;
}
```

The index parameter values are supplied separately when reading or writing through reflection.

## Custom attributes

Attributes can be attached to:

```text
types
methods
properties
fields
parameters
assemblies
modules
```

Common APIs:

```csharp
member.GetCustomAttributes();
member.GetCustomAttributes<T>();
member.GetCustomAttribute<T>();
member.IsDefined(typeof(MyAttribute));
```

Example:

```csharp
MyAttribute? attribute =
    property.GetCustomAttribute<MyAttribute>();
```

Missing attributes normally produce `null` from generic single-attribute helpers. Code that immediately dereferences `.Name` without null handling is unsafe.

When multiple attributes are allowed or possible, use:

```csharp
IEnumerable<MyAttribute> attributes =
    property.GetCustomAttributes<MyAttribute>();
```

A single-result API can throw an ambiguity exception when multiple matching attributes exist.

`IsDefined` is a cheap existence question when the attribute instance is not needed:

```csharp
bool obsolete = type.IsDefined(
    typeof(ObsoleteAttribute),
    inherit: true);
```

## Attribute inheritance

The meaning of `inherit` depends on the reflected target and API.

A practical mental model:

```text
inherit: false
    inspect only the current member/type

inherit: true
    allow supported inheritance-chain lookup
```

Attribute inheritance is not uniform across all member kinds. Methods and types commonly support inheritance-chain lookup. Properties and events have special behavior because metadata inheritance is represented through accessor methods and related APIs. Verify the exact API when inheritance semantics matter.

## What should be recallable

- Which metadata and get/set operations belong to `FieldInfo` and `PropertyInfo`?
- How are indexers represented and invoked?
- When should attribute lookup return one, many, existence-only, or null?
- Why must attribute inheritance behavior be checked per target and API?

## Related knowledge

- `dotnet.reflection-type-members-and-binding-flags`

## Sources

- Workspace: `_ai-conspects/REFLECTION/`
- Authoritative processed source: `regions/R01R02R03R04-reflection-final-v001.md`, R01 `Fields` through `Attribute inheritance`
- Original SVG: `source/REFLECTION.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
