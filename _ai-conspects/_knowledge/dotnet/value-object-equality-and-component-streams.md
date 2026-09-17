# ValueObject equality and declarative component streams

Knowledge ID: `dotnet.value-object-equality-and-component-streams`

Topic: `dotnet`

## Value object equality model

Value objects are domain objects whose identity is defined by their attributes rather than a persistent ID or reference identity. Two value objects with identical attribute values are considered logically equal.

When implementing a class-based value object hierarchy, a common pattern uses an abstract base class that delegates equality and hashing to an ordered component stream:

```csharp
public class Address : ValueObject
{
    public string City    { get; init; } = "";
    public string Street  { get; init; } = "";
    public string Zip     { get; init; } = "";
    public string Country { get; init; } = "";

    protected override IEnumerable<object> GetEqualityComponents()
    {
        yield return City;
        yield return Street;
        yield return Zip;
        yield return Country;
    }
}
```

The base class implementation then compares components using sequence equality:

```csharp
GetEqualityComponents().SequenceEqual(other.GetEqualityComponents())
```

and computes the hash code across the same stream.

## Why yield return is used for component streams

The `yield return` pattern is chosen over returning a concrete array or `List<object>` for four architectural reasons:

1. **Expressive declarative intent (clarity over data structures):**
   `yield return` directly answers the conceptual question: *"What are the equality components, in order?"* It reads declaratively: *"Equality consists of City, then Street, then Zip, then Country."* Returning `new object[] { City, Street, ... }` hides the sequence inside an allocated container and feels like building a data structure rather than declaring identity rules.

2. **No accidental coupling to a concrete collection:**
   `yield return` produces a pure, read-only, throwaway sequence with no implied ownership. With a `List<object>`, callers or derived classes might be tempted to call `.Add()`, cache the list, or mutate it later. `yield return` prevents accidental mutation by construction.

3. **No risk of reusing stale data (correct by construction):**
   Attempting to cache components in a field, such as:
   ```csharp
   private object[]? _components;
   protected override IEnumerable<object> GetEqualityComponents()
       => _components ??= new object[] { City, Street, Zip, Country }; // BUG
   ```
   breaks equality if property values change after construction or during object initialization. With `yield return`, values are read dynamically at enumeration time with no hidden state or stale cache.

4. **Natural integration with base-class logic:**
   The `ValueObject` base class only requires an `IEnumerable<object>` to perform `SequenceEqual`. It does not need to know whether component values come from backing fields, auto-properties, or calculated domain properties.

## Complete value object implementation with operators

For standalone value object classes that do not inherit from a base class (such as `Money`), implement `IEquatable<T>`, `Equals`, `GetHashCode`, equality operators, and domain string formatting together:

```csharp
public sealed class Money : IEquatable<Money>
{
    public decimal Amount   { get; }
    public string  Currency { get; }

    public Money(decimal amount, string currency)
    {
        Amount   = amount;
        Currency = currency;
    }

    public bool Equals(Money? other)
    {
        if (ReferenceEquals(null, other)) return false;
        if (ReferenceEquals(this, other)) return true;
        return Amount == other.Amount
            && Currency == other.Currency;
    }

    public override bool Equals(object? obj)
        => obj is Money other && Equals(other);

    public override int GetHashCode()
        => HashCode.Combine(Amount, Currency);

    public static bool operator ==(Money? left, Money? right)
        => Equals(left, right);

    public static bool operator !=(Money? left, Money? right)
        => !Equals(left, right);

    public override string ToString()
        => $"{Amount} {Currency}";
}
```

## ToString() is outside the equality contract

`ToString()` has no effect on equality correctness.

Override `ToString()` only when you need:

- clearer logging;
- better debugging representations;
- prettier API output;
- domain-friendly text formats (e.g. `100 USD`).

C# `record` types synthesize `ToString()` automatically for convenience, but class-based value objects are not required to override `ToString()` for equality to be correct.

## What should be recallable

- What defines value object identity vs entity identity?
- How does the `GetEqualityComponents()` pattern work with base-class `SequenceEqual`?
- Name the four reasons why `yield return` is preferred over allocating a collection or caching components.
- Why is caching `GetEqualityComponents()` in a field an anti-pattern?
- Which operators (`==`, `!=`) should be overloaded for standalone value object classes?
- Why is `ToString()` independent of the equality contract?

## Related knowledge

- `dotnet.hashcode-api-and-implementation` - IEquatable<T>, GetHashCode, and equality consistency rules
- `dotnet.hashcode-equality-contract` - GetHashCode contract, security/stability boundaries, and mutable-key failure
- `dotnet.record-value-semantics-and-representation` - C# record value semantics and auto-generated equality

## Sources

- Workspace: `_ai-conspects/equality/`
- Authoritative processed source: `10-full-source-preserving-transcript-v003.md`, sections S-001, S-002, S-005, S-008, S-009, S-010, S-013, S-015, S-016
- Technical corrections: `11-technical-corrections-v002.md`
- Original SVG: `source/equality.svg` (Git blob SHA: 02906f4e05e6e444ad07a4de26cd17d1255aac5c)
