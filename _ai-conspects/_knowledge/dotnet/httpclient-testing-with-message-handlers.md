# Testing HttpClient code with message handlers

Knowledge ID: `dotnet.httpclient-testing-with-message-handlers`

Topic: `dotnet`

## Test at the handler boundary

`HttpClient` sends through an `HttpMessageHandler`. Replacing that boundary lets a test exercise the real client wrapper, request construction, serialization, and response handling without opening a network connection.

```csharp
sealed class StubHandler : HttpMessageHandler
{
    public required Func<HttpRequestMessage, CancellationToken,
        Task<HttpResponseMessage>> Send { get; init; }

    protected override Task<HttpResponseMessage> SendAsync(
        HttpRequestMessage request, CancellationToken ct) => Send(request, ct);
}

var handler = new StubHandler
{
    Send = (request, _) =>
    {
        Assert.Equal(HttpMethod.Get, request.Method);
        Assert.Equal("application/json",
            request.Headers.Accept.Single().MediaType);

        return Task.FromResult(new HttpResponseMessage(HttpStatusCode.OK)
        {
            Content = JsonContent.Create(new MovieDto(1, "Arrival"))
        });
    }
};

using var client = new HttpClient(handler)
{
    BaseAddress = new Uri("https://example.test/")
};
```

The stub should inspect the observable request contract—method, URI, headers, and content—and return deliberate success, failure, malformed, delayed, or cancelled responses. This is more valuable than mocking every helper call inside the wrapper.

## DelegatingHandler is outgoing middleware

A `DelegatingHandler` wraps an inner handler. It can add authentication or correlation headers, log, cache, reject, or short-circuit a request; it does not necessarily touch the network.

```text
HttpClient
-> outer DelegatingHandler
-> inner DelegatingHandler
-> primary transport handler
-> network
```

Tests can terminate the chain with a stub primary handler and verify both pre-send behavior and the response path back through the wrappers.

## What should be recallable

- Why `HttpMessageHandler` is the stable network-test seam for `HttpClient`.
- Which request and response conditions a stub handler can verify.
- Why a `DelegatingHandler` is middleware rather than necessarily a transport.
- How a stub primary handler can test an entire outgoing handler chain.

## Related knowledge

- `dotnet.httpclient-handler-pipelines-and-transport-configuration`

## Sources

- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R01R02-httpclient-testing-create-jsonpatch-base-usage.md`, R01 testing/custom-handler material
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
