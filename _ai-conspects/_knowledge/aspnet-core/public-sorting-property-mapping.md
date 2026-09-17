# Public sorting and property mapping

Knowledge ID: `aspnet-core.public-sorting-property-mapping`

Topic: `aspnet-core`

Sorting is part of the public resource contract. Accept clauses such as `age desc,name`, validate every public field and direction token, and apply a deterministic default/tie-breaker before paging. The first clause becomes `OrderBy`; later clauses become `ThenBy`. Keep the pipeline as `IQueryable<T>` until materialization—`Func<T, object>` risks in-memory work, while expression/provider-translatable ordering stays in SQL.

Public fields need not match entity fields. A property mapping can express:

```text
Name → LastName, FirstName
Age  → DateOfBirth, Revert = true
```

`age desc` therefore becomes `DateOfBirth asc`; mapped destination order defines tie-breaking. Parse comma clauses with trimming, compare names ordinal-ignore-case, reject malformed/unknown fields with a controlled 400, and never feed unvalidated client strings into SQL, reflection, or Dynamic LINQ.

A typed `PropertyMapping<TSource, TDestination>` can hold destination names plus the reversal flag; a non-generic marker lets one immutable service store heterogeneous mappings. Controller validation distinguishes client errors from missing developer configuration. `ApplySort` resolves each clause, computes effective direction, appends all mapped keys, then paging/materialization follow. Avoid unconditional reversal of multi-property mappings. Dynamic LINQ is only the execution convenience after whitelist translation, not the security boundary.

```csharp
var authorMapping = new Dictionary<string, PropertyMappingValue>(
    StringComparer.OrdinalIgnoreCase)
{
    ["name"] = new(new[] { "LastName", "FirstName" }),
    ["age"] = new(new[] { "DateOfBirth" }, revert: true)
};

if (!mappingService.ValidMappingExistsFor<AuthorDto, Author>(orderBy))
    return BadRequest();

var mapping = mappingService.GetPropertyMapping<AuthorDto, Author>();
var query = context.Authors.Where(authorFilter);
query = query.ApplySort(orderBy, mapping);
var page = await query.Skip(skip).Take(take).ToListAsync(token);
var result = page.Select(author => mapper.Map<AuthorDto>(author));
```

`GetPropertyMapping<TSource, TDestination>` should require exactly one configured mapping: absence or duplication is a developer/configuration error, whereas an unsupported requested field is a client error. A singleton lifetime suits a service whose mapping collection is immutable and contains no scoped state.

## Sources
- Workspace: `_ai-conspects/SORTING,MAPPING SERVICE/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R03-filtering-searching-pagination-sorting.md`, public-field sorting and mapping styles
- Original SVG: `source/REST API BASICS.svg`
