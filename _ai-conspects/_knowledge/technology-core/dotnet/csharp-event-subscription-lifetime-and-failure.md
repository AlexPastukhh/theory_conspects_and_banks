# C# event subscription lifetime, cancellation, and failure

Knowledge ID: `dotnet.csharp-event-subscription-lifetime-and-failure`

Topic: `dotnet`

## Subscription identity and retention

Subscribe with `+=` and unsubscribe with `-=`. A named handler is straightforward to remove. A syntactically identical new lambda is a different delegate instance, so retain the original when later removal matters:

```csharp
EventHandler handler = (_, _) => Refresh();
publisher.Changed += handler;

// Later, remove the same delegate instance.
publisher.Changed -= handler;
```

The publisher's invocation list creates a reference path to each subscriber. A long-lived publisher can keep a short-lived subscriber alive. Unsubscribe when lifetimes differ, especially for static events, singleton/background services, UI objects, or other long-lived publishers.

## Cooperative cancellable event

A custom event-arguments object can expose mutable `bool Cancel`. The publisher creates it, raises the event, then checks the flag before continuing; a subscriber sets it to `true`. This is cooperative same-process cancellation, not asynchronous `CancellationToken` cancellation.

## Multicast exceptions

Normal multicast invocation is sequential. If one handler throws, later handlers may not run, and the exception propagates to the raiser.

If the contract requires attempting every handler, enumerate the invocation list and isolate each failure:

```csharp
foreach (EventHandler handler in Changed?.GetInvocationList()
         ?? Array.Empty<Delegate>())
{
    try
    {
        handler(this, EventArgs.Empty);
    }
    catch (Exception error)
    {
        // Apply the documented per-handler failure policy.
    }
}
```

This deliberately changes ordinary event semantics and must be documented.

## Event versus delegate and delivery boundary

A delegate is a callable type. An event is a restricted delegate-like member: outside code can subscribe/unsubscribe but cannot normally invoke it or replace its invocation list. That restriction protects publisher ownership.

C# events suit simple same-process object notifications. They do not automatically supply transaction integration, persistence, retries, distributed delivery, or cross-service communication. Business/integration workflows may instead require a mediator, message queue, outbox/integration events, or another explicit delivery mechanism.

## What should be recallable

- Why unsubscription requires the same delegate instance and how event publishers retain subscribers.
- The lifecycle situations where unsubscription is important.
- How cancellable event arguments differ from `CancellationToken`.
- Sequential multicast failure behavior and the semantic change introduced by per-handler isolation.
- Event versus delegate access restrictions and when in-process events are insufficient.

## Sources

- Workspace: `_ai-conspects/events,delegaates,action/`
- Processed source: `01-final-transcript.md`, R02
- Original SVG: `source/events,delegaates,action.svg`
- Workspace: `_ai-conspects/events-delegaates-action/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v003.md`, S-016, S-019, S-021–S-022, S-024–S-026, S-030–S-033, S-035, S-039–S-040; `11-technical-corrections-v002.md`, correction 4
- Original SVG: `source/events,delegaates,action.svg`, SHA-256 `58fe05fdd4d608c36102140c4a25a6f8975bc5d914825d20ebc1aea90364778e`
