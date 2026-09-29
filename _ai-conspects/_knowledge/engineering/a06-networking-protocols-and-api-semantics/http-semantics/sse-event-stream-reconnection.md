# SSE event framing, retry, and reconnection

Knowledge ID: `http.sse-event-stream-reconnection`

Topic: `http`

## Event-stream fields and framing

An SSE record can contain:

```text
event: custom event type
id: event identifier
data: payload line
retry: reconnect delay in milliseconds
```

A blank line terminates and dispatches one event. `data:` is repeatable: multiple data lines are joined into one payload with newline characters. `event:` selects the named browser event; without it, the event is delivered as the ordinary message event. `id:` supplies the event identifier remembered for resumption.

The standard fields do not define arbitrary application properties. Put richer data in `data:`, commonly as JSON:

```text
event: progress
id: 123
data: {"pct":42,"stage":"upload"}

```

## What `retry` controls

`retry:` updates the browser's delay for future reconnect attempts. It is not a sleep before each message, so normal streaming continues without that delay while the socket is healthy.

The server may send `retry` once near startup or change it dynamically—for example, increasing it during overload or unstable network conditions and reducing it after recovery.

The directive may be its own blank-line-terminated block (`retry: 5000\n\n`) or accompany `event`, `id`, and `data` fields. If the server never sends it, the browser chooses its own reconnect delay, which is not a portable cross-browser constant. A calmer delay can reduce reconnect storms after deployments, load-balancer/proxy timeouts, mobile-network interruptions, or simultaneous server overload.

## Server response lifecycle

The server must respond with `Content-Type: text/event-stream`, write correctly framed records, and flush periodically so buffered events become visible to the client:

```csharp
Response.ContentType = "text/event-stream";
await Response.WriteAsync("retry: 5000\n\n");
await Response.Body.FlushAsync();
```

A long-lived endpoint must also observe request cancellation/client disconnect and stop its production loop rather than continuing abandoned work.

Heartbeat comments such as `: ping\n\n` keep an otherwise idle stream active through some proxies without dispatching an application event. Resume is a server contract: read `Last-Event-ID`, replay persisted events after that ID in bounded batches, and only then enter the live loop. The browser remembering an ID is insufficient if the server cannot replay missed events.

If `data` contains embedded newlines, every logical line needs its own `data:` prefix. A helper writes optional `id`, `event`, and `retry`, prefixes each data line, terminates with a blank line, then flushes.

## Disconnect and recovery timeline

```text
server emits id/event/data/retry records
-> browser dispatches events while the connection is healthy
-> deploy, proxy timeout, or network interruption closes the socket
-> browser raises error and enters CONNECTING
-> browser waits approximately the current retry delay
-> browser reconnects to the same URL with Last-Event-ID
-> successful connection raises open
-> server resumes and may update retry again
```

`Last-Event-ID` is the browser's remembered most recent `id:` value. It gives the server the event identifier needed to resume after the last delivered event.

Explicit `EventSource.close()` is different from a failed socket: it permanently closes that client instance and prevents the reconnect sequence.

If a response is non-successful or is not a valid SSE stream, browsers generally surface `error` and may keep retrying. The browser event does not reliably reveal the HTTP status, so an appropriate `retry` delay can help avoid aggressive repeated attempts.

## What should be recallable

- The meanings of `event`, `id`, repeatable `data`, and `retry`, including blank-line framing.
- Why richer application fields are encoded inside `data`, commonly as JSON.
- Why `retry` affects only future reconnects and how the server can adjust it dynamically.
- The server's content type, flushing, and cancellation responsibilities.
- The complete healthy-stream → interruption → wait → `Last-Event-ID` → reopen timeline.
- The distinction between unexpected disconnection and explicit client closure.

## Related knowledge

- `javascript.eventsource-client-lifecycle` covers the browser object, lifecycle handlers, ready states, named listeners, and `close()` API.

## Sources

- Workspace: `_ai-conspects/event source browser/`
- Processed source: `regions/final-coverage-transcript.md`, R02–R04 and final model
- Original SVG: `source/event source browser.svg`
- Workspace: `_ai-conspects/event-source-browser/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v003.md`, S-003–S-007, S-009–S-010, S-014–S-020; `11-technical-corrections-v002.md`, corrections 2–7
- Original SVG: `source/event source browser.svg`, SHA-256 `e2fe30a13873b066a835fcec4a9c48d2335b0f156d723845e95dfb6f4590dbd6`
- Workspace: `_ai-conspects/streaming/`
- Authoritative processed source: `regions/R05-sse-eventsource-writer-heartbeat-reconnect.md`, sections 1-10
- Original SVG: `source/streaming.svg`
