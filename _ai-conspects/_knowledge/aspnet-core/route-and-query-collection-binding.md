# ASP.NET Core route and query collection binding

Knowledge ID: `aspnet-core.route-and-query-collection-binding`

Topic: `aspnet-core`

A route segment such as `/users/1,2,3` is one route value. ASP.NET Core can bind it to `string`, but does not automatically split it into `long[]`, `IEnumerable<Guid>`, or another collection. GUID scalar conversion is supported; what is missing is an application-defined list grammar.

```csharp
[HttpGet("users/{ids}")]
public IActionResult GetUsers(string ids)
{
    // Parse with controlled validation; raw int.Parse can throw.
}
```

Reusable choices are a strongly typed parsable value or custom model binder. Define invalid-item, empty-item, duplicate, ordering, count, URL-length, and escaping policies. A packed composite form such as `key1=value1,key2=value2` likewise needs a documented parser; explicit segments are often clearer for conventional composite identity.

Repeated query keys are the natural built-in collection shape:

```http
GET /users?ids=1&ids=2&ids=3
```

```csharp
[HttpGet("users")]
public IActionResult GetUsers([FromQuery] int[] ids) => Ok(ids);
```

`?ids=1,2,3` contains one query value and also needs explicit/custom parsing. Path identity versus query filtering is a design recommendation, not a protocol ban: a path may intentionally identify a batch resource. For ordinary filters prefer repeated query keys; for large/complex selections consider a request body on a purpose-designed endpoint.

## Sources
- Workspace: `_ai-conspects/ROUTE PARAMS,QUERY STRING BASICS/`
- Processed source: `04-source-preserving-transcript-v002.md`, complete transcript
