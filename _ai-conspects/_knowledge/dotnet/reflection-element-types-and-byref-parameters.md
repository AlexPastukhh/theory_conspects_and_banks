# Reflection element types and by-ref parameters

Knowledge ID: `dotnet.reflection-element-types-and-byref-parameters`

Topic: `dotnet`

## `GetElementType()`

`Type.GetElementType()` applies to types that wrap another element type:

```text
arrays
pointers
by-ref types
```

Examples:

```csharp
typeof(int[]).GetElementType()
// typeof(int)

typeof(int*).GetElementType()
// typeof(int), in unsafe context

typeof(int).MakeByRefType()
    .GetElementType()
// typeof(int)
```

It does not unwrap `List<int>` because `List<T>` is a constructed generic type, not an array, pointer or by-ref wrapper. Use `GetGenericArguments()` for generic collections.

## Pointer types

Unsafe pointer type:

```csharp
Type pointer =
    typeof(int*);
```

Metadata:

```csharp
pointer.IsPointer
pointer.GetElementType()
```

A pointer is different from:

```text
managed by-ref type
object reference
generic collection
IntPtr
```

## By-ref types

Create or detect a by-ref type:

```csharp
Type byRef =
    typeof(int).MakeByRefType();

bool isByRef = byRef.IsByRef;
Type? element = byRef.GetElementType();
```

Reflection represents `ref`, `out` and `in` parameters using a by-ref `ParameterType`.

```csharp
void Modify(
    ref int x,
    out string y,
    in int z)
{
    y = "";
}
```

All three parameter types are by-ref wrappers:

```text
System.Int32&
System.String&
System.Int32&
```

The element type removes the `&` wrapper:

```csharp
Type underlying =
    parameter.ParameterType.GetElementType()!;
```

## Distinguishing `ref`, `out` and `in`

Relevant `ParameterInfo` data:

```text
ParameterType.IsByRef
IsOut
IsIn
Attributes
GetRequiredCustomModifiers()
GetOptionalCustomModifiers()
```

Typical conceptual output:

```text
ref int
    IsByRef = true
    IsOut = false
    IsIn may be false

out string
    IsByRef = true
    IsOut = true

in int
    IsByRef = true
    IsIn may be true
    readonly intent may also be represented by metadata modifiers
```

Metadata can vary by compiler and runtime details. For advanced interop or exact signature inspection, check required and optional custom modifiers instead of relying on only one flag.

## By-ref type members are usually not what you want

This:

```csharp
Type byRef =
    typeof(int).MakeByRefType();

MethodInfo[] methods =
    byRef.GetMethods();
```

inspects the wrapper type metadata and is rarely useful. To inspect the underlying value type:

```csharp
Type underlying =
    byRef.GetElementType()!;

MethodInfo[] methods =
    underlying.GetMethods();
```

## Invoking by-ref methods

Reflection invocation uses an object array. The runtime updates array entries for `ref` and `out` parameters.

```csharp
MethodInfo method =
    typeof(Demo).GetMethod("Modify")!;

object?[] arguments =
{
    10,
    null,
    20,
};

method.Invoke(null, arguments);

int changedRef = (int)arguments[0]!;
string outValue = (string)arguments[1]!;
```

The exact argument positions correspond to `ParameterInfo.Position`.

## Practical reflection checklist

```text
[ ] start from Type
[ ] select public/non-public and instance/static flags deliberately
[ ] disambiguate overloaded methods by parameter types
[ ] distinguish DeclaringType from ReflectedType
[ ] use GetCustomAttributes<T> when multiple attributes are possible
[ ] handle a missing single attribute as null
[ ] close generic definitions before creating or invoking
[ ] read IsAssignableFrom in target <- source direction
[ ] use Nullable.GetUnderlyingType for Nullable<T>
[ ] use GetElementType only for array/pointer/by-ref wrappers
[ ] inspect ParameterInfo for ref/out/in details
[ ] cache reflection metadata on hot paths
```

## What should be recallable

- Which wrappers can `GetElementType()` unwrap, and why does it not unwrap generic collections?
- How do pointer and managed by-ref types differ?
- How are `ref`, `out`, and `in` represented by `ParameterInfo` and modifiers?
- How does `MethodInfo.Invoke` return changed `ref` and `out` arguments?

## Related knowledge

- `dotnet.reflection-methods-constructors-and-parameters`
- `dotnet.reflection-generics-type-checks-and-performance`

## Sources

- Workspace: `_ai-conspects/REFLECTION/`
- Authoritative processed source: `regions/R01R02R03R04-reflection-final-v001.md`, R04 complete
- Original SVG: `source/REFLECTION.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
