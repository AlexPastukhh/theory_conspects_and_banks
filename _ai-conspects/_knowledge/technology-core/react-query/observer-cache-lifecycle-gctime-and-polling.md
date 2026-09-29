# React Query observer lifecycle, gcTime, and polling

Knowledge ID: `react-query.observer-cache-lifecycle-gctime-and-polling`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R04B-observer-cache-lifecycle-gctime-refetchinterval.md`


### R04B-S001 / S-069 - `33b49582ee`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-active-inactive-gctime`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Active vs inactive queries and gcTime eligibility

#### Verified visible text
```text
10. Active vs inactive queries

A query with at least one mounted observer is active.

A query with no observers is inactive.

When components mount/unmount, observer count changes.

Inactive queries are eligible for garbage collection after `gcTime`.
```

#### Notes
Moved from R04A to R04B during local R04A review because it is active/inactive query + gcTime lifecycle.

---

### R04B-S002 / S-072 - `852ba9b003`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-observer-result-flow`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Query state change -> observer result -> rerender if tracked/allowed prop changed

#### Verified visible text
```text
So the flow is basically:

`cache/query state changes -> observer recomputes result -> TanStack Query checks tracked/allowed props -> React rerenders if one of those changed`

That state change can come from:

- `setQueryData`
- a successful refetch
- fetch status changing (`isFetching` false -> true -> false)
- error/status changes
- staleness changes, if your component uses `isStale`
```

#### Notes
Verified from R04B source image.

---

### R04B-S003 / S-078 - `6185671034`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-not-every-cache-update-rerenders`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Not every cache update causes every subscriber to rerender

#### Verified visible text
```text
A couple of important nuances:

- Not every cache update causes every subscriber to rerender. TanStack Query tracks which properties were actually used via a Proxy, and “will only trigger a re-render if one of the properties returned from useQuery is actually used.”
- Data changes can also be optimized away. With structural sharing, unchanged parts keep their references, and if nothing effectively changed, `data` can stay referentially stable.
- You can override the default tracking behavior with `notifyOnChangeProps`; if set, the component rerenders only when one of those listed properties changes.

So your sentence:

“observer notifies react that rerender is needed?”
```

#### Notes
Verified from R04B source image.

---

### R04B-S004 / S-081 - `508013e6b9`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04b-structural-sharing-old-data`
- readability: `high`
- cut_off: `bottom-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: Structural sharing reuses references from previous data

#### Verified visible text
```text
Structural sharing means:

when TanStack Query gets new query data, it tries to reuse references from the previous data for every part that did not actually change, instead of replacing the whole object tree with brand-new references.

Simple example

Suppose old cached data is:
```

#### Verified visible code
```tsx
oldData = {
  user: { id: 1, name: "Ann" },
  todos: [
    { id: 1, text: "A" },
    { id: 2, text: "B" }
  ]
}
```

#### Notes
Bottom continuation is cropped; next structural-sharing examples continue in S-092 and S-100.

---

### R04B-S005 / S-086 - `3f38cd3ee4`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-observer-notification-example`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Observer notices state change and schedules notification for changed tracked prop

#### Verified visible text
```text
More precisely:

- the observer notices query state changed
- it computes a new result for that hook
- if a tracked result property changed, it schedules notification
- then React rerenders that component

Example:

Then:

- `setQueryData` with new `data` -> rerender
- background refetch starts, `isFetching: false -> true` -> rerender
- refetch finishes, `isFetching: true -> false` -> rerender
- if fetched data is identical after structural sharing, you may still rerender because `isFetching` changed, even if `data` did not meaningfully change
```

#### Verified visible code
```tsx
const { data, isFetching } = useQuery(...)
```

#### Notes
Verified from R04B source image.

---

### R04B-S006 / S-089 - `ee98c678db`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-gctime`
- readability: `high`
- cut_off: `top-border-crop-no-text-loss`
- confidence: `high`
- theme: gcTime controls how long inactive queries stay in cache

#### Verified visible text
```text
9.4 `gcTime` (garbage collection time)

Controls how long inactive queries stay in cache before being removed.

An inactive query = query with 0 observers.

Example:

Key difference:

- `staleTime` = freshness
- `gcTime` = how long inactive cache is retained

Fresh data can still be removed if it becomes inactive long enough.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['issues', search],
  queryFn: () => fetchIssues(search),
  gcTime: 3000,
})
```

#### Notes
Verified from R04B source image.

---

### R04B-S007 / S-092 - `db432e0178`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04b-structural-sharing-new-data`
- readability: `high`
- cut_off: `top-continuation-cropped`
- confidence: `high-for-visible-code`
- theme: New server response example for structural sharing

#### Verified visible text
```text
New server response is logically:
```

#### Verified visible code
```tsx
newData = {
  user: { id: 1, name: "Ann" },
  todos: [
    { id: 1, text: "A" },
    { id: 2, text: "B updated" }
  ]
}
```

#### Notes
Continuation of S-081 structural sharing example.

---

### R04B-S008 / S-096 - `d076db1a35`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04b-only-data-read-no-isfetching-rerender`
- readability: `high`
- cut_off: `top-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: If component only reads data, isFetching changes usually do not rerender it

#### Verified visible text
```text
But if your component only reads:

then a change only to `isFetching` usually won't rerender that component, because `isFetching` was not used.
```

#### Verified visible code
```tsx
const { data } = useQuery(...)
```

#### Notes
Continuation of observer tracked-props example.

---

### R04B-S009 / S-100 - `873cf4d11f`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-structural-sharing-result`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Structural sharing result keeps unchanged references

#### Verified visible text
```text
With structural sharing, TanStack Query will try to produce something like:

So:

- unchanged parts keep the same identity
- changed parts get new references
```

#### Verified visible code
```tsx
result = {
  user: oldData.user,                 // same reference reused
  todos: [
    oldData.todos[0],                 // same reference reused
    { id: 2, text: "B updated" }      // new reference only for changed part
  ]
}
```

#### Notes
Verified from R04B source image.

---

### R04B-S010 / S-102 - `03697f7b6d`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-isstale-isfetching-ui`
- readability: `high`
- cut_off: `no`
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
This source image duplicates a code card already seen near R02A/R02C, but in R04B it supports observer/richer UI state usage.

---

### R04B-S011 / S-105 - `dc0361e533`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-why-structural-sharing-useful`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Why structural sharing is useful

#### Verified visible text
```text
Why this is useful

This helps avoid unnecessary rerenders and makes memoization work better:

- if data didn't actually change, the top-level reference can stay the same
- if only part changed, only that part gets replaced
- `useMemo`, `useCallback`, and child props comparisons behave better because stable parts stay stable
```

#### Notes
Verified from R04B source image.

---

### R04B-S012 / S-107 - `180be1e245`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04b-refetchinterval-polling`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Polling with refetchInterval

#### Verified visible text
```text
13. Polling with `refetchInterval`

Use polling when data changes often and you want the cache kept updated.

If another normal refetch happens before the timer fires, the timer resets.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['repos', sort],
  queryFn: () => fetchRepos(sort),
  refetchInterval: 5000,
})
```

#### Notes
Verified from R04B source image.

---

## Authoritative claim transcript: `R04B-v002-functional-refetchinterval-correction.md`


### S-113 - functional refetchInterval stops polling when condition met

Metadata:
```text
source_id: S-113
image_use_id: IU-113
fileId_short: 2bc6c3c458
image_file: S-113__2bc6c3c458.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
13.1 Functional `refetchInterval`

You can stop polling when a condition is met.

Return:

- number → keep polling
- `false` → stop polling
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['totalAmount'],
  queryFn: fetchTotalAmount,
  refetchInterval: (query) => {
    return query.state.data?.finished ? false : 3000
  },
})
```

#### Notes

Readable correction card; belongs to R04B polling/refetchInterval.

---

## What should be recallable

- How observers, inactivity, gcTime, and cache removal relate.
- How functional refetchInterval can stop polling.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R04B-observer-cache-lifecycle-gctime-refetchinterval.md`, source-transcript section
- Authoritative processed source: `regions/R04B-v002-functional-refetchinterval-correction.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
