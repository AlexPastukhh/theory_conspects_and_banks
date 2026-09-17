# IQueryable repository and resource boundaries

Knowledge ID: `ef-core.iqueryable-repository-and-resource-boundaries`

Topic: `ef-core`

`IQueryable<T>` lets its caller add expression trees that a provider may translate. That power also exposes the provider boundary: callers must know which expressions translate, when execution occurs, and which resource must still be alive.

```csharp
return repository.GetAll()
    .Where(x => x.Email.EndsWith(".edu")) // provider may translate
    .ToList()                              // execute and materialize
    .Select(MapToDto);                     // now LINQ-to-Objects
```

Only a subset of all valid LINQ expressions is supported by a particular provider. An arbitrary projection such as `Select(MapToDto)` may not translate. Returning `IQueryable<T>` therefore gives the consumer an API broader than the actual database provider contract and moves runtime translation failures outside the repository.

Accepting `Expression<Func<T, bool>>` does not remove that leak: it still tells callers to construct provider-consumable expression trees and to understand translation constraints. The captured source treats direct exposure as potentially acceptable in a small project, but unsuitable as a public repository API for medium or large systems.

## Keep query composition behind plain inputs

Pass domain/filter values across the repository boundary and compose the query internally:

```csharp
public IEnumerable<Student> GetAll(string emailDomain)
{
    IQueryable<Student> query = _context.Set<Student>();

    if (!string.IsNullOrWhiteSpace(emailDomain))
    {
        query = query.Where(x => x.Email.EndsWith(emailDomain));
    }

    return query.AsEnumerable();
}
```

This hides arbitrary expression composition, but it does **not** materialize the query. `AsEnumerable()` only presents an `IEnumerable<T>` surface; operators appended after that boundary use LINQ-to-Objects, while enumerating the underlying sequence can still execute the provider query later. Returning `IEnumerable<T>` is less powerful than returning `IQueryable<T>`, yet the static type alone does not prove that results are already stored.

That creates a resource-lifetime contract. A deferred query cannot safely escape a context that is disposed before enumeration:

```csharp
public IEnumerable<User> GetUsers()
{
    using var db = new AppDbContext();
    return db.Users.Where(user => user.IsActive);
} // db is disposed before the caller enumerates
```

The caller sees only the enumerable contract and has no way through that interface to verify that the hidden database connection/context is still available. The source frames that strengthened, hidden precondition as a design-by-contract/LSP problem.

When results must outlive the resource, materialize while the context is alive:

```csharp
public List<User> GetUsers()
{
    using var db = new AppDbContext();
    return db.Users
        .Where(user => user.IsActive)
        .ToList();
}
```

The query and any provider exception now occur inside the intended boundary. Otherwise execution can move into a controller/service/UI layer, making timing, logging, retry behavior, performance, and failure ownership harder to reason about. Deferred return remains valid when laziness/streaming is intentional, the source remains usable, replay is acceptable, and the method contract says so explicitly.

## What should be recallable

- Why does `IQueryable<T>` expose provider translation details?
- Why can an expression-parameter repository API leak the same abstraction?
- What does passing plain filter values keep inside the repository?
- Why does `AsEnumerable()` not establish a materialization boundary?
- How can a deferred sequence strengthen the apparent `IEnumerable<T>` preconditions?
- Where should materialization occur when a `DbContext` has a shorter lifetime than its caller?

## Related knowledge

- `dotnet.deferred-enumeration-replay-and-materialization`
- `dotnet.linq-materialization-casting-and-provider-boundaries`
- `ef-core.lazy-loading-and-query-shaping`

## Sources

- Workspace: `_ai-conspects/returning-iqueryable-problems-when-returning-ienumerable-without-tolist-async-enumerable-problems-yield/`
- Authoritative processed sources: `regions/RIQ01-iqueryable-public-api-leaky-abstraction.md` and `regions/RIQ02-ienumerable-tolist-materialization-boundary.md`, resource-boundary portions
- Original SVG: `assets/raw/returning-iqueryable-ienumerable-async-yield.svg`
