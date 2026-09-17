# Accept general inputs and return specific results

Knowledge ID: `dotnet.accept-general-return-specific`

Topic: `dotnet`

An API should accept the most general type that supplies the operations it needs and return the most specific truthful type it knows.

If feeding needs only `Pet` behavior, accept `Pet` rather than `Dog`:

```csharp
void Feed(Pet pet)
```

This lets every suitable subtype participate without exposing irrelevant restrictions. For outputs, if a method really finds a dog, return `Dog`:

```csharp
public static Dog FindNextDogToWash() { /* ... */ }
```

Returning `Pet` would hide known capability and force the caller to downcast:

```csharp
Dog dog = (Dog)FindNextDogToWash();
```

That cast reveals a leaky abstraction: consumers know more about the result than the signature admits.

C# covariance and contravariance formalize why input and output positions have different compatibility rules. For collections, choose the interface matching required operations: `IEnumerable<T>`, `IReadOnlyCollection<T>`, `IReadOnlyList<T>`, `ICollection<T>`, `IList<T>`, or `IQueryable<T>` are not interchangeable promises.

Returned collections should expose an immutable/read-only shape when mutation is not part of the contract. `ImmutableArray<T>` or an appropriate read-only interface avoids defensive copying and mutation bugs while still giving callers useful guarantees.

## What should be recallable

- Why accepting `Pet` can be better than accepting `Dog`, while returning `Dog` can be better than returning `Pet`.
- How an unnecessary caller downcast exposes a weak/leaky return contract.
- How variance relates to input/output positions and how collection interfaces communicate required operations.
- Why immutable/read-only return shapes reduce copying and mutation errors.

## Sources

- Workspace: `_ai-conspects/returning-most-specific-passing-most-generic/`
- Processed sources: `regions/RMSG01-accept-generic-return-specific.md` and `regions/RMSG02-dotnet-variance-collection-hierarchy.md`
- Original SVG: `assets/raw/full.svg`
