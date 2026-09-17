# Using QueryClient outside React and preserving cache shape

Knowledge ID: `react-query.queryclient-outside-react-and-shape-discipline`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R08C-queryclient-outside-react-shape-discipline.md`


### R08C-S001 / S-127 - `78a5bec30e`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08c-shared-queryclient-file`
- readability: `high`
- cut_off: `bottom-continuation-visible-in-s141`
- confidence: `high-for-visible-text`
- theme: Create one shared QueryClient file

#### Verified visible text

```text
Common pattern

Create one shared file:

Use that same instance in React:
```

#### Verified visible code

```ts
// queryClient.ts
import { QueryClient } from '@tanstack/react-query'

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 30_000,
    },
  },
})
```

#### Notes

The bottom says to use the same instance in React; S-141 continues the React/outside-React usage.

---

### R08C-S002 / S-133 - `0a41cac8a5`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08c-setqueriesdata-per-entry-old`
- readability: `high`
- cut_off: `bottom-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: setQueriesData updater runs once per matching cache entry

#### Verified visible text

```text
Yes.

With `setQueriesData`, the updater runs once per matching cache entry. For each matching query, `old` is the cached data of that one entry.

So if you do:

TanStack Query finds every cached query whose key matches `['todos']`, and for each one:

- reads that entry's current cached value
- passes that value as `old`
- stores whatever your updater returns back into that same entry
```

#### Verified visible code

```ts
queryClient.setQueriesData(
  { queryKey: ['todos'] },
  (old) => { ... }
)
```

#### Notes

Bottom continuation is cropped; the core per-entry `old` behavior is visible.

---

### R08C-S003 / S-135 - `471c964d3b`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08c-olddata-shape-source`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: How oldData shape is known

#### Verified visible text

```text
How do we know the shape of `oldData`?

You only know it from your own query design.

TanStack Query does not magically infer runtime shape from the key alone. The cache stores "whatever data that query has". The docs emphasize type inference and type safety via query options helpers and generic typing, but that is a TypeScript aid, not runtime validation.

So the real answer is:

- the shape comes from the `queryFn` and how you use that key in your app
- TypeScript can help you model that shape
- at runtime, TanStack Query trusts you

Example:

Here you are declaring: "all matching `['todos', ...]` queries contain `Todo[]`."
```

#### Verified visible code

```ts
type Todo = { id: number; title: string; completed: boolean }

queryClient.setQueriesData<Todo[]>(
  { queryKey: ['todos'] },
  (old) => old?.map(t => t.id === updated.id ? { ...t, ...updated } : t)
)
```

#### Notes

Verified from extracted SVG image.

---

### R08C-S004 / S-141 - `d913087434`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08c-shared-client-react-and-outside`
- readability: `high`
- cut_off: `bottom-ui-overlay-no-obvious-text-loss`
- confidence: `high-for-visible-text`
- theme: Use the same QueryClient instance in React and outside React

#### Verified visible text

```text
And outside React:

That works because these are instance methods on `QueryClient`, not hook-only APIs.
```

#### Verified visible code

```ts
import { QueryClientProvider } from '@tanstack/react-query'
import { queryClient } from './queryClient'

<QueryClientProvider client={queryClient}>
  <App />
</QueryClientProvider>

import { queryClient } from './queryClient'

export async function warmPost(path: string) {
  await queryClient.prefetchQuery({
    queryKey: ['posts', path],
    queryFn: () => fetchPost(path),
    staleTime: 5000,
  })
}
```

#### Notes

Continuation of S-127. Bottom UI overlay visible; no obvious text loss.

---

### R08C-S005 / S-149 - `8c5f325354`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08c-mixed-shape-danger`
- readability: `high`
- cut_off: `bottom-ui-overlay-no-obvious-text-loss`
- confidence: `high-for-visible-text`
- theme: Problem when one matching query stores another shape

#### Verified visible text

```text
What if one matching query stores another shape?

Then you have a problem.

Example:

If you do:

then `['todos', 'count']` also matches the prefix, but its data is `number`, not `Todo[]`.

That can cause:

- wrong TypeScript assumptions
- runtime errors like `old.map is not a function`
- corrupted cache data

So `setQueriesData` is safe only when the matched queries really share a compatible shape.
```

#### Verified visible code

```ts
['todos'] -> Todo[]
['todos', 'count'] -> number

queryClient.setQueriesData<Todo[]>(
  { queryKey: ['todos'] },
  old => old?.map(...)
)
```

#### Notes

Bottom UI overlay visible; content is readable.

---

### R08C-S006 / S-155 - `7580b14f8c`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08c-outside-react-use-cases-caveat`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: When QueryClient outside React is useful and same-instance caveat

#### Verified visible text

```text
When this is useful outside React

- route loaders / navigation helpers
- plain TS utility modules
- SSR / hydration setup
- auth/logout handlers that clear or reset cache
- websocket/event handlers that call `setQueryData` or `invalidateQueries`
- test setup code
- startup bootstrapping / preloading code

Important caveat

Use the same client instance if you want that external code to affect the cache your React app is using. If you accidentally create a second `new QueryClient()` in some random TS file, you'll be talking to a different cache. That follows from `useQueryClient` returning the current provider's instance and `QueryClientProvider` wiring one client into context.
```

#### Notes

Verified from extracted SVG image.

---

### R08C-S007 / S-160 - `57e5d6a530`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08c-setqueriesdata-compatible-shape-rule`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Rule of thumb for setQueriesData compatible shapes

#### Verified visible text

```text
Rule of thumb

Use `setQueriesData` only when all matching queries have the same or compatible data shape.

Good:

All are `Todo[]`.

Bad:

These should not be bulk-updated with one `Todo[]` updater.
```

#### Verified visible code

```ts
['todos']
['todos', { status: 'done' }]
['todos', { status: 'open' }]

['todos'] -> Todo[]
['todos', 'count'] -> number
['todos', 'stats'] -> { total: number }
```

#### Notes

Verified from extracted SVG image.

---

### R08C-S008 / S-170 - `eb754a7f2d`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r08c-avoid-mixed-shapes-clearer-keys`
- readability: `high`
- cut_off: `top-continuation-from-s160-visible-at-edge`
- confidence: `high`
- theme: Avoid mixed shapes with clearer keys

#### Verified visible text

```text
How to avoid mixed shapes

1. Use clearer keys

Separate list data from summary data.

Good:

Then `setQueriesData({ queryKey: ['todoList'] }, ...)` is much safer.
```

#### Verified visible code

```ts
['todoList']
['todoList', { status: 'done' }]
['todoCount']
['todoStats']
```

#### Notes

The very top has continuation text from the previous source, but the R08C content is clear.

---

### R08C-S009 / S-179 - `d8da9f8d84`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08c-centralize-query-keys`
- readability: `high`
- cut_off: `top-continuation-from-s170-visible-at-edge`
- confidence: `high-for-visible-text`
- theme: Centralize query keys with key factories

#### Verified visible text

```text
2. Centralize query keys

Use key factories:

Then update only list-shaped queries:
```

#### Verified visible code

```ts
const todoKeys = {
  all: ['todos'] as const,
  lists: () => ['todos', 'list'] as const,
  list: (filter: { status?: string }) => ['todos', 'list', filter] as const,
  count: () => ['todos', 'count'] as const,
}

queryClient.setQueriesData(
  { queryKey: todoKeys.lists() },
  ...
)
```

#### Notes

Top has tail text from S-170; centralize-key content is readable.

---

### R08C-S010 / S-187 - `5e6930a90d`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r08c-inspect-and-prefer-invalidation`
- readability: `high`
- cut_off: `top-continuation-cropped`
- confidence: `high-for-visible-text`
- theme: Use getQueriesData first and prefer invalidation when shapes differ

#### Verified visible text

```text
3. Use `getQueriesData` first when unsure

TanStack also provides `getQueriesData`, which returns the cached data for all matches. That is useful for inspecting what is actually in cache before bulk-updating.

4. Prefer invalidation when shapes differ

If queries are related but shaped differently, it is often better to do:

- `setQueryData` for the one or two queries you know exactly
- `invalidateQueries` for the rest

That avoids forcing one updater across incompatible cached values.
```

#### Notes

Top continuation cropped; visible text is complete for points 3 and 4.

---

## What should be recallable

- When QueryClient can be used outside React components.
- Why direct cache writes must preserve the registered query-data shape.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R08C-queryclient-outside-react-shape-discipline.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
