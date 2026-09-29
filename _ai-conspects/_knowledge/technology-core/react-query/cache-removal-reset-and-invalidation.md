# React Query cache removal, reset, and invalidation

Knowledge ID: `react-query.cache-removal-reset-and-invalidation`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R09A-cache-remove-reset.md`


### S-211 - removeQueries deletes matching queries from cache

Metadata:
```text
source_id: S-211
image_use_id: IU-211
fileId_short: ed216f6b30
image_file: S-211__ed216f6b30.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`removeQueries` deletes matching queries from the cache. After that, the cached entry is just gone. It does not refetch, and it does not return anything.
```

#### Notes

Fully readable.

---

### S-213 - resetQueries resets query entry and can refetch active queries

Metadata:
```text
source_id: S-213
image_use_id: IU-213
fileId_short: 66a439f157
image_file: S-213__66a439f157.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`resetQueries` keeps the query entry but resets it back to its initial/pre-loaded state. It notifies subscribers, resets data to `initialData` if there was any, and if the query is active it will refetch. It returns a promise that resolves after active queries have been refetched.

A good mental model is:

- `removeQueries` = “forget this query ever existed”
- `resetQueries` = “put this query back to its starting state”

So if a component is mounted and using that query:

- after `resetQueries`, it stays subscribed to the query, sees the reset, and active queries refetch.
- after `removeQueries`, the cache entry is removed; there is no “reset and refetch” behavior described for it. The next time the query is needed, it will behave like a query with no cached entry.
```

#### Notes

Readable.

---

### S-223 - direct QueryCache API is advanced; high-level QueryClient methods usually enough

Metadata:
```text
source_id: S-223
image_use_id: IU-223
fileId_short: 4f209f3728
image_file: S-223__4f209f3728.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Usually you do not need it for normal app code, because higher-level methods like:

- `getQueryData`
- `setQueryData`
- `invalidateQueries`
- `removeQueries`

are easier and safer. Those are the normal API surface.

When you may need it:

Mostly advanced cases:

- inspecting all queries
- subscribing to cache-level changes
- building tooling
- custom debugging/instrumentation
- very custom integrations
```

#### Notes

Top continuation is cropped, but main list is readable.

---

### S-229 - queryClient.getQueryCache gives lower-level QueryCache object

Metadata:
```text
source_id: S-229
image_use_id: IU-229
fileId_short: 20e12516b1
image_file: S-229__20e12516b1.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example idea

Then you can work at the lower level with the cache object instead of only the higher-level `QueryClient` helpers.

Mental model:

- `QueryClient` = control panel
- `QueryCache` = actual storage for queries
```

#### Verified visible code
```tsx
const queryCache = queryClient.getQueryCache()
```

#### Notes

Readable.

---

## What should be recallable

- How remove, reset, clear, and invalidate operations differ.
- What happens to active observers and cached data under each operation.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R09A-cache-remove-reset.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
