# React Query staleness, refetch triggers, and retry

Knowledge ID: `react-query.staleness-refetch-triggers-and-retry`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R04A-staleness-static-refetch-retry.md`


### R04A-S001 / S-062 - `976499b4dc`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-static-stale-word-meaning`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: staleTime static: not stale by time but can be invalidated

#### Verified visible text
```text
Yeah, this is one of the more confusing parts of TanStack Query's API — the word “stale” is doing two slightly different jobs here.

Key idea

With `staleTime: 'static'`:

- it never becomes stale due to time
- but it can still be marked stale manually (via invalidation)
```

#### Notes
Inbound from R02 reserved overlap; verified as R04A.

---

### R04A-S002 / S-063 - `603893e98b`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04a-query-retry-options`
- readability: `high`
- cut_off: `bottom-example-start-cropped`
- confidence: `high-for-visible-text`
- theme: Query retry options and defaults

#### Verified visible text
```text
There are separate retry settings for queries and mutations, and their defaults are different. For queries, `retry` defaults to 3 on the client and 0 on the server. For mutations, `retry` defaults to 0.

Queries

For `useQuery`, the `retry` option can be:

- `false` → never retry
- `true` → retry infinitely
- a number like `3` → retry until that many retries have been attempted
- a function `((failureCount, error) => boolean)` → decide dynamically whether to retry.

Example:
```

#### Notes
Bottom starts an Example section; code is continued by S-068.

---

### R04A-S003 / S-067 - `ecd69b961a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-time-based-staleness-vs-static`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Time-based staleness versus static

#### Verified visible text
```text
So what actually happens?

Think of it like two separate mechanisms:

1. Time-based staleness

Normally:

→ after 60s → query becomes stale automatically

With:

→ this never happens
→ it stays “fresh forever” from a time perspective
```

#### Verified visible code
```tsx
staleTime: 60_000

staleTime: 'static'
```

#### Notes
Verified from R04A source image.

---

### R04A-S004 / S-068 - `3d947e5f86`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04a-query-retry-example`
- readability: `high`
- cut_off: `top-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: retry: 3 example

#### Verified visible text
```text
Example:

That means:

- first request fails
- React Query retries up to 3 times
- so you can get the initial attempt plus up to 3 retries.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  retry: 3,
})
```

#### Notes
Continuation from S-063; top tail is cropped.

---

### R04A-S005 / S-070 - `8d3fd0a7f7`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-manual-invalidation-static`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Manual invalidation with static

#### Verified visible text
```text
2. Manual invalidation

This does two things internally:

- marks the query as invalidated
- sets `isStale = true`

So yes — it does become stale.

But...

“stale” here does NOT trigger refetch when `staleTime: 'static'`.
```

#### Verified visible code
```tsx
queryClient.invalidateQueries(['todos'])
```

#### Notes
Verified from R04A source image.

---

### R04A-S006 / S-071 - `9eb932564a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-retry-delay-default-and-retryonmount`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: retryDelay default and retryOnMount

#### Verified visible text
```text
Query retry delay default

Retries do not happen instantly. By default, TanStack Query uses exponential backoff: it starts at 1000 ms, doubles with each retry attempt, and caps at 30 seconds.

So roughly:

- retry 1 → about 1s
- retry 2 → about 2s
- retry 3 → about 4s
- and so on, capped at 30s.

`retryOnMount`

Queries also have `retryOnMount`, which defaults to `true`. If a query is in an error state and the component mounts again, it can retry on mount unless you turn that off.
```

#### Notes
Verified from R04A source image.

---

### R04A-S007 / S-073 - `bba33258c2`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-refetch-triggers-stale-queries`
- readability: `high`
- cut_off: `bottom-ui-overlay-no-obvious-text-loss`
- confidence: `high`
- theme: Refetch triggers for stale queries

#### Verified visible text
```text
9.3 Refetch triggers for stale queries

Stale queries may refetch when:

- the key changes
- a new observer mounts
- the window regains focus
- the device reconnects

Options:
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['repos', { sort }],
  queryFn: () => fetchRepos(sort),
  refetchOnMount: false,
  refetchOnWindowFocus: false,
  refetchOnReconnect: false,
})
```

#### Notes
Bottom UI overlay visible; no obvious content loss.

---

### R04A-S008 / S-074 - `577412eb23`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-static-mental-model`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Static disables automatic refetch logic even after invalidation

#### Verified visible text
```text
Why this feels contradictory

Because normally:

stale → eligible for refetch

But with `'static'`, TanStack Query changes the rule to:

stale → still do nothing automatically

So you end up with a query that is:

- stale
- invalidated
- but won't refetch unless you explicitly tell it to

Mental model that actually works

Treat `'static'` like:

“Disable all automatic refetch logic — even after invalidation”
```

#### Notes
Verified from R04A source image.

---

### R04A-S009 / S-075 - `62d845b921`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-query-error-reset-boundary-retryonmount-false`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: QueryErrorResetBoundary with retryOnMount false

#### Verified visible text
```text
Yes — no automatic retry on mount.

If `retryOnMount` is `false`, then after `QueryErrorResetBoundary` resets the boundary state and the component renders/mounts again, the query is allowed to be rendered again, but it will not automatically start a new fetch just because it mounted while in error state. That is exactly what `retryOnMount` controls.

So:

- `QueryErrorResetBoundary` = “stop immediately re-throwing the old query error; let me try again from the boundary flow.”
- `retryOnMount: false` = “but do not auto-retry this errored query on mount.”
```

#### Notes
Verified from R04A source image.

---

### R04A-S010 / S-076 - `4e4df28c03`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-mutation-retry-default`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Mutation retry exists but defaults to 0

#### Verified visible text
```text
Mutations

For `useMutation`, `retry` also exists, but the default is 0, meaning failed mutations are not retried automatically unless you opt in.

That default makes sense because mutations often change server state, and blindly retrying writes can be risky depending on the endpoint and whether the operation is idempotent. That last sentence is an inference, but it matches the documented default behavior.

Example:

Now a failed mutation can be retried up to 2 times.
```

#### Verified visible code
```tsx
useMutation({
  mutationFn: updateTodo,
  retry: 2,
})
```

#### Notes
Verified from R04A source image.

---

### R04A-S011 / S-077 - `2e326e9966`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-become-stale-after-staletime`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: A query becomes stale after staleTime expires

#### Verified visible text
```text
A query can become stale in these main ways:

1. After its `staleTime` expires

This is the normal case.

- default `staleTime` is 0, so data is considered stale immediately after it is fetched unless you configure otherwise.
- if `staleTime` is 5000, it becomes stale 5 seconds after `dataUpdatedAt`.
```

#### Notes
Verified from R04A source image.

---

### R04A-S012 / S-079 - `ac6478b204`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-freshness-vs-retention-staletime`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Freshness vs retention, staleTime default

#### Verified visible text
```text
9. Freshness vs retention

This is one of the most important topics.

9.1 `staleTime`

Controls how long data is considered fresh.

Default:

That means data becomes stale immediately after being cached.
```

#### Verified visible code
```tsx
staleTime: 0
```

#### Notes
Verified from R04A source image.

---

### R04A-S013 / S-082 - `a75c02ceb1`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-invalidate-overrides-staletime-infinity`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Invalidation marks stale and overrides staleTime

#### Verified visible text
```text
2. When you invalidate it

`queryClient.invalidateQueries(...)` marks matching queries as stale, and this overrides `staleTime`. For active queries, it also refetches them in the background by default.

So yes:

- if `staleTime: Infinity`, the query is still fresh forever unless you manually invalidate it
- after invalidation, it does become stale even with `Infinity`

3. Initial data can already be stale

If you use `initialData`, it is considered stale by default unless you also set `staleTime` or provide `initialDataUpdatedAt`.
```

#### Notes
Verified from R04A source image.

---

### R04A-S014 / S-084 - `68a664c2d5`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-throwonerror-retryonmount-false-flow`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: throwOnError + retryOnMount false boundary flow

#### Verified visible text
```text
That means with:

and a proper `QueryErrorResetBoundary` setup:

1. query fails
2. normal `retry` attempts for that fetch cycle are exhausted
3. error is thrown to the React error boundary
4. user resets the boundary
5. `QueryErrorResetBoundary` clears the query-error-boundary state
6. component renders again
7. the query does not automatically retry on mount, because `retryOnMount` is `false`
```

#### Verified visible code
```tsx
throwOnError: true
retryOnMount: false
```

#### Notes
Verified from R04A source image.

---

### R04A-S015 / S-087 - `6674e4d2e9`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-staletime-example-infinity`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: staleTime example and Infinity

#### Verified visible text
```text
Example

`Infinity`

This means data never becomes stale automatically.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['repos', sort],
  queryFn: () => getRepos(sort),
  staleTime: 60 * 60 * 1000, // 1 hour
})

staleTime: Infinity
```

#### Notes
Verified from R04A source image.

---

### R04A-S016 / S-088 - `e48ab34495`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-retrydelay-option`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: retryDelay option can be number or function

#### Verified visible text
```text
Yes — there is a `retryDelay` option for both queries and mutations. For `useQuery` and `useMutation`, it can be either a number or a function `((retryAttempt, error) => number)` that returns the delay in milliseconds before the next retry.

Example for a query:

That means each retry waits 2 seconds.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  retry: 3,
  retryDelay: 2000,
})
```

#### Notes
Verified from R04A source image.

---

### R04A-S017 / S-090 - `ba574a8024`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-static-never-considered-stale`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: static prevents being considered stale

#### Verified visible text
```text
Can a query be prevented from ever becoming stale?

Yes — in v5 there is a stronger option than `Infinity`:

With `staleTime: 'static'`, the data is never considered stale. Also, it will not refetch even if invalidated manually.
```

#### Verified visible code
```tsx
staleTime: 'static'
```

#### Notes
Verified from R04A source image.

---

### R04A-S018 / S-091 - `1c6a61c9e4`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-static-refetch-paths-shut-off`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: static shuts off normal automatic refetch paths

#### Verified visible text
```text
Yes — with `staleTime: 'static'`, the query is treated as never stale, and the usual automatic refetch paths tied to staleness are effectively shut off. The docs say `'static'` means “the data will never be considered stale,” and for `refetchOnMount`, `refetchOnWindowFocus`, and `refetchOnReconnect`, even `"always"` does not force a refetch when `'static'` is used.

So your statement is basically correct:

- if `staleTime: 'static'`
- and you did not set `refetchInterval`
- and you do not call a manual fetch API yourself
```

#### Notes
Verified from R04A source image.

---

### R04A-S019 / S-095 - `ff5a3dac41`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-staletime-variants`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Differences between 0, finite, Infinity, and static

#### Verified visible text
```text
So the differences are:

- `staleTime: 0` → stale immediately
- `staleTime: 10_000` → stale after 10 seconds
- `staleTime: Infinity` → never stale unless invalidated manually
- `staleTime: 'static'` → never stale at all, even manual invalidation does not make it refetch in the normal way

So to your question:

do we have an option that controls can a query be stale at all?

Yes:

- `Infinity` says “don't become stale by time”
- `'static'` says “never be considered stale”
```

#### Notes
Verified from R04A source image.

---

### R04A-S020 / S-097 - `4e38da6f7c`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-what-happens-when-stale`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: What happens when a query becomes stale

#### Verified visible text
```text
9.2 What happens when a query becomes stale?

Nothing dramatic.

It is still in cache.
It can still be shown immediately.

Stale data is usually better than showing nothing.

When stale data exists, React Query often shows cached data first and then refetches in the background.
```

#### Notes
Verified from R04A source image.

---

### R04A-S021 / S-098 - `27679ed8ee`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-static-manual-fetch-and-refetchinterval`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: What can still fetch with static

#### Verified visible text
```text
What can still fetch with `'static'`

`'static'` does not mean “this query can never be fetched again by any API.” It means the usual stale-driven / auto-refetch behavior is disabled. You can still fetch manually through explicit fetch/refetch-style APIs, and polling with `refetchInterval` is separate from staleness. The docs list explicit fetch methods like `fetchQuery`, `prefetchQuery`, `refetchQueries`, and note that `refetchInterval` is independent of `staleTime`.

So the practical picture is:

- `refetchInterval` → can still fetch
- explicit manual fetch/refetch calls → can still fetch
- mount/focus/reconnect/invalidate-driven refetch → effectively no, with `'static'`
```

#### Notes
Verified from R04A source image.

---

### R04A-S022 / S-099 - `1314fac193`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r04a-retrydelay-function-linear-backoff`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: retryDelay function linear backoff

#### Verified visible text
```text
Or with a function:

That gives linear backoff:

- retry 1 after 1s
- retry 2 after 2s
- retry 3 after 3s.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  retry: 3,
  retryDelay: (attempt) => attempt * 1000,
})
```

#### Notes
Verified from R04A source image.

---

### R04A-S023 / S-103 - `4e59a80541`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04a-how-to-think-about-static`
- readability: `high`
- cut_off: `bottom-tiny-example-cropped`
- confidence: `high-for-visible-text`
- theme: When to use static and rule of thumb

#### Verified visible text
```text
How to think about `'static'`

Use `'static'` when the data is effectively immutable for the lifetime of the app session, or when you want to be fully in charge of when refetching happens. Examples:

- build metadata
- app config loaded once
- constants / dictionaries / feature flags that you refresh only explicitly
- reference data you want to update only with a button or a custom flow

A good rule of thumb

- use `Infinity` when you want: “don't refetch automatically unless I invalidate”
- use `'static'` when you want: “don't even refetch on invalidation; only fetch when I explicitly choose another mechanism”

Tiny example:
```

#### Notes
Bottom starts a tiny example, continued/cropped; core text is visible.

---

### R04A-S024 / S-104 - `50eadf70df`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r04a-retrydelay-exponential-and-mutations`
- readability: `high`
- cut_off: `top-and-bottom-ui-overlay`
- confidence: `high-for-visible-text`
- theme: retryDelay exponential backoff example and mutation retryDelay

#### Verified visible text
```text
TanStack's docs also give the exponential-backoff style example:

and note that the default behavior uses exponential backoff for query retries.

Same idea exists on mutations:

So yes:

- `retry` controls whether/how many times
- `retryDelay` controls how long to wait between attempts.
```

#### Verified visible code
```tsx
retryDelay: (attempt) =>
  Math.min(attempt > 1 ? 2 ** attempt * 1000 : 1000, 30 * 1000)

useMutation({
  mutationFn: updateTodo,
  retry: 2,
  retryDelay: (attempt) => attempt * 1000,
})
```

#### Notes
Top and bottom UI overlays visible; core code/text readable.

---

## Authoritative claim transcript: `R04A-v002-static-staleness-correction.md`


### S-109 - query can have data, be stale, and be fetching at same time

Metadata:
```text
source_id: S-109
image_use_id: IU-109
fileId_short: 39e62ae511
image_file: S-109__39e62ae511.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
A query can:

- have data
- be stale
- be fetching

all at the same time.
```

#### Notes

Fully readable static/staleness correction.

---

### S-110 - staleTime static overrides always refetch triggers

Metadata:
```text
source_id: S-110
image_use_id: IU-110
fileId_short: 96bd41a485
image_file: S-110__96bd41a485.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Tiny example. Even with `"always"` on `refetchOnMount`, `refetchOnWindowFocus`, and `refetchOnReconnect`, the docs say those refetches still won't happen because `'static'` overrides them for those triggers.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['config'],
  queryFn: fetchConfig,
  staleTime: 'static',
  refetchOnMount: 'always',
  refetchOnWindowFocus: 'always',
  refetchOnReconnect: 'always',
})
```

#### Notes

Readable correction card; belongs to R04A static staleTime, not R09.

---

## What should be recallable

- How staleTime, static staleness, trigger policies, and retries interact.
- How a query can simultaneously hold data, be stale, and be fetching.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R04A-staleness-static-refetch-retry.md`, source-transcript section
- Authoritative processed source: `regions/R04A-v002-static-staleness-correction.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
