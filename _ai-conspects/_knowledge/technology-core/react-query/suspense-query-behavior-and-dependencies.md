# React Query Suspense behavior and query dependencies

Knowledge ID: `react-query.suspense-query-behavior-and-dependencies`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R12-suspense-enabled-serial-behavior.md`


### S-274 - Suspense fallback maps closest to initial isLoading / no data available

Metadata:
```text
source_id: S-274
image_use_id: IU-274
fileId_short: 93a0d0d3e4
image_file: S-274__93a0d0d3e4.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
So which one maps best?

If you want the closest plain-English mapping:

- Suspense fallback ≈ initial `isLoading`
- broader underlying condition: there is no data available yet (`isPending`) and the component suspends.

So not “both” in the sense of two separate triggers.
It is basically the first load with no data case.

Example:

`<Suspense fallback={<Spinner />}>`
`  <UserPage />`
`</Suspense>`
```

#### Verified visible code
```tsx
<Suspense fallback={<Spinner />}>
  <UserPage />
</Suspense>
```

#### Notes

Fully readable; explains first no-data load, not every refetch.

---

### S-277 - Suspense moves loading handling to nearest boundary

Metadata:
```text
source_id: S-277
image_use_id: IU-277
fileId_short: c56ec7fd55
image_file: S-277__c56ec7fd55.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Suspense changes where loading is handled.

Instead of every component doing:

`if (isPending) return <Loading />`
`if (isError) return <Error />`
`return <DataView />`

a Suspense-enabled query can pause rendering until data is ready, and React shows the nearest Suspense fallback.
```

#### Verified visible code
```tsx
if (isPending) return <Loading />
if (isError) return <Error />
return <DataView />
```

#### Notes

Readable.

---

### S-278 - useSuspenseQuery keeps component visible during later refetch with existing data

Metadata:
```text
source_id: S-278
image_use_id: IU-278
fileId_short: a865458f88
image_file: S-278__a865458f88.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Behavior:

- first mount, no cached data → fallback shows
- later refetch with existing data → component stays visible, `isFetching` can be true.
```

#### Verified visible code
```tsx
function UserPage() {
  const { data, isFetching } = useSuspenseQuery({
    queryKey: ['user', 1],
    queryFn: fetchUser,
  })

  return (
    <>
      {isFetching && <small>Refreshing...</small>}
      <div>{data.name}</div>
    </>
  )
}
```

#### Notes

Readable.

---

### S-279 - Suspense lets loading handling move higher in tree

Metadata:
```text
source_id: S-279
image_use_id: IU-279
fileId_short: 6ea27df25b
image_file: S-279__6ea27df25b.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
35. Suspense

Suspense lets you move loading handling higher in the tree.

With Suspense-based query hooks, components can often skip manual loading checks.
```

#### Verified visible code
```tsx
<Suspense fallback={<Loading />}>
  <Repos />
</Suspense>
```

#### Notes

Readable.

---

### S-283 - normal useQuery component handles loading and error itself

Metadata:
```text
source_id: S-283
image_use_id: IU-283
fileId_short: b8fa03d9e2
image_file: S-283__b8fa03d9e2.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
1. Normal query vs Suspense query

Normal `useQuery`

The component itself handles loading and error UI.
```

#### Verified visible code
```tsx
function Repos() {
  const { data, isPending, isError } = useQuery({
    queryKey: ['repos'],
    queryFn: fetchRepos,
  })

  if (isPending) return <div>Loading...</div>
  if (isError) return <div>Error</div>

  return (
    <ul>
      {data.map((repo) => (
        <li key={repo.id}>{repo.name}</li>
      ))}
    </ul>
  )
}
```

#### Notes

Readable.

---

### S-287 - manual cache removal vs invalidation and Suspense fallback

Metadata:
```text
source_id: S-287
image_use_id: IU-287
fileId_short: 4f7fbb9957
image_file: S-287__4f7fbb9957.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Question: Suspense fallback is being shown on first no data + fetching state; will it be shown when cache is removed manually or invalidated?

Answer:

Yes for manual cache removal; usually no for invalidation alone.
```

#### Notes

Readable prompt/answer card.

---

### S-292 - Suspense version starts with useSuspenseQuery

Metadata:
```text
source_id: S-292
image_use_id: IU-292
fileId_short: 676060fc01
image_file: S-292__676060fc01.png
status: verified-visible-partial
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Suspense version
```

#### Verified visible code
```tsx
import { Suspense } from 'react'
import { useSuspenseQuery } from '@tanstack/react-query'

function Repos() {
  const { data } = useSuspenseQuery({
    queryKey: ['repos'],
    queryFn: fetchRepos,
  })
  // render follows in continuation
}
```

#### Notes

Top of code card; continuation is S-298.

---

### S-298 - Suspense version moves loading UI to boundary

Metadata:
```text
source_id: S-298
image_use_id: IU-298
fileId_short: 094d84e79b
image_file: S-298__094d84e79b.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Here:

- `Repos` does not check `isPending`
- if data is not ready, React suspends that subtree
- `<Suspense fallback={...}>` is shown instead
```

#### Verified visible code
```tsx
return (
  <ul>
    {data.map((repo) => (
      <li key={repo.id}>{repo.name}</li>
    ))}
  </ul>
)

export default function Page() {
  return (
    <Suspense fallback={<div>Loading repos...</div>}>
      <Repos />
    </Suspense>
  )
}
```

#### Notes

Continuation of S-292; readable.

---

### S-308 - what suspend means

Metadata:
```text
source_id: S-308
image_use_id: IU-308
fileId_short: 3076481cd7
image_file: S-308__3076481cd7.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
2. What “suspend” actually means

It does not mean “return loading UI from the component”.

It means:

- component starts rendering
- query sees data is not ready
- query throws a special Promise internally
- React catches it through Suspense
- React renders fallback until Promise resolves
- then React retries rendering the component

So Suspense is render control flow, not just a loading boolean.
```

#### Notes

Readable.

---

### S-318 - why people like Suspense

Metadata:
```text
source_id: S-318
image_use_id: IU-318
fileId_short: 57fab47856
image_file: S-318__57fab47856.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
3. Why people like Suspense

It can make components cleaner.

Instead of mixing data fetching and loading UI in every component, you can put loading state handling higher up.

Without Suspense, every component often has:

- loading logic
- error logic
- empty state logic
```

#### Notes

Readable.

---

### S-329 - with Suspense component focuses on successful render

Metadata:
```text
source_id: S-329
image_use_id: IU-329
fileId_short: 74ba77c711
image_file: S-329__74ba77c711.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
With Suspense

The component can focus more on successful render.

That is simpler, but only because loading is moved to the boundary.
```

#### Verified visible code
```tsx
function UserProfile() {
  const { data } = useSuspenseQuery({
    queryKey: ['user'],
    queryFn: fetchUser,
  })

  return <h1>{data.name}</h1>
}
```

#### Notes

Readable.

---

### S-340 - Suspense boundary controls loading UI

Metadata:
```text
source_id: S-340
image_use_id: IU-340
fileId_short: 752c806f65
image_file: S-340__752c806f65.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
4. The boundary controls the loading UI

This means:

- if `Repos` suspends, show `<Spinner />`
- when `Repos` is ready, show actual content

You can wrap small or large parts of the tree.
```

#### Verified visible code
```tsx
<Suspense fallback={<Spinner />}>
  <Repos />
</Suspense>
```

#### Notes

Readable.

---

### S-345 - small Suspense boundary

Metadata:
```text
source_id: S-345
image_use_id: IU-345
fileId_short: 180dcf4b32
image_file: S-345__180dcf4b32.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Small boundary

Only `Repos` area shows loading.
```

#### Verified visible code
```tsx
<PageLayout>
  <Header />
  <Suspense fallback={<div>Loading repos...</div>}>
    <Repos />
  </Suspense>
</PageLayout>
```

#### Notes

Readable.

---

### S-350 - large Suspense boundary

Metadata:
```text
source_id: S-350
image_use_id: IU-350
fileId_short: c68e2a8d43
image_file: S-350__c68e2a8d43.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Large boundary

Whole dashboard waits together.

Small boundaries usually feel better because they preserve more UI.
```

#### Verified visible code
```tsx
<Suspense fallback={<FullPageLoader />}>
  <Dashboard />
</Suspense>
```

#### Notes

Readable.

---

### S-354 - Suspense does not replace error handling

Metadata:
```text
source_id: S-354
image_use_id: IU-354
fileId_short: 0a82c038b6
image_file: S-354__0a82c038b6.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
5. Suspense does not replace error handling by itself

Suspense handles loading, not normal error UI.

For query errors, use an Error Boundary.
```

#### Verified visible code
```tsx
import { ErrorBoundary } from 'react-error-boundary'
import { Suspense } from 'react'

function Repos() {
  const { data } = useSuspenseQuery({
    queryKey: ['repos'],
    queryFn: fetchRepos,
  })

  return (
    <ul>
      {data.map((repo) => (
        <li key={repo.id}>{repo.name}</li>
      ))}
    </ul>
  )
}
```

#### Notes

Top part readable; continuation in S-358.

---

### S-358 - ErrorBoundary plus Suspense pair

Metadata:
```text
source_id: S-358
image_use_id: IU-358
fileId_short: e1ac560b26
image_file: S-358__e1ac560b26.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Typical pair:

- Suspense → loading
- ErrorBoundary → errors
```

#### Verified visible code
```tsx
export default function Page() {
  return (
    <ErrorBoundary fallback={<div>Could not load repos</div>}>
      <Suspense fallback={<div>Loading repos...</div>}>
        <Repos />
      </Suspense>
    </ErrorBoundary>
  )
}
```

#### Notes

Continuation of S-354; lower bullet partly cropped but meaning readable.

---

### S-363 - useSuspenseQuery does not support enabled

Metadata:
```text
source_id: S-363
image_use_id: IU-363
fileId_short: 283c1bb2a3
image_file: S-363__283c1bb2a3.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
6. Why `useSuspenseQuery` does not support `enabled`

With normal `useQuery`, you can say:

This means: define the query, but do not run it until `id` exists.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['user', id],
  queryFn: () => fetchUser(id),
  enabled: !!id,
})
```

#### Notes

Readable.

---

### S-366 - disabled-but-not-running suspense query does not fit Suspense state model

Metadata:
```text
source_id: S-366
image_use_id: IU-366
fileId_short: c74ee8553b
image_file: S-366__c74ee8553b.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
With `useSuspenseQuery`, that pattern does not fit well, because Suspense expects the hook either to:

- have data
- suspend
- throw an error

A disabled-but-not-running suspense query would create an awkward state: it is neither ready nor really loading in the Suspense sense.

So `useSuspenseQuery` simply does not support `enabled`.
```

#### Notes

Readable.

---

### S-370 - instead of enabled move condition outside Suspense hook

Metadata:
```text
source_id: S-370
image_use_id: IU-370
fileId_short: d3572dccdb
image_file: S-370__d3572dccdb.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
7. What to do instead of `enabled`

You usually move the condition outside the suspense hook.

Example: conditional rendering

Instead of this
```

#### Verified visible code
```tsx
function User({ id }: { id?: string }) {
  const { data } = useSuspenseQuery({
    queryKey: ['user', id],
    queryFn: () => fetchUser(id!),
    // enabled: !!id  ❌ not supported
  })

  return <div>{data.name}</div>
}
```

#### Notes

Readable.

---

### S-373 - conditional render wrapper around Suspense child

Metadata:
```text
source_id: S-373
image_use_id: IU-373
fileId_short: 7f5fd03cda
image_file: S-373__7f5fd03cda.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Do this
```

#### Verified visible code
```tsx
function User({ id }: { id?: string }) {
  if (!id) return <div>Select a user</div>

  return (
    <Suspense fallback={<div>Loading user...</div>}>
      <UserContent id={id} />
    </Suspense>
  )
}
```

#### Notes

Readable.

---

### S-375 - condition decides whether suspense-query component exists

Metadata:
```text
source_id: S-375
image_use_id: IU-375
fileId_short: a5b18d2c3b
image_file: S-375__a5b18d2c3b.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
The condition decides whether the suspense-query component exists at all.

That is the main replacement for `enabled`.
```

#### Verified visible code
```tsx
function UserContent({ id }: { id: string }) {
  const { data } = useSuspenseQuery({
    queryKey: ['user', id],
    queryFn: () => fetchUser(id),
  })

  return <div>{data.name}</div>
}
```

#### Notes

Continuation of S-373; readable.

---

### S-377 - serial behavior in one component

Metadata:
```text
source_id: S-377
image_use_id: IU-377
fileId_short: 5f7ffd16a1
image_file: S-377__5f7ffd16a1.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
8. Serial behavior in one component

This is one of the biggest Suspense gotchas.

Example.

This looks like two queries in one component.
```

#### Verified visible code
```tsx
function Dashboard() {
  const { data: user } = useSuspenseQuery({
    queryKey: ['user'],
    queryFn: fetchUser,
  })

  const { data: repos } = useSuspenseQuery({
    queryKey: ['repos'],
    queryFn: fetchRepos,
  })

  return (
    <>
      <h1>{user.name}</h1>
      <div>{repos.length} repos</div>
    </>
  )
}
```

#### Notes

Readable.

---

### S-380 - two Suspense queries in one component often behave serially

Metadata:
```text
source_id: S-380
image_use_id: IU-380
fileId_short: 11664458c2
image_file: S-380__11664458c2.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
But what usually happens is:

1. render starts
2. first query (`user`) suspends
3. render stops there
4. second query (`repos`) is not reached yet
5. when `user` resolves, React retries render
6. now it reaches `repos`
7. `repos` suspends
8. another wait happens

So they often behave serially.

That is slower than normal parallel fetching.
```

#### Notes

Readable.

---

### S-382 - timeline: Suspense serial vs parallel non-suspense queries

Metadata:
```text
source_id: S-382
image_use_id: IU-382
fileId_short: 9b1e04f8ba
image_file: S-382__9b1e04f8ba.png
status: verified-visible
transcript_method: manually prepared from Stage5a source image/contact sheet
```

#### Verified visible text
```text
Timeline

In one component with Suspense

- start render
- user query suspends
- wait
- rerender
- repos query suspends
- wait
- rerender
- final UI

With parallel non-suspense queries

Both requests can start in the same render cycle.
```

#### Notes

Readable.

---

## Authoritative claim transcript: `R12-v002-suspense-correction-tail.md`


### S-288 - 35.1 useSuspenseQuery

Metadata:
```text
source_id: S-288
image_use_id: IU-288
fileId_short: a08d07bb82
image_file: S-288__a08d07bb82.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
35.1 useSuspenseQuery
“ TypeScript O
import { useSuspenseQuery } from ‘@tanstack/react-query*
function Repos() {
const { data } = useSuspenseQuery({
queryKey: ['‘repos'],
queryFn: fetchRepos,
})
return (
<ul>
{data.map((repo) => (
<li key={repo.id}>{repo.name}</1i>
))}
</ul>
)
t
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-295 - 35.2 Important limitations

Metadata:
```text
source_id: S-295
image_use_id: IU-295
fileId_short: 4052f751bb
image_file: S-295__4052f751bb.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
35.2 Important limitations
useSuspenseQuery does not support enabled .
That means conditional query patterns need different component boundaries or composition.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-300 - 35.3 Serial behavior in one component

Metadata:
```text
source_id: S-300
image_use_id: IU-300
fileId_short: 8f00091879
image_file: S-300__8f00091879.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
35.3 Serial behavior in one component

If multiple suspense queries are called in one component, they often run serially because the first unresolved
one suspends before the next hook runs.

To get better parallelism, split into child components or use different composition patterns.

35.4 Transitions

During a transition, React can keep showing previous data instead of falling back immediately.

This can create smoother Suspense pagination/filtering experiences.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

## Authoritative claim transcript: `R12-v003-suspense-parallel-dependent-tail.md`


### S-386 - 9. How to make Suspense queries parallel

Metadata:
```text
source_id: S-386
image_use_id: IU-386
fileId_short: 6ff5da2ed3
image_file: S-386__6ff5da2ed3.png
stage6a_group: R21
stage6d_region: R12
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
9. How to make Suspense queries parallel
You usually split them into separate components under the same boundary.
Better pattern
«” TypeScript oO
function UserSection() {
const { data } = useSuspenseQuery({
querykey: ['user'],
queryFn: fetchUser,
D>)
return <h1>{data.name}</h1>
}
function RepoSection() {
const { data } = useSuspenseQuery({
querykey: [‘repos'],
queryFn: fetchRepos,
D>)
return <div>{data. length} repos</div>
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-389 - export default function Dashboard() {

Metadata:
```text
source_id: S-389
image_use_id: IU-389
fileId_short: b6379df317
image_file: S-389__b6379df317.png
stage6a_group: R21
stage6d_region: R12
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
export default function Dashboard() {
return (
<Suspense fallback={<div>Loading dashboard. ..</div>}>
<UserSection />
<RepoSection />
</Suspense>
)
+
This is often a better structure because sibling components can participate more naturally in concurrent
rendering behavior.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-393 - Even better with separate boundaries

Metadata:
```text
source_id: S-393
image_use_id: IU-393
fileId_short: e91d3c5a46
image_file: S-393__e91d3c5a46.png
stage6a_group: R21
stage6d_region: R12
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Even better with separate boundaries
«” TypeScript
export default function Dashboard() {
return (
°
<Suspense fallback={<div>Loading user... .</div>}>
<UserSection />
</Suspense>
<Suspense fallback={<div>Loading repos. ..</div>}>
<RepoSection />
</Suspense>
<P
)
+
Now each section can resolve independently.
This often feels much nicer in the UI.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-396 - 10. Suspense with dependent queries

Metadata:
```text
source_id: S-396
image_use_id: IU-396
fileId_short: ab518b8fb7
image_file: S-396__ab518b8fb7.png
stage6a_group: R21
stage6d_region: R12
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
10. Suspense with dependent queries
Suspense makes dependent queries more obvious.
Example
«> TypeScript
function MovieAndDirector({ title }: { title: string }) {
const { data: movie } = useSuspenseQuery({
queryKey: ['movie', title],
queryFn: () => fetchMovie(title),
>)
const { data: director } = useSuspenseQuery({
queryKey: [‘director', movie.directorId],
queryFn: () => fetchDirector(movie.directorId),
>)
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-401 - return (

Metadata:
```text
source_id: S-401
image_use_id: IU-401
fileId_short: ed1ff3c24e
image_file: S-401__ed1ff3c24e.png
stage6a_group: R21
stage6d_region: R12
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
return (
<div>
<h1>{movie.title}</h1>
<p>{director.name}</p>
</div>
)
}
This is truly serial by nature because query 2 needs result of query 1.
That is fine. This is a real dependency.
The important thing is not to accidentally create serial behavior for queries that are actually independent.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## What should be recallable

- How Suspense query hooks change loading and error rendering.
- Why colocated Suspense queries may serialize and how parallel/dependent patterns differ.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R12-suspense-enabled-serial-behavior.md`, source-transcript section
- Authoritative processed source: `regions/R12-v002-suspense-correction-tail.md`, source-transcript section
- Authoritative processed source: `regions/R12-v003-suspense-parallel-dependent-tail.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
