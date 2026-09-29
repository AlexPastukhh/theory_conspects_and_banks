# User-defined implicit and explicit conversions

Knowledge ID: `dotnet.user-defined-conversion-operators`

Topic: `dotnet`

A type can declare conversion operators to or from another type:

```csharp
public readonly struct MyValue
{
    private readonly string _value;

    public MyValue(string value) =>
        _value = value ?? throw new ArgumentNullException(nameof(value));

    public static implicit operator MyValue(string value) => new(value);
    public static implicit operator string(MyValue value) => value._value;
}
```

The compiler inserts these for `MyValue value = "abc"` and `string text = value`.

Use `implicit` only when conversion is safe, unsurprising, effectively lossless, and not expected to fail for normal input. If construction validates restrictive input or can commonly throw, hiding it in assignment obscures control flow.

Use `explicit` for potentially failing/lossy directions:

```csharp
public static explicit operator PositiveInt(int value) => new(value);
public static implicit operator int(PositiveInt value) => value.Value;

var positive = (PositiveInt)5;
int number = positive;
```

The cast exposes validation risk; do not also make `PositiveInt p = 5` implicit when invalid integers exist.

Conversions participate in overload resolution; a string may convert before a value object's `==` executes, which can be convenient but make overloads ambiguous. Equality must still be consistent across `Equals`, `GetHashCode`, and `==`/`!=`.

The operator must be `public static`, declared in either source or target type, and convert different types. An unrelated third type cannot define the conversion, and built-in conversions cannot simply be redefined.

## What should be recallable

- Declaration and compiler insertion of bidirectional conversions.
- Safety criteria for implicit versus visible explicit casts.
- PositiveInt failure-direction example.
- Overload/equality interaction and declaration-placement/language restrictions.

## Sources

- Workspace: `_ai-conspects/implicit operators  explicit operators/`
- Processed source: `regions/R01-implicit-explicit-conversion-operators-final.md`, R01
- Original SVG: `source/implicit operators  explicit operators.svg`
