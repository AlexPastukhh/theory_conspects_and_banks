# Browser WebSocket lifecycle, backpressure, and reconnect

Knowledge ID: `javascript.websocket-client-lifecycle-backpressure-and-reconnect`

Topic: `javascript`

The browser `WebSocket` API exposes complete logical messages rather than individual transport fragments:

```javascript
const socket = new WebSocket("wss://api.example.com/ws", ["chat.v1"]);
socket.binaryType = "arraybuffer";

socket.onopen = () => {
  socket.send(JSON.stringify({ type: "hello" }));
};

socket.onmessage = event => {
  if (typeof event.data === "string") {
    handleJson(JSON.parse(event.data));
  } else if (event.data instanceof ArrayBuffer) {
    handleBinary(new Uint8Array(event.data));
  }
};

socket.onerror = event => {
  console.error("WebSocket transport error", event);
};

socket.onclose = event => {
  console.log(event.code, event.reason, event.wasClean);
};
```

Important properties include `readyState`, `protocol`, `extensions`, `binaryType`, `bufferedAmount`, and `url`. A transport state such as `OPEN` does not prove that the peer or application handler is healthy; protocols that need liveness can define a heartbeat or ping/ack.

## Local queue pressure

`bufferedAmount` reports bytes queued by the browser for transmission. It is not confirmation that the peer received or processed them. If it grows unchecked, memory and latency grow, replaceable UI updates become stale, and a recovered network can release a large burst.

Use high and low watermarks rather than a single threshold:

```text
above the high watermark
    pause, coalesce, or discard nonessential producers

below the low watermark
    resume those producers
```

Commands, telemetry, and replaceable state snapshots need different policies. Application message IDs and acknowledgements supply processing confirmation when local queue progress is insufficient.

## Reconnect is an application policy

A reconnect loop should combine exponential backoff, jitter, a maximum delay, cancellation on logout or unmount, one active attempt, and attempt-state reset after a stable connection. The close cause determines the decision:

```text
normal logout or deliberate stop -> do not reconnect
policy or authentication failure -> refresh credentials deliberately or stop
temporary network loss           -> retry
protocol mismatch                -> stop and surface the error
server restart                   -> retry with backoff
```

Guard obsolete component/effect lifetimes so they cannot create parallel sockets. Do not automatically replay a non-idempotent command after reconnect unless message IDs and deduplication make replay safe.

Useful client diagnostics include close code/reason, current `bufferedAmount`, reconnect attempt and delay, and application message ID/type. Do not log tokens, cookies, full query strings, or confidential payloads.

## Related knowledge

- `http.websocket-upgrade-subprotocols-and-application-contracts`
- `http.websocket-message-framing`
- `react.use-ref-lifecycle-and-latest-values`

## What should be recallable

- Which event payloads follow from text and `arraybuffer` binary messages?
- Why do `readyState` and `bufferedAmount` not prove application health or processing?
- How do high/low watermarks prevent a stop-start producer loop?
- Which close causes should retry, stop, or require deliberate credential handling?
- Why is automatic command replay unsafe without IDs and deduplication?

## Sources

- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, sections 5, 13, 17-18, 24-25
- Original SVG: `source/websockets.svg`

