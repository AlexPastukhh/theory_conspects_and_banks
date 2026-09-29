# HttpClient handler pipelines and transport configuration

Knowledge ID: `dotnet.httpclient-handler-pipelines-and-transport-configuration`

Topic: `dotnet`

## Pipeline order is nested middleware

The primary handler is the innermost transport. `DelegatingHandler` instances wrap it as outgoing middleware:

```csharp
services.AddTransient<CorrelationHandler>();
services.AddTransient<AuthHandler>();

services.AddHttpClient("api")
    .AddHttpMessageHandler<CorrelationHandler>()
    .AddHttpMessageHandler<AuthHandler>()
    .ConfigurePrimaryHttpMessageHandler(() =>
        new SocketsHttpHandler
        {
            PooledConnectionLifetime = TimeSpan.FromMinutes(5)
        });
```

Request processing travels from outer to inner; response processing unwinds from inner to outer. Order therefore changes which handler observes or wraps another handler's behavior.

Use delegating handlers for cross-cutting request/response logic. Configure the primary handler for transport-level ownership such as pools, proxies, cookies, credentials, decompression, redirects, and TLS.

## Defaults and per-request policy have different scope

`AddHttpClient` can configure base address, default headers, and a client-wide timeout. A per-operation deadline should use a cancellation token, commonly a linked source combining the caller/request-aborted token with `CancelAfter`.

When catching `OperationCanceledException`, filters can distinguish the caller token from the operation deadline. Do not translate every cancellation into a timeout; caller disconnect/shutdown and deadline expiry have different causes.

## What should be recallable

- Which handler is the primary transport and how delegating handlers nest around it.
- Why handler registration order affects both request and response paths.
- Which concerns belong in delegating handlers versus the primary handler.
- The difference between client-wide timeout defaults and per-operation cancellation.
- Why timeout and caller cancellation should not be collapsed into one outcome.

## Related knowledge

- `dotnet.httpclient-testing-with-message-handlers`
- `dotnet.httpclientfactory-client-and-handler-lifetimes`
- `dotnet.cancellation-tokens-linked-sources-and-causes`
- `dotnet.sockets-http-handler-connection-pooling-and-proxies`

## Sources

- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R06R07-config-primary-delegating-handlers-final.md`, complete transcript
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
