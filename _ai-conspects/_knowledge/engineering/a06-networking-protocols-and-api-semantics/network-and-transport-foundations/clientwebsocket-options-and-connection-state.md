# ClientWebSocket options and connection state

Knowledge ID: `dotnet.clientwebsocket-options-and-connection-state`

Topic: `dotnet`

Configure a `ClientWebSocket` before connecting, then coordinate one send loop and one receive loop for the connection lifetime:

```csharp
using var client = new ClientWebSocket();

client.Options.AddSubProtocol("chat.v1");
client.Options.SetRequestHeader("X-Correlation-Id", correlationId);
client.Options.KeepAliveInterval = TimeSpan.FromSeconds(20);

await client.ConnectAsync(uri, cancellationToken);

var sendTask = RunSendLoopAsync(client, cancellationToken);
var receiveTask = RunReceiveLoopAsync(client, cancellationToken);

await Task.WhenAll(sendTask, receiveTask);
```

Requested subprotocols, cookies/credentials, proxy behavior, non-browser custom handshake headers, client certificates, keep-alive behavior, HTTP upgrade version policy, response details where supported, and TLS certificate-validation hooks are connection options. A certificate callback that blindly returns `true` disables server identity validation and enables man-in-the-middle attacks; it is not a production shortcut.

Connection properties such as `State`, `SubProtocol`, `CloseStatus`, and `CloseStatusDescription` report transport and negotiation state. They do not establish application-level health. Treat a missing or unexpected `SubProtocol` as a protocol mismatch instead of guessing the payload format.

The per-instance concurrency boundary remains explicit:

```text
one active SendAsync
one active ReceiveAsync
send and receive may run concurrently
overlapping sends are unsafe
overlapping receives are unsafe
```

When many producers need to send, a single channel-backed sender owns `SendAsync`; producers enqueue messages instead of writing to the socket concurrently.

## Related knowledge

- `dotnet.channels-producer-consumer-lifecycle`
- `http.websocket-message-framing`
- `http.websocket-upgrade-subprotocols-and-application-contracts`

## What should be recallable

- Which options must be selected before `ConnectAsync`?
- Why is an always-successful TLS certificate callback dangerous?
- Which state properties describe transport state without proving application health?
- Which same-direction WebSocket operations may not overlap?

## Sources

- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, sections 10-15
- Original SVG: `source/websockets.svg`

