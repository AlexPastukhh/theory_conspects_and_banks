# GetHashCode and HashCode API implementation patterns

Knowledge ID: `dotnet.hashcode-api-and-implementation`

Topic: `dotnet`

## IEquatable<T> implementation pattern

When implementing custom equality, normally provide all three members together:

- `Equals(object?)` - override from `object`;
- `IEquatable<T>.Equals(T?)` - typed equality implementation;
- `GetHashCode()` - must use exactly the same identity fields as equality.

Full example:

```csharp
public sealed class Person : IEquatable<Person>
{
    public string FirstName { get; init; } = "";
    public string LastName  { get; init; } = "";

    public bool Equals(Person? other)
    {
        if (ReferenceEquals(null, other)) return false;
        if (ReferenceEquals(this, other)) return true;
        return FirstName == other.FirstName
            && LastName  == other.LastName;
    }

    public override bool Equals(object? obj)
        => obj is Person other && Equals(other);

    public override int GetHashCode()
        => HashCode.Combine(FirstName, LastName);

    public static bool operator ==(Person? left, Person? right)
        => Equals(left, right);

    public static bool operator !=(Person? left, Person? right)
        => !Equals(left, right);
}
```

Typed equality avoids repeated casts through object (and avoids boxing when implemented on value types), giving generic collections an efficient, consistent equality path. Overloading `==` and `!=` ensures value equality semantics apply consistently when using operator syntax. GetHashCode must use the same identity fields and comparison rules as Equals; == and != must agree with the same equality semantics.

## Records as a shortcut

For `record` types, .NET generates equality and hashing automatically:

```csharp
public record Person(string FirstName, string LastName);
```

Records are convenient for value-like objects where all positional properties define identity. Manual `GetHashCode` is usually not needed.

## HashCode.Combine - small fixed sets

`HashCode.Combine` provides overloads for a fixed number of arguments:

```csharp
return HashCode.Combine(A, B);
return HashCode.Combine(A, B, C);
return HashCode.Combine(A, B, C, D);
```

Use Combine when the contributing values are known, fixed, and few. It does not require a null check - passing a null reference to Combine is safe.

```csharp
public override int GetHashCode()
    => HashCode.Combine(Name, OptionalDescription);  // null OptionalDescription is fine
```

## HashCode accumulator (Add) - many fields, loops, conditions

For many fields, loops, or collections, use the `HashCode` struct with incremental `Add`:

```csharp
public override int GetHashCode()
{
    var hash = new HashCode();
    hash.Add(FirstName);
    hash.Add(LastName);
    hash.Add(BirthDate);
    return hash.ToHashCode();
}
```

Use the accumulator when:

- there are many fields;
- some values are conditional;
- items are added in a loop.

Conditional accumulation:

```csharp
public override int GetHashCode()
{
    var hash = new HashCode();
    hash.Add(Id);

    if (Name is not null)
        hash.Add(Name);

    if (Metadata is not null)
        hash.Add(Metadata.Version);

    return hash.ToHashCode();
}
```

`Equals` must mirror the same conditions - if hashing conditionally includes a value, equality must apply the same condition.

## HashCode.Add with an explicit comparer

`HashCode.Add(value, comparer)` accepts a comparer. Equality and hashing must agree not only on fields but also on comparison rules such as case sensitivity:

```csharp
public override int GetHashCode()
{
    var hash = new HashCode();
    hash.Add(Email, StringComparer.OrdinalIgnoreCase);
    return hash.ToHashCode();
}
```

If equality uses `StringComparer.OrdinalIgnoreCase.Equals(a, b)`, hashing must use the same comparer. If equality ignores case but hashing does not, two case-equivalent emails will end up in different buckets and `Dictionary`/`HashSet` lookups will fail.

## Collection hashing - order-sensitive

When an identity model includes a collection, add each element with the accumulator:

```csharp
public sealed class Order : IEquatable<Order>
{
    public int Id { get; init; }
    public IReadOnlyList<string> Tags { get; init; } = Array.Empty<string>();

    public override int GetHashCode()
    {
        var hash = new HashCode();
        hash.Add(Id);
        foreach (var tag in Tags)
            hash.Add(tag);
        return hash.ToHashCode();
    }
}
```

Adding tags in sequence makes the hash order-sensitive. Equality for `Order` must use the same sequence semantics. `HashCode.Combine` is awkward for a variable-length list because it is designed for a fixed number of arguments.

## Collection hashing - order-independent (set-like)

When order should not matter, sort before hashing so that `["a","b"]` and `["b","a"]` produce the same hash:

```csharp
public static int GetSetLikeHash(IEnumerable<string>? values)
{
    if (values is null)
        return 0;

    var hash = new HashCode();
    foreach (var value in values.OrderBy(x => x, StringComparer.Ordinal))
        hash.Add(value, StringComparer.Ordinal);

    return hash.ToHashCode();
}
```

Benefits over an older manual style:

- no manual `s?.GetHashCode() ?? 0` pre-hashing;
- no manual element-null fallback (Add handles nulls);
- consistent comparer used for both sorting and accumulation;
- accumulator fits loop hashing naturally.

The function is duplicate-sensitive: `["a"]` and `["a","a"]` are not the same multiset. Equality must define whether collections are compared as sequences, sets, or multisets, and hashing must mirror that definition.

Do not use `HashCode.Combine` inside a loop - it is designed for a small, fixed set of inputs. Combining an accumulated int as if it were another original identity field obscures intent.

## Manual unchecked formula (older style)

Older code sometimes used:

```csharp
public override int GetHashCode()
{
    unchecked
    {
        int hash = 17;
        hash = hash * 23 + FirstName.GetHashCode();
        hash = hash * 23 + LastName.GetHashCode();
        hash = hash * 23 + BirthDate.GetHashCode();
        return hash;
    }
}
```

This can work but requires:

- explicit `unchecked` to allow overflow;
- manual null handling (`?.GetHashCode() ?? 0`);
- manual comparer consistency.

Modern .NET prefers `HashCode.Combine` or `HashCode.Add` because they communicate intent more clearly and handle nulls and comparers without extra code.

## Field consistency rule

GetHashCode and Equals must use the same identity fields with the same comparison rules. Bad mismatch:

```csharp
public override bool Equals(object? obj)
    => obj is Person p
       && FirstName == p.FirstName
       && LastName  == p.LastName;  // two fields

public override int GetHashCode()
    => HashCode.Combine(
           FirstName,
           LastName,
           BirthDate);  // three fields - wrong mismatch
```

Two persons equal by `Equals` (same first/last name, different birth date) would hash differently and land in different buckets. The repair is either to remove `BirthDate` from hashing or to add it to equality.

## What should be recallable

- Which three members should be implemented together for custom equality?
- Why implement `IEquatable<T>` alongside the object override?
- When is `HashCode.Combine` the right choice vs `HashCode.Add`?
- How do you hash a variable-length collection with the accumulator?
- How do you make collection hashing order-independent?
- What is the comparer consistency rule for `HashCode.Add`?
- Does `HashCode.Combine` or `Add` handle null values without extra code?
- What is wrong with calling element `.GetHashCode()` manually inside a loop?
- Why does conditional hashing require matching conditional logic in Equals?

## Related knowledge

- `dotnet.hashcode-equality-contract` - the conceptual contract, security/stability boundaries, mutable-key failure mechanics
- `dotnet.value-object-equality-and-component-streams` - ValueObject base pattern and declarative component streams
- `dotnet.record-value-semantics-and-representation` - record-generated equality in more detail

## Sources

- Workspace: `_ai-conspects/hashcode/`
- Authoritative processed source: `02-source-preserving-transcript-v002.md`, sections S-001, S-004, S-005, S-006, S-007, S-008, S-009, S-010, S-011, S-013, S-014, S-015, S-017, S-018, S-019, S-020, S-021
- Quality audit: `05-transcript-quality-correction-audit-v002.md`
- Original SVG: `source/hashcode.svg` (Git blob SHA: 0eaf471525a9cf3056a6815b07a7c1c266ed210c)
- Workspace: `_ai-conspects/equality/`
- Authoritative processed source: `10-full-source-preserving-transcript-v003.md`, sections S-004, S-006, S-007, S-009, S-011, S-012, S-014, S-017, S-018
