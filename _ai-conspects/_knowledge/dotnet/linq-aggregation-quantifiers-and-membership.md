# LINQ aggregation, quantifiers, and membership

Knowledge ID: `dotnet.linq-aggregation-quantifiers-and-membership`

Topic: `dotnet`

`Aggregate` folds a sequence into accumulated state. A seed defines the empty-sequence result and accumulator type; the result-selector overload can turn the final accumulator into another result shape.

```csharp
var summary = values.Aggregate(
    new { Count = 0, Sum = 0 },
    (acc, value) => new { Count = acc.Count + 1, Sum = acc.Sum + value },
    acc => acc.Count == 0 ? 0d : (double)acc.Sum / acc.Count);
```

`Count` counts elements; `LongCount` avoids `int` range limits. `Sum`, `Min`, `Max`, and `Average` have type- and null-specific overloads. Empty non-nullable `Min`/`Max`/`Average` and seedless `Aggregate` can throw, while `Sum` commonly returns zero; choose explicit empty semantics instead of assuming all aggregates behave alike.

`Any` asks whether at least one element exists or matches and can short-circuit. Prefer `Any()` to `Count() > 0` when only existence matters, especially for deferred/provider queries. `All` also short-circuits and is true for an empty sequence (vacuous truth); `!source.Any(x => !predicate(x))` is equivalent but should be used only when it reads more clearly. `Contains` uses the selected equality semantics. Repeated membership tests against the same collection often justify a `HashSet<T>` with the domain comparer rather than repeated linear scans.

Keep custom accumulator state inside the fold. Mutating shared external state makes results depend on enumeration count/order and is especially unsafe when a deferred query is enumerated repeatedly.

For `IQueryable`, provider translation and database null/aggregate behavior must be verified; a custom in-memory comparer usually does not translate.

## Sources

- Workspace: `_ai-conspects/-all/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R03
- Original SVG: `source/-all.svg`
