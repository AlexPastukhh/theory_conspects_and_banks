# React Query state, status, errors, and cache core

Knowledge ID: `react-query.query-state-status-error-and-cache-core`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R02A-usequery-state-status-error-cache-core.md`


### R02A-S001 / S-008 - `77eaf12c68`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-status-fetchstatus-core`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: status vs fetchStatus core distinction

#### Verified visible text
```text
5.2 `status`, `fetchStatus`, `isLoading`, `isFetching`

These are easy to mix up.

`status`

Represents data availability/result state:

- `'pending'`
- `'success'`
- `'error'`

`fetchStatus`

Represents whether a request is executing right now:

- `'fetching'`
- `'idle'`
- `'paused'`
```

#### Notes
Previously checked as not R01; now included in R02A statuses block.

---

### R02A-S002 / S-011 - `1d512b6a91`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-queryclient-core-setup`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Create one QueryClient outside render scope

#### Verified visible text
```text
2. Core setup

2.1 Create one `QueryClient`

The `QueryClient` must be created outside render scope, so the cache stays stable.

Correct:
```

#### Verified visible code
```tsx
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'

const queryClient = new QueryClient()

export default function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <Root />
    </QueryClientProvider>
  )
}
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S003 / S-012 - `6114875a76`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-isloading-specificity`
- readability: `high`
- cut off: `bottom-ui-dot-no-text-loss`
- confidence: `high`
- theme: isLoading is more specific than pending

#### Verified visible text
```text
`isLoading`

This is more specific than “pending”.

It means:

So this is possible:

That often happens with disabled queries.
```

#### Verified visible code
```tsx
status === 'pending' && fetchStatus === 'fetching'

status === 'pending'
fetchStatus === 'idle'
isLoading === false
```

#### Notes
Bottom UI dot is visible; text is readable.

---

### R02A-S004 / S-013 - `768ded59fc`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-status-mental-model-correction`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Example mental model for isPending and isFetching

#### Verified visible text
```text
Example mental model:

- First page load:
  - `isPending: true`
  - `isFetching: true`

- Data loaded and sitting on screen:
  - `isPending: false`
  - `isFetching: false`

- Background refetch after window focus / invalidation:
  - `isPending: false`
  - `isFetching: true`
```

#### Notes
Moved from R02B to R02A after local R02B review because it is a status/fetchStatus mental-model card, not enabled/disabled semantics.

---

### R02A-S005 / S-016 - `114f1fa612`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-queryclientprovider`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: QueryClientProvider gives the client to the component tree

#### Verified visible text
```text
2.2 `QueryClientProvider`

This provider makes the query client available to the component tree.

All components that should share the same cache must be wrapped by the same provider.

React Query uses context mainly for dependency injection of the client.
```

#### Verified visible code
```tsx
<QueryClientProvider client={queryClient}>
  <App />
</QueryClientProvider>
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S006 / S-017 - `d913b80242`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-query-cache-fundamentals`
- readability: `high`
- cut off: `right-edge-cropped-no-text-loss`
- confidence: `high`
- theme: Query cache identified by key

#### Verified visible text
```text
4. Query cache fundamentals

A query is identified by its key.

This means:

- `['pokemon', 1]` and `['pokemon', 2]` are different cache entries
- key design controls cache correctness
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['pokemon', id],
  queryFn: () => fetchPokemon(id),
})
```

#### Notes
Right edge is cropped, but no visible text appears lost.

---

### R02A-S007 / S-018 - `a3d61eaf9c`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-isfetching-and-pending-vs-loading`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: isFetching and isPending vs isLoading mental model

#### Verified visible text
```text
`isFetching`

Means a request is currently happening.

You can have data and still be fetching.

5.3 `isPending` vs `isLoading`

A useful mental model:

- `isPending`: no successful result yet for this query
- `isLoading`: first fetch is actively running
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S008 / S-020 - `bbc587153e`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-what-usequery-does`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: What useQuery does

#### Verified visible text
```text
3.2 What `useQuery` does

It:

- looks up data in the cache using `queryKey`
- runs `queryFn` if needed
- subscribes the component to changes
- rerenders when relevant query state/data changes
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S009 / S-021 - `61ff65ee41`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-two-query-rules`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Two core rules: queryKey identifies, queryFn returns Promise

#### Verified visible text
```text
4.1 Two rules you must remember

Rule 1 — `queryKey` must uniquely identify the resource

Rule 2 — `queryFn` must return a Promise
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S010 / S-022 - `2899e0756c`

Metadata:
- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r02a-isloading-formula`
- readability: `high`
- cut off: `top-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: isLoading formula in modern TanStack Query

#### Verified visible text
```text
`isLoading` in modern TanStack Query means:
```

#### Verified visible code
```tsx
isLoading = isPending && isFetching
```

#### Notes
Top continuation is cropped; visible formula is readable.

---

### R02A-S011 / S-023 - `03697f7b6d`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-isstale-isfetching-rich-ui`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: isStale and isFetching for richer UI

#### Verified visible text
```text
11. `isStale` and `isFetching`

These are useful for richer UI.
```

#### Verified visible code
```tsx
function Book({ bookId }: { bookId: string }) {
  const { data, isStale, isFetching, refetch } = useBook(bookId)

  return (
    <div>
      <h1>{data?.title}</h1>

      {isFetching && <small>Updating in background...</small>}
      {isStale && <button onClick={() => refetch()}>Refresh</button>}
    </div>
  )
}
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S012 / S-024 - `fe5b1db522`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-safe-rendering-correct`
- readability: `high`
- cut off: `left-edge-rounded-card-crop-no-text-loss`
- confidence: `high`
- theme: Safe rendering pattern with isPending/isError before data.map

#### Verified visible text
```text
Correct safe rendering pattern for media devices: check pending and error state before rendering `data.map(...)`.
```

#### Verified visible code
```tsx
function MediaDevices() {
  const { data, isPending, isError } = useQuery({
    queryKey: ['mediaDevices'],
    queryFn: () => navigator.mediaDevices.enumerateDevices(),
  })

  if (isPending) return <div>Loading...</div>
  if (isError) return <div>Unable to access devices</div>

  return (
    <ul>
      {data.map((device) => (
        <li key={device.deviceId}>{device.label}</li>
      ))}
    </ul>
  )
}
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S013 / S-025 - `c8b43511a0`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-safe-rendering-wrong`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Unsafe rendering when assuming data exists on first render

#### Verified visible text
```text
5.1 Safe rendering pattern

Never assume `data` exists on first render.

Wrong:

This can fail because `data` is initially `undefined`.
```

#### Verified visible code
```tsx
function MediaDevices() {
  const { data } = useQuery({
    queryKey: ['mediaDevices'],
    queryFn: () => navigator.mediaDevices.enumerateDevices(),
  })

  return (
    <ul>
      {data.map((device) => (
        <li key={device.deviceId}>{device.label}</li>
      ))}
    </ul>
  )
}
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S014 / S-030 - `39e62ae511`

Metadata:
- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r02a-query-data-stale-fetching-same-time`
- readability: `high`
- cut off: `top-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: A query can have data, be stale, and be fetching at the same time

#### Verified visible text
```text
A query can:

- have data
- be stale
- be fetching

all at the same time.
```

#### Notes
Top continuation is cropped; visible statement is complete.

---

### R02A-S015 / S-034 - `14368dd8ca`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02a-custom-hooks-for-queries`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Custom hooks for queries and throwing errors

#### Verified visible text
```text
6. Custom hooks for queries

Wrapping queries in custom hooks keeps components clean.
```

#### Verified visible code
```tsx
async function getBook() {
  const response = await fetch('/api/book')
  if (!response.ok) throw new Error('Unable to fetch book')
  return response.json()
}

function useBook() {
  return useQuery({
    queryKey: ['book'],
    queryFn: getBook,
  })
}
```

#### Notes
Verified from extracted SVG image.

---

### R02A-S016 / S-036 - `4d72a0bb65`

Metadata:
- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r02a-do-not-swallow-errors`
- readability: `high`
- cut off: `top-continuation-and-bottom-ui-overlay`
- confidence: `high-for-visible-text`
- theme: Do not swallow errors in queryFn

#### Verified visible text
```text
Throwing inside `async` is good. React Query sees that as a rejected promise.

7.2 Do not swallow errors

Bad

This hides real failures from React Query.
```

#### Verified visible code
```tsx
async function getData() {
  try {
    const res = await fetch('/api/data')
    return await res.json()
  } catch (error) {
    console.error(error)
    return []
  }
}
```

#### Notes
Top continuation and bottom UI overlay are visible; main warning and bad example are readable.

---

## What should be recallable

- How query status, fetch status, data, errors, and cache state relate.
- How cached data and observer state affect rendered query results.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R02A-usequery-state-status-error-cache-core.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
