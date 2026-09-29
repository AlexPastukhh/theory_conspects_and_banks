# React Query pagination and infinite queries

Knowledge ID: `react-query.pagination-and-infinite-queries`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R05-pagination-infinitequery-keeppreviousdata-side-area.md`


### R05-S001 / S-080 - `0871bd898b`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `yes-bottom-cropped`
- confidence: `high-for-visible-text`
- theme: normal pagination with useQuery intro

#### Verified visible text

```text
1) Normal pagination with `useQuery`

For classic pagination like "page 1 / page 2 / page 3", the built-in pattern is:

- put the page number or cursor into the `queryKey`
- fetch that page in `queryFn`
```

#### Notes

Bottom continuation is cropped. Visible text is transcribed.

---

### R05-S002 / S-083 - `e3c0a532d3`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: docs pattern for paginated useQuery

#### Verified visible text

```text
Example from the docs pattern:

TanStack says paginated data "just works" by including the page info in the query key. Each page is treated as its own cached query entry.

Why this can feel awkward

If you do only that, moving from page 1 to page 2 means React Query sees a new query key, so the UI can bounce between success and pending states while the next page loads. The pagination guide calls this out directly.
```

#### Verified visible code

```ts
const { data } = useQuery({
  queryKey: ['projects', page],
  queryFn: () => fetchProjects(page),
})
```

#### Notes

Source chips omitted from transcript body.

---

### R05-S003 / S-085 - `bc3e0aa237`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: placeholderData keepPreviousData vs useTransition

#### Verified visible text

```text
Yes - you can still get re-renders with `placeholderData: keepPreviousData`. The key difference is:

- `placeholderData: keepPreviousData` is a TanStack Query data behavior: when the query key changes, React Query immediately gives the new query observer the previous result as placeholder data, so the UI keeps showing the old page while the new page fetches in the background. TanStack Query marks this state with `isPlaceholderData`. In v5, this is the replacement for the old `keepPreviousData` option.

- `useTransition` is a React scheduling behavior: it marks an update as non-blocking, lets React keep the current UI visible while preparing the next render, and gives you `isPending` for pending UI like a spinner.

So they solve related but different problems.
```

#### Notes

Verified from extracted SVG image.

---

### R05-S004 / S-093 - `c8cc88b3af`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: biggest difference between useTransition and keepPreviousData

#### Verified visible text

```text
The biggest difference

With `useTransition`, React is preserving the previous rendered tree while a transition is pending.
With `placeholderData: keepPreviousData`, TanStack Query is providing previous query data to the new query instance.

That means `useTransition` is more about:

- update priority
- keeping typing/clicking responsive
- avoiding janky synchronous renders
- showing a pending indicator with `isPending`

While `keepPreviousData` is more about:

- pagination/data fetching semantics
- avoiding "empty/loading/new data" flicker on query-key changes
- telling you explicitly that the shown data is stale placeholder data via `isPlaceholderData`
```

#### Notes

Verified from extracted SVG image.

---

### R05-S005 / S-094 - `975b593423`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `bottom-slightly-cropped-after-source-chip`
- confidence: `high-for-visible-text-and-code`
- theme: built-in fix with placeholderData keepPreviousData

#### Verified visible text

```text
Built-in fix for that

In v5, the docs recommend `placeholderData: keepPreviousData` for paginated queries so the previous page stays visible while the next page is loading, which avoids the jumpy UI.

Typical shape:

That is the built-in "lagged pagination" experience in v5.
```

#### Verified visible code

```ts
import { keepPreviousData, useQuery } from '@tanstack/react-query'

const { data, isPlaceholderData } = useQuery({
  queryKey: ['projects', page],
  queryFn: () => fetchProjects(page),
  placeholderData: keepPreviousData,
})
```

#### Notes

Bottom is slightly cropped after the final source chip; visible content is transcribed.

---

### R05-S006 / S-101 - `4c44fb1d2a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: why use both keepPreviousData and useTransition

#### Verified visible text

```text
Why use both?

Because sometimes you want both guarantees:

1. Keep previous data visible for the new query key
   That is Query's job.
2. Make the state update low priority so the UI stays responsive during expensive rendering
   That is React's job.

A good example is a paginated page where the next page:

- triggers a fetch
- also causes a heavy table/grid/chart subtree to render
- maybe recomputes filters/sorting/layout
- maybe suspends in some nested part

In that case:

- `keepPreviousData` keeps old rows on screen
- `useTransition` makes the page switch non-blocking and gives you `isPending` for UI polish
```

#### Notes

Verified from extracted SVG image.

---

### R05-S007 / S-106 - `fc61dcb8e6`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: infinite pagination with useInfiniteQuery

#### Verified visible text

```text
2) Infinite pagination with `useInfiniteQuery`

If you want:

- "Load more"
- infinite scroll
- cursor-based endless list

then the built-in API is `useInfiniteQuery`. It is specifically designed for this. The docs say infinite queries provide `data.pages`, `data.pageParams`, `fetchNextPage`, `fetchPreviousPage`, `hasNextPage`, and `hasPreviousPage`.
```

#### Notes

Verified from extracted SVG image.

---

### R05-S008 / S-108 - `728900c573`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: isPlaceholderData vs manual isPending

#### Verified visible text

```text
Why `isPlaceholderData` can be better than a manual `isPending`

Because it answers a more specific question:

- `isPending`: "React is currently processing a transition."
- `isPlaceholderData`: "The data currently shown belongs to the previous query result, not the final data for the current key."

That distinction matters.

For example, with pagination you may want to:

- disable "Next" while you are still showing previous data for the current page key
- dim the table only when the displayed rows are placeholder rows
- avoid double-advancing pages until real data lands

`isPlaceholderData` is tailor-made for that. `isPending` is broader and does not specifically mean "the data on screen is old query data."
```

#### Notes

Verified from extracted SVG image.

---

### R05-S009 / S-111 - `b643ae1bee`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: infinite query mental model

#### Verified visible text

```text
6) Full mental model

Think of it like this:

- `queryFn({ pageParam })` fetches one page
- returned page is pushed into `data.pages`
- used param is pushed into `data.pageParams`
- `getNextPageParam(...)` looks at the latest data and decides the next param
- if it returns a param, `hasNextPage` is true
- if it returns `undefined`/`null`, `hasNextPage` is false
```

#### Notes

Verified from extracted SVG image.

---

### R05-S010 / S-112 - `41cc77d4c3`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `stage4d-included-source`
- readability: `high`
- cut off: `bottom-slightly-cropped-after-source-chip`
- confidence: `high-for-visible-text-and-code`
- theme: useInfiniteQuery example shape

#### Verified visible text

```text
Example shape:

Important built-in pieces:

- `initialPageParam` is required in v5
- `getNextPageParam` tells React Query what the next cursor/page should be
- fetched pages are stored in `data.pages`
```

#### Verified visible code

```ts
const {
  data,
  fetchNextPage,
  hasNextPage,
  isFetchingNextPage,
} = useInfiniteQuery({
  queryKey: ['projects'],
  queryFn: ({ pageParam }) => fetchProjects(pageParam),
  initialPageParam: 0,
  getNextPageParam: (lastPage) => lastPage.nextCursor,
})
```

#### Notes

Bottom is slightly cropped after source chip; visible text/code is transcribed.

---

### R05-S011 / S-114 - `38adfee555`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `same-road-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: useInfiniteQuery data shape: pages and pageParams

#### Verified visible text

```text
`useInfiniteQuery` does not return one flat array. Its `data` shape is:
```

#### Verified visible code

```ts
{
  pages: [...],
  pageParams: [...],
}
```

#### Additional visible text

```text
- `pages` = array of each page result returned by your API
- `pageParams` = array of the page params React Query used to fetch those pages
```

#### Notes

Verified from extracted SVG image. Continues the R05 infinite-query road after S-111/S-112.

---

### R05-S012 / S-115 - `1f0e98522e`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `same-road-continuation`
- readability: `high`
- cut off: `bottom-cropped-code-continues`
- confidence: `high-for-visible-code`
- theme: 19.2 Load more button

#### Verified visible text

```text
19.2 Load more button
```

#### Verified visible code

```ts
function PostList() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = usePosts()

  const items = data?.pages.flatMap((page) => page.items) ?? []
```

#### Notes

Bottom is cropped after the visible `items` line; visible code is transcribed. Continues R05 infinite-query UI example.

---

### R05-S013 / S-116 - `69bfa97f82`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `same-road-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: flatten data.pages before rendering

#### Verified visible text

```text
So if your API returned 3 pages, `data.pages` might look like:

That is why the screenshot says to flatten before rendering:

Because usually your UI wants one flat list of items, while React Query stores the data grouped by page.
```

#### Verified visible code

```ts
[
  { items: [{ id: 1 }, { id: 2 }], nextCursor: 2 },
  { items: [{ id: 3 }, { id: 4 }], nextCursor: 4 },
  { items: [{ id: 5 }, { id: 6 }], nextCursor: null },
]

const items = data?.pages.flatMap((page) => page.items) ?? []
```

#### Notes

Verified from extracted SVG image.

---

## Authoritative claim transcript: `R05-v003-infinite-query-correction.md`


### S-118 - fetchNextPage button and flattened pages render

Metadata:
```text
source_id: S-118
image_use_id: IU-118
fileId_short: 5230e3ed40
image_file: S-118__5230e3ed40.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Visible code continues an infinite-query component render:

- render a list from `data.map((post) => ...)`;
- render a button;
- `onClick={() => fetchNextPage()}`;
- `disabled={!hasNextPage || isFetchingNextPage}`;
- button text uses `isFetchingNextPage ? 'Loading...' : 'More'`.

The core point is that the UI triggers `fetchNextPage()` and disables the button when there is no next page or a next page is already being fetched.
```

#### Verified visible code
```tsx
return (
  <div>
    {items.map((post) => (
      <div key={post.id}>{post.title}</div>
    ))}

    <button
      onClick={() => fetchNextPage()}
      disabled={!hasNextPage || isFetchingNextPage}
    >
      {isFetchingNextPage ? 'Loading...' : 'More'}
    </button>
  </div>
)
```

#### Notes

Continuation card; lower part visible enough for button/fetchNextPage logic.

---

### S-119 - useInfiniteQuery does not require special API response shape

Metadata:
```text
source_id: S-119
image_use_id: IU-119
fileId_short: 2ced60a702
image_file: S-119__2ced60a702.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
2) Does `useInfiniteQuery` expect a special API response shape?

No — not really.
```

#### Notes

Small card; fully readable.

---

### S-121 - infinite scroll with IntersectionObserver

Metadata:
```text
source_id: S-121
image_use_id: IU-121
fileId_short: 70259fd00d
image_file: S-121__70259fd00d.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
19.3 Infinite scroll with intersection observer
```

#### Verified visible code
```tsx
function InfinitePosts() {
  const {
    data,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
  } = usePosts()

  const loadMoreRef = React.useRef<HTMLDivElement | null>(null)

  React.useEffect(() => {
    const el = loadMoreRef.current
    if (!el) return

    const observer = new IntersectionObserver((entries) => {
      const first = entries[0]
      if (first.isIntersecting && hasNextPage && !isFetchingNextPage) {
        fetchNextPage()
      }
    })
```

#### Notes

Top/central code readable; continuation is S-137.

---

### S-122 - API response shape is arbitrary; lastPage is raw returned page

Metadata:
```text
source_id: S-122
image_use_id: IU-122
fileId_short: c74a0b5ca9
image_file: S-122__c74a0b5ca9.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
React Query does not require your API to return fields with special names like `nextCursor`, `items`, `data`, etc.

`lastPage` is just whatever your query function returned for that page.

So this is valid:

If `fetchUsers` returns:

then in `getNextPageParam`, `lastPage` will be:
```

#### Verified visible code
```tsx
queryFn: async ({ pageParam }) => {
  return fetchUsers(pageParam)
}

// if fetchUsers returns:
{
  results: [...],
  next: 42
}
```

#### Notes

Bottom continuation goes into S-136.

---

### S-136 - lastPage raw shape and choosing next page param

Metadata:
```text
source_id: S-136
image_use_id: IU-136
fileId_short: 90f673f1e8
image_file: S-136__90f673f1e8.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
then in `getNextPageParam`, `lastPage` will be:

You choose how to read it.

So yes:

- `lastPage` = raw page data from your API
- you decide how to compute the next page param from it
- then `fetchNextPage()` uses that computed next param for the next query call
```

#### Verified visible code
```tsx
{
  results: [...],
  next: 42
}
```

#### Notes

Continuation from S-122.

---

### S-137 - IntersectionObserver cleanup and flattened items render

Metadata:
```text
source_id: S-137
image_use_id: IU-137
fileId_short: cf6de009a3
image_file: S-137__cf6de009a3.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Continuation of the intersection-observer infinite-scroll example.
```

#### Verified visible code
```tsx
observer.observe(el)
return () => observer.disconnect()
}, [fetchNextPage, hasNextPage, isFetchingNextPage])

const items = data?.pages.flatMap((page) => page.items) ?? []

return (
  <>
    {items.map((post) => (
      <div key={post.id}>{post.title}</div>
    ))}
    <div ref={loadMoreRef} />
  </>
)
```

#### Notes

Continuation from S-121; visible enough for cleanup and render.

---

### S-148 - getNextPageParam signature in v5

Metadata:
```text
source_id: S-148
image_use_id: IU-148
fileId_short: ade73b8922
image_file: S-148__ade73b8922.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
3) How `getNextPageParam` works

In v5, its signature is:
```

#### Verified visible code
```tsx
getNextPageParam: (lastPage, allPages, lastPageParam, allPageParams) =>
  pageParam | undefined | null
```

#### Notes

Card readable.

---

### S-156 - getNextPageParam arguments and return values

Metadata:
```text
source_id: S-156
image_use_id: IU-156
fileId_short: 8f1063ec18
image_file: S-156__8f1063ec18.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Arguments:

- `lastPage` = the most recently fetched page data
- `allPages` = array of all fetched page data
- `lastPageParam` = the page param used for that last page
- `allPageParams` = array of all page params used so far

You return:

- the next page param to use
- or `undefined` / `null` if there is no next page

Example:

If your API returns:

then the next fetch will use `pageParam = 30`.
```

#### Verified visible code
```tsx
getNextPageParam: (lastPage) => lastPage.nextCursor ?? undefined

{
  items: [...],
  nextCursor: 30
}
```

#### Notes

Readable with visible example.

---

### S-166 - null nextCursor means no next page

Metadata:
```text
source_id: S-166
image_use_id: IU-166
fileId_short: 9b8c6d0493
image_file: S-166__9b8c6d0493.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
If your API returns:

then the next fetch will use `pageParam = 30`.

If later the API returns:

then `getNextPageParam` returns `undefined`, and React Query knows there is no next page.
```

#### Verified visible code
```tsx
{ items: [...], nextCursor: 30 }

{ items: [...], nextCursor: null }
```

#### Notes

Readable continuation of S-156.

---

### S-174 - how fetchNextPage uses current last page and getNextPageParam

Metadata:
```text
source_id: S-174
image_use_id: IU-174
fileId_short: cc89bc8d71
image_file: S-174__cc89bc8d71.png
status: verified-visible-partial-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
4) How `fetchNextPage()` uses it

Yes, exactly:

1. current last page is in `data.pages[data.pages.length - 1]`
2. React Query calls `getNextPageParam(...)`
3. if it gets a value back, that value becomes the next `pageParam`
4. `queryFn` runs again with that `pageParam` in its context
```

#### Notes

Lower edge is cropped, but numbered logic is readable.

---

### S-181 - typical useInfiniteQuery function

Metadata:
```text
source_id: S-181
image_use_id: IU-181
fileId_short: 37105501d1
image_file: S-181__37105501d1.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Typical query function:

Here:

- first fetch uses `initialPageParam: 0`
- next fetches use whatever `getNextPageParam` returns
```

#### Verified visible code
```tsx
const result = useInfiniteQuery({
  queryKey: ['projects'],
  queryFn: async ({ pageParam }) => {
    const res = await fetch(`/api/projects?cursor=${pageParam}`)
    return res.json()
  },
  initialPageParam: 0,
  getNextPageParam: (lastPage) => lastPage.nextCursor ?? undefined,
})
```

#### Notes

Readable code and notes.

---

### S-188 - hasNextPage source

Metadata:
```text
source_id: S-188
image_use_id: IU-188
fileId_short: a0d3c07634
image_file: S-188__a0d3c07634.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
5) How does it know whether there is a next page?

Through `getNextPageParam`.
```

#### Notes

Small card; fully readable.

---

### S-192 - hasNextPage true if getNextPageParam returns non-nullish

Metadata:
```text
source_id: S-192
image_use_id: IU-192
fileId_short: fc6e30d164
image_file: S-192__fc6e30d164.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
The docs say `hasNextPage` is true if `getNextPageParam` returns something other than `null` or `undefined`.

So:

means:

- if `lastPage.nextCursor` is `123` -> `hasNextPage === true`
- if `lastPage.nextCursor` is `undefined` or `null` -> `hasNextPage === false`

So React Query does not magically inspect your API response schema. It relies on your `getNextPageParam` return value to know both:

- what to fetch next
- whether a next page exists at all
```

#### Verified visible code
```tsx
getNextPageParam: (lastPage) => lastPage.nextCursor
```

#### Notes

Readable.

---

## What should be recallable

- How paginated and infinite query shapes differ.
- How getNextPageParam, hasNextPage, page flattening, and IntersectionObserver flow work.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R05-pagination-infinitequery-keeppreviousdata-side-area.md`, source-transcript section
- Authoritative processed source: `regions/R05-v003-infinite-query-correction.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
