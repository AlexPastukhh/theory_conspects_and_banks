# SocketsHttpHandler response, upload, and TLS options

Knowledge ID: `dotnet.sockets-http-handler-response-upload-and-tls-options`

Topic: `dotnet`

`SocketsHttpHandler` exposes transport policy for redirect following, response decompression, large-body negotiation, and TLS. Each option owns a narrower phase than an overall request policy.

## Redirects and response decompression

`AllowAutoRedirect = false` leaves `301`, `302`, `307`, or `308` responses for application inspection. This is useful when code must preserve a signed redirect flow or validate the target before following it. Enable automatic following only when the client accepts the handler's redirect behavior, and bound chains with `MaxAutomaticRedirections` to prevent loops or unbounded redirects:

```csharp
new SocketsHttpHandler
{
    AllowAutoRedirect = true,
    MaxAutomaticRedirections = 10,
};
```

`AutomaticDecompression` decodes supported response content before application code consumes it:

```csharp
new SocketsHttpHandler
{
    AutomaticDecompression =
        DecompressionMethods.GZip |
        DecompressionMethods.Deflate,
};
```

This controls response decompression, not compression of an outgoing request body.

## `Expect: 100-continue` for rejectable uploads

A large upload can send headers first with `Expect: 100-continue`:

```text
send request headers
-> 100 Continue: send the body
-> 401 / 413 / another final response: do not send the body
-> no timely response: wait only the configured interval, then send the body
```

`Expect100ContinueTimeout` bounds that wait:

```csharp
new SocketsHttpHandler
{
    ConnectTimeout = TimeSpan.FromSeconds(5),
    Expect100ContinueTimeout = TimeSpan.FromSeconds(2),
};
```

It is most useful for large bodies that the server may reject before reading. It is neither the connection timeout nor the overall upload/request timeout, and small JSON requests may gain little from it.

## TLS policy belongs to the transport

`SslOptions` controls TLS concerns such as client certificates, protocol selection, and remote certificate validation:

```csharp
new SocketsHttpHandler
{
    SslOptions = new SslClientAuthenticationOptions
    {
        RemoteCertificateValidationCallback =
            (sender, certificate, chain, errors) =>
                errors == SslPolicyErrors.None,
    },
};
```

TLS settings are separate from destination authentication credentials. A callback that accepts every certificate disables validation and must not be used as a production shortcut.

## Browser WebSockets are a different client stack

The browser `WebSocket` constructor accepts a URL and optional subprotocols. Browser JavaScript cannot configure its connection through a .NET `SocketsHttpHandler`, install client certificates through that handler, or attach arbitrary handshake headers. Subprotocol negotiation uses the constructor and `Sec-WebSocket-Protocol` rather than .NET primary-handler options.

## Related knowledge

- `http.content-coding-direction-and-negotiation`
- `http.websocket-message-framing`

## What should be recallable

- Why might a client disable automatic redirect following?
- Which option bounds an automatically followed redirect chain?
- Which direction does `AutomaticDecompression` affect?
- What response states determine whether a `100-continue` client sends the body?
- Which wait does `Expect100ContinueTimeout` bound?
- Why is an always-successful certificate callback unsafe?
- Why can browser WebSockets not be configured through this .NET handler?

## Sources

- Workspace: `_ai-conspects/primary httphandler optoins, socket/`
- Authoritative processed source: `regions/R01R02R03R04R05-primary-httphandler-options-socket-corrected-final-v002.md`, sections 2, 8, 9, 11, the large-upload configuration in section 12, and related checklist claims
- Original SVG: `source/primary httphandler optoins, socket.svg`
