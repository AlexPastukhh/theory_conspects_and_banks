# Reflection Type, members, and BindingFlags

Knowledge ID: `dotnet.reflection-type-members-and-binding-flags`

Topic: `dotnet`

## Reflection model

Reflection inspects metadata about types and members at runtime.

Start with a `Type`:

```csharp
Type fromCompileTime = typeof(MyClass);
Type fromInstance = instance.GetType();
```

`typeof(T)` is based on a known type expression. `obj.GetType()` returns the actual runtime type of a non-null object.

An assembly contains types:

```csharp
Assembly assembly = typeof(MyClass).Assembly;
Type[] types = assembly.GetTypes();
```

Assemblies can also be loaded through explicit assembly APIs when plugin or discovery scenarios require it.

## `Type` as the central metadata object

Useful `Type` members include:

```text
Name
FullName
Namespace
Assembly
AssemblyQualifiedName
BaseType
IsClass
IsValueType
IsInterface
IsEnum
IsAbstract
IsSealed
IsGenericType
IsGenericTypeDefinition
IsNested
```

Enumerate member categories:

```csharp
type.GetMembers();
type.GetFields();
type.GetProperties();
type.GetMethods();
type.GetConstructors();
type.GetEvents();
type.GetInterfaces();
type.GetNestedTypes();
```

The singular APIs such as `GetMethod`, `GetProperty` and `GetField` require enough information to select one result. Overloads and hidden members can make name-only lookup ambiguous.

## `MemberInfo`

`MemberInfo` is the common base for reflected members.

```csharp
MemberInfo[] members = type.GetMembers();

foreach (MemberInfo member in members)
{
    Console.WriteLine(
        $"{member.MemberType}: {member.Name}");
}
```

Shared metadata includes:

```text
Name
MemberType
DeclaringType
ReflectedType
GetCustomAttributes(...)
IsDefined(...)
```

Specialized types include:

```text
FieldInfo
PropertyInfo
MethodInfo
ConstructorInfo
EventInfo
Type, for nested types
```

## `BindingFlags`

Default reflection lookups usually expose public members and include inherited members according to the selected API.

To control the search, combine flags:

```csharp
BindingFlags flags =
    BindingFlags.Public |
    BindingFlags.NonPublic |
    BindingFlags.Instance |
    BindingFlags.Static;
```

Common flags:

```text
Public
NonPublic
Instance
Static
DeclaredOnly
FlattenHierarchy
IgnoreCase
```

Example:

```csharp
FieldInfo[] fields = type.GetFields(
    BindingFlags.Instance |
    BindingFlags.Public |
    BindingFlags.NonPublic);
```

A common reason private members appear to be missing is forgetting `NonPublic` or forgetting to include `Instance`/`Static`.

### `DeclaredOnly`

`DeclaredOnly` restricts results to members declared on the inspected type rather than inherited members.

```csharp
type.GetMethods(
    BindingFlags.Public |
    BindingFlags.Instance |
    BindingFlags.DeclaredOnly);
```

### `FlattenHierarchy`

`FlattenHierarchy` affects inherited public/protected static members. It does not simply mean “include every private member from every base class.”

## What should be recallable

- How are `Type`, assemblies, and specialized `MemberInfo` types related?
- Which lookup APIs enumerate each member category?
- How must public/non-public and instance/static `BindingFlags` be combined?
- What do `DeclaredOnly` and `FlattenHierarchy` actually restrict?

## Related knowledge

- `dotnet.reflection-fields-properties-and-attributes`
- `dotnet.reflection-methods-constructors-and-parameters`

## Sources

- Workspace: `_ai-conspects/REFLECTION/`
- Authoritative processed source: `regions/R01R02R03R04-reflection-final-v001.md`, R01 `Reflection model` through `BindingFlags`
- Original SVG: `source/REFLECTION.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
