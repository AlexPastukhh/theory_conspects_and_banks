# C# event declaration, payloads, and raiser pattern

Knowledge ID: `dotnet.csharp-event-declaration-and-raising`

Topic: `dotnet`

A C# event is a delegate-based publisher-to-subscriber notification mechanism. The publisher exposes the event, subscribers attach compatible handlers, and only the declaring type can normally raise it.

Use `EventHandler` when no custom payload is needed and `EventHandler<TEventArgs>` when the notification carries data:

```csharp
public sealed class OrderPlacedEventArgs : EventArgs
{
    public required int OrderId { get; init; }
    public required decimal Total { get; init; }
}

public event EventHandler? SomethingHappened;
public event EventHandler<OrderPlacedEventArgs>? OrderPlaced;
```

A custom delegate event is also possible but less common when the standard shapes fit. Invocation normally uses the null-conditional form:

```csharp
OrderPlaced?.Invoke(this, args);
```

The raiser should invoke a stable delegate reference, either through `?.Invoke` or the traditional local-copy pattern. This avoids the race in a separate null check followed by invocation of a reference that another thread could clear between those operations.

The sender is normally the publisher instance. The subscriber's handler must match the signature and reads domain values from the event arguments.

```csharp
static void HandleOrderPlaced(object? sender, OrderPlacedEventArgs e)
{
    Console.WriteLine($"Order ID: {e.OrderId}; total: {e.Total}");
}
```

Event names describe something that happened: `Saved`, `OrderPlaced`, `SomethingChanged`, `SomethingCompleted`, or `SomethingFailed`. The corresponding raiser convention is `On<EventName>`.

## Protected virtual raiser

```csharp
protected virtual void OnOrderPlaced(OrderPlacedEventArgs e)
    => OrderPlaced?.Invoke(this, e);
```

The public operation performs its work and calls the raiser. A derived class can override the raiser, add behavior, and optionally call the base implementation. This centralizes invocation and avoids scattering direct `Invoke` calls through the publisher.

## What should be recallable

- Publisher/subscriber ownership and why outside code cannot normally raise an event.
- When to use `EventHandler`, `EventHandler<TEventArgs>`, custom arguments, or a custom delegate.
- Sender, compatible handler signatures, event naming, and null-conditional invocation.
- Why `On<EventName>` is protected virtual and how derived classes participate.

## Sources

- Workspace: `_ai-conspects/events,delegaates,action/`
- Processed source: `01-final-transcript.md`, R01
- Original SVG: `source/events,delegaates,action.svg`
- Workspace: `_ai-conspects/events-delegaates-action/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v003.md`, S-001–S-014; `11-technical-corrections-v002.md`, corrections 1–3
- Original SVG: `source/events,delegaates,action.svg`, SHA-256 `58fe05fdd4d608c36102140c4a25a6f8975bc5d914825d20ebc1aea90364778e`
