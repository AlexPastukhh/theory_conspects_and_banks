# Channel<T> producer-consumer lifecycle

Knowledge ID: `dotnet.channels-producer-consumer-lifecycle`

Topic: `dotnet`

`Channel<T>` combines async queue storage, producer/consumer coordination, completion, and waiting. Unbounded channels can grow when producers outrun consumers; bounded channels apply capacity and `Wait`, `DropWrite`, `DropNewest`, or `DropOldest` full modes.

```csharp
await channel.Writer.WriteAsync(item);
await foreach (var item in channel.Reader.ReadAllAsync(ct))
    await ProcessAsync(item, ct);
```

`TryWrite`/`TryRead` return immediately. `WaitToReadAsync` followed by an inner `TryRead` loop waits once then drains available items; writers can similarly use `WaitToWriteAsync`. `TryComplete(exception)` stops future writes while buffered items remain readable; readers finish after draining and can observe error completion.

`SingleReader`/`SingleWriter` are binary access-pattern hints, not numeric limits. A channel stores queued items and coordinates asynchronous producers/consumers; `SemaphoreSlim` limits how many operations run. `BlockingCollection<T>` is the older blocking/thread-oriented producer-consumer primitive.

For WebSockets, many producers can enqueue messages while one send loop serializes socket writes:

```csharp
await foreach (
    var message in connection.Outgoing.Reader.ReadAllAsync(ct))
{
    await socket.SendAsync(
        message.Buffer,
        message.MessageType,
        message.EndOfMessage,
        ct);
}
```

One active send and one active receive may run concurrently on a WebSocket, but multiple concurrent sends or multiple concurrent receives are unsupported. Give one send loop ownership of the socket and let every producer enqueue outbound messages instead of calling `SendAsync` itself.

Capacity policy is part of the application protocol. `Wait` preserves every command through backpressure; dropping may be acceptable for replaceable telemetry or snapshots; coalescing can keep only the newest state; disconnecting a persistently slow client can be safer than unbounded growth. Do not silently apply a dropping mode to messages whose loss changes correctness.

The connection coordinator owns the full lifecycle: start receive/send loops, propagate cancellation, complete the outgoing writer so the sender can drain or finish, stop new producers, coordinate the close handshake, and await both loops. A bounded channel similarly supports hosted background queues while preventing unbounded memory growth.

## Sources

- Workspace: `_ai-conspects/channel/`
- Processed source: `FINAL_TRANSCRIPT.md`, integrated complete study transcript
- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, sections 10-11 and 19
- Original SVG: `source/websockets.svg`
