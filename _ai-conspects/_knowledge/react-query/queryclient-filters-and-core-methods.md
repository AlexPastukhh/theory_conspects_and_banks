# QueryClient filters and core methods

Knowledge ID: `react-query.queryclient-filters-and-core-methods`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R08A-queryclient-queryfilters-core-methods.md`


### R08A-S001 / S-123 - `89aca4f37a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-core`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Main QueryFilters fields: queryKey prefix matching

#### Verified visible text

```text
Main QueryFilters fields

queryKey

Match queries by key prefix, unless `exact: true` is also set.

This matches:

- `['todos']`
- `['todos', 1]`
- `['todos', { page: 1 }]`

unless you require exact matching.
```

#### Verified visible code

```ts
queryClient.invalidateQueries({ queryKey: ['todos'] })
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S002 / S-124 - `4f1b873c49`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-intro`
- readability: `high`
- cut_off: `right-bottom-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: useQueryClient gives current QueryClient instance

#### Verified visible text

```text
`useQueryClient()` gives you the current `QueryClient` instance from React Query context. That instance is the central object that manages the query cache and lets you interact with queries imperatively.

What it is

Usually you use declarative hooks like:

But sometimes inside a component or custom hook you need to do something manually with the cache or queries. That is when you call:
```

#### Verified visible code

```ts
const query = useQuery(...)
const mutation = useMutation(...)
```

#### Notes

Bottom continuation after 'that is when you call:' is cropped; next related image S-138 gives the call.

---

### R08A-S003 / S-125 - `730d9b1236`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-methods-heading`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryClient methods: what they take and do

#### Verified visible text

```text
2) QueryClient methods: what they take and what they do

`useQueryClient()` gives you the current `QueryClient` from context. Outside React, you use the `QueryClient` instance directly.

Here's the practical map.
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S004 / S-138 - `01111ee2eb`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-intro-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: useQueryClient import and call

#### Verified visible text

```text
By default it returns the `QueryClient` from the nearest `QueryClientProvider`.
```

#### Verified visible code

```ts
import { useQueryClient } from '@tanstack/react-query'

const queryClient = useQueryClient()
```

#### Notes

Continuation of S-124.

---

### R08A-S005 / S-139 - `c3f45a9f79`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-exact`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryFilters exact matching

#### Verified visible text

```text
exact

Makes key matching exact instead of prefix-based.

This matches only:

- `['todos']`

and not:

- `['todos', 1]`
```

#### Verified visible code

```ts
queryClient.invalidateQueries({
  queryKey: ['todos'],
  exact: true,
})
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S006 / S-144 - `a6832a1bc1`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-usequeryclient-when-needed`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: When useQueryClient may be needed

#### Verified visible text

```text
When you may need it

You use `useQueryClient()` when you want to do something imperative, for example:

- mark some queries stale after a mutation
- manually update cached data
- read cached data synchronously
- prefetch data before navigation
- cancel an in-flight query
- remove/reset/refetch matching queries

This is why you often see it next to `useMutation`. After a successful mutation, you often invalidate or update related queries through the client. The TanStack quick start shows this exact pattern.
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S007 / S-151 - `3b50c6200c`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-type`
- readability: `high`
- cut_off: `slight-top-crop-title-visible`
- confidence: `high-for-visible-text`
- theme: QueryFilters type: active/inactive/all

#### Verified visible text

```text
type

Filters by whether a query is active or inactive.

Possible values:

- `active`
- `inactive`
- `all`

Meaning:

- active = has at least one observer/subscriber
- inactive = in cache but currently no active observers
- all = both

Example:

Only active queries will be matched.
```

#### Verified visible code

```ts
queryClient.refetchQueries({ type: 'active' })
```

#### Notes

Top is slightly cropped but title and text are readable.

---

### R08A-S008 / S-154 - `32c48060b8`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-method-invalidate`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: invalidateQueries

#### Verified visible text

```text
1. Invalidate queries

Use when the server data probably changed and you want related queries marked stale and usually refetched.

`invalidateQueries` marks matching queries stale and, by default, refetches active ones in the background.
```

#### Verified visible code

```ts
const queryClient = useQueryClient()

const mutation = useMutation({
  mutationFn: addTodo,
  onSuccess: () => {
    queryClient.invalidateQueries({ queryKey: ['todos'] })
  },
})
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S009 / S-158 - `d4dd4f4a1e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-read-cache-summary`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Read cache synchronously: getQueryData/getQueriesData/getQueryState

#### Verified visible text

```text
Read cache synchronously

`getQueryData(queryKey)`

Returns cached data for one query or `undefined`.

`getQueriesData(filters)`

Returns an array of tuples: `[queryKey, data]` for all matching queries. Takes `QueryFilters`.

`getQueryState(queryKey)`

Returns the full cached query state or `undefined`. Useful for `dataUpdatedAt`, status, etc.
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S010 / S-161 - `53f93b6919`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-stale`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryFilters stale

#### Verified visible text

```text
stale

Filter by staleness.

Matches only stale queries.
```

#### Verified visible code

```ts
queryClient.refetchQueries({ stale: true })
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S011 / S-164 - `f514209027`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-method-setquerydata`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: setQueryData update cache directly

#### Verified visible text

```text
2. Update cache directly with `setQueryData`

Use when you already know the new data and want the UI to update immediately.

or:

`setQueryData` is synchronous and should be done immutably. If the query doesn't exist, it will be created in the cache.
```

#### Verified visible code

```ts
queryClient.setQueryData(['todo', id], updatedTodo)

queryClient.setQueryData(['todos'], (old) =>
  old?.map((t) => (t.id === updatedTodo.id ? updatedTodo : t))
)
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S012 / S-168 - `2702832cda`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-fetchstatus`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryFilters fetchStatus

#### Verified visible text

```text
fetchStatus

Filter by current fetch status.

Possible values are based on query fetch status:

- `fetching`
- `paused`
- `idle`

Example:

Matches only queries currently fetching.
```

#### Verified visible code

```ts
queryClient.cancelQueries({ fetchStatus: 'fetching' })
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S013 / S-173 - `8840240941`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-read-prefetch`
- readability: `high`
- cut_off: `bottom-overlay-no-obvious-text-loss`
- confidence: `high-for-visible-text`
- theme: getQueryData and prefetchQuery

#### Verified visible text

```text
3. Read cached data with `getQueryData`

Use when you want to synchronously peek at what is already in cache.

If the query isn't in cache, it returns `undefined`.

4. Prefetch data

Use when you want data loaded before a screen renders.

This fetches and caches the query ahead of time but does not return the data to you.
```

#### Verified visible code

```ts
const todo = queryClient.getQueryData(['todo', id])

await queryClient.prefetchQuery({
  queryKey: ['todo', id],
  queryFn: () => fetchTodo(id),
})
```

#### Notes

Bottom UI overlay visible, but text is readable.

---

### R08A-S014 / S-177 - `3c56741074`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-predicate`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryFilters predicate

#### Verified visible text

```text
predicate

A custom function for final filtering.

This gives you the most flexibility when the built-in filters are not enough. The docs describe `predicate` as a final filter applied to each query; if no other filters are specified, it runs against all queries.
```

#### Verified visible code

```ts
queryClient.invalidateQueries({
  predicate: (query) => query.queryKey[0] === 'todos',
})
```

#### Notes

Verified from extracted SVG image.

---

### R08A-S015 / S-183 - `27e50ec60e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-important-idea`
- readability: `high`
- cut_off: `bottom-overlay-no-text-loss`
- confidence: `high`
- theme: Important idea: filters match queries, methods choose action

#### Verified visible text

```text
Important idea

These filters do not themselves say what action to take.

They only say which queries match.
```

#### Notes

Bottom UI overlay visible, no text loss.

---

### R08A-S016 / S-185 - `625ee2c8c4`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08a-queryfilters-pattern-reuse`
- readability: `high`
- cut_off: `bottom-overlay-no-obvious-text-loss`
- confidence: `high-for-visible-text`
- theme: Same filter object pattern reused across methods

#### Verified visible text

```text
For example:

means:

- first find matching queries using the filters
- then run invalidate on those matched queries

while:

means:

- find inactive `todos` queries
- then remove them

So the same filter object pattern is reused across many methods.
```

#### Verified visible code

```ts
queryClient.invalidateQueries({ queryKey: ['todos'], stale: true })

queryClient.removeQueries({ queryKey: ['todos'], type: 'inactive' })
```

#### Notes

Bottom UI overlay visible, but content is readable.

---

### R08A-S017 / S-206 - `8ef8d853c6`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08a-queryclient-remove-reset`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: removeQueries and resetQueries

#### Verified visible text

```text
8. Remove or reset queries

Useful if you want to clear cached entries or reset them.

These are also methods on `QueryClient`.
```

#### Verified visible code

```ts
queryClient.removeQueries({ queryKey: ['todos'] })
queryClient.resetQueries({ queryKey: ['todos'] })
```

#### Notes

Verified from extracted SVG image.

---

## What should be recallable

- How QueryFilters select cached queries.
- What the core QueryClient read, write, invalidate, and fetch methods do.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R08A-queryclient-queryfilters-core-methods.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
