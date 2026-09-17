# Reflection events, interfaces, nested types, and member origin

Knowledge ID: `dotnet.reflection-events-interfaces-and-member-origin`

Topic: `dotnet`

## Events

```csharp
EventInfo[] events =
    type.GetEvents(flags);

EventInfo? eventInfo =
    type.GetEvent("Changed", flags);
```

Useful metadata:

```text
Name
EventHandlerType
AddMethod
RemoveMethod
RaiseMethod
DeclaringType
ReflectedType
```

Reflection can add or remove handlers:

```csharp
eventInfo.AddEventHandler(
    target,
    handler);

eventInfo.RemoveEventHandler(
    target,
    handler);
```

## Interfaces

```csharp
Type[] interfaces =
    type.GetInterfaces();

Type? disposable =
    type.GetInterface("IDisposable");
```

Check assignability more safely with the actual interface type:

```csharp
bool implements =
    typeof(IDisposable)
        .IsAssignableFrom(type);
```

`GetInterfaces()` includes interfaces inherited through base types and other interfaces.

## Nested types

```csharp
Type[] nestedTypes =
    type.GetNestedTypes(
        BindingFlags.Public |
        BindingFlags.NonPublic);
```

Useful nested-type metadata:

```text
Name
IsNested
IsNestedPublic
IsNestedPrivate
DeclaringType
```

A nested type is a first-class `Type`, not merely a member name.

## `DeclaringType` versus `ReflectedType`

`DeclaringType` is where the member was originally declared.

`ReflectedType` is the type through which the member was obtained.

Example:

```csharp
class Base
{
    public void Hello() { }
}

class Derived : Base
{
}
```

When `Hello` is obtained through `typeof(Derived)`, its declaring type can be `Base` while its reflected type is `Derived`.

Mental model:

```text
DeclaringType -> origin
ReflectedType -> lookup/discovery type
```

## What should be recallable

- How are event accessors and handler subscription exposed through `EventInfo`?
- How are implemented interfaces and nested public/non-public types discovered?
- What is the difference between `DeclaringType` and `ReflectedType`?

## Related knowledge

- `dotnet.reflection-type-members-and-binding-flags`
- `dotnet.reflection-generics-type-checks-and-performance`

## Sources

- Workspace: `_ai-conspects/REFLECTION/`
- Authoritative processed source: `regions/R01R02R03R04-reflection-final-v001.md`, R02 `Events` through `DeclaringType versus ReflectedType`
- Original SVG: `source/REFLECTION.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
