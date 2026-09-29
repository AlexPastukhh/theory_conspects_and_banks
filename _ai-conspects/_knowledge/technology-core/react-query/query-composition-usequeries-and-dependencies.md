# React Query composition with useQueries and dependent queries

Knowledge ID: `react-query.query-composition-usequeries-and-dependencies`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R06-query-composition-usequeries-dependent-combine.md`


### R06-S001 / S-126 - `68f33d5ec1`

Metadata:

- status: `verified-visible-partial-from-embedded-svg-image`
- readability: `high`
- cut off: `yes-bottom-continuation-in-S-140`
- confidence: `high-for-visible-text`
- theme: component example without combine

#### Verified visible text

```text
7. Example in a component

Without `combine`:
```

#### Verified visible code

```ts
function BookPage({ bookId }: { bookId: string }) {
  const [bookQuery, reviewsQuery] = useQueries({
    queries: [
      { queryKey: ['book', bookId], queryFn: () => getBook(bookId) },
      { queryKey: ['reviews', bookId], queryFn: () => getReviews(bookId) },
    ],
  })

  if (bookQuery.status === 'pending' || reviewsQuery.status === 'pending') {
    return <div>Loading...</div>
  }
```

#### Notes

Visible bottom is cut off. The component continues in S-140.

---

### R06-S002 / S-140 - `52ce7625ac`

Metadata:

- status: `verified-visible-continuation-from-embedded-svg-image`
- readability: `high`
- cut off: `yes-top-continuation-from-S-126`
- confidence: `high-for-visible-text`
- theme: component example without combine continuation

#### Verified visible code

```ts
if (bookQuery.status === 'error' || reviewsQuery.status === 'error') {
    return <div>Something went wrong</div>
  }

  return (
    <div>
      <h1>{bookQuery.data.title}</h1>
      <div>{reviewsQuery.data.length} reviews</div>
    </div>
  )
}
```

#### Notes

Continuation of S-126.

---

### R06-S003 / S-128 - `664984d1b2`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: useQueries and dynamic useQueries

#### Verified visible text

```text
15.3 `useQueries`

Best of both worlds: separate caches, parallel execution, easy aggregation.

Dynamic `useQueries`
```

#### Verified visible code

```ts
const results = useQueries({
  queries: [
    { queryKey: ['repos'], queryFn: fetchRepos },
    { queryKey: ['members'], queryFn: fetchMembers },
  ],
})

function useRepoIssues(repoNames: string[]) {
  return useQueries({
    queries: repoNames.map((repo) => ({
      queryKey: ['issues', repo],
      queryFn: () => fetchIssues(repo),
    })),
  })
}
```

#### Notes

Verified from embedded SVG image.

---

### R06-S004 / S-130 - `d4b221fae1`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: dependent queries

#### Verified visible text

```text
14. Dependent queries

Sometimes query B needs data from query A.
```

#### Verified visible code

```ts
function useMovie(title: string) {
  return useQuery({
    queryKey: ['movie', title],
    queryFn: () => getMovie(title),
  })
}

function useDirector(id?: string) {
  return useQuery({
    queryKey: ['director', id],
    queryFn: () => getDirector(id!),
    enabled: id !== undefined,
  })
}
```

#### Notes

Verified from embedded SVG image.

---

### R06-S005 / S-145 - `bfef41b217`

Metadata:

- status: `verified-visible-partial-from-embedded-svg-image`
- readability: `high`
- cut off: `top-context-cropped`
- confidence: `high-for-visible-text`
- theme: dependent query serial loading caveat

#### Verified visible text

```text
Dependent queries are correct, but they create serial loading.

If resources are independent, fetch them in parallel instead.
```

#### Verified visible code

```ts
function useMovieWithDirectorDetails(title: string) {
  const movie = useMovie(title)
  const directorId = movie.data?.director
  const director = useDirector(directorId)

  return { movie, director }
}
```

#### Notes

Top context is cropped; visible code/text is transcribed.

---

### R06-S006 / S-142 - `6c191bae1e`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: combine option for useQueries

#### Verified visible text

```text
15.4 `combine`

You can derive one combined result.
```

#### Verified visible code

```ts
function useBookAndReviews(bookId: string) {
  return useQueries({
    queries: [
      { queryKey: ['book', bookId], queryFn: () => getBook(bookId) },
      { queryKey: ['reviews', bookId], queryFn: () => getReviews(bookId) },
    ],
    combine: (queries) => {
      const isPending = queries.some((q) => q.status === 'pending')
      const isError = queries.some((q) => q.status === 'error')
      const [book, reviews] = queries.map((q) => q.data)

      return { isPending, isError, book, reviews }
    },
  })
}
```

#### Notes

Verified from embedded SVG image.

---

### R06-S007 / S-150 - `3071e8a02c`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: combine returns object-shaped result

#### Verified visible text

```text
With `combine`:
```

#### Verified visible code

```ts
function useBookAndReviews(bookId: string) {
  return useQueries({
    queries: [
      { queryKey: ['book', bookId], queryFn: () => getBook(bookId) },
      { queryKey: ['reviews', bookId], queryFn: () => getReviews(bookId) },
    ],
    combine: (queries) => {
      return {
        isPending: queries.some((q) => q.status === 'pending'),
        isError: queries.some((q) => q.status === 'error'),
        book: queries[0].data,
        reviews: queries[1].data,
      }
    },
  })
}
```

#### Notes

Verified from embedded SVG image.

---

### R06-S008 / S-159 - `36f2dd3bd7`

Metadata:

- status: `verified-visible-partial-from-embedded-svg-image`
- readability: `high`
- cut off: `top-context-cropped`
- confidence: `high-for-visible-text`
- theme: component consuming combined result

#### Verified visible text

```text
This is easier to read because the component gets exactly what it needs.
```

#### Verified visible code

```ts
function BookPage({ bookId }: { bookId: string }) {
  const { isPending, isError, book, reviews } = useBookAndReviews(bookId)

  if (isPending) return <div>Loading...</div>
  if (isError) return <div>Something went wrong</div>

  return (
    <div>
      <h1>{book?.title}</h1>
      <div>{reviews?.length ?? 0} reviews</div>
    </div>
  )
}
```

#### Notes

Top context is cropped; visible code/text is transcribed. This source pairs with S-150.

---

### R06-S009 / S-157 - `7897e4ffa9`

Metadata:

- status: `verified-from-embedded-svg-image`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: parallel queries with multiple useQuery calls

#### Verified visible text

```text
15. Parallel queries

15.1 Multiple `useQuery` calls

Best when resources are independent.
```

#### Verified visible code

```ts
const reposQuery = useQuery({
  queryKey: ['repos'],
  queryFn: fetchRepos,
})

const membersQuery = useQuery({
  queryKey: ['members'],
  queryFn: fetchMembers,
})
```

#### Notes

Verified from embedded SVG image.

---

### R06-S010 / S-165 - `58affaa7df`

Metadata:

- status: `verified-visible-partial-from-embedded-svg-image`
- readability: `high`
- cut off: `top-context-cropped`
- confidence: `high-for-visible-text`
- theme: independent query lifecycle

#### Verified visible text

```text
Each query gets its own:

- cache entry
- loading state
- error state
- retry logic
- stale/fetch lifecycle
```

#### Notes

Top context is cropped. This appears to continue the parallel queries explanation.

---

## Stage 4i correction addendum - R06 v002

Generated: 2026-06-01 22:02:02 UTC

### Direction check

Goal: finish the audited correction for R06 under the no-image-loss boundary rules.
Now: R06 v001 contained the main `useQueries` / dependent / combine transcript, but audit found one missing continuation.
This step: add `S-176` and explicitly document neighboring R07 sources that are not R06.
Why: `Promise.all` inside one `queryFn` is query composition, while the adjacent prefetch/fetchQuery road belongs to R07.

### 0.2 Coverage / boundary review update

Included in R06 v002:

```text
S-126, S-128, S-130, S-140, S-142, S-145, S-150, S-157, S-159, S-165, S-176
```

Added in v002:

```text
S-176 -> 15.2 One query with Promise.all
```

Checked but excluded from R06:

```text
S-132, S-146, S-162, S-171, S-180 -> R07 prefetch / staleTime / fetchQuery / ensureQueryData road, not R06.
```

### R06-S011 / S-176 - `f7fe899443`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `same-road-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: 15.2 One query with Promise.all

#### Verified visible text

```text
15.2 One query with `Promise.all`

This is simple, but both requests now:

- fetch together
- refetch together
- error together
- share one lifecycle
```

#### Verified visible code

```ts
useQuery({
  queryKey: ['reposAndMembers'],
  queryFn: () => Promise.all([fetchRepos(), fetchMembers()]),
})
```

### R06 v002 interpretation update

`Promise.all` inside one `queryFn` is the compact alternative where several requests are treated as one query lifecycle. This belongs to R06 because it is about query composition, not prefetching.

## What should be recallable

- How useQueries, dependent queries, and combine express query composition.
- Where serial dependencies differ from parallel query execution.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R06-query-composition-usequeries-dependent-combine.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
