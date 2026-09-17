# Transitions, Suspense, and query cancellation

Knowledge ID: `react.transitions-suspense-and-query-cancellation`

Topic: `react`

`startTransition` marks state work as non-urgent. React keeps the last committed UI visible while rendering the next tree, and `isPending` describes pending transition work. A newer transition may interrupt or supersede an intermediate render, but interruption does not cancel network I/O by itself.

Keep controlled-input updates urgent, then transition the expensive derived update:

```tsx
const [isPending, startTransition] = useTransition();

function onChange(event: React.ChangeEvent<HTMLInputElement>) {
  const next = event.target.value;
  setInput(next);
  startTransition(() => setFilter(next));
}
```

Transitions are scheduling, not a fixed delay, debounce, loading/error model, or request-cancellation mechanism. React may restart non-urgent renders and commit only the latest state, so expensive children still benefit from memoization, virtualization, and profiling. Work after an `await` may need another transition boundary depending on the React version/API semantics. Do not let transition UI hide confirmation required for a destructive action.

Suspense can keep the previous completed boundary visible while the next result is unavailable:

```text
page 1 committed → page 2 transition suspends → page 1 remains visible
```

One shared boundary coordinates the subtree as a unit; nested or separate boundaries can reveal independently completed parts. Multiple overlapping transitions share pending coordination rather than exposing a durable identity for each `startTransition` call, so workflows that require per-request ownership need explicit IDs/state and stale-result protection.

TanStack Query cancellation is a separate contract. An ordinary query can consume the supplied `AbortSignal`:

```tsx
useQuery({
  queryKey: ["users", filter],
  queryFn: ({ signal }) => fetch(`/api/users?q=${filter}`, { signal })
    .then(r => r.json()),
});
```

`queryClient.cancelQueries(...)` requests cancellation, but the underlying fetch stops only when the query function forwards the signal. Suspense-oriented query hooks have cancellation limitations, so do not infer transport cancellation from an interrupted render. Coordinate parent/child work with query keys, explicit cancellation, or request IDs rather than transition call order.

## React Query transition and pagination claim transcripts

The following source IDs retain the complete workspace-specific transition, Suspense, placeholder, and pagination timelines.

### Authoritative claim transcript: `R15-v002-query-cancellation-transition-tail.md`


### S-384 - 4

Metadata:
```text
source_id: S-384
image_use_id: IU-384
fileId_short: bbfaf9d502
image_file: S-384__bbfaf9d502.png
stage6a_group: R16
stage6b_region: R15
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
4
return (
<div>
<h2>Products</h2>
<div style={{ display: ‘flex’, gap: 8, marginBottom: 12 }}>
<button onClick={goToPrevPage} disabled={page === 1}>
Prev
</button>
<button onClick={goToNextPage}>
Next
</button>
<button
onClick={() => {
queryClient.cancelQueries({ queryKey: [“products*] })
}}
>
Cancel request
</button>
</div>
<div style={{ marginBottom: 12 }}>
<strong>Current page state:</strong> {page}
</div>
NY
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-388 - {isPending && <div>Transition pending. ..</div>}

Metadata:
```text
source_id: S-388
image_use_id: IU-388
fileId_short: 26a09fc19d
image_file: S-388__26a09fc19d.png
stage6a_group: R16
stage6b_region: R15
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
{isPending && <div>Transition pending. ..</div>}
{query.isFetching && <div>Fetching...</div>}
{query.isPending ? (
<div>Initial loading. ..</div>
) : query.isError ? (
<div>{(query.error as Error) .message}</div>
»: ¢
<ul>
{query .data.items.map((item) => (
<li key={item.id}>{item.name}</1i>
))}
</ul>
)}
</div>
)
}
export default function App() {
return (
<QueryClientProvider client={queryClient}>
<ProductsPage />
</QueryClientProvider>
)
}
sast a a fii a rr gs
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-392 - A slightly better version for many rapid clicks

Metadata:
```text
source_id: S-392
image_use_id: IU-392
fileId_short: bd24fb8749
image_file: S-392__bd24fb8749.png
stage6a_group: R16
stage6b_region: R15
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
A slightly better version for many rapid clicks
Instead of closing over page , compute next page from the updater and cancel before setting:
“> TypeScript 0)
const goToNextPage = () => {
queryClient.cancelQueries({ queryKey: [‘products*] })
startTransition(() => {
setPage((p) => p + 1)
+)
}
That is safer for repeated fast clicks because it avoids scale page reads.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-395 - Minimal version

Metadata:
```text
source_id: S-395
image_use_id: IU-395
fileId_short: 79093152e5
image_file: S-395__79093152e5.png
stage6a_group: R16
stage6b_region: R15
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Minimal version
If you want the smallest working pattern, it is this:
“> TypeScript 0)
const query = useQuery({
queryKey: [‘products’, page],
queryFn: async ({ signal }) => {
const res = await fetch( /api/products?page=${page}, { signal })
return res.json()
}5
})
const onNext = () => {
queryClient.cancelQueries({ queryKey: [‘products*] })
setPage((p) => p + 1)
}
That is the core idea.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### Authoritative claim transcript: `R17-useTransition-pagination-pending-ui.md`


### S-399 - 14. Practical rule for when to use it

Metadata:
```text
source_id: S-399
image_use_id: IU-399
fileId_short: 77f3392f85
image_file: S-399__77f3392f85.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
14. Practical rule for when to use it
Use useTransition when:
* anupdate may suspend
* an update causes heavy rerendering
e you want to keep current UI visible while the next UI is prepared
* one user action triggers both urgent and non-urgent updates
Do not use it for every state update.
For simple updates like:
e checkbox toggle
* modal open
¢ button hover
¢ small local state
it is usually unnecessary.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-402 - 1. Your sentence, translated into React terms

Metadata:
```text
source_id: S-402
image_use_id: IU-402
fileId_short: ae1e6f231c
image_file: S-402__ae1e6f231c.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
1. Your sentence, translated into React terms
You said:
react can understand what state change causes specific rerender and delay that specific rerender when
we do change with starttransition and pass all other rerender while the transition rerender prepares, so
the transitoin rerender will finally replace everything?
That is basically yes, with these corrections:
Better version
React can:
e mark updates inside startTransition as low priority
e start rendering the UI for those updates in the background
e allow other urgent updates/renders to happen meanwhile
e keep the currently committed UI visible while transition work is unfinished
e finally commit the transition result when it is ready
So yes, the transition render can eventually become the new visible UI.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-404 - 13. Without vs with: timeline comparison

Metadata:
```text
source_id: S-404
image_use_id: IU-404
fileId_short: 8e0c011793
image_file: S-404__8e0c011793.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
13. Without vs with: timeline comparison
Case: page change with Suspense
Without useTransition

1. user clicks Next

2. setPage(2) runs

3. React renders new page

4. query suspends

5. fallback replaces old content

6. data resolves

7. new content appears
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-410 - 2. What is being “delayed”?

Metadata:
```text
source_id: S-410
image_use_id: IU-410
fileId_short: c8f2acd497
image_file: S-410__c8f2acd497.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
2. What is being “delayed”?
Not exactly:
e the state value itself in some magical storage
e or “this rerender object”
What is mainly being delayed/deprioritized is:
e the rendering/commit of UI based on that transition update
* especially the replacement of already visible content
So React is not saying:
“| will ignore this state update for now.”
It is more like:
“| know this update matters, but | can prepare it at lower priority and avoid immediately replacing the
current screen.”
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-413 - With useTransition

Metadata:
```text
source_id: S-413
image_use_id: IU-413
fileId_short: 5e8f804ee4
image_file: S-413__5e8f804ee4.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
With useTransition
1. user clicks Next
2. startTransition(() => setPage(2))
3. React keeps old UI visible
4. React prepares new page in background
5. query suspends while preparing
6. isPending is true
7. data resolves
8. React swaps old content for new content
9. isPending becomes false
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-417 - 3. Can other renders pass while transition is preparing?

Metadata:
```text
source_id: S-417
image_use_id: IU-417
fileId_short: 0aad523474
image_file: S-417__0aad523474.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
3. Can other renders pass while transition is preparing?
Yes.

This is one of the main points.

While transition work is in progress, React can still process more urgent updates.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-418 - useTransition lets you mark a state update as non-urgent.

Metadata:
```text
source_id: S-418
image_use_id: IU-418
fileId_short: 3bdb1b257a
image_file: S-418__3bdb1b257a.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
useTransition lets you mark a state update as non-urgent.
That tells React:
e “this update is important, but not as important as keeping the UI responsive right now”
e “keep the current UI visible if possible while preparing the next one”
It is mostly about smoother UI during expensive or suspending updates.
1. What it returns
‘> TypeScript O
const [isPending, startTransition] = React.useTransition()
You get two things:
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-421 - 10. What isPending really means

Metadata:
```text
source_id: S-421
image_use_id: IU-421
fileId_short: 84844e7d4b
image_file: S-421__84844e7d4b.png
stage6a_group: R17
stage6b_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
10. What isPending really means

isPending becomes true while React is still working on the transition.
That may include:

e rendering work

¢ waiting for a suspended subtree to resolve

* preparing the next screen/list/page
It is often used for subtle status, not full replacement loading UI.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### Authoritative claim transcript: `R17-v002-useTransition-step-comparison.md`


### S-458 - 4. Step by step: without useTransition

Metadata:
```text
source_id: S-458
image_use_id: IU-458
fileId_short: 6417d8eeec
image_file: S-458__6417d8eeec.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
4. Step by step: without useTransition
Let’s use a common example: pagination with Suspense.
Example without transition
</> TypeScript
function ProductsPage() {
const [page, setPage] = React.useState(1)
return (
<>
<button onClick={() => setPage((p) => p + 1)}>Next</button>
<React.Suspense fallback={<div>Loading. ..</div>}>
<ProductsList page={page} />
</React.Suspense>
</>
)
}
And: NY
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-465 - And:

Metadata:
```text
source_id: S-465
image_use_id: IU-465
fileId_short: 5500f63476
image_file: S-465__5500f63476.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
And:
> TypeScript
function ProductsList({ page }: { page: number }) {
const { data } = useSuspenseQuery({
queryKey: [‘products', page],
queryFn: () => fetchProducts(page),
})
return (
<ul>
{data.items.map((item: any) => (
<li key={item.id}>{item.name}</1i>
))}
</ul>
)
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-471 - What happens step by step without transition

Metadata:
```text
source_id: S-471
image_use_id: IU-471
fileId_short: db04f35502
image_file: S-471__db04f35502.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
What happens step by step without transition
User clicks Next.
Step 1
React receives:
<> TypeScript
setPage(2)
Step 2
React starts rendering with page = 2.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-472 - Step 3

Metadata:
```text
source_id: S-472
image_use_id: IU-472
fileId_short: 6dfbaf8577
image_file: S-472__6dfbaf8577.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 3
ProductsList now asks for query [‘products", 2].
Step 4
That data is not ready yet, so useSuspenseQuery suspends.
Step 5
React immediately shows the Suspense fallback:
</> TypeScript
<div>Loading. ..</div>
Step 6
Old page content disappears.
Step 7
When new data finishes loading, React renders page 2.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-475 - User-visible behavior without transition

Metadata:
```text
source_id: S-475
image_use_id: IU-475
fileId_short: 6f877c2651
image_file: S-475__6f877c2651.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
User-visible behavior without transition
The user sees:
1. page 1 content
2. click Next
3. page 1 disappears immediately
4. loading fallback appears
5. page 2 appears
That can feel abrupt.
Especially if:
e data is slightly slow
e fallback flashes often
e user is navigating quickly
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-479 - 5. Step by step: with useTransition

Metadata:
```text
source_id: S-479
image_use_id: IU-479
fileId_short: 8e9a7a7ae4
image_file: S-479__8e9a7a7ae4.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
5. Step by step: with useTransition
Now same example with transition.
</> TypeScript
function ProductsPage() {
const [page, setPage] = React.useState(1)
const [isPending, startTransition] = React.useTransition()
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-482 - return (

Metadata:
```text
source_id: S-482
image_use_id: IU-482
fileId_short: f6e6efb55f
image_file: S-482__f6e6efb55f.png
stage6a_group: R22
stage6c_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
return (
<>
<button
onClick={() => {
startTransition(() => {
setPage((p) => p + 1)
})
tt
>
Next
</button>
{isPending && <small>Updating. ..</small>}
<React.Suspense fallback={<div>Loading. ..</div>}>
<ProductsList page={page} />
</React.Suspense>
</>
)
}
NY
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### Authoritative claim transcript: `R17-v003-transition-suspense-placeholder-tail.md`


### S-403 - 11. Transitions: keeping previous data visible

Metadata:
```text
source_id: S-403
image_use_id: IU-403
fileId_short: 4d034f9fe0
image_file: S-403__4d034f9fe0.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
11. Transitions: keeping previous data visible
This part is about making Suspense feel smoother during changes like:
* pagination
* filtering
* changing tabs
* changing selected item
Without a transition, changing input may immediately suspend and show fallback.
That can cause a flash:
* old content disappears
© spinner appears
* new content appears
Sometimes that feels too jumpy.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-414 - startTransition

Metadata:
```text
source_id: S-414
image_use_id: IU-414
fileId_short: 86c00bd7de
image_file: S-414__86c00bd7de.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
startTransition
React lets you mark an update as a transition.
During that transition, React may keep showing previous UI while the new suspended UI is preparing.
Example
«> TypeScript 0
import * as React from 'react"
import { Suspense } from 'react'
function ProductsPage() {
const [page, setPage] = React .useState(1)
const [isPending, startTransition] = React.useTransition()
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-420 - return (

Metadata:
```text
source_id: S-420
image_use_id: IU-420
fileId_short: 95c0e9bb43
image_file: S-420__95c0e9bb43.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
return (
<div>
<button
onClick={() => {
startTransition(() => {
setPage((p) => p - 1)
vn
hb
disabled={page === 1}
>
Prev
</button>
<button
onClick={() => {
startTransition(() => {
setPage((p) => p + 1)
vn
hb
>
Next
</button>
{isPending && <small>Updating. . .</small>}
1
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-423 - startTransition(fn)

Metadata:
```text
source_id: S-423
image_use_id: IU-423
fileId_short: 5d5a0ccf6e
image_file: S-423__5d5a0ccf6e.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
startTransition(fn)
Wrap state updates inside it.
> TypeScript oO
startTransition(() => {
setPage(2)
vn
Those updates become transition updates.
isPending
Boolean that becomes [##ué) while the transition is still in progress.
You can use it for small feedback like:
> TypeScript ia)
{isPending && <small>Updating. ..</smal1>}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-424 - Good:

Metadata:
```text
source_id: S-424
image_use_id: IU-424
fileId_short: 3be0fe3997
image_file: S-424__3be0fe3997.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Good:
> TypeScript oO
{isPending && <small>Updating. . .</smal1>}

Usually less good:
«> TypeScript ia’)
{isPending ? <BigSpinner /> : <FullUI />}

because that often defeats the point of keeping previous UI visible.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-425 - <Suspense tallback={<div>Loading page.. .</div>}>

Metadata:
```text
source_id: S-425
image_use_id: IU-425
fileId_short: 04afe6e8fc
image_file: S-425__04afe6e8fc.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
<Suspense tallback={<div>Loading page.. .</div>}>
<ProductsPageContent page={page} />
</Suspense>
</div>
)
+
function ProductsPageContent({ page }: { page: number }) {
const { data } = useSuspenseQuery({
querykey: ['products', page],
queryFn: () => fetchProducts(page),
n
return (
<ul
{data.items.map((item: any) => (
<li key={item.id}>{item.name}</1i>
»}
</ul>
)
+
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-429 - 2. Why React needs this

Metadata:
```text
source_id: S-429
image_use_id: IU-429
fileId_short: 64ae29536d
image_file: S-429__64ae29536d.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
2. Why React needs this
Not all state updates feel equally urgent.
Urgent updates
Things the user expects immediately:

© typing in an input

* licking a button

* opening a menu

+ checkbox toggle feedback
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-433 - What this improves

Metadata:
```text
source_id: S-433
image_use_id: IU-433
fileId_short: 0ff4794c70
image_file: S-433__0ff4794c70.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
What this improves

When page changes:
* React can keep showing previous page briefly
* instead of instantly switching to fallback
+ then swap to the new page when ready

This makes navigation feel smoother.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-436 - Non-urgent updates

Metadata:
```text
source_id: S-436
image_use_id: IU-436
fileId_short: 5b31422c36
image_file: S-436__5b31422c36.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Non-urgent updates
Things that may take a bit more work:
* rendering a huge filtered list
* changing a page of results
* navigating to data that suspends
* expensive search result updates
Without transitions, React often treats them the same way.
That can cause:
* input lag
* flashing spinners/fallbacks
old Ul disappearing too soon
*  janky rendering
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-438 - 12. Suspense vs placeholderData

Metadata:
```text
source_id: S-438
image_use_id: IU-438
fileId_short: 8298e740e1
image_file: S-438__8298e740e1.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
12. Suspense vs placeholderData

These solve similar UX problems in different ways.

placeholderData

Lets {useQuery show temporary previous data while new data loads.

Suspense + transitions

Lets React keep old rendered UI visible while the new suspended UI prepares.

Rough rule
* Ifyou want classic query control and explicit states, use useQuery + placeholderData
«If your app uses Suspense architecture, use Suspense + transitions
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-446 - 3. Mental model

Metadata:
```text
source_id: S-446
image_use_id: IU-446
fileId_short: 6901482439
image_file: S-446__6901482439.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
3. Mental model
useTransition Says:
“Update the important interactive state now, but let the heavier UI update happen in the background.”
It does not make code faster by itself.
It changes priority and behavior.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-447 - 13. When Suspense is a good fit

Metadata:
```text
source_id: S-447
image_use_id: IU-447
fileId_short: 561c21b24d
image_file: S-447__561c21b24d.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
13. When Suspense is a good fit
Suspense is a strong fit when:
* your app already uses React Suspense patterns
* you want loading boundaries higher in the tree
* you want simpler success-only components
* you are okay structuring Ul around boundaries
* you are using SSR/streaming/server-component-oriented architecture
14. When Suspense is a bad fit
It may be a poor fit when:
* you rely heavily on enabled
* you want highly explicit loading flags in each component
* your team is less comfortable with Suspense control flow
* you have many conditional/dependent branches in one component
* you want very fine manual loading behavior without boundaries
In those cases, standard useQuery) is often easier. |
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-486 - What happens step by step with transition

Metadata:
```text
source_id: S-486
image_use_id: IU-486
fileId_short: 1925501b08
image_file: S-486__1925501b08.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
What happens step by step with transition
User clicks Next.
Step 1
React receives a transition update:

«> TypeScript

startTransition(() => {

setPage(2)
vn
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-490 - Step 2

Metadata:
```text
source_id: S-490
image_use_id: IU-490
fileId_short: 8a89987039
image_file: S-490__8a89987039.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 2

React knows this update is non-urgent.

Step 3

React keeps the current visible UI if possible while preparing the next state.
So page 1 can remain on screen.

Step 4

React starts rendering the new tree in the background with (page!22)-
Step 5

ProductsList asks for query |[ "products", 2] -

Step 6

It suspends because data is not ready.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-493 - Step7

Metadata:
```text
source_id: S-493
image_use_id: IU-493
fileId_short: e94b5eb363
image_file: S-493__e94b5eb363.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step7

Because this is happening inside a transition, React prefers to keep showing the previous UI instead of

immediately replacing it with fallback.

Step 8

isPending becomes true.

You can show a subtle hint like:
> TypeScript ia’)
<small>Updating. . .</smal1>

Step 9

When page 2 data is ready, React swaps page 1 UI for page 2 UI.

Step 10

isPending becomes false .
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-496 - User-visible behavior with transition

Metadata:
```text
source_id: S-496
image_use_id: IU-496
fileId_short: 643f602633
image_file: S-496__643f602633.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
User-visible behavior with transition
The user sees:
1. page 1 content
2. dick Next
3. page 1 stays visible
4. maybe a small “Updating...” indicator appears
5. page 2 appears when ready
This usually feels much smoother than flashing a loading fallback.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-498 - 6. Key difference in one sentence

Metadata:
```text
source_id: S-498
image_use_id: IU-498
fileId_short: 796a1b979e
image_file: S-498__796a1b979e.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
6. Key difference in one sentence
Without transition:
React tends to switch to loading/fallback immediately.
With transition:
React tries to keep the previous UI visible while the new UI prepares.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-499 - 7. Very important: it does not delay the state forever

Metadata:
```text
source_id: S-499
image_use_id: IU-499
fileId_short: f004c25ab3
image_file: S-499__f004c25ab3.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
7. Very important: it does not delay the state forever
startTransition does not mean “ignore this update”.
It means:
* schedule it at lower priority
© let urgent updates win first
* keep UI responsive while it is being prepared
The update still happens.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-501 - 12. What it does not do

Metadata:
```text
source_id: S-501
image_use_id: IU-501
fileId_short: c4d203ec2e
image_file: S-501__c4d203ec2e.png
stage6a_group: R21
stage6d_region: R17
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
12. What it does not do

It does not make network requests faster

If fetch takes 2 seconds, it still takes 2 seconds.

It does not replace loading states completely

You may still want indicators like isPending .

It does not mean “run later with setTimeout”

Itis not a timer. It is priority scheduling.

It does not fix bad architecture automatically

If rendering is extremely expensive, transitions help perception, but optimization may still be needed.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### Recall additions

- How urgent and transition updates differ in step-by-step pagination timelines.
- How transitions interact with Suspense, placeholder data, pending UI, rapid navigation, and request cancellation.


## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R15-v002-query-cancellation-transition-tail.md`, source-transcript section
- Authoritative processed source: `regions/R17-useTransition-pagination-pending-ui.md`, source-transcript section
- Authoritative processed source: `regions/R17-v002-useTransition-step-comparison.md`, source-transcript section
- Authoritative processed source: `regions/R17-v003-transition-suspense-placeholder-tail.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).


- Workspace: `_ai-conspects/useTransition full flow, usedebounce, useDefferedvalue/`
- Authoritative processed source: `07-full-combined-final-transcript.md`, R02-R04
- Original SVG: `source/useTransition full flow, usedebounce, useDefferedvalue.svg`

- Workspace: `_ai-conspects/usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions/`
- Processed source: `01-final-transcript.md`, complete transcript
