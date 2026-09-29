# React Query core architecture and practical patterns

Knowledge ID: `react-query.core-architecture-and-practical-patterns`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R24-cheat-sheet-summary-core-patterns.md`


### S-485 - 39. Best practices summary

Metadata:
```text
source_id: S-485
image_use_id: IU-485
fileId_short: 8551008f16
image_file: S-485__8551008f16.png
stage6a_group: R21
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
39. Best practices summary
Always do these
* cteate one stable QueryClient
© put every query input into the queryKey
© treat staleTime and gcTime as different concepts
* handle loading/error states safely
* use custom hooks for reusable queries
* prefer declarative key changes over manual (refetch
* use invalidation after writes unless manual cache updates are clearly simpler
* keep cache updates immutable
* use query key factories in medium/large apps
* prefer network mocking over mocking {useQuery) in tests
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-489 - Be careful with these

Metadata:
```text
source_id: S-489
image_use_id: IU-489
fileId_short: 2a8a82cfff
image_file: S-489__2a8a82cfff.png
stage6a_group: R21
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Be careful with these

* creating QueryClient inside a component

* forgetting dynamic values in the key

* accessing (data.map(...) before data exists

© using queries for server writes

© mutating cached objects in place

© overusing manual |etQuérybata) for complex list scenarios
* confusing isPending, isLoading, and isFetching
* confusing staleTime with gcTime

© mocking [useQuery) directly in tests

«  destructuring query results with the rest operator

* assuming Suspense queries support ‘enabled
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-503 - 27. Infinite queries

Metadata:
```text
source_id: S-503
image_use_id: IU-503
fileId_short: e6431cdcfb
image_file: S-503__e6431cdcfb.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
27. Infinite queries
*  useInfiniteQuery
* one long logical cache entry
*° data.pages
* = data_pageParams
© initialPageParam
*  getNextPageParam
*©  fetchNextPage
*  hasNextPage
©  isFetchingNextPage
* flatten pages
* bidirectional infinite queries
* intersection observer for load-more
* consistency on refetch
28. Query purity
* queries for reading only
query functions should be idempotent
* no server side effects in queries
* writes belong to mutations
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-504 - 11. Refetch triggers

Metadata:
```text
source_id: S-504
image_use_id: IU-504
fileId_short: 8f84323643
image_file: S-504__8f84323643.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
11. Refetch triggers
«key changes
* mount/new observer
* window focus
* reconnect
*  refetchOnMount
© refetchOnWindowFocus
* — refetchOnReconnect
12. Cache lifetime
* active query
* inactive query
© observer count = 0
© gcTime
«default garbage collection idea
* freshness vs retention
* fresh data can still be garbage-collected if inactive
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-505 - 33. Optimistic updates

Metadata:
```text
source_id: S-505
image_use_id: IU-505
fileId_short: 4501984f59
image_file: S-505__4501984f59.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
33. Optimistic updates

* instant Ul updates before server confirms
* cancel in-flight queries

«snapshot previous cache

* optimistic [SetQueryData

© rollback on error

invalidate on settle

* useful for predictable UI changes

34. Defaults and configuration

© global defaults in (QueryClignt

*  defaultOptions

* queries

© mutations

© per-key defaults with setQueryDefaults
© per-query override in useQuery
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-506 - 18. ESLint support

Metadata:
```text
source_id: S-506
image_use_id: IU-506
fileId_short: aff7a63b67
image_file: S-506__aff7a63b67.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
18. ESLint support

© @tanstack/eslint-plugin-query

* exhaustive key dependency checking
19. Parallel queries

© multiple (useQuery) calls

* separate lifecycle per query

* parallel fetching for independent resources
20. Multiple requests in one query

© one (querykn

© Promise.all

* one cache entry

* one loading state

* one error state

* one retry lifecycle

* no separate deduplication
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-509 - 5. Query states

Metadata:
```text
source_id: S-509
image_use_id: IU-509
fileId_short: 18e061539b
image_file: S-509__18e061539b.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
5. Query states
*° status
*°  fetchStatus
* isPending
* isLoading
© isFetching
© isError
*  isSuccess
* isStale
6. Safe rendering
© guard against data being undefined
* loading branch
© error branch
* success branch
«render order of async states
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-510 - 59. Persisted mutations

Metadata:
```text
source_id: S-510
image_use_id: IU-510
fileId_short: cbf6a625d3
image_file: S-510__cbf6a625d3.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
59. Persisted mutations
© mutation defaults for restore
* replay persisted writes
* resume in original order
* side effects after restore
60. Real-time / WebSockets
© push-based updates
* invalidate on server message
* direct setQueryData from server message
* real-time app strategy
* event-driven freshness
61. On-demand app strategy
© staleTime: Infinity
* rely on server push
* invalidate from events
© direct cache writes from events
* no time-based freshness checks
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-511 - React Query / TanStack Query Cheat Sheet Topics

Metadata:
```text
source_id: S-511
image_use_id: IU-511
fileId_short: ebb15590fa
image_file: S-511__ebb15590fa.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
React Query / TanStack Query Cheat Sheet Topics
1. Core idea

© server-state manager

* async, promise-based state

* caching

* background refetching

* loading/error/success states

* query vs mutation

* server state vs client state
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-514 - 77. Core architecture mental model

Metadata:
```text
source_id: S-514
image_use_id: IU-514
fileId_short: 410db3d5df
image_file: S-514__410db3d5df.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
77. Core architecture mental model
© observers
* cache
* subscriptions
* Ulupdates triggered from cache changes
* adapters built on query core
78. Performance philosophy
* render cheaper rather than only render less
© React.memo
°  useMemo
© useCallback
© query structural sharing
* small subscriptions via (select
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-515 - 2. Setup

Metadata:
```text
source_id: S-515
image_use_id: IU-515
fileId_short: 064a1ad368
image_file: S-515__064a1ad368.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
2. Setup

*  QueryClient

* create client outside render

© QueryClientProvider

* one stable client

* shared cache through provider

* context used for client injection
3. useQuery basics

*  queryKey

© queryFn

* subscription to cache

+ rerenders on relevant state/data change

* custom query hooks
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-517 - 29. Mutations

Metadata:
```text
source_id: S-517
image_use_id: IU-517
fileId_short: a1b7bbb50b
image_file: S-517__a1b7bbb50b.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
29. Mutations
* useMutation
© = mutationFn
° mutate
© mutation variables
* mutation lifecycle states
*  onMutate
* ~ onSuccess
*  onError
* ~ onSettled
30. Cache updates after mutation
* queryClient.setQueryData
«immutable updates only
« do not mutate cached objects in place
* return new references
* manual detail cache updates
© manual list cache updates
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-518 - 53. networkMode

Metadata:
```text
source_id: S-518
image_use_id: IU-518
fileId_short: 22618c5d8b
image_file: S-518__22618c5d8b.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
53. networkMode
* online
° always
*  offlineFirst
* queries that do not require network
© offline-aware retries/resume
54. Offline mutations
© queue writes while offline
«replay on reconnect
* mutation ordering on restore
* invalidation/refetch bursts after reconnect
55. Persistence
«in-memory cache by default
* cache lost on reload/tab close/navigation
+ persisters
* sync persister
* async persister
*  PersistQueryClientProvider
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-519 - 13. Conditional queries

Metadata:
```text
source_id: S-519
image_use_id: IU-519
fileId_short: dd54fb38a9
image_file: S-519__dd54fb38a9.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
13. Conditional queries

* hooks must not be conditional

© (enabled

* disabled query states

* status: "pending' with fetchStatus: ‘idle"

* separate “no input yet” UI

* conditional component mounting as alternative
14. Polling

© (refetchInterval

* fixed interval polling

¢ function form of refetchInterval

* stop polling with false

* polling until condition is met
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-520 - 44. Request cancellation

Metadata:
```text
source_id: S-520
image_use_id: IU-520
fileId_short: c85b8a0c7c
image_file: S-520__c85b8a0c7c.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
44. Request cancellation

* ~AbortSignal

* pass signal to fetch

* cancel obsolete in-flight requests

* useful for search and navigation
45. Retry behavior

© retry

* retryDelay

* retry function form

* retries before final error state

*  pending/fetching during retries
46. Error handling

* local isError) rendering

© query final error state

«local error UI vs global error handling
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-521 - 21. Dependent queries

Metadata:
```text
source_id: S-521
image_use_id: IU-521
fileId_short: 27be4eaafb
image_file: S-521__27be4eaafb.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
21. Dependent queries
* second query depends on first
* enabled with derived ID
* serial loading
* composed hooks for dependencies
22. useQueries
© array of query configs
* parallel queries with separate caches
© dynamic query arrays
* combine results
«derive aggregate flags
© combine
23. Prefetching
* queryClient.prefetchQuery
* prefetch on hover
* prefetch likely next route
«prefetch likely next page
* prefetch does not guarantee no loading UI
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-522 - 62. Suspense basics

Metadata:
```text
source_id: S-522
image_use_id: IU-522
fileId_short: 6a97b2c3f6
image_file: S-522__6a97b2c3f6.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
62. Suspense basics
* Suspense moves loading handling up the tree
© boundary fallback
* success-only query components
63. useSuspenseQuery
*  Suspense-oriented query hook
* no manual loading branch
«data assumed ready in render
* wrap with Suspense
64. Suspense limitations
* no enabled
* conditional mounting instead of enabled
* composition patterns instead of conditional hooks
65. Suspense serial behavior
«multiple suspense queries in one component can run serially
© split into siblings/components for better parallelism
* separate boundaries per section
7
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-523 - 35. Query key factories

Metadata:
```text
source_id: S-523
image_use_id: IU-523
fileId_short: dc849d0bfb
image_file: S-523__dc849d0bfb.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
35. Query key factories
* central key helpers
© one factory per feature
«shared prefix per feature
¢  list/detail/all variants
* safer invalidation
° safer reuse
36. Query option factories
* reusable query config builders
* return queryKey
* retum queryFn
« retum shared options
«merge per-use overrides
37. Structural sharing
* unchanged nested references preserved
© helps React.memo
«helps dependency arrays
* content matters, not wrapper identity
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-525 - 7. Query functions

Metadata:
```text
source_id: S-525
image_use_id: IU-525
fileId_short: 50c2040d0f
image_file: S-525__50c2040d0f.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
7. Query functions
© async/await
* response.ok checks
«throw on bad responses
«thrown async errors become rejected promises
© do not swallow errors
8. Declarative refetching
* use queryKey changes instead of manual refetch
* avoid imperative refetch when input belongs in key
© (refetch() as manual override only
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-526 - 79. Practical anti-patterns

Metadata:
```text
source_id: S-526
image_use_id: IU-526
fileId_short: 59c3bada86
image_file: S-526__59c3bada86.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
79. Practical anti-patterns
© creating QueryClient inside component
* forgetting dynamic values in querykey
* conditionally calling query hooks
mutating cached data
* using queries for writes
* swallowing query errors
«mocking [useQuery in tests
«rest destructuring query result
* giant app-wide suspense fallback for everything
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-527 - 4. Query rules

Metadata:
```text
source_id: S-527
image_use_id: IU-527
fileId_short: c97e56b4c7
image_file: S-527__c97e56b4c7.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
4. Query rules
© (querykey must uniquely identify data
© queryFn must return a Promise
include every value used by queryfn in queryKey
© query keys can contain arrays and objects
«deterministic key hashing
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-529 - 56. Persisted hydration flow

Metadata:
```text
source_id: S-529
image_use_id: IU-529
fileId_short: 1ab0020f75
image_file: S-529__1ab0020f75.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
56. Persisted hydration flow

* restoration before queries run

* restoration fallback/loading UI

* avoid fresh queries before restore completes
57. Selective persistence

«do not persist everything

*  metadata-based persistence flags

* persist only successful queries

© dehydrate filters

*  sensitive/large data filtering
58. Persistence storage limits

* localStorage quota

* pruning

* remove oldest query strategy

* selective persistence to avoid quota issues
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-530 - 24. initialData

Metadata:
```text
source_id: S-530
image_use_id: IU-530
fileId_short: 5632bffbe4
image_file: S-530__5632bffbe4.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
24. initialData
* seed query from existing cache
© hydrate detail from list cache
* synchronous initial value
25. placeholderData
temporary visual data while real fetch runs
* keep previous page visible
* smooth transitions
* not the same as final data
26. Pagination
* page in queryKkey
* one cache entry per page
© prev/next page logic
* placeholder while switching
* prefetch next page
* unknown total pages handling
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-532 - 15. Derived query UI flags

Metadata:
```text
source_id: S-532
image_use_id: IU-532
fileId_short: 796c21f006
image_file: S-532__796c21f006.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
15. Derived query UI flags
© isFetching for background activity
© isStale for outdated cache
* stale indicator
* background refresh indicator
16. Custom hooks
© wrap [useQuery, in reusable hooks
*  deaner components
* parameterized query hooks
* composition of hooks
17. Dynamic query keys
* ~ ["book", bookId]
°  ['repos", sort]
*  [‘repos*, sort, page]
* key must change when data source changes J,
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-534 - 31. Invalidation

Metadata:
```text
source_id: S-534
image_use_id: IU-534
fileId_short: 7ad6555434
image_file: S-534__7ad6555434.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
31. Invalidation

© queryClient.invalidateQueries

* refetch active queries

* mark inactive queries stale

* safer than manual updates in many cases

* verify cache after server change
32. Invalidation matching

© fuzzy query key matching

* prefix matching

* invalidate subsets by prefix

*° stale: true

© type: ‘active’

* predicate

* refetchType: ‘all’
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-536 - 9. Shared cache and observers

Metadata:
```text
source_id: S-536
image_use_id: IU-536
fileId_short: bf8890fd14
image_file: S-536__bf8890fd14.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
9. Shared cache and observers
«shared cache through same provider
* multiple components observing same query
© observer count
* updates fan out to subscribers

10. Freshness and staleness
*°  staleTime
© default staleTime: @

* stale vs fresh

* stale data still usable

* stale data better than no data

* background refetch on stale queries
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-537 - 80. Good practical patterns

Metadata:
```text
source_id: S-537
image_use_id: IU-537
fileId_short: 704b310795
image_file: S-537__704b310795.png
stage6a_group: R23
stage6d_region: R24
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
80. Good practical patterns
* one stable client
* custom hooks
© query key factories
*  per-feature query factories
* invalidate after mutations
* optimistic update + rollback + invalidate
* use select for narrow subscriptions
* use stale cached data while background fetching
* use ErrorBoundary + QueryErrorResetBoundary
* use MSW + fresh QueryClient in tests
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## What should be recallable

- The source's consolidated architecture model, setup rules, and best-practice checklist.
- The major anti-patterns and decision rules spanning queries, mutations, persistence, Suspense, and testing.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R24-cheat-sheet-summary-core-patterns.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
