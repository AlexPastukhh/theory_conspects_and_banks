# EF Core JSON-converted collections and SQL Server querying

Knowledge ID: `ef-core.json-converted-collections-and-sql-server-querying`

Topic: `ef-core`

A converter can serialize a small collection into one JSON/string column when the value is normally read as a whole:

```csharp
builder.Property(x => x.Tags)
    .HasConversion(
        value => JsonSerializer.Serialize(value, jsonOptions),
        json => JsonSerializer.Deserialize<List<string>>(json, jsonOptions)
                ?? new List<string>());
```

This denormalizes the model. The database cannot enforce per-item foreign keys, arbitrary CLR collection operations do not automatically translate through the converter, and change tracking still needs a comparer/immutable strategy. Provider-native JSON/collection mapping can have better translation. Frequently queried fields may justify extracted/computed columns and indexes; item-heavy constraints/updates may justify normalized child rows.

`JSON_VALUE(column, path)` extracts one scalar and can be exposed through a mapped scalar DbFunction for filters/projections/ordering. In advanced queries over a converted property, `EF.Property<string>(entity, "Tags")` can expose the provider column, but that does not make arbitrary CLR-list operations translatable. Array membership is a rowset problem: `OPENJSON` expands elements and `EXISTS` avoids duplicating the outer row and can stop after the first match.

```csharp
var posts = await context.Posts
    .FromSqlInterpolated($@"
        SELECT p.*
        FROM Posts AS p
        WHERE EXISTS (
            SELECT 1
            FROM OPENJSON(p.Tags) AS j
            WHERE j.[value] = {tag}
        )")
    .ToListAsync();
```

`FromSqlInterpolated` parameterizes values; never concatenate user input. The default `OPENJSON` schema supplies key/value/type and is sufficient for a primitive string array. Use `WITH` for object properties, multiple fields, or typed numeric/date comparison—do not compare numeric JSON lexically as strings. Mapping `OPENJSON` as a scalar function is awkward because it returns a table.

Provider-specific raw SQL needs explicit projection, integration tests, generated SQL/query-plan measurement, and a deliberate schema exit when repeated high-volume JSON predicates dominate.

## Sources

- Workspace: `_ai-conspects/ef has conversion, value converte,comparer/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01 and R04-R05
- Original SVG: `source/ef has conversion, value converte,comparer.svg`
