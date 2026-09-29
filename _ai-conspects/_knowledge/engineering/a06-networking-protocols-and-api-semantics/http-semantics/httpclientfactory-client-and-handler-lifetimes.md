# HttpClientFactory client and handler lifetimes

Knowledge ID: `dotnet.httpclientfactory-client-and-handler-lifetimes`

Topic: `dotnet`

## Separate the facade from the connection owner

`HttpClient` is a facade over a handler pipeline. The primary `SocketsHttpHandler` owns connection pools and therefore most connection reuse and DNS behavior.

Creating and disposing a client together with a fresh handler for every request defeats pooling, repeats TCP/TLS setup, and can leave many sockets in `TIME_WAIT`. A single client/handler improves reuse, but connections in a never-refreshed pool can continue reaching old addresses after DNS changes.

`IHttpClientFactory` returns cheap client wrappers while pooling handlers. Disposing a factory-created client does not normally destroy its pooled handler immediately. The handler lifetime controls when a handler becomes eligible for replacement; the commonly shown default is about two minutes, not an application guarantee to hard-code.

## Handler rotation is not connection rotation

Replacing an expired pooled handler affects new clients and new work. It does not magically terminate every active long-lived connection. `HandlerLifetime` and `SocketsHttpHandler.PooledConnectionLifetime` address related but distinct refresh layers:

```text
HandlerLifetime
    -> rotation of factory-pooled handler instances

PooledConnectionLifetime
    -> maximum age used when selecting/reusing pooled connections
```

DNS health therefore depends on client, handler, and connection lifetimes together. Rotation is a refresh mechanism, not an instant guarantee that every request resolves DNS anew.

## What should be recallable

- Why per-request handler creation harms connection reuse and can cause socket pressure.
- Why one forever-lived pool can become stale after DNS changes.
- What the factory creates cheaply and what it pools.
- Why client disposal, handler expiry, and active-connection closure are different events.
- The distinction between handler lifetime and pooled-connection lifetime.

## Related knowledge

- `dotnet.sockets-http-handler-connection-pooling-and-proxies`
- `dotnet.httpclient-handler-pipelines-and-transport-configuration`

## Sources

- Workspace: `_ai-conspects/httpclient,summary,theory,base usage,jsonoptions wrapper,handlers/`
- Authoritative processed source: `regions/R05AB-httpclientfactory-lifetime-dns-named-typed-clients.md`, complete lifetime/DNS/factory material; `regions/R05AB-coverage-correction-leftover-network-sources.md`
- Original source identity: `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` (named by `00-source-check-and-boundary-review.md`; not tracked or resolvable from the current branch tree)
