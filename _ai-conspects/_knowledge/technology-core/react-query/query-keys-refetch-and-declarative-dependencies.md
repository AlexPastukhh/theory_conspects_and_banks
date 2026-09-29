# React Query keys, refetch, and declarative dependencies

Knowledge ID: `react-query.query-keys-refetch-and-declarative-dependencies`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R02C-query-keys-manual-refetch-declarative-dependencies.md`


### R02C-S001 / S-039 - `913cfdb055`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-query-key-missing-dependency-bad`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Query keys must include every value used by queryFn

#### Verified visible text

```text
8. Query keys

8.1 Include every value used by the query function

If the query function depends on something, that value belongs in the key.

Bad:

This wrongly reuses one cache entry for many books.
```

#### Verified visible code

```tsx
function useBook(bookId: string) {
  return useQuery({
    queryKey: ['book'],
    queryFn: () => getBook(bookId),
  })
}
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S002 / S-040 - `5b76d4c5fc`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r02c-usebook-usage`
- readability: `high`
- cut_off: `top-continuation-cropped`
- confidence: `high-for-visible-code`
- theme: useBook usage with pending/error guards

#### Verified visible text

```text
Usage:
```

#### Verified visible code

```tsx
function Book() {
  const { data, isPending, isError } = useBook()

  if (isPending) return <div>Loading...</div>
  if (isError) return <div>Error</div>

  return <h1>{data.title}</h1>
}
```

#### Notes

Top continuation is cropped; visible usage code is readable.

---

### R02C-S003 / S-043 - `7c40b916d5`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r02c-better-queryfn-error`
- readability: `high`
- cut_off: `surrounding-context-cropped`
- confidence: `high-for-visible-code`
- theme: Better queryFn throws on failed fetch

#### Verified visible text

```text
Better
```

#### Verified visible code

```tsx
async function getData() {
  const res = await fetch('/api/data')
  if (!res.ok) throw new Error('Failed to fetch')
  return res.json()
}
```

#### Notes

This is a visible nearby code card reinforcing queryFn error behavior; included in R02C because it is in the formal R02C row and local review kept it as queryFn/key-adjacent support.

---

### R02C-S004 / S-045 - `7aca1a90bf`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-query-key-good`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Good query key includes bookId

#### Verified visible text

```text
Good
```

#### Verified visible code

```tsx
function useBook(bookId: string) {
  return useQuery({
    queryKey: ['book', bookId],
    queryFn: () => getBook(bookId),
  })
}
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S005 / S-048 - `bafb8949f1`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-eslint-plugin`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: ESLint plugin catches missing key dependencies

#### Verified visible text

```text
8.4 ESLint plugin

The TanStack ESLint plugin helps catch missing key dependencies.
```

#### Verified visible code

```bash
npm i @tanstack/eslint-plugin-query
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S006 / S-050 - `33f7c75961`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-manual-refetch-imperative-bad`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Avoid manual refetch when changing variable belongs in key

#### Verified visible text

```text
8.2 Declarative refetching

Avoid manual `refetch()` when a changing variable should already be part of the key.

Imperative approach
```

#### Verified visible code

```tsx
const { refetch } = useRepos(sort)

function onChange(e: React.ChangeEvent<HTMLSelectElement>) {
  setSort(e.target.value)
  refetch()
}
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S007 / S-051 - `0e0d2b0487`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-sort-state-flow`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Sort state causes rerender and new queryKey on next render

#### Verified visible text

```text
Yes — in that example, `sort` is typically a React state value in the component that calls `useRepos(sort)`.

So the flow is:

When `setSort(...)` runs:

1. React updates state
2. component re-renders
3. `useRepos(sort)` runs again with the new `sort`
4. `queryKey` becomes `['repos', newSort]`
5. TanStack Query treats that as a different query

So your understanding is right: it does not instantly fetch at the moment `setSort` is called. It fetches on the next render, when the hook sees the new key.
```

#### Verified visible code

```tsx
const [sort, setSort] = useState('stars')
const reposQuery = useRepos(sort)
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S008 / S-052 - `26863f1800`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-query-key-arrays-objects`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Keys can contain arrays and objects

#### Verified visible text

```text
8.3 Keys can contain arrays and objects

React Query hashes keys deterministically.

They do not need referential stability like React dependency arrays often do.
```

#### Verified visible code

```tsx
queryKey: ['repos', { sort, page }]
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S009 / S-054 - `2cdf7b8634`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-declarative-approach-good`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Better declarative key includes sort

#### Verified visible text

```text
Better declarative approach

Now a sort change automatically means “new query”.
```

#### Verified visible code

```tsx
function useRepos(sort: string) {
  return useQuery({
    queryKey: ['repos', sort],
    queryFn: () => getRepos(sort),
  })
}
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S010 / S-057 - `2fc52e535e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-new-key-cache-nuance`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: New key may use cache, refetch, or fetch

#### Verified visible text

```text
Important nuance

It is not always “no cache => fetch”.

For the new key, TanStack Query does this:

- if cache for `['repos', newSort]` exists, it can return cached data immediately
- if that cached data is stale, it may also refetch in the background
- if no cache exists, it starts a new fetch

So more precisely:

Changing `sort` causes a re-render, which gives `useQuery` a new `queryKey`. Then TanStack Query looks up that key in cache and decides whether to use cached data, fetch, or both.
```

#### Notes

Verified from extracted SVG image.

---

### R02C-S011 / S-061 - `3ec1269c3e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r02c-why-declarative`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Why query keys make fetching declarative

#### Verified visible text

```text
Why this is called declarative

Because you are not saying:

“please refetch now”

You are saying:

“my data depends on `sort`”

and the query key expresses that dependency.
```

#### Notes

Verified from extracted SVG image.

---

## What should be recallable

- Why changing dependencies belongs in the query key.
- When declarative key changes or imperative refetch is appropriate.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R02C-query-keys-manual-refetch-declarative-dependencies.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
