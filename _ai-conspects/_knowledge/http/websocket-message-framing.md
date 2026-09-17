# WebSocket message framing across server and browser APIs

Knowledge ID: `http.websocket-message-framing`

Topic: `http`

A WebSocket uses TCP underneath but exposes a message protocol, not an unrestricted application byte stream. Transport chunks and application messages are different boundaries.

On a .NET server, one logical message can require several `ReceiveAsync` calls. Accumulate the returned byte ranges and use `EndOfMessage` to recognize the final chunk. Do not treat each receive result as a complete application message.

Dispatch by `WebSocketMessageType`: text, binary, and close are different protocol cases. Enforce a maximum logical-message size while accumulating. Because a multibyte UTF-8 character can be split across receives, do not decode each fragment independently: either buffer the complete message and decode it after `EndOfMessage`, or incrementally use one stateful `Decoder` across all fragments. Binary messages remain bytes unless the application protocol defines another codec.

Buffering the complete message before decoding is not the only safe shape. Incremental text processing may instead keep one stateful `Decoder` for all fragments of one message, decode exactly `result.Count` bytes from each receive, pass `flush: result.EndOfMessage`, and dispatch the assembled text only after that boundary. Recreating or resetting the decoder per fragment loses a partial UTF-8 sequence. Close frames terminate normal receive processing, and cancellation must flow through the receive and conversion loops.

```csharp
static async Task<(WebSocketMessageType Type, byte[] Payload)?>
    ReceiveMessageAsync(WebSocket socket, CancellationToken ct)
{
    var buffer = new byte[8 * 1024];
    using var message = new MemoryStream();

    while (true)
    {
        var result = await socket.ReceiveAsync(buffer, ct);

        if (result.MessageType == WebSocketMessageType.Close)
            return null;

        message.Write(buffer, 0, result.Count);

        if (message.Length > MaximumMessageBytes)
            throw new InvalidDataException("WebSocket message is too large.");

        if (result.EndOfMessage)
            return (result.MessageType, message.ToArray());
    }
}
```

Sending has the same logical boundary. One `SendAsync(..., endOfMessage: true, ...)` emits a complete message; several sends with `endOfMessage: false` followed by one `true` deliberately fragment one logical message. Receivers must not infer application records from individual frames or receive-buffer fills.

In the browser, a `message` event normally delivers one complete message as a text string, `Blob`, or `ArrayBuffer`, depending on message type and `binaryType`. The browser API does not expose the server's individual receive chunks.

Connection termination has distinct strengths. `CloseAsync` participates in the closing handshake, `CloseOutputAsync` sends the local close output without waiting for the whole handshake to finish, and `Abort` tears down immediately. These lifecycle operations are separate from recognizing `EndOfMessage` while receiving application messages.

When a receive reports `Close`, stop normal message processing and coordinate the peer-close response rather than treating it as text or binary data. Common statuses include:

```text
1000  Normal Closure
1001  Endpoint Going Away
1002  Protocol Error
1003  Invalid/Unsupported Message Type
1008  Policy Violation
1009  Message Too Big
1011  Internal Server Error
```

Some codes are reserved and cannot be sent by applications; browser `close(code, reason)` accepts only valid application-facing ranges. A close reason is optional diagnostic UTF-8 text, not a place for secrets, and the control-frame limit leaves at most 123 UTF-8 bytes after the status code. A graceful peer handshake, a locally initiated close, cancellation, and an abrupt abort are distinct outcomes that the connection coordinator should record and clean up consistently.

If an application needs chunk-like progress, define it at the application protocol level: send smaller messages and include fields such as message type, sequence, or completion state. TCP packet boundaries are not a framing contract to reuse.

## What should be recallable

- Why is WebSocket not an arbitrary TCP byte-stream API?
- What does `EndOfMessage` mean in a server receive loop?
- Which value shapes can a browser `message` event deliver?
- How should an application represent incremental work when messages are otherwise complete units?

## Sources

- Workspace: `_ai-conspects/processing data as stream in dif situations, httpclient,endpoint,browser,websockets/`
- Authoritative processed source: `regions/full-svg-reconciliation-v002.md`, R06
- Original SVG: `source/source-complete-v002.svg`
- Workspace: `_ai-conspects/processing-data-as-stream-in-dif-situations-httpclient-endpoint-browser-websockets/`
- Authoritative processed source: `regions/PDS02-browser-fetch-websocket-utf8-decoding.md`, WebSocket framing and close behavior
- Source preservation: regional evidence and materialized source images recorded by the workspace coverage audit
- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, sections 2-4 and 8-9
- Original SVG: `source/websockets.svg`
- Workspace: `_ai-conspects/encoding, utf8, chunk processing/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, section 9
- Original SVG: source artifact verified by `CURRENT_SOURCE_OF_TRUTH.md` as Git blob `5763263be84e2e28658314edf49351c6b07ec35e`
