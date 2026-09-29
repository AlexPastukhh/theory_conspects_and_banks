# Reflection methods, constructors, and parameters

Knowledge ID: `dotnet.reflection-methods-constructors-and-parameters`

Topic: `dotnet`

## Methods

```csharp
MethodInfo[] methods =
    type.GetMethods(flags);

MethodInfo? method =
    type.GetMethod(
        "Combine",
        flags,
        binder: null,
        types: new[]
        {
            typeof(int),
            typeof(DateTime),
        },
        modifiers: null);
```

Specifying parameter types disambiguates overloads.

Useful `MethodInfo` metadata:

```text
Name
ReturnType
IsPublic
IsPrivate
IsStatic
IsAbstract
IsVirtual
IsGenericMethod
IsGenericMethodDefinition
GetParameters()
GetGenericArguments()
DeclaringType
```

Invoke:

```csharp
object? result = method.Invoke(
    targetInstance,
    new object?[]
    {
        123,
        DateTime.UtcNow,
    });
```

Use a null target for static methods.

Reflection wraps exceptions from the invoked method in reflection-specific invocation exceptions, so inspect the inner exception when diagnosing failures.

## Constructors and `Activator`

Constructors are represented by `ConstructorInfo`.

```csharp
ConstructorInfo[] constructors =
    type.GetConstructors(flags);

ConstructorInfo? constructor =
    type.GetConstructor(new[]
    {
        typeof(string),
    });
```

Invoke directly:

```csharp
object instance = constructor.Invoke(
    new object?[]
    {
        "hello",
    });
```

Or use `Activator`:

```csharp
object? instance =
    Activator.CreateInstance(type);

object? withArguments =
    Activator.CreateInstance(
        type,
        new object?[]
        {
            "hello",
        });
```

`Activator.CreateInstance` is concise for ordinary construction. `ConstructorInfo` gives explicit control over which constructor is selected and exposes its metadata.

## `ParameterInfo`

Method and constructor parameters are represented by `ParameterInfo`.

```csharp
ParameterInfo[] parameters =
    method.GetParameters();
```

Useful metadata:

```text
Name
Position
ParameterType
HasDefaultValue
DefaultValue
IsOptional
IsIn
IsOut
Attributes
GetRequiredCustomModifiers()
GetOptionalCustomModifiers()
```

`ParameterType` may itself be by-ref:

```csharp
bool byRef =
    parameter.ParameterType.IsByRef;
```

## What should be recallable

- How are overloaded methods selected and invoked?
- How do `ConstructorInfo` and `Activator.CreateInstance` differ?
- Which `ParameterInfo` properties describe position, defaults, optionality, and by-ref shape?
- Where is an invoked method's original exception found?

## Related knowledge

- `dotnet.reflection-type-members-and-binding-flags`
- `dotnet.reflection-element-types-and-byref-parameters`

## Sources

- Workspace: `_ai-conspects/REFLECTION/`
- Authoritative processed source: `regions/R01R02R03R04-reflection-final-v001.md`, R02 `Methods` through `ParameterInfo`
- Original SVG: `source/REFLECTION.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
