# Browser EventSource client lifecycle

Knowledge ID: `javascript.eventsource-client-lifecycle`

Topic: `javascript`

## Opening and observing the connection

```js
const source = new EventSource("/events");

source.onopen = () => {
  // Connection is open.
};

source.onmessage = (event) => {
  // Unnamed SSE event.
  console.log(event.data);
};

source.onerror = () => {
  // The connection failed or was interrupted.
};
```

`new EventSource(url)` opens a long-lived HTTP connection for server-to-browser events. Its standard hooks are `onopen`, `onmessage`, and `onerror`.

`readyState` reports `CONNECTING`, `OPEN`, or `CLOSED`. `url` exposes the configured URL, and `withCredentials` describes whether the connection was configured to use credentials.

Credentials mode is selected in the constructor rather than changed later:

```js
const source = new EventSource("/events", { withCredentials: true });
```

Unnamed server events are delivered to `onmessage`. A named SSE event uses the server's `event:` field and is handled by its name:

```js
source.addEventListener("inventory-changed", (event) => {
  console.log(event.data);
});
```

Message and named-event callbacks receive a `MessageEvent`. Its useful fields are `data` (a string), `lastEventId`, `origin`, and `type`; repeated server `data:` lines appear joined with `\n`. Protocol fields do not create arbitrary properties on this object, so richer application fields normally travel as JSON inside `data`.

`open` and `error` callbacks normally receive a plain `Event`. In particular, browser EventSource errors do not reliably expose an HTTP status code or detailed failure reason. CORS failures, invalid SSE responses, and non-success responses can surface as `error`, and the browser may continue its automatic retry lifecycle rather than giving application code a detailed transport diagnosis.

## Unexpected disconnect and reconnect

When the connection drops unexpectedly, the browser normally:

```text
enters CONNECTING
-> waits for the current reconnect delay
-> opens the same URL again
```

Ordinary lifecycle handlers may run again during this process: interruption can raise `error`, and a successful replacement connection raises `open`.

The browser remembers the latest server `id:` and sends it as `Last-Event-ID` when reconnecting. The server can use that value to resume after the last delivered event rather than blindly starting over.

## Permanent client close

```js
source.close();
```

`close()` permanently closes that `EventSource` instance and disables its automatic reconnect. An unexpected transport failure and an explicit close therefore have different lifecycle outcomes.

## One-way channel boundary

EventSource is a server-to-client channel. The client chooses the URL and receives events, but it cannot send arbitrary application messages back over that same stream. Use a separate `fetch` request for client-to-server operations or WebSocket when the application requires a duplex message channel.

In a component lifecycle, create the `EventSource` in the effect, translate `open`/`error` into UI states such as connected/reconnecting, parse named `MessageEvent.data` deliberately, and call `close()` during cleanup or when the URL identity changes. Cookie credentials fit the browser API; arbitrary bearer headers are not available through the native constructor, so authentication design must account for that boundary.

## What should be recallable

- How to create an `EventSource` and use `onopen`, `onmessage`, `onerror`, and named-event listeners.
- What `readyState`, `url`, and `withCredentials` describe.
- Which fields a `MessageEvent` exposes and why custom application fields belong inside `data`.
- Why `error` is not a reliable HTTP-status diagnostics API.
- The browser's automatic reconnect lifecycle and repeated lifecycle callbacks.
- How remembered event IDs become `Last-Event-ID`, and why `close()` stops reconnection.
- Why EventSource is one-way and when fetch or WebSocket supplies the missing direction.

## Related knowledge

- `http.sse-event-stream-reconnection` defines the server fields, record framing, retry directive, and resume timeline consumed by this browser API.

## Sources

- Workspace: `_ai-conspects/event source browser/`
- Processed source: `regions/final-coverage-transcript.md`, R01–R02 and final model
- Original SVG: `source/event source browser.svg`
- Workspace: `_ai-conspects/event-source-browser/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v003.md`, S-001–S-003, S-006, S-008, S-011–S-013, S-016, S-019; `11-technical-corrections-v002.md`, corrections 1, 3–5, and 8
- Original SVG: `source/event source browser.svg`, SHA-256 `e2fe30a13873b066a835fcec4a9c48d2335b0f156d723845e95dfb6f4590dbd6`
- Workspace: `_ai-conspects/streaming/`
- Authoritative processed source: `regions/R05-sse-eventsource-writer-heartbeat-reconnect.md`, browser and React lifecycle sections
- Original SVG: `source/streaming.svg`
