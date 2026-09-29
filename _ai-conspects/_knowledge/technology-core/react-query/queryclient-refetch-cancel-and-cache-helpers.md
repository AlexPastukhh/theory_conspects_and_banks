# QueryClient refetch, cancellation, and cache helpers

Knowledge ID: `react-query.queryclient-refetch-cancel-and-cache-helpers`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R08B-refetch-cancel-options-cache-helpers.md`


### R08B-S001 / S-129 - `fc2d174df6`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-getqueriesdata-example`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: getQueriesData example: read all matching todos queries

#### Verified visible text

```text
`getQueriesData` example

Imagine you have these queries in cache:

You can read all cached `todos` queries like this:
```

#### Verified visible code

```ts
['todos']
['todos', { status: 'done' }]
['todos', { status: 'open' }]
['users']

const entries = queryClient.getQueriesData({ queryKey: ['todos'] })

console.log(entries)
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S002 / S-134 - `30bdec4695`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-fetch-prefetch`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: fetchQuery options and behavior

#### Verified visible text

```text
Fetch / prefetch

`fetchQuery(options)`

Imperatively fetches and caches one query; resolves with data or throws on error. If cache data is still fresh enough for the passed `staleTime`, it returns cached data instead of fetching. Its options are the same as `useQuery` options except options that are observer-only, such as `enabled`, refetch-on-focus/mount/reconnect, `refetchInterval`, `notifyOnChangeProps`, `select`, `placeholderData`, `suspense`, and `throwOnError`.

Typical args:

- `queryKey`
- `queryFn`
- optional fetch/query options like `staleTime`, `gcTime`, `retry`, `networkMode`, `meta` etc. via query options support.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S003 / S-143 - `81cc0883ba`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-getqueriesdata-output`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: getQueriesData returns tuples

#### Verified visible text

```text
You get an array of tuples:

That is exactly what the docs describe: an array of `[queryKey, data]` tuples for all matching queries, or `[]` if none match.
```

#### Verified visible code

```ts
[
  [['todos'], allTodos],
  [['todos', { status: 'done' }], doneTodos],
  [['todos', { status: 'open' }], openTodos],
]
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S004 / S-147 - `8578a757ff`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-fetch-prefetch-ensure-family`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: fetchInfiniteQuery, prefetchQuery, ensureQueryData family

#### Verified visible text

```text
`fetchInfiniteQuery(options)`

Same idea for infinite queries; returns `InfiniteData`. Same options shape as `fetchQuery`.

`prefetchQuery(options)`

Same options as `fetchQuery`, but returns `Promise<void>`, does not return data, and does not throw. Good for hover/router preloading.

`prefetchInfiniteQuery(options)`

Infinite-query version of `prefetchQuery`. For prefetching more than one page, the prefetch guide shows `pages` plus `getNextPageParam`.

`ensureQueryData(options & { revalidateIfStale?: boolean })`

Returns cached data if present; otherwise fetches it. `revalidateIfStale: true` means return stale cached data immediately and refetch in background.

`ensureInfiniteQueryData(options & { revalidateIfStale?: boolean })`

Same idea for infinite queries.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S005 / S-153 - `b9490025be`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-setqueriesdata-example`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: setQueriesData example: update all existing todos lists

#### Verified visible text

```text
`setQueriesData` example

Say a todo was edited, and you want to update every cached todos list that already exists:

This will update all existing queries whose key matches `['todos']`, such as:

- `['todos']`
- `['todos', { status: 'done' }]`
- `['todos', { status: 'open' }]`

but it will not create any missing queries in cache. The docs explicitly call out that `setQueriesData` only updates existing matching queries and calls `setQueryData` under the hood for each one.
```

#### Verified visible code

```ts
const updatedTodo = { id: 5, title: 'New title', completed: true }

queryClient.setQueriesData(
  { queryKey: ['todos'] },
  (oldData: { id: number; title: string; completed: boolean }[] | undefined) =>
    oldData?.map((todo) =>
      todo.id === updatedTodo.id ? { ...todo, ...updatedTodo } : todo
    )
)
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S006 / S-167 - `4fc2178dca`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-write-cache-synchronously`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: setQueryData and setQueriesData write cache synchronously

#### Verified visible text

```text
Write cache synchronously

`setQueryData(queryKey, updaterOrValue)`

Immediately updates one query's cached data. Creates the query if it doesn't exist. Updater can be:

- a value
- or `(oldData) => newData`

If the value/updater returns `undefined`, no update happens. Updates must be immutable.

`setQueriesData(filters, updater)`

Updates multiple existing matching queries. Takes `QueryFilters` plus the same updater style as `setQueryData`. It does not create new cache entries.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S007 / S-169 - `4a083521f3`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08b-invalidate-refetchtype`
- readability: `high`
- cut_off: `bottom-start-of-example-cropped`
- confidence: `high-for-visible-text`
- theme: refetchType in invalidateQueries

#### Verified visible text

```text
`refetchType` in `invalidateQueries` answers which matched queries should be refetched now, not which queries should be invalidated. The invalidation target is controlled by the filters you pass, like `queryKey`, `exact`, `predicate`, etc. `refetchType` only changes what happens after those queries are matched.

So think of it like this:

- filters = which queries are selected
- refetchType = among those selected queries, which ones should refetch immediately

When you call `invalidateQueries`, TanStack Query first marks the matched queries as stale. Then, depending on `refetchType`, it may refetch some or all of them. By default, matched active queries are refetched in the background.

The `refetchType` values are:

- `active`: refetch only matched queries that are currently active/rendered. This is the default.
- `inactive`: refetch only matched queries that are currently inactive.
- `all`: refetch both active and inactive matched queries.
- `none`: do not refetch immediately; just mark matched queries as stale.
```

#### Notes

Bottom shows the start of an Example section, but no example content is visible.

---

### R08B-S008 / S-175 - `71e000a8c4`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-invalidatequeries-signature`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: invalidateQueries filters and refetchType

#### Verified visible text

```text
Mark stale / refetch / cancel / clear

`invalidateQueries(filters?, options?)`

Marks matching queries stale and, by default, refetches active matching queries in the background.

Important filter arg:

- `queryKey`
- `refetchType?: 'active' | 'inactive' | 'all' | 'none'`
- plus other `QueryFilters` matching fields like `exact`, `type`, `stale`, `predicate` via Query Filters support.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S009 / S-178 - `511b7bdef1`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-type-vs-refetchtype`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: type filter versus refetchType

#### Verified visible text

```text
A common source of confusion is the `type` filter versus `refetchType`:

Here:

- `type: 'inactive'` means only inactive queries are matched
- `refetchType: 'all'` means refetch all matched queries
- but since the matched set is already only inactive queries, only those inactive ones will refetch.

So the most accurate sentence is:

`refetchType` is used to decide which of the already-matched invalidated queries should refetch immediately.
```

#### Verified visible code

```ts
queryClient.invalidateQueries({
  queryKey: ['todos'],
  type: 'inactive',
  refetchType: 'all',
})
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S010 / S-182 - `1b495c7744`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-refetchqueries-options`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: refetchQueries options and notes

#### Verified visible text

```text
Options:

- `throwOnError?: boolean`
- `cancelRefetch?: boolean` default `true`

`refetchQueries(filters?, options?)`

Explicitly refetches matching queries. Docs show filters such as:

- `stale: true`
- `queryKey`
- `type: 'active'`
- `exact: true`

Notes:

- disabled queries are not refetched
- static queries are not refetched
- can be configured to throw with `throwOnError` true.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S011 / S-190 - `11e2c7d93f`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-cancel-remove-reset-clear`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: cancelQueries, removeQueries, resetQueries, clear

#### Verified visible text

```text
`cancelQueries(filters?, cancelOptions?)`

Cancels matching in-flight queries. Useful for optimistic updates. Takes:

- `filters?: QueryFilters`
- `cancelOptions?: CancelOptions`

Docs example shows `{ silent: true }`.

`removeQueries(filters?)`

Removes matching queries from cache.

`resetQueries(filters?, options?)`

Resets matching queries to initial state; if a query has `initialData`, it resets to that. Active queries are refetched. Unlike `clear`, it notifies subscribers. Options:

- `throwOnError?: boolean`
- `cancelRefetch?: boolean` default `true`

`clear()`

Clears all connected caches.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S012 / S-191 - `5bec075fe3`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-cancelqueries-optimistic-why`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: why cancelQueries matters in optimistic updates

#### Verified visible text

```text
2) Why `cancelQueries` matters in optimistic updates

TanStack's optimistic update guide literally says to cancel outgoing refetches so they don't overwrite your optimistic update.

The problem without cancellation

Imagine this timeline:

1. `['todos']` query is on screen
2. a refetch is already in flight
3. user edits/adds a todo
4. you optimistically call `setQueryData` and show the new todo immediately
5. the older in-flight refetch finishes with stale server data
6. that old response writes into cache and wipes out your optimistic change

That is the race you are preventing.

So the idea is:

cancel old fetches first, then write optimistic data, then later sync with the server result.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S013 / S-193 - `9625ff3c1f`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-canceloptions`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: CancelOptions silent/revert

#### Verified visible text

```text
2) `CancelOptions` and optimistic updates with `cancelQueries`

`cancelQueries` cancels matching outgoing queries. The docs say this is especially useful for optimistic updates so that an in-flight refetch does not overwrite your optimistic cache change when it finishes.

The `CancelOptions` are:

- `silent?: boolean` — default `false`. If `true`, it suppresses propagation of `CancelledError` to observers and related notifications, and returns the retry promise instead of rejecting.
- `revert?: boolean` — default `true`. If `true`, cancellation restores the query state from immediately before the in-flight fetch and sets `fetchStatus` back to `idle`; it only throws if there was no prior data.

So the simplest way to think about them is:

- `silent` controls how noisy the cancellation is
- `revert` controls whether query state rolls back to the pre-fetch state.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S014 / S-194 - `6401d2ad9e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-cancel-refetch-basic-methods`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: cancelQueries and refetchQueries basic examples

#### Verified visible text

```text
6. Cancel queries

Useful in optimistic updates or when you want to stop an in-flight request.

The docs describe this as canceling matching queries and reverting them to the previous state if cancellation is supported by the query function.

7. Refetch queries manually

Use when you want to actively rerun matching queries now.

This is more direct than invalidation. Invalidation says "this is stale"; refetch says "fetch now."
```

#### Verified visible code

```ts
await queryClient.cancelQueries({ queryKey: ['todos'] })

await queryClient.refetchQueries({ queryKey: ['todos'] })
```

#### Notes

Previously reserved as R08D/neighbor, but local R08B review shows it is direct cancel/refetch-method continuation, so it is included in R08B.

---

### R08B-S015 / S-197 - `75a0c9e06f`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-status-helpers`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: isFetching and isMutating status helpers

#### Verified visible text

```text
Counters / status helpers

`isFetching(filters?)`

Returns a number: how many queries are currently fetching. Takes optional `QueryFilters`.

`isMutating(filters?)`

Returns a number: how many mutations are currently running. Takes `MutationFilters`.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S016 / S-198 - `f128bccab6`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08b-optimistic-flow`
- readability: `high`
- cut_off: `bottom-example-cropped`
- confidence: `high-for-visible-text`
- theme: standard optimistic update flow with cancelQueries

#### Verified visible text

```text
3) Standard optimistic update flow with `cancelQueries`

TanStack's documented flow is:

1. `onMutate`
2. cancel outgoing refetches
3. snapshot previous cache value
4. write optimistic value with `setQueryData`
5. if mutation fails, roll back using the snapshot
6. on settled, invalidate/refetch to sync with server.

Example:
```

#### Notes

Example content begins below the crop and is not visible here; full code example is visible in S-207.

---

### R08B-S017 / S-200 - `6ce7aeccdc`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-cancel-revert-true`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: revert true behavior and why preferred

#### Verified visible text

```text
If there was already data before the canceled fetch

With `revert: false`, that old data does not get actively restored by cancellation. But it also does not necessarily disappear. The docs only define the `true` behavior explicitly: restore previous data/status. When you set it to `false`, you are disabling that restoration step.

If there was no previous data

Then there is nothing to restore anyway. In that case, after cancellation you may still have no usable data. The docs note that with `revert: true`, it only throws if there was no prior data.

Why `revert: true` is usually preferred

Because manual cancellation normally "revert[s] it back to its previous state," and optimistic updates commonly cancel outgoing refetches specifically so they do not clobber the optimistic cache write.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S018 / S-204 - `a00c2c49ff`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-defaults-config`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryClient defaults/config methods

#### Verified visible text

```text
Defaults / config

`getDefaultOptions()`

Returns current client-level default options.

`setDefaultOptions({ queries?, mutations? })`

Sets client-level defaults dynamically, overwriting previous defaults.

`getQueryDefaults(queryKey)`

Returns defaults registered for matching query keys. Matching defaults are merged by registration order.

`setQueryDefaults(queryKey, options)`

Registers defaults for queries matching that key. Registration order matters: generic first, then specific.

`getMutationDefaults(mutationKey)`

Returns defaults for matching mutation keys.

`setMutationDefaults(mutationKey, options)`

Registers defaults for mutations with that key. Order matters here too.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S019 / S-207 - `55a51e51f4`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-optimistic-update-code-example`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: optimistic update code example with cancelQueries

#### Verified visible text

```text
Example:

That exact pattern is straight from the docs.
```

#### Verified visible code

```ts
const mutation = useMutation({
  mutationFn: updateTodo,
  onMutate: async (newTodo, context) => {
    await context.client.cancelQueries({ queryKey: ['todos'] })

    const previousTodos = context.client.getQueryData(['todos'])

    context.client.setQueryData(['todos'], (old) => [...old, newTodo])

    return { previousTodos }
  },
  onError: (err, newTodo, onMutateResult, context) => {
    context.client.setQueryData(['todos'], onMutateResult.previousTodos)
  },
  onSettled: (_data, _error, _vars, _result, context) => {
    context.client.invalidateQueries({ queryKey: ['todos'] })
  },
})
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S020 / S-212 - `13b08c1aea`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-low-level-cache-access-summary`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: low-level cache access and resumePausedMutations summary

#### Verified visible text

```text
Low-level cache access

`getQueryCache()`

Returns the connected `QueryCache`.

`getMutationCache()`

Returns the connected `MutationCache`.

`resumePausedMutations()`

Resumes mutations paused because there was no network connection.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S021 / S-216 - `97e37315a6`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-getquerycache-details`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: getQueryCache low-level store details

#### Verified visible text

```text
`getQueryCache()`

This returns the `QueryCache` connected to the `QueryClient`.

What the query cache is

It is the low-level store that holds all query entries:

- their keys
- data
- status
- fetch state
- metadata
- observers/subscribers relationship info at the cache level.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S022 / S-219 - `850109ec0c`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-v5-optimistic-update-callback-placement`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: v5 removed useQuery callbacks; cancellation handled in mutation flow

#### Verified visible text

```text
In v5, `useQuery` does not have `onError`, `onSuccess`, or `onSettled`. Those query callbacks were removed in v5; they still exist for mutations, not queries.

So for optimistic updates, you usually do not "handle cancellation in `useQuery onError`", because there is no such callback in v5. Instead, you handle it by:

- canceling the relevant queries before your optimistic write,
- optionally making that cancellation silent,
- snapshotting previous cache data,
- writing optimistic data,
- rolling back in the mutation `onError`,
- invalidating/refetching in `onSettled`.
```

#### Notes

Verified from extracted SVG image.

---

### R08B-S023 / S-221 - `e79f52ad22`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08b-resumepausedmutations-details`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: resumePausedMutations offline workflow

#### Verified visible text

```text
`resumePausedMutations()`

This is for mutations that were paused, most commonly because the app was offline or the mutation was otherwise waiting for network conditions to allow it to continue. Calling `queryClient.resumePausedMutations()` tells TanStack Query to continue those paused mutations.

Why this exists

Imagine the user clicks "Save" while offline:

- mutation starts
- TanStack Query pauses it instead of finishing it
- later the app comes back online
- `resumePausedMutations()` can continue those paused writes.

Typical use

This is mostly useful with offline workflows or persisted clients, where you want pending writes to continue after reconnect or app restore. The `QueryClient` API exposes it specifically as a client-level method for that purpose.
```

#### Notes

Previously reserved as R08D/neighbor, but local R08B review shows it belongs with low-level QueryClient/cache helper methods, so it is included in R08B.

---

## What should be recallable

- How refetch and cancellation options affect matching queries.
- How cache helper methods differ in side effects and return behavior.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R08B-refetch-cancel-options-cache-helpers.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
