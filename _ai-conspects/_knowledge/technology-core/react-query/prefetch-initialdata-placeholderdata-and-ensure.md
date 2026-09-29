# React Query prefetch, initialData, placeholderData, and ensure APIs

Knowledge ID: `react-query.prefetch-initialdata-placeholderdata-and-ensure`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R07-prefetch-initialdata-placeholderdata-usequeryclient.md`


### R07-S001 / S-117 - `8160273b4d`

Metadata:

- status: `verified-visible-partial-from-embedded-svg-image`
- readability: `high`
- cut off: `yes-bottom-continuation-in-S-120`
- confidence: `high-for-visible-text`
- theme: Prefetching intro and beginning of link-hover example

#### Verified visible text

```text
16. Prefetching

Prefetching loads data into cache before the user navigates there.

A common case is link hover.
```

#### Verified visible code

```ts
import { useQueryClient } from '@tanstack/react-query'

function PostLink({ post }: { post: { path: string; title: string } }) {
  const queryClient = useQueryClient()
```

#### Notes

This screenshot is visibly cut off after `const queryClient = useQueryClient()`. The continuation is in S-120.

---

### R07-S002 / S-120 - `77905ae043`

Metadata:

- status: `verified-visible-continuation-from-embedded-svg-image`
- readability: `high`
- cut off: `yes-top-continuation-from-S-117`
- confidence: `high-for-visible-text`
- theme: Prefetching link-hover example continuation

#### Verified visible text

```text
Prefetching helps perceived performance, but it does not guarantee zero loading UI.
```

#### Verified visible code

```ts
return (
  <a
    href={`/posts/${post.path}`}
    onMouseEnter={() => {
      queryClient.prefetchQuery({
        queryKey: ['posts', post.path],
        queryFn: () => fetchPost(post.path),
        staleTime: 5000,
      })
    }}
  >
    {post.title}
  </a>
)
}
```

#### Notes

Continuation of S-117. Together S-117 and S-120 form the prefetch link-hover example.

---

### R07-S003 / S-131 - `436c717cfb`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: initialData vs placeholderData intro and initialData example

#### Verified visible text

```text
17. initialData vs placeholderData

These are very different.

17.1 initialData

Seeds the query with real starting data.

Useful when you already have related data in cache.
```

#### Verified visible code

```ts
function usePost(path: string) {
  const queryClient = useQueryClient()

  return useQuery({
    queryKey: ['posts', path],
    queryFn: () => fetchPost(path),
    initialData: () =>
      queryClient
        .getQueryData<{ path: string; title: string }[]>(['posts'])
        ?.find((post) => post.path === path),
  })
}
```

#### Notes

Verified from embedded SVG image.

---

### R07-S004 / S-132 - `3d2af35386`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: prefetch staleTime and second hover behavior

#### Verified visible text

```text
1) If user hovers, prefetch fires, does not click, then hovers again later

It depends on whether the prefetched cache entry is still considered fresh at the moment of the second hover.

In your screenshot:

that `staleTime: 5000` is used for the prefetch decision: if the cached data for that key is not invalidated and is not older than 5 seconds, `prefetchQuery` will just resolve without fetching again; otherwise it will fetch.
```

#### Verified visible code

```ts
queryClient.prefetchQuery({
  queryKey: ['posts', post.path],
  queryFn: () => fetchPost(post.path),
  staleTime: 5000,
})
```

#### Notes

Verified from embedded SVG image.

---

### R07-S005 / S-146 - `5ee5757310`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: prefetch staleTime summary

#### Verified visible text

```text
So:

- hover again within 5s -> usually no new request
- hover again after 5s -> prefetch will usually fetch again
- if the query was invalidated in between -> it can fetch again even before 5s, because invalidation marks it stale and overrides staleTime.
```

#### Notes

Visible source chip omitted from transcript body.

---

### R07-S006 / S-152 - `b67831fde6`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: initialData cache persistence and immediate refetch

#### Verified visible text

```text
Yes, `initialData` is written into that query's cache when the query is initialized - but a refetch may still happen immediately on mount, depending on freshness settings.

So the precise answer is:

- Yes: `initialData` becomes the cached data for that query key. It is persisted to the cache.
- No, not "without any refetch" by default: with the default `staleTime: 0`, that initial data is treated as stale, so the query will usually refetch immediately when it mounts.

Example:
```

#### Verified visible code

```ts
useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  initialData: initialTodos,
})
```

#### Notes

Visible source chips omitted from transcript body.

---

### R07-S007 / S-162 - `7ad643e947`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: prefetch staleTime vs useQuery staleTime

#### Verified visible text

```text
Yes. By default, the data will still be stale for `useQuery` unless you also give `useQuery` (or the client defaults for that query) a nonzero `staleTime`. The React prefetching guide states this explicitly: the `staleTime` you pass to `prefetchQuery` is only used for the prefetch, and you still need to set `staleTime` for the later `useQuery` call as well.

So in your scenario:
```

#### Verified visible code

```ts
await queryClient.prefetchQuery({
  queryKey: ['post', id],
  queryFn: fetchPost,
  staleTime: 10_000,
})
```

#### Notes

Visible source chip omitted from transcript body.

---

### R07-S008 / S-163 - `df3c1dacf6`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: initialData skipped when cache already exists

#### Verified visible text

```text
so if there is data in cache for that key, then initialdata will be skipped?

Думал на протяжении 5s >

Yes. If that query key already has cached data, `initialData` is skipped for that query instance - it does not overwrite existing cached data. The `useQuery` reference says `initialData` is used "as long as the query hasn't been created or cached yet," and the SSR guide says even fresher `initialData` will not overwrite data already in the cache.
```

#### Notes

Verified from embedded SVG image. Mixed Russian/English source text is preserved.

---

### R07-S009 / S-171 - `54c1e18a5f`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `top-context-cropped`
- confidence: `high-for-visible-text`
- theme: useQuery after prefetch reads cache then may refetch

#### Verified visible text

```text
then later:

what happens is:

- `useQuery` will read the prefetched data from cache immediately
- but because `useQuery`'s own `staleTime` defaults to `0`, that data is considered stale immediately
- so on mount, the query can refetch in the background under the normal rules for stale queries.
```

#### Verified visible code

```ts
useQuery({
  queryKey: ['post', id],
  queryFn: fetchPost,
})
```

#### Notes

Top context is cropped; visible text/code is transcribed.

---

### R07-S010 / S-172 - `4014246e26`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: placeholderData

#### Verified visible text

```text
17.2 placeholderData

Temporary UI data while the real query fetches.

Classic use case: pagination transitions.

This keeps the previous page visible while the next page loads.

Mental model

- `initialData` -> real initial cache value
- `placeholderData` -> temporary visual fallback while waiting
```

#### Verified visible code

```ts
useQuery({
  queryKey: ['repos', sort, page],
  queryFn: () => fetchRepos(sort, page),
  placeholderData: (previousData) => previousData,
})
```

#### Notes

Verified from embedded SVG image.

---

### R07-S011 / S-180 - `8930b327c7`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `bottom-slightly-cropped-after-code`
- confidence: `high-for-visible-text-and-code`
- theme: prefetch staleTime vs mounted useQuery staleTime distinction

#### Verified visible text

```text
The important distinction is:

- prefetch `staleTime` answers: "When I call `prefetchQuery`, should it fetch again or reuse cached data?"
- useQuery `staleTime` answers: "When this observer mounts, should this cached data be treated as fresh or stale?"

So if you want the mounted component to treat the prefetched data as fresh for 10 seconds too, do this:
```

#### Verified visible code

```ts
await queryClient.prefetchQuery({
  queryKey: ['post', id],
  queryFn: fetchPost,
  staleTime: 10_000,
})

const query = useQuery({
  queryKey: ['post', id],
  queryFn: fetchPost,
  staleTime: 10_000,
})
```

#### Notes

Bottom is slightly cropped after the code block; visible text/code is transcribed.

---

## Authoritative claim transcript: `R07-v005-prefetch-ensurequerydata-correction.md`


### S-189 - prefetch staleTime does not stamp future useQuery observer freshness

Metadata:
```text
source_id: S-189
image_use_id: IU-189
fileId_short: a4fc92617d
image_file: S-189__a4fc92617d.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Then:

- prefetch won't refetch again within 10s
- and the component's `useQuery` will also consider that cached data fresh for 10s.

A compact rule:

Prefetch `staleTime` does not “stamp” the future `useQuery` observer with freshness rules. It only affects the prefetch operation itself. The later observer still uses its own `staleTime` or the QueryClient defaults.
```

#### Notes

Readable R07 correction.

---

### S-195 - ensureQueryData revalidateIfStale returns cached data and refreshes in background

Metadata:
```text
source_id: S-195
image_use_id: IU-195
fileId_short: 4330f070b7
image_file: S-195__4330f070b7.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`revalidateIfStale` on `ensureQueryData`

This is what makes `ensureQueryData` closer to “return now, maybe refresh in background.”

Behavior:

- if cache exists, return cached data immediately
- if that cached data is stale, also refetch in the background

So it becomes:

“Give me whatever we have now, but refresh if it's outdated.”

That is different from `fetchQuery`, which would wait for the fresh fetch result if data is stale.
```

#### Verified visible code
```tsx
const data = await queryClient.ensureQueryData({
  queryKey: ['todo', id],
  queryFn: () => fetchTodo(id),
  revalidateIfStale: true,
})
```

#### Notes

Readable R07 correction.

---

## Stage 4i correction addendum - R07 v004

Generated: 2026-06-01 22:02:02 UTC

### Direction check

Goal: finish the audited correction for R07 under the no-image-loss boundary rules.
Now: R07 v003 covered prefetch/initialData/placeholderData/useQueryClient, but audit found the fetchQuery/ensureQueryData road continued.
This step: add `S-184` and `S-186`, and reserve the separate QueryClient/methods column for R08.
Why: these two screenshots are direct continuation of `S-180`; the QueryClient method column is a neighboring but separate area.

### 0.2 Coverage / boundary review update

Included in R07 v004:

```text
S-117, S-120, S-131, S-132, S-146, S-152, S-162, S-163, S-171, S-172, S-180, S-184, S-186
```

Added in v004:

```text
S-184 -> Fetch or ensure query data imperatively
S-186 -> Core difference: fetchQuery vs ensureQueryData
```

Checked but not forced into R07:

```text
S-124, S-138, S-144, S-154, S-164, S-173 -> likely R08 QueryClient/methods column.
```

### R07-S012 / S-184 - `39529d4e6d`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `same-road-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Fetch or ensure query data imperatively

#### Verified visible text

```text
5. Fetch or ensure query data imperatively

Useful outside normal `useQuery` flow.

`fetchQuery` fetches if needed and returns data or throws on error. `ensureQueryData` returns cached data if present, otherwise fetches it.
```

#### Verified visible code

```ts
const data = await queryClient.fetchQuery({
  queryKey: ['todo', id],
  queryFn: () => fetchTodo(id),
})

// or

const data = await queryClient.ensureQueryData({
  queryKey: ['todo', id],
  queryFn: () => fetchTodo(id),
})
```

### R07-S013 / S-186 - `30ab614e5c`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `same-road-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Core difference between fetchQuery and ensureQueryData

#### Verified visible text

```text
Core difference

`fetchQuery`

Uses freshness logic:

- fresh cache → return cache
- stale/missing cache → fetch

`ensureQueryData`

Uses existence logic:

- cache exists → return cache
- cache missing → fetch

By default, `ensureQueryData` does not care that cached data is stale. It only cares whether data exists. The docs say if the query exists in the cache, `ensureQueryData` will return it; if you want stale data to also be revalidated, use `revalidateIfStale: true`.
```

### R07 v004 interpretation update

`fetchQuery` is freshness-oriented; `ensureQueryData` is existence-oriented by default. This is part of the R07 imperative cache/query-client road, while the broader QueryClient methods column remains reserved for R08.

## What should be recallable

- How prefetch, ensureQueryData, initialData, and placeholderData differ.
- Which operations populate cache and which only shape observer output.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R07-prefetch-initialdata-placeholderdata-usequeryclient.md`, source-transcript section
- Authoritative processed source: `regions/R07-v005-prefetch-ensurequerydata-correction.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
