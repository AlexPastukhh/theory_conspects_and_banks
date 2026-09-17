# React Query cancellation and AbortSignal

Knowledge ID: `react-query.query-cancellation-and-abortsignal`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R15-query-cancellation-abortsignal.md`


### S-376 - Suspense hooks and cancellation limitation

Metadata:
```text
source_id: S-376
image_use_id: IU-376
fileId_short: 2e53933f4d
image_file: S-376__2e53933f4d.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
This does not work with `useSuspenseQuery`; TanStack Query documents that cancellation does not work for Suspense hooks.

Full example begins with imports, `QueryClient`, `QueryClientProvider`, `useQuery`, and `useQueryClient`; then defines a `Product` type.
```

#### Verified visible code
```tsx
import * as React from 'react'
import {
  QueryClient,
  QueryClientProvider,
  useQuery,
  useQueryClient,
} from '@tanstack/react-query'

const queryClient = new QueryClient()

type Product = {
  id: number
  name: string
}
```

#### Notes

Top of full cancellation example; continuation in S-378 and S-381/S-383.

---

### S-378 - fetch with AbortSignal and useQuery receives signal

Metadata:
```text
source_id: S-378
image_use_id: IU-378
fileId_short: ff1f13ba3a
image_file: S-378__ff1f13ba3a.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Continuation of the full request-cancellation example. The API function accepts `AbortSignal`, passes it to `fetch`, and `useQuery` passes the query `signal` into that function.
```

#### Verified visible code
```tsx
type ProductsResponse = {
  page: number
  items: Product[]
  hasMore: boolean
}

// Simulated API call using fetch + AbortSignal
async function fetchProducts(page: number, signal?: AbortSignal): Promise<ProductsResponse> {
  const res = await fetch(`/api/products?page=${page}`, { signal })

  if (!res.ok) {
    throw new Error(`Failed to fetch page ${page}`)
  }

  return res.json()
}

function ProductsPage() {
  const [page, setPage] = React.useState(1)
  const [isPending, startTransition] = React.useTransition()
  const queryClient = useQueryClient()

  const query = useQuery({
    queryKey: ['products', page],
    queryFn: ({ signal }) => fetchProducts(page, signal),
    staleTime: 0,
  })
}
```

#### Notes

Readable top/central part; later page handlers continue in S-381/S-383.

---

### S-379 - query functions can receive AbortSignal

Metadata:
```text
source_id: S-379
image_use_id: IU-379
fileId_short: 3183b42852
image_file: S-379__3183b42852.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
27. Request cancellation

Query functions can receive an `AbortSignal`.

If the query becomes obsolete, React Query can cancel the request.

Useful for:

- fast-changing search input
- navigation away
- outdated request replacement
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos', search],
  queryFn: ({ signal }) =>
    fetch(`/api/todos?q=${search}`, { signal }).then((r) => r.json()),
})
```

#### Notes

Readable.

---

### S-381 - explicitly cancel older product-page requests before navigation

Metadata:
```text
source_id: S-381
image_use_id: IU-381
fileId_short: a0ea9f6a34
image_file: S-381__a0ea9f6a34.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
The example explicitly cancels older product-page requests before moving to the next or previous page. This is useful when users click quickly and older pages are no longer interesting.
```

#### Verified visible code
```tsx
const goToNextPage = () => {
  const nextPage = page + 1

  // Optional: explicitly cancel older product-page requests.
  // This is useful when user clicks quickly and you know
  // older pages are no longer interesting.
  queryClient.cancelQueries({
    queryKey: ['products'],
  })

  startTransition(() => {
    setPage(nextPage)
  })
}

const goToPrevPage = () => {
  if (page === 1) return

  const prevPage = page - 1

  queryClient.cancelQueries({
    queryKey: ['products'],
  })

  startTransition(() => {
    setPage(prevPage)
  })
}
```

#### Notes

Readable; duplicated by S-383.

---

### S-383 - duplicate source: explicit cancelQueries page navigation

Metadata:
```text
source_id: S-383
image_use_id: IU-383
fileId_short: a0ea9f6a34
image_file: S-383__a0ea9f6a34.png
status: verified-visible-duplicate
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Duplicate visual source of S-381: explicit `queryClient.cancelQueries({ queryKey: ['products'] })` before page transitions.
```

#### Verified visible code
```tsx
queryClient.cancelQueries({
  queryKey: ['products'],
})

startTransition(() => {
  setPage(nextPage)
})
```

#### Notes

S-383 has the same image/fileId as S-381; kept as duplicate-source evidence so the source is not lost.

---

## What should be recallable

- How a query function consumes AbortSignal.
- What cancelQueries can and cannot cancel, including Suspense limitations.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R15-query-cancellation-abortsignal.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
