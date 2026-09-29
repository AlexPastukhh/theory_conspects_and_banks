# WebSocket-driven React Query cache updates

Knowledge ID: `react-query.websocket-event-driven-cache-updates`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R13-websockets-event-driven-cache.md`


### S-276 - React Query core model for WebSocket-driven cache updates

Metadata:
```text
source_id: S-276
image_use_id: IU-276
fileId_short: 4f53d979bc
image_file: S-276__4f53d979bc.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
The core model

React Query is still centered on:

- query keys identifying cached server state
- manual cache actions telling the cache what changed

So with WebSockets, the usual pattern is:

1. open a WebSocket connection yourself
2. receive server events/messages
3. decide which query key(s) those messages affect
4. either:
   - invalidate those queries and let them refetch
   - or write directly into the cache with `setQueryData` / `setQueriesData`
```

#### Notes

Stage5b boundary correction: moved from R12 candidate group to R13 because it is WebSockets/on-demand strategy.

---

### S-285 - WebSockets / real-time updates strategies

Metadata:
```text
source_id: S-285
image_use_id: IU-285
fileId_short: 789db879bc
image_file: S-285__789db879bc.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
34. WebSockets / real-time updates

For real-time systems, you often do not want polling alone.

Two common strategies with WebSockets:

1. receive a message telling the client to refetch
2. receive the actual new data and write it directly into cache

34.1 Refetch strategy
```

#### Verified visible code
```tsx
socket.onmessage = () => {
  queryClient.invalidateQueries({ queryKey: ['todos', 'list'] })
}
```

#### Notes

Readable.

---

### S-293 - direct cache update strategy from WebSocket event

Metadata:
```text
source_id: S-293
image_use_id: IU-293
fileId_short: d4e1e182d3
image_file: S-293__d4e1e182d3.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
34.2 Direct cache update strategy
```

#### Verified visible code
```tsx
socket.onmessage = (event) => {
  const updatedTodo = JSON.parse(event.data)

  queryClient.setQueryData(['todos', 'list'], (previous) =>
    previous?.map((todo) =>
      todo.id === updatedTodo.id ? updatedTodo : todo
    ) ?? previous
  )
}
```

#### Notes

Readable.

---

### S-299 - on-demand app strategy with staleTime Infinity

Metadata:
```text
source_id: S-299
image_use_id: IU-299
fileId_short: 50585b9627
image_file: S-299__50585b9627.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
34.3 On-demand app strategy

If server pushes all important updates, one possible strategy is very long freshness.

Then rely on:

- invalidation from server messages
- direct cache updates from server messages

This is great for highly interactive real-time apps.
```

#### Verified visible code
```tsx
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: Infinity,
    },
  },
})
```

#### Notes

Readable.

---

### S-313 - why staleTime Infinity fits event-driven freshness

Metadata:
```text
source_id: S-313
image_use_id: IU-313
fileId_short: 38abff4a0e
image_file: S-313__38abff4a0e.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Why `staleTime: Infinity` fits this

Because freshness is no longer based on time.
Freshness is based on events.

So the app behaves like this:

- query loads once
- data stays “fresh”
- React Query does not keep rechecking automatically
- server events decide when cache should change

That is why it is called an on-demand strategy.
```

#### Notes

Readable.

---

### S-321 - normal refetch strategy vs on-demand strategy

Metadata:
```text
source_id: S-321
image_use_id: IU-321
fileId_short: 05e742e808
image_file: S-321__05e742e808.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Simple comparison

Normal strategy

“Data may be outdated after some time, so refetch automatically.”

On-demand strategy

“Data stays valid until the server explicitly tells me it changed.”
```

#### Notes

Stage5b boundary correction: moved from R12 candidate group to R13 because it belongs to event-driven freshness.

---

### S-328 - when on-demand WebSocket strategy is a good fit

Metadata:
```text
source_id: S-328
image_use_id: IU-328
fileId_short: f6f7e865e5
image_file: S-328__f6f7e865e5.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
When this strategy is a good fit

Use it when:

- server push exists, like WebSockets or SSE
- backend emits reliable update events
- real-time consistency matters
- you want to reduce unnecessary network traffic
```

#### Notes

Readable.

---

### S-333 - when staleTime Infinity push strategy is a bad fit

Metadata:
```text
source_id: S-333
image_use_id: IU-333
fileId_short: 98945a566a
image_file: S-333__98945a566a.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
When it is a bad fit

Avoid it when:

- you do not have reliable server push
- users can change data elsewhere and your client will not hear about it
- backend events are incomplete or delayed
- you still need time-based revalidation

In that case, `staleTime: Infinity` can make data stay wrong for too long.
```

#### Notes

Readable.

---

## What should be recallable

- How server events trigger invalidation or direct cache updates.
- How subscription lifecycle and event payload shape affect cache consistency.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R13-websockets-event-driven-cache.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
