# HttpClient requests, responses, and ownership

Knowledge ID: `dotnet.httpclient-requests-responses-and-ownership`

Topic: `dotnet`

## Use shortcuts for simple calls and messages for explicit contracts

`GetAsync`, `PostAsync`, `PutAsync`, and `PatchAsync` are convenient when method, URI, and content are enough. Use `HttpRequestMessage` when a single request needs explicit `Accept`, content headers, custom options, or other per-request behavior.

```csharp
using var request = new HttpRequestMessage(HttpMethod.Patch, "movies/42")
{
    Content = JsonContent.Create(patchDocument)
};
request.Headers.Accept.ParseAdd("application/json; q=1.0");
request.Headers.Accept.ParseAdd("application/problem+json; q=0.9");

using var response = await client.SendAsync(request, ct);
response.EnsureSuccessStatusCode();
var movie = await response.Content.ReadFromJsonAsync<MovieDto>(ct);
```

`Content-Type` describes the representation being sent in the request body. `Accept` describes response representations the caller prefers; quality values express relative preference. They are different negotiations and belong to different header collections.

`EnsureSuccessStatusCode` is a fail-fast boundary before success DTO deserialization. When non-success bodies have a meaningful public error contract, inspect status/content deliberately instead of accidentally deserializing them as success.

## Reading shape changes cost, not the wire document

`ReadAsStringAsync` creates a full string representation. `ReadFromJsonAsync` or deserialization from a stream can avoid that intermediate string; progressive network consumption additionally requires the correct completion option and an incremental consumer. A stream-shaped API by itself does not prove an unbuffered response.

## Dispose what the caller owns

An owned request and response should be disposed. The response can own a live body stream; disposing it releases that body and makes the underlying connection available for reuse or closure according to the handler. Do not dispose a request/content/stream before `SendAsync` has finished consuming it.

The reusable `HttpClient` lifetime is a separate concern from per-operation request/response ownership.

## What should be recallable

- When shortcuts are sufficient and when `HttpRequestMessage` is preferable.
- The difference between request `Content-Type` and response `Accept`, including `q` preferences.
- Why success validation should precede success-body deserialization.
- What an intermediate string costs and why a stream API alone does not prove live streaming.
- Why request/response disposal does not imply per-request `HttpClient` disposal.

## Related knowledge

- `dotnet.httpclient-request-content-and-representation`
- `dotnet.httpclient-response-streaming`
- `aspnet-core.json-patch-formatters-and-content-negotiation`

## Sources

- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R01R02-httpclient-testing-create-jsonpatch-base-usage.md`, R01/R02 base request, CRUD/JSON Patch, headers, response reading, and ownership material
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
