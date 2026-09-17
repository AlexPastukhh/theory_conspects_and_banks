# React Query error boundaries, throwOnError, and reset

Knowledge ID: `react-query.error-boundaries-throwonerror-and-reset`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R16-error-boundary-throwonerror-reset.md`


### S-390 - 29. Error handling

Metadata:
```text
source_id: S-390
image_use_id: IU-390
fileId_short: 47947570b6
image_file: S-390__47947570b6.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
29. Error handling
29.1 Local error Ul
‘> TypeScript
const { isError, error } = useQuery({
queryKey: ['‘repos'],
queryFn: fetchRepos,
})
if (isError) {
return <div>{(error as Error) .message}</div>
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-394 - 29.2 Error boundaries with throwOnError

Metadata:
```text
source_id: S-394
image_use_id: IU-394
fileId_short: b3351d14fd
image_file: S-394__b3351d14fd.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
29.2 Error boundaries with throwOnError

Error boundaries catch render-time errors.

To let query errors surface into render, use throwOnError .
‘> TypeScript ‘eo
function useTodos() {

return useQuery({
queryKey: [‘todos'’, ‘list'],
queryFn: fetchTodos,
throwOnError: true,
})
}
Then wrap with an error boundary.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-398 - 29.3 Conditional throwOnError

Metadata:
```text
source_id: S-398
image_use_id: IU-398
fileId_short: bfb1da8007
image_file: S-398__bfb1da8007.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
29.3 Conditional throwOnError
Often you want to throw only when there is no cached data.
‘> TypeScript oO
useQuery({
queryKey: [‘todos', ‘list'],
queryFn: fetchTodos,
throwOnError: (_error, query) => typeof query.state.data === ‘undefined’,
})
This is a great pattern:
¢ initial load failure — throw to boundary
e background refetch failure while old data exists - keep showing stale data
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-405 - 29.4 QueryErrorResetBoundary

Metadata:
```text
source_id: S-405
image_use_id: IU-405
fileId_short: 913168d66e
image_file: S-405__913168d66e.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
29.4 QueryErrorResetBoundary
Use this to integrate error boundaries with query retries.
‘> TypeScript
import { QueryErrorResetBoundary } from ‘@tanstack/react-query'
import { ErrorBoundary } from ‘react-error-boundary'
fon etinn TrandancDaanl) FF
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-407 - Not immediately.

Metadata:
```text
source_id: S-407
image_use_id: IU-407
fileId_short: 750efbd479
image_file: S-407__750efbd479.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Not immediately.

lf retries are configured, React Query usually does not throw to the Error Boundary on the first failed
attempt.

lt first uses its retry logic.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-408 - FLOW 1 — First render, query starts

Metadata:
```text
source_id: S-408
image_use_id: IU-408
fileId_short: b3e6794ae9
image_file: S-408__b3e6794ae9.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
FLOW 1 — First render, query starts
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-409 - Step 1

Metadata:
```text
source_id: S-409
image_use_id: IU-409
fileId_short: 80a0e0aac1
image_file: S-409__80a0e0aac1.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 1
React renders TodosPage .
Inside it, React renders:
® QueryErrorResetBoundary
e then ErrorBoundary
e then Todos
Step 2
Todos runs.
Inside Todos , useQuery(...) runs with:
‘> TypeScript
queryKey: [‘todos' ]
queryFn: fetchTodos
throwOnError: true
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-411 - Only after the query ends up in its final error state does throwOnError matter for render.

Metadata:
```text
source_id: S-411
image_use_id: IU-411
fileId_short: e55cc5a5e6
image_file: S-411__e55cc5a5e6.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Only after the query ends up in its final error state does throwOnError matter for render.
So the rough order is:
1. query runs
2. request fails
3. React Query retries if allowed
4. if aretry later succeeds — no thrown render error
5. if all retries fail and query ends in error state — then throwOnError can throw during render
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-412 - function TodosPage() {

Metadata:
```text
source_id: S-412
image_use_id: IU-412
fileId_short: c1bdab56fb
image_file: S-412__c1bdab56fb.png
stage6a_group: R16
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
function TodosPage() {
return (
<QueryErrorResetBoundary>
{({ reset }) => (
<ErrorBoundary
onReset={reset}
fallbackRender={({ error, resetErrorBoundary }) => (
<div>
<p>{error .message}</p>
<button onClick={resetErrorBoundary}>Try again</button>
</div>
)}
>
<Todos />
</ErrorBoundary>
)}
</QueryErrorResetBoundary>
)
}
Recovery flow:
1. reset boundary
2. refetch query A];
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-419 - 29.5 Global error handling

Metadata:
```text
source_id: S-419
image_use_id: IU-419
fileId_short: 2736adf8b0
image_file: S-419__2736adf8b0.png
stage6a_group: R19
stage6b_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
29.5 Global error handling
You can configure defaults in the client.
‘> TypeScript ‘eo
const queryClient = new QueryClient({
defaultOptions: {
queries: {
throwOnError: (_error, query) => typeof query.state.data === ‘undefined’,
hs
}>
})
And surface non-boundary errors through:
e toast
¢ global notification
e logging
* query-cache callbacks
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## Authoritative claim transcript: `R16-v002-error-boundary-reset-flow.md`


### S-416 - Step 3

Metadata:
```text
source_id: S-416
image_use_id: IU-416
fileId_short: 3a4b17c0bd
image_file: S-416__3a4b17c0bd.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 3
React Query looks for [*todos*] in the cache.
Assume:
* no successful data yet
© request starts
Step 4
At some point the request fails.
So query state becomes roughly:
* status = error
* error = some Error( ‘Failed to load todos’)
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-422 - FLOW 2 — Error gets thrown into render

Metadata:
```text
source_id: S-422
image_use_id: IU-422
fileId_short: 551b3e7039
image_file: S-422__551b3e7039.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
FLOW 2 — Error gets thrown into render
Step 5
React tries to render (Tedes) again.
Because query is now errored and [throwOnError? true), React Query throws the error during render.
So conceptually:
«” TypeScript
throw error
happens from inside {useQuery .
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-428 - Step 6

Metadata:
```text
source_id: S-428
image_use_id: IU-428
fileId_short: 57b6c5e673
image_file: S-428__57b6c5e673.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 6
That thrown error travels upward in the render tree.
ErrorBoundary catches it.
Step 7
Because |ErrorBoundary caught it, React does not render <Todos />-
Instead it renders the fallback
«” TypeScript
<div>
<p>{error.message}</p>
<button onClick={resetErrorBoundary}>Try again</button>
</div>
So now the user sees:
* error message
Try again button
1
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-437 - What is the state right now?

Metadata:
```text
source_id: S-437
image_use_id: IU-437
fileId_short: 05397c5c1b
image_file: S-437__05397c5c1b.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
What is the state right now?

At this moment:

ErrorBoundary state

“An error happened in my child subtree, so | am showing fallback.”
React Query state

“The [*todos*] query is errored.”

Both are now in an error-related state.

That is why recovery needs to reset both layers.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-444 - FLOW 3 — User clicks “Try again”

Metadata:
```text
source_id: S-444
image_use_id: IU-444
fileId_short: 183e59182f
image_file: S-444__183e59182f.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
FLOW 3 — User clicks “Try again”
User clicks:
«> TypeScript
<button onClick={resetErrorBoundary}>Try again</button>
Let's go step by step.
Step 8
resetErrorBoundary() is called.
This function belongs to the |ErrorBoundary .
Its job is:
* dear the boundary's internal “I caught an error” state
© try rendering children again
But there is more.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-454 - FLOW 4 — ErrorBoundary reset triggers React Query reset

Metadata:
```text
source_id: S-454
image_use_id: IU-454
fileId_short: b5e8b40ff4
image_file: S-454__b5e8b40ff4.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
FLOW 4 — ErrorBoundary reset triggers React Query reset

Remember this line:
> TypeScript oO
onReset={reset}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-457 - The reset here comes from QueryErrorResetBoundary .

Metadata:
```text
source_id: S-457
image_use_id: IU-457
fileId_short: a7257b2fb8
image_file: S-457__a7257b2fb8.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
The reset here comes from QueryErrorResetBoundary .

So when |ReSetERFenBaundary() resets the boundary, the boundary also calls:
«> TypeScript oO
onReset()

which means:
«> TypeScript oO
reset()

from QueryErrorResetBoundary -
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-464 - Step 9

Metadata:
```text
source_id: S-464
image_use_id: IU-464
fileId_short: 60fc4df97e
image_file: S-464__60fc4df97e.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 9

So now two things happen together:

A. ErrorBoundary resets

It stops showing fallback and is ready to render children again.

B. QueryErrorResetBoundary resets query error recovery state

It tells React Query something like:
“Okay, this boundary was reset. Queries inside it are allowed to retry/recover instead of just rethrowing
the previous error state immediately.”

This is the key bridge.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-469 - FLOW 5 — React tries to render Todos again

Metadata:
```text
source_id: S-469
image_use_id: IU-469
fileId_short: bf76afefe1
image_file: S-469__bf76afefe1.png
stage6a_group: R21
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
FLOW 5 — React tries to render Todos again
Step 10
After reset, React renders the children of the boundary again.
So it renders (<Tedos />) again.
Step 11
Todos runs useQuery(...) again.
React Query sees:
* same query key: ["todos*]
* the boundary reset has happened
* this query is now allowed to attempt recovery/refetch instead of staying stuck in the previous thrown-
error cycle
Step 12
The query gets another chance to run.
Possible outcomes: v
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-507 - 50. Global error strategy

Metadata:
```text
source_id: S-507
image_use_id: IU-507
fileId_short: e4cef97c4a
image_file: S-507__e4cef97c4a.png
stage6a_group: R23
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
50. Global error strategy
© dient defaults for | throwOnError
© query cache level (onError
© toast/global notifications
«keep stale data visible on background refetch failure
51. Response validation
* validate API shape
* Zod as example
«throw invalid data into query error path
* tradeoff: runtime cost
© useful for unreliable/third-party APIs
52. Offline support
* paused queries
*° fetchStatus: "paused"
* offline Ul vs loading UI
* resume on reconnect
a Lb
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-528 - 47. Error Boundaries

Metadata:
```text
source_id: S-528
image_use_id: IU-528
fileId_short: 40bed35fff
image_file: S-528__40bed35fff.png
stage6a_group: R23
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
47. Error Boundaries
+ render-time error handling
© throwOnError
© boundary fallback Ul
© retry/recovery flow
48. throwOnError
* boolean form
© callback form
* throw only when no cached data exists
* throw only for some error types
+ retries happen before final throw behavior matters
49. QueryErrorResetBoundary
* connects query error recovery with Error Boundary reset
© [reset
© [onReset
© resetErrorBoundary
* reset boundary + retry query flow V
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-533 - 66. Suspense + ErrorBoundary

Metadata:
```text
source_id: S-533
image_use_id: IU-533
fileId_short: d36e67e421
image_file: S-533__d36e67e421.png
stage6a_group: R23
stage6d_region: R16
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
66. Suspense + ErrorBoundary

* Suspense for loading

«©  ErrorBoundary for errors

* paired boundary pattern
67. Transitions

*  useTransition

©  startTransition

° isPending

* old UI stays visible while new UI prepares

+ smoother pagination/filter changes with Suspense
68. Transition mental model

* urgent vs non-urgent updates

* background preparation

«delayed commit of transition result

* pending marker while old Ul remains visible
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## What should be recallable

- When query errors are returned as state or thrown during render.
- How QueryErrorResetBoundary coordinates retry after an ErrorBoundary reset.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R16-error-boundary-throwonerror-reset.md`, source-transcript section
- Authoritative processed source: `regions/R16-v002-error-boundary-reset-flow.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
