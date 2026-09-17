# React useRef lifecycle and latest values

Knowledge ID: `react.use-ref-lifecycle-and-latest-values`

Topic: `react`

`useRef` stores a stable mutable container across renders without causing a rerender. Use it for DOM nodes, imperative handles, timers, subscriptions, and latest-value escape hatches—not for state that must appear in rendered output.

When an object is created inside an effect but another callback must access it, store it in a ref and clear/close the same instance during cleanup:

```tsx
const socketRef = useRef<WebSocket | null>(null);

useEffect(() => {
  const socket = new WebSocket(url);
  socketRef.current = socket;
  return () => {
    socketRef.current = null;
    socket.close();
  };
}, [url]);

const sendJson = (value: unknown) => {
  const socket = socketRef.current;
  if (socket?.readyState !== WebSocket.OPEN) return;
  socket.send(JSON.stringify(value));
};
```

Existence of a socket does not mean it is ready to send; check `readyState === WebSocket.OPEN` before `send()`.

To let a stable subscription read the latest callback/value without resubscribing, update a ref and read `.current` when the event fires:

```tsx
const onMessageRef = useRef(onMessage);

useEffect(() => {
  onMessageRef.current = onMessage;
}, [onMessage]);

useEffect(() => {
  const socket = new WebSocket(url);
  const handleMessage = (event: MessageEvent) => {
    onMessageRef.current(event.data);
  };

  socket.addEventListener("message", handleMessage);
  return () => {
    socket.removeEventListener("message", handleMessage);
    socket.close();
  };
}, [url]);
```

Here subscription lifetime depends only on `url`, while the handler reads the latest `onMessage`. This is appropriate only when the callback should not define subscription identity. Reactive inputs that determine connection, query, or effect setup remain dependencies; refs must not be used to hide them from the dependency list.

Do not read or write refs during render except predictable initialization patterns. Effects run after commit, so an effect-created ref is initially null and consumers must tolerate that lifecycle.

Reconnect logic must also belong to the effect instance that created the socket. Cleanup should cancel that instance's timers/listeners and close that exact socket; delayed work from an obsolete effect must verify that it still owns the current connection before opening or publishing another one. This prevents a URL change or retry race from leaving parallel sockets alive.

## Sources
- Workspace: `_ai-conspects/useref, when need to have ref from obj created in useeffect + when need to access someting inside effect without incl into dep array/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, section 6
- Original SVG: `source/websockets.svg`
