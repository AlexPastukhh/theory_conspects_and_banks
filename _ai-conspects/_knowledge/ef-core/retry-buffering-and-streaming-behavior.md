# EF Core retry buffering and streaming behavior

Knowledge ID: `ef-core.retry-buffering-and-streaming-behavior`

Topic: `ef-core`

Enabling a retrying execution strategy can cause EF Core to buffer query results internally. EF needs a replayable result boundary if a database command fails during enumeration.

This changes the meaning of apparently streaming code.

Without retry buffering:

```csharp
await foreach (var post in db.Posts.AsAsyncEnumerable())
{
    Process(post);
}
```

can process rows with roughly constant application memory.

With a retrying strategy, EF may first buffer the complete result set and only then expose rows to the consumer. The code still looks like streaming, but memory use can grow with result size.

Terminal buffering operators add another layer. `ToListAsync` and `ToArrayAsync` already create a complete in-memory result. With retries enabled the effective flow can be:

```text
database rows -> EF internal retry buffer -> application List or array
```

The result may therefore be represented in memory twice.

This buffering is client-side application memory in the EF process. It is not an extra SQL Server-side result cache created by EF.

Scalar queries are different. `AnyAsync`, for example, normally translates to an `EXISTS`-style query that returns one boolean-like value. Even if retry behavior applies, there is no large result set to buffer. The memory warning matters primarily for queries that return many rows.

## What should be recallable

- Why can retries cause EF to buffer a result set internally?
- Why can `await foreach` stop being true streaming when retries are enabled?
- How can `ToListAsync` create a second full in-memory representation?
- Is this retry buffer in SQL Server memory or application memory?
- Why is `AnyAsync` normally not a large buffering concern?

## Sources

- Workspace: `_ai-conspects/ef core retry, savepoints/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, section 6
- Original SVG: `source/source-complete-v002.svg`
