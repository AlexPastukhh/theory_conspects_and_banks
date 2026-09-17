# Last-Modified revalidation and freshness

Knowledge ID: `http.last-modified-revalidation-and-freshness`

Topic: `http`

`Last-Modified` is a validator for the selected representation. Persist a stable UTC timestamp and update it for every representation-changing mutation, including relevant child changes when the representation aggregates them. EF Core can use a normal/shadow property and update it in `SaveChangesAsync` or an interceptor.

```csharp
modelBuilder.Entity<Author>()
    .Property<DateTimeOffset>("LastModified");

foreach (var entry in ChangeTracker.Entries<Author>())
  if (entry.State is EntityState.Added or EntityState.Modified)
    entry.Property<DateTimeOffset>("LastModified").CurrentValue = now;
```

Read a shadow value inside the query with `EF.Property<DateTimeOffset>(author, "LastModified")` so the representation and validator are selected together.

HTTP dates have whole-second precision, so normalize to UTC and truncate both stored and request values before comparing. For GET-style validation, return 304 when `lastModified <= If-Modified-Since`; otherwise return 200 with the current representation. `If-None-Match` takes precedence when both validators are present. Unsafe methods must not reuse this GET-oriented 304 rule.

```csharp
var headers = Request.GetTypedHeaders();
Response.GetTypedHeaders().LastModified = lastModified;
if (headers.IfModifiedSince is { } since &&
    lastModified <= TruncateToSecond(since))
  return StatusCode(StatusCodes.Status304NotModified);
return Ok(dto);
```

Emit validators and relevant cache metadata on 200 and 304; a 304 has no normal representation body. Validators answer whether stored content is current, while `max-age`/`Expires` define freshness without contacting the server. `no-cache` permits storage but requires revalidation before reuse; `no-store` forbids storage. After freshness expires, a cache sends `If-Modified-Since` and receives 304 or a new 200. Prefer ETags when several changes can happen within one second or modification time cannot represent the output precisely.

## Sources
- Workspace: `_ai-conspects/last modified header, implementation, expirational model/`
- Processed source: `01-final-transcript.md`, complete transcript
