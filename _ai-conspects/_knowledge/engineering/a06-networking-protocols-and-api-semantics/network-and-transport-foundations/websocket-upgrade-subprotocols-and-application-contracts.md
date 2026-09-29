# WebSocket upgrade, subprotocols, and application contracts

Knowledge ID: `http.websocket-upgrade-subprotocols-and-application-contracts`

Topic: `http`

A WebSocket starts as an HTTP upgrade request. Authentication, cookies, a query-string connection token, `Origin` validation, and subprotocol negotiation therefore belong to the handshake. After the upgrade succeeds, ordinary request/response semantics stop: later application messages do not carry HTTP headers, content types, or status codes.

Metadata needed after the upgrade belongs in an application envelope:

```json
{
  "type": "chat.send",
  "id": "c-123",
  "payload": {
    "text": "hello"
  }
}
```

The same logical fields can be encoded as JSON text, MessagePack, protobuf, or another agreed binary format. The transport does not infer the application's command names, correlation IDs, versions, payload schema, or acknowledgement meaning.

## Handshake headers and subprotocol selection

Handshake headers can include `Connection: Upgrade`, `Upgrade: websocket`, `Sec-WebSocket-Key`, `Sec-WebSocket-Version`, `Sec-WebSocket-Protocol`, `Origin`, and `Cookie`. Non-browser clients can often add custom request headers; the native browser `WebSocket` API does not expose a general arbitrary-header or `Authorization`-header mechanism. Those headers exist only during the upgrade.

A client can offer application subprotocols in preference order:

```javascript
const socket = new WebSocket(
  "wss://api.example.com/ws",
  ["chat.v2", "chat.v1"]
);
```

The server selects at most one offered value:

```csharp
var requested = context.WebSockets.WebSocketRequestedProtocols;

var selected = requested.Contains("chat.v2")
    ? "chat.v2"
    : requested.Contains("chat.v1")
        ? "chat.v1"
        : null;

if (selected is null)
{
    context.Response.StatusCode = StatusCodes.Status400BadRequest;
    return;
}

using var socket =
    await context.WebSockets.AcceptWebSocketAsync(selected);
```

After connection, inspect `socket.protocol` in the browser or `SubProtocol` in .NET. A missing or unexpected value is a protocol mismatch; do not silently guess how to decode messages.

## Delivery and processing acknowledgements

Transport progress and business completion are distinct:

```text
socket.send() returned
    the local client accepted bytes into its send queue

bufferedAmount decreased
    the browser transmitted more queued bytes

peer sent an acknowledgement with the same message ID
    application processing reached the protocol's declared acknowledgement point
```

For important operations, carry a message ID and return an acknowledgement that defines whether the command was merely received, validated, persisted, or fully processed. Automatic replay after reconnect is unsafe for non-idempotent commands unless the protocol also defines deduplication.

## Compression boundary

Per-message compression can save bandwidth at the cost of CPU, per-connection memory/state, interoperability complexity, and harder debugging. It can also create a side channel when secrets and attacker-controlled reflected input share a compression context. Enable it deliberately and avoid that mixture.

## What should be recallable

- Which concerns exist only during the HTTP upgrade and which metadata must move into an application envelope afterward?
- How are offered and selected WebSocket subprotocols related?
- Why is local send-queue acceptance different from an application acknowledgement?
- Which resource, interoperability, and secret-mixing tradeoffs accompany per-message compression?

## Sources

- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, sections 1, 14-16 and 18
- Original SVG: `source/websockets.svg`

