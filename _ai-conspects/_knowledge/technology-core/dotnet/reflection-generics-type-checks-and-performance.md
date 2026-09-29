# Reflection generics, type checks, and performance

Knowledge ID: `dotnet.reflection-generics-type-checks-and-performance`

Topic: `dotnet`

## Generic types

Important properties:

```csharp
type.IsGenericType
type.IsGenericTypeDefinition
type.GetGenericArguments()
type.GetGenericTypeDefinition()
```

Examples:

```csharp
typeof(List<int>).IsGenericType
// true

typeof(List<int>).IsGenericTypeDefinition
// false

typeof(List<>).IsGenericTypeDefinition
// true
```

Mental model:

```text
List<>       open generic type definition
List<int>    constructed/closed generic type
```

Get the open definition:

```csharp
Type definition =
    typeof(List<int>)
        .GetGenericTypeDefinition();
```

Construct a closed type:

```csharp
Type closed =
    typeof(List<>)
        .MakeGenericType(typeof(string));

object? instance =
    Activator.CreateInstance(closed);
```

Inspect arguments:

```csharp
Type[] arguments =
    typeof(Dictionary<string, int>)
        .GetGenericArguments();
```

## Generic methods

```csharp
MethodInfo definition =
    typeof(Demo).GetMethod("Echo")!;

bool isDefinition =
    definition.IsGenericMethodDefinition;
```

Construct:

```csharp
MethodInfo closedMethod =
    definition.MakeGenericMethod(
        typeof(int));
```

Invoke:

```csharp
object? result =
    closedMethod.Invoke(
        target,
        new object?[]
        {
            42,
        });
```

Before invoking a generic method, its generic parameters must be closed with valid type arguments satisfying constraints.

## Type equality and runtime checks

Exact type equality:

```csharp
obj.GetType() == typeof(string)
```

This matches only the exact runtime type and does not match derived types.

Language-level instance check:

```csharp
if (obj is IDisposable disposable)
{
    disposable.Dispose();
}
```

Reflection equivalent when only `Type` is available:

```csharp
bool match =
    typeof(IDisposable)
        .IsInstanceOfType(obj);
```

## `IsAssignableFrom`

Direction is easy to reverse.

```csharp
bool assignable =
    targetType.IsAssignableFrom(
        sourceType);
```

Read it as:

> Can a value of `sourceType` be assigned to a variable of `targetType`?

Example:

```csharp
typeof(Stream)
    .IsAssignableFrom(
        typeof(MemoryStream));
// true
```

Use cases:

```text
plugin discovery
interface implementation checks
base/derived compatibility
serializer/handler selection
```

## Nullable value types

```csharp
Type? underlying =
    Nullable.GetUnderlyingType(
        typeof(int?));
// typeof(int)

Nullable.GetUnderlyingType(
    typeof(int));
// null
```

This is the standard way to detect and unwrap `Nullable<T>`.

## Performance guidance

Reflection has lookup and invocation overhead.

```text
do not repeat metadata discovery in a hot loop
cache Type/PropertyInfo/MethodInfo results
avoid reflection as a replacement for ordinary business logic
use it for metadata-driven infrastructure
```

Typical appropriate uses:

```text
serialization
dependency injection
ORM mapping
plugin discovery
test tooling
validation frameworks
object mapping
```

## What should be recallable

- How do open generic definitions, closed constructed types, and generic arguments differ?
- How are generic types and methods closed before creation or invocation?
- How do exact type equality, `IsInstanceOfType`, and `IsAssignableFrom` differ?
- How is `Nullable<T>` detected, and why should reflection metadata be cached?

## Related knowledge

- `dotnet.reflection-methods-constructors-and-parameters`

## Sources

- Workspace: `_ai-conspects/REFLECTION/`
- Authoritative processed source: `regions/R01R02R03R04-reflection-final-v001.md`, R03 complete
- Original SVG: `source/REFLECTION.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
