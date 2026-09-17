# React Query network modes, offline state, and paused-work resumption

Knowledge ID: `react-query.network-mode-offline-validation-and-resume`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R09B-network-offline.md`


### S-202 - default networkMode online

Metadata:
```text
source_id: S-202
image_use_id: IU-202
fileId_short: c078f2032f
image_file: S-202__c078f2032f.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
1) Default: `networkMode: 'online'`

This is the default mode. It assumes your query normally depends on network access. The docs say it pauses network-dependent queries when offline, and if a query was already running when you go offline, the retry mechanism is paused and continues when connection returns.
```

#### Notes

Readable.

---

### S-203 - online mode pauses only when a fetch wants to happen offline

Metadata:
```text
source_id: S-203
image_use_id: IU-203
fileId_short: 17f9a3bf92
image_file: S-203__17f9a3bf92.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Does online option pause query when it has data in React Query cache?

No, not automatically.

With default `networkMode: 'online'`, a query is paused only when it wants to fetch but cannot because there is no network connection. TanStack defines `fetchStatus: 'paused'` as “the query wanted to fetch, but has been paused.”

So if the query already has cached data:

- it can still show that cached data
- and it is only paused if a fetch/refetch should happen at that moment and offline prevents it
```

#### Notes

Prompt bubble visible; answer readable.

---

### S-205 - offline paused queries can be pending and paused

Metadata:
```text
source_id: S-205
image_use_id: IU-205
fileId_short: c6a05bb126
image_file: S-205__c6a05bb126.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
31. Offline behavior and `networkMode`

31.1 Paused queries

When offline, queries maybe paused instead of fetching.

Possible state:

This is why `isLoading` is not the same as `status === 'pending'`.

A paused query is not actively loading.
```

#### Verified visible code
```tsx
status: 'pending'
fetchStatus: 'paused'
data: undefined
```

#### Notes

Readable.

---

### S-208 - network-dependent query example

Metadata:
```text
source_id: S-208
image_use_id: IU-208
fileId_short: 635b0dd4d8
image_file: S-208__635b0dd4d8.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example: network-dependent

This query is network-dependent because:

- it calls a remote API
- no internet usually means no successful fetch

How it works in `online` mode:

- online -> it fetches normally
- offline before it starts -> it can be paused instead of actively fetching
- offline during retries -> retries pause and continue later when back online
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos'],
  queryFn: async () => {
    const res = await fetch('/api/todos')
    return res.json()
  },
})
```

#### Notes

Readable.

---

### S-214 - offline-aware UI using status and fetchStatus

Metadata:
```text
source_id: S-214
image_use_id: IU-214
fileId_short: d894c9608c
image_file: S-214__d894c9608c.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
31.2 Offline-aware UI
```

#### Verified visible code
```tsx
function Repos() {
  const { data, status, fetchStatus } = useQuery({
    queryKey: ['repos'],
    queryFn: fetchRepos,
  })

  if (status === 'pending' && fetchStatus === 'paused') {
    return <div>Offline...</div>
  }

  if (status === 'pending' && fetchStatus === 'fetching') {
    return <div>Loading...</div>
  }

  return (
    <div>
      {fetchStatus === 'paused' && <div>Offline</div>}
      <ul>
        {data?.map((repo) => (
          <li key={repo.id}>{repo.name}</li>
        ))}
      </ul>
    </div>
  )
}
```

#### Notes

Readable code card.

---

### S-217 - networkMode always for non-network query functions

Metadata:
```text
source_id: S-217
image_use_id: IU-217
fileId_short: 73d84c25d2
image_file: S-217__73d84c25d2.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
2) `networkMode: 'always'`

This mode tells TanStack Query to ignore online/offline state and always run the query. The docs say queries are never paused because of connectivity in this mode, and retries also do not pause.

Use this when the query function does not really need a network.

Example: local storage / IndexedDB / AsyncStorage

Why this is not network-dependent:

- it reads from browser storage
- internet connection is irrelevant
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['draftSettings'],
  queryFn: async () => {
    const raw = localStorage.getItem('draftSettings')
    return raw ? JSON.parse(raw) : { theme: 'dark' }
  },
  networkMode: 'always',
})
```

#### Notes

Readable.

---

### S-225 - always mode for computed async value

Metadata:
```text
source_id: S-225
image_use_id: IU-225
fileId_short: af413353f2
image_file: S-225__af413353f2.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example: computed async value

Again, no network is needed. TanStack's docs use this kind of example directly.

What would we need here?

If you left this as default `online`, then going offline could pause something that actually could have run just fine without internet. That is why `always` exists. This is an inference from the documented behavior of the modes.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['localValue'],
  queryFn: () => Promise.resolve(1),
  networkMode: 'always',
})
```

#### Notes

Readable.

---

### S-228 - offlineFirst basic option

Metadata:
```text
source_id: S-228
image_use_id: IU-228
fileId_short: 33ec33e3f6
image_file: S-228__33ec33e3f6.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`offlineFirst`

Useful when cached/storage-backed work should continue gracefully and retries should wait for connectivity.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['data'],
  queryFn: fetchData,
  networkMode: 'offlineFirst',
})
```

#### Notes

Readable.

---

### S-230 - offlineFirst for cache/storage-backed fetch paths

Metadata:
```text
source_id: S-230
image_use_id: IU-230
fileId_short: 80e917c63d
image_file: S-230__80e917c63d.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
3) `networkMode: 'offlineFirst'`

This is for cases where work may still succeed offline-ish because of a cache/storage layer, like:

- service worker cache
- HTTP cache
- persistent local cache backing some fetch path

The docs describe it as useful when cached/storage-backed work should continue gracefully and retries should wait for connectivity.
```

#### Notes

Readable.

---

### S-231 - mixed/cache-backed fetches with offlineFirst

Metadata:
```text
source_id: S-231
image_use_id: IU-231
fileId_short: ad15f92387
image_file: S-231__ad15f92387.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Mixed / cache-backed fetches

Use `offlineFirst` when:

- query may still succeed due to cache
- but real retries should wait for connectivity

Example:
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['catalog'],
  queryFn: () => fetch('/api/catalog').then(r => r.json()),
  networkMode: 'offlineFirst',
})
```

#### Notes

Readable.

---

### S-232 - offlineFirst article fetch example

Metadata:
```text
source_id: S-232
image_use_id: IU-232
fileId_short: 921a92e2c6
image_file: S-232__921a92e2c6.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example: fetch that may be served from cache
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['article', id],
  queryFn: async () => {
    const res = await fetch(`/api/articles/${id}`)
    return res.json()
  },
  networkMode: 'offlineFirst',
})
```

#### Notes

Readable.

---

### S-234 - why offlineFirst can make sense

Metadata:
```text
source_id: S-234
image_use_id: IU-234
fileId_short: 8fb60bf0f8
image_file: S-234__8fb60bf0f8.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Why this can make sense:

- maybe a service worker or HTTP cache serves the request even while offline
- if the fetch fails and retries are needed, TanStack can wait for connectivity instead of behaving like pure `always` mode

So `offlineFirst` is like:

- “go ahead and try”
- “but if retries are needed, connectivity matters”
```

#### Notes

Readable.

---

### S-235 - offlineFirst is permission to try, not a freshness guarantee

Metadata:
```text
source_id: S-235
image_use_id: IU-235
fileId_short: 40b7d5950d
image_file: S-235__40b7d5950d.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
The key point is that `offlineFirst` is about whether the query is allowed to try running while offline, not a guarantee that the data is up to date. TanStack describes `offlineFirst` as useful when “cached data or data storage mechanisms” can make the request succeed, while retries wait for connectivity.

So there are two different freshness layers here:

1. Browser / service worker / HTTP cache freshness

If your `fetch()` is satisfied from some cache while offline, that cached response may be old. `offlineFirst` does not make it fresh. It just allows the request attempt to happen even when offline, which is useful if some cache layer can answer it.
```

#### Notes

Readable; bottom may continue elsewhere, but visible core idea is complete.

---

## Authoritative claim transcript: `R09C-validation-resumePaused.md`


### S-196 - offline mutations can queue and resume later

Metadata:
```text
source_id: S-196
image_use_id: IU-196
fileId_short: 5e844a74b1
image_file: S-196__5e844a74b1.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
32. Offline mutations

`networkMode` also matters for mutations.

Offline mutations can be queued and resumed later. That means several queued writes may replay on reconnect, so plan invalidation and side effects carefully.
```

#### Notes

Readable.

---

### S-199 - mutation networkMode defaults and paused queued mutations

Metadata:
```text
source_id: S-199
image_use_id: IU-199
fileId_short: bf62b2d61c
image_file: S-199__bf62b2d61c.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Yes — mutations do have a `networkMode` option. On `useMutation`, it can be `'online'`, `'always'`, or `'offlineFirst'`, and it defaults to `'online'`.

The important part:

`networkMode: 'online'` for mutations

This is the default. In this mode, queries and mutations will not fire unless there is network connection. When offline, they can be paused instead.

So this is the mode where offline mutations can end up paused/queued and later resumed. The mutations guide shows exactly that flow: a mutation can be paused while offline, dehydrated/hydrated, and then continued with `queryClient.resumePausedMutations()`.
```

#### Notes

Readable; bottom continuation noted but core is visible.

---

### S-201 - response validation with Zod

Metadata:
```text
source_id: S-201
image_use_id: IU-201
fileId_short: c9417e839c
image_file: S-201__c9417e839c.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
30. Response validation

Do not blindly trust API data.

Schema validation is useful for third-party or fragile APIs.

Using Zod:
```

#### Notes

Readable heading/intro.

---

### S-209 - Zod schema parse in query function

Metadata:
```text
source_id: S-209
image_use_id: IU-209
fileId_short: 1c40ea8745
image_file: S-209__1c40ea8745.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example TypeScript/Zod validation for fetched posts. The query function fetches JSON and returns `PostsSchema.parse(json)` so malformed API data throws instead of silently entering the cache.
```

#### Verified visible code
```tsx
import { z } from 'zod'

const PostSchema = z.object({
  id: z.string(),
  title: z.string(),
  body: z.string(),
})

const PostsSchema = z.array(PostSchema)

async function fetchPosts() {
  const response = await fetch('/api/posts')
  if (!response.ok) throw new Error('Failed to fetch')

  const json = await response.json()
  return PostsSchema.parse(json)
}
```

#### Notes

Readable code card; lower edge is cropped but parse flow is visible.

---

### S-210 - networkMode always does not pause; no need for resumePausedMutations

Metadata:
```text
source_id: S-210
image_use_id: IU-210
fileId_short: dfc5091fca
image_file: S-210__dfc5091fca.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`networkMode: 'always'`

This means “ignore online/offline state.” TanStack says in `always` mode, queries and mutations always run and are not paused because of missing network. Retries also do not pause.

So for your question:

when they are being queued while offline, always, we just choose to run `resumePausedMutations` or not?

No.

With `always`, they generally are not paused/queued because of offline state in the first place. They try to run immediately; if they truly need network, they can just fail rather than sit paused waiting for resume.
```

#### Notes

Readable.

---

### S-215 - networkMode offlineFirst for mutations

Metadata:
```text
source_id: S-215
image_use_id: IU-215
fileId_short: 810e074c35
image_file: S-215__810e074c35.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`networkMode: 'offlineFirst'`

This is the middle ground. TanStack says it will run once, but then pause retries if needed. That mode is mainly useful when some cache/storage layer might satisfy the request first.
```

#### Notes

Readable.

---

### S-218 - validation benefits and tradeoffs

Metadata:
```text
source_id: S-218
image_use_id: IU-218
fileId_short: 213fe9db03
image_file: S-218__213fe9db03.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Benefits:

- catches malformed data early
- throws into normal query error handling
- can reduce useless data in cache if schema strips/reshapes

Tradeoff:

- runtime validation costs performance
- expensive for very large payloads
```

#### Notes

Readable.

---

### S-220 - when resumePausedMutations matters

Metadata:
```text
source_id: S-220
image_use_id: IU-220
fileId_short: 819762c974
image_file: S-220__819762c974.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
So when does `resumePausedMutations()` matter?

It matters when you actually have paused mutations — typically with offline behavior under the default `online` mode, especially if you persist them across app reloads. The docs show calling `queryClient.resumePausedMutations()` after hydration/restore for that case.

Best mental model:

- `online` → offline can pause/queue mutations; `resumePausedMutations()` is relevant.
- `always` → doesn't pause because of offline; usually nothing to “resume”.
- `offlineFirst` → try once, then pause retries if network is needed.
```

#### Notes

Readable.

---

### S-222 - networkMode default and always example

Metadata:
```text
source_id: S-222
image_use_id: IU-222
fileId_short: 805253d94b
image_file: S-222__805253d94b.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
31.3 `networkMode`

Default: `'online'`

Pauses network-dependent queries when offline.

`'always'`

Use when the query does not actually need network.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['localValue'],
  queryFn: () => Promise.resolve(1),
  networkMode: 'always',
})
```

#### Notes

Readable.

---

### S-226 - resumePausedMutations on reconnect example

Metadata:
```text
source_id: S-226
image_use_id: IU-226
fileId_short: 2d9e66f8f9
image_file: S-226__2d9e66f8f9.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example. Add an online listener and call `queryClient.resumePausedMutations()` on reconnect.

Mental model:

- paused mutation = “write is queued/waiting”
- `resumePausedMutations` = “continue those writes now”
```

#### Verified visible code
```tsx
import { QueryClient } from '@tanstack/react-query'

const queryClient = new QueryClient()

window.addEventListener('online', () => {
  queryClient.resumePausedMutations()
})
```

#### Notes

Readable.

---

### S-227 - resumePausedMutations mainly for persisted/hydrated paused mutations

Metadata:
```text
source_id: S-227
image_use_id: IU-227
fileId_short: 79a4777b2f
image_file: S-227__79a4777b2f.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Usually no, not in the normal “same app session reconnects” case.

With `networkMode: 'offlineFirst'`, TanStack Query will keep the mutation once, and if retries are needed it can pause those retries when there is no network. For paused work, TanStack Query's network mode behavior is that it can continue once connectivity returns; that “continue when back online” behavior is built into the paused/retry mechanism.

`resumePausedMutations()` is mainly needed when you have paused mutations that were persisted and then restored, such as after a page reload or app restart. The mutations guide shows the pattern: dehydrate state, hydrate it later, then call `queryClient.resumePausedMutations()`. It also notes that if you persist offline mutations, they cannot be resumed after reload unless you provide a default mutation function.
```

#### Notes

Readable.

---

## Authoritative claim transcript: `R09D-offline-fetchstatus-resume-tail.md`


### S-275 - 32. Offline mutations

Metadata:
```text
source_id: S-275
image_use_id: IU-275
fileId_short: 5e844a74b1
image_file: S-275__5e844a74b1.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
32. Offline mutations
networkMode also matters for mutations.
Offline mutations can be queued and resumed later.
That means several queued writes may replay on reconnect, so plan invalidation and side effects carefully.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-280 - 1) Default: networkMode: ‘online’

Metadata:
```text
source_id: S-280
image_use_id: IU-280
fileId_short: c078f2032f
image_file: S-280__c078f2032f.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
1) Default: networkMode: ‘online’

This is the default mode. It assumes your query normally depends on network access. The docs say it pauses
network-dependent queries when offline, and if a query was already running when you go offline, the retry
mechanism is paused and continues when connection returns. — tanstack +1
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-281 - DOES ONLINE OPTION PAUSES QUERY WHEN IT HAS DATA IN REQCTQ

Metadata:
```text
source_id: S-281
image_use_id: IU-281
fileId_short: 17f9a3bf92
image_file: S-281__17f9a3bf92.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
DOES ONLINE OPTION PAUSES QUERY WHEN IT HAS DATA IN REQCTQ
CACHE?
Zlyman Ha npotsxKeHun 11s >
Not automatically.
With default networkMode: ‘online’ , a query is paused only when it wants to fetch but cannot because
there is no network connection. TanStack defines fetchStatus: ‘paused’ as “the query wanted to fetch, but
has been paused.”  tanstackcom = 1
So if the query already has cached data:
¢ it can still show that cached data
¢ and it is only paused if a fetch/refetch should happen at that moment and offline prevents it.
tanstack.com +1
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-282 - 31. Offline behavior and networkMode

Metadata:
```text
source_id: S-282
image_use_id: IU-282
fileId_short: c6a05bb126
image_file: S-282__c6a05bb126.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
31. Offline behavior and networkMode
31.1 Paused queries
When offline, queries may become paused instead of fetching.
Possible state:

“) TypeScript

status: ‘pending’

fetchStatus: "paused"

data: undefined
This is why isLoading is not the same as status === ‘pending’ .
A paused query is not actively loading.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-286 - Example: network-dependent

Metadata:
```text
source_id: S-286
image_use_id: IU-286
fileId_short: 635b0dd4d8
image_file: S-286__635b0dd4d8.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example: network-dependent
“) TypeScript a.)
useQuery({
queryKey: ['‘todos'],
queryFn: async () => {
const res = await fetch('/api/todos')
return res.json()
}
))
This query is network-dependent because:
¢ it calls a remote API
* no internet usually means no successful fetch
How it works in online mode:
¢ online — it fetches normally
¢ offline before it starts > it can be paused instead of actively fetching
¢ offline during retries — retries pause and continue later when back online. —tanstack +:
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-291 - 31.2 Offline-aware UI

Metadata:
```text
source_id: S-291
image_use_id: IU-291
fileId_short: d894c9608c
image_file: S-291__d894c9608c.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
31.2 Offline-aware UI
«> TypeScript 6
function Repos() {
const { data, status, fetchStatus } = useQuery({
querykey: [‘repos'],
queryFn: fetchRepos,
»
if (status === 'pending' && fetchStatus === 'paused') {
return <div>Offline</div>
3
if (status === 'pending' && fetchStatus === 'fetching') {
return <div>Loading. ..</div>
3
return (
<div>
{fetchStatus === ‘paused’ && <div>Offline</div>}
<ul>
{data?.map((repo) => (
<li key={repo.id}>{repo.name}</1i>
))}
</ul>
</div>
) v
+
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-294 - 2) networkMode: ‘always*

Metadata:
```text
source_id: S-294
image_use_id: IU-294
fileId_short: 73d84c25d2
image_file: S-294__73d84c25d2.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
2) networkMode: ‘always*
This mode tells TanStack Query to ignore online/offline state and always run the query. The docs say queries
are never paused because of connectivity in this mode, and retries also do not pause. test
Use this when the query function does not really need a network.
Example: local storage / IndexedDB / AsyncStorage
«> TypeScript oO
useQuery({
querykey: ['draftSettings'],
queryFn: async () => {
const raw = localStorage.getItem('draftSettings')
return raw ? JSON.parse(raw) : { theme: ‘dark’ }
Lb
networkMode: 'always",
3)
Why this is not network-dependent:
* it reads from browser storage
* internet connection is irrelevant Vv
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-296 - networkMode: ‘offlineFirst’

Metadata:
```text
source_id: S-296
image_use_id: IU-296
fileId_short: 810e074c35
image_file: S-296__810e074c35.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
networkMode: ‘offlineFirst’
This is the middle ground. TanStack says it will run once, but then pause retries if needed. That mode is
mainly useful when some cache/storage layer might satisfy the request first. tanstackcom +1
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-301 - 31.3 networkMode

Metadata:
```text
source_id: S-301
image_use_id: IU-301
fileId_short: 805253d94b
image_file: S-301__805253d94b.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
31.3 networkMode

Default: ‘online’

Pauses network-dependent queries when offline.

*always*
Use when the query does not actually need network.
«> TypeScript oO
useQuery({
queryKey: ['localValue'],
queryfn: () => Promise.resolve(7),
networkMode: 'always",

»
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-302 - So when does resumePausedMutations() matter?

Metadata:
```text
source_id: S-302
image_use_id: IU-302
fileId_short: 819762c974
image_file: S-302__819762c974.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
So when does resumePausedMutations() matter?
It matters when you actually have paused mutations — typically with offline behavior under the default
online mode, especially if you persist them across app reloads. The docs show calling
queryClient.resumePausedMutations() after hydration/restore for that case.  tanstaccom -
Best mental model:

* online — offline can pause/queue mutations; resumePausedMutations() is relevant. tanstacccom ~

* (always — don’t pause because of offline; usually nothing to “resume.” tansackcom

© offlineFirst — try once, then pause retries if network is needed. tanstckcom +
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-312 - Usually no, not in the normal “same app session reconnects” case.

Metadata:
```text
source_id: S-312
image_use_id: IU-312
fileId_short: 79a4777b2f
image_file: S-312__79a4777b2f.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Usually no, not in the normal “same app session reconnects” case.
With networkMode: ‘offlineFirst’ , TanStack Query will run the mutation once, and if retries are needed it
can pause those retries when there is no network. For paused work, TanStack Query’s network mode
behavior is that it can continue once connectivity returns; that “continue when back online” behavior is built
into the paused/retry mechanism.  tansactcom -

resumePausedMutations() is mainly needed when you have paused mutations that were persisted and then
restored, such as after a page reload or app restart. The mutations guide shows the pattern: dehydrate state,
hydrate it later, then call queryClient .resumePausedMutations() . It also notes that if you persist offline
mutations, they cannot be resumed after reload unless you provide a default mutation function. tantactcom
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-314 - Mixed / cache-backed fetches

Metadata:
```text
source_id: S-314
image_use_id: IU-314
fileId_short: ad15f92387
image_file: S-314__ad15f92387.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Mixed / cache-backed fetches
Use offlineFirst when:
* query may still succeed due to cache
* but real retries should wait for connectivity
Example:
> TypeScript
useQuery({
querykey: ['catalog'],
queryFn: () => fetch('/api/catalog').then(r => r.json()),
networkMode: 'offlineFirst',
3)
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-327 - The key point is that offlineFirst is about whether the query is allowed to try running wh

Metadata:
```text
source_id: S-327
image_use_id: IU-327
fileId_short: 40b7d5950d
image_file: S-327__40b7d5950d.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
The key point is that offlineFirst is about whether the query is allowed to try running while offline, not
a guarantee that the data is up to date. TanStack describes offlineFirst as useful when “cached data or
data storage mechanisms” can make the request succeed, while retries wait for connectivity.

So there are two different freshness layers here:

1. Browser / service worker / HTTP cache freshness

If your fetch() is satisfied from some cache while offline, that cached response may be old. offlineFirst
does not make it fresh. It just allows the request attempt to happen even when offline, which is useful if
some cache layer can answer it.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-334 - Best mental model

Metadata:
```text
source_id: S-334
image_use_id: IU-334
fileId_short: 8fdcc18b67
image_file: S-334__8fdcc18b67.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Best mental model

offlineFirst means:

“Try now, even offline, because some local/network cache might satisfy the request.”
It does not mean:

“The data is guaranteed current”
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-284 - Yes — mutations do have a networkMode option. On useMutation, itcan be ‘online’ | ‘always'

Metadata:
```text
source_id: S-284
image_use_id: IU-284
fileId_short: bf62b2d61c
image_file: S-284__bf62b2d61c.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Yes — mutations do have a networkMode option. On useMutation, itcan be ‘online’ | ‘always' |
*offlineFirst’ , and it defaults to ‘online’ . tontacecom
The important part:

networkMode: ‘online’ for mutations
This is the default. In this mode, queries and mutations will not fire unless there is network connection.
When offline, they can be paused instead, nstckcom

So this is the mode where offline mutations can end up paused/queued and later resumed. The mutations
guide shows exactly that flow: a mutation can be paused while offline, dehydrated/hydrated, and then
continued with queryClient.resumePausedMutations() . tanstackcom +
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-290 - networkmode: ‘always*

Metadata:
```text
source_id: S-290
image_use_id: IU-290
fileId_short: dfc5091fca
image_file: S-290__dfc5091fca.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
networkmode: ‘always*
This means “ignore online/offline state.” TanStack says in always mode, queries and mutations always run
and are not paused because of missing network. Retries also do not pause. ackcom
So for your question:
when they are being queued while offline, always, we just choose to run resumePausedMutations) or not?
No.
With always , they generally are not paused/queued because of offline state in the first place. They try to
run immediately; if they truly need network, they can just fail rather than sit paused waiting for resume.
==
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-303 - Example: computed async value

Metadata:
```text
source_id: S-303
image_use_id: IU-303
fileId_short: af413353f2
image_file: S-303__af413353f2.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example: computed async value
«> TypeScript oO
useQuery({
querykey: ['localValue'],
queryFn: () => Promise.resolve(7),
networkMode: always",
3)
Again, no network is needed. TanStack’s docs use this kind of example directly. trstct
What would be weird here?
If you left this as default ‘online , then going offline could pause something that actually could have run just
fine without internet. That is why always exists. This is an inference from the documented behavior of the
modes. _ tanstack Vv
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-309 - “‘offlineFirst"

Metadata:
```text
source_id: S-309
image_use_id: IU-309
fileId_short: 33ec33e3f6
image_file: S-309__33ec33e3f6.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
“‘offlineFirst"
Useful when cached/storage-backed work should continue gracefully and retries should wait for
connectivity.
” TypeScript
useQuery({
queryKey: [‘data'],
queryFn: fetchData,
networkMode: 'offlineFirst',
»
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-311 - 3) networkMode: ‘offlineFirst'

Metadata:
```text
source_id: S-311
image_use_id: IU-311
fileId_short: 80e917c63d
image_file: S-311__80e917c63d.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
3) networkMode: ‘offlineFirst'
This is for cases where work may still succeed offline-ish because of a cache/storage layer, like:
* service worker cache
* HTTP cache
* persistent local cache backing some fetch path
The docs describe it as useful when cached/storage-backed work should continue gracefully and retries
should wait for connectivity. tense
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-320 - Example: fetch that may be served from cache

Metadata:
```text
source_id: S-320
image_use_id: IU-320
fileId_short: 921a92e2c6
image_file: S-320__921a92e2c6.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example: fetch that may be served from cache
> TypeScript
useQuery({
queryKey: ['article', id],
queryFn: async () => {
const res = await fetch(~ /api/articles/${id} )
return res.json()
Lb
networkMode: 'offlineFirst',
3)
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-326 - Why this can make sense:

Metadata:
```text
source_id: S-326
image_use_id: IU-326
fileId_short: 8fb60bf0f8
image_file: S-326__8fb60bf0f8.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Why this can make sense:
* maybe a service worker or HTTP cache serves the request even while offline
«if the fetch fails and retries are needed, TanStack can wait for connectivity instead of behaving like pure
always mode
So offlineFirst is like:
© “go ahead and try”
* “but if retries are needed, connectivity matters” tarsi -
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

## What should be recallable

- How online, always, and offlineFirst modes affect fetchStatus.
- How paused queries and mutations are validated and resumed.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R09B-network-offline.md`, source-transcript section
- Authoritative processed source: `regions/R09C-validation-resumePaused.md`, source-transcript section
- Authoritative processed source: `regions/R09D-offline-fetchstatus-resume-tail.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
