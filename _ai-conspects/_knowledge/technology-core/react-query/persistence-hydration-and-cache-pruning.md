# React Query persistence, hydration, and cache pruning

Knowledge ID: `react-query.persistence-hydration-and-cache-pruning`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R14-persistence-hydration-pruning.md`


### S-289 - Persistence in TanStack Query means saving the QueryClient cache somewhere durable so it c

Metadata:
```text
source_id: S-289
image_use_id: IU-289
fileId_short: c4797efb72
image_file: S-289__c4797efb72.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Persistence in TanStack Query means saving the QueryClient cache somewhere durable so it can be
restored later, such as after a page reload, app restart, or reopening the app. The docs describe
persistQueryClient as utilities that save your queryClient for later use via a persister. tnstack
What gets saved is a dehydrated version of the cache:

* query state

* mutation state

timestamps / metadata
and later that state is hydrated back into a QueryClient . persistQueryClientRestore hydrates previously
persisted query/mutation cache back into the passed client. msa«
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-297 - What PersistQueryClientProvider does

Metadata:
```text
source_id: S-297
image_use_id: IU-297
fileId_short: 6a8d99b81a
image_file: S-297__6a8d99b81a.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
What PersistQueryClientProvider does
PersistQueryClientProvider is the React-friendly wrapper around this persistence flow.
It does two important things for you:
1. subscribes and unsubscribes correctly with the React lifecycle
2. prevents queries from starting to fetch while restore is still in progress, which avoids restore-vs-fetch
race conditions. During restore, queries can still render, but they stay in fetchStatus: ‘idle’ until data
has been restored. Then they may refetch unless the restored data is fresh enough. terswc
So it is basically:
QueryClientProvider + persistence restore/save behavior + restore safety. tensa
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-304 - persistQueryClient(...) is the lower-level utility function.

Metadata:
```text
source_id: S-304
image_use_id: IU-304
fileId_short: 0c3b1184a0
image_file: S-304__0c3b1184a0.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
persistQueryClient(...) is the lower-level utility function.
PersistQueryClientProvider is the React component wrapper around that persistence flow.
So in your example:
«> TypeScript oO
persistQueryClient({
queryClient,
persister,
»
you are using the utility directly.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-305 - Yes — conceptually the flows are the same.

Metadata:
```text
source_id: S-305
image_use_id: IU-305
fileId_short: 8f675d5a4b
image_file: S-305__8f675d5a4b.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Yes — conceptually the flows are the same.
Both approaches are doing the same core persistence lifecycle:
1. restore persisted cache
2. hydrate it into the QueryClient
3. subscribe to future cache changes
4. keep saving updated state back through the persister
So at a high level:
© persistQueryClient(...) = imperative/manual way
© PersistQueryClientProvider = React wrapper around the same idea (tanstack.com a)
The important difference
The difference is how the lifecycle is managed, especially in React.
persistQueryClient(...)
You call it manually.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-306 - Main persistence pieces

Metadata:
```text
source_id: S-306
image_use_id: IU-306
fileId_short: 5d27ffc66e
image_file: S-306__5d27ffc66e.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Main persistence pieces
The docs split persistence into these utilities:

© persistQueryClientSave — dehydrates and stores the current query/mutation cache. tenstack

© persistQueryClientSubscribe — watches cache changes and keeps saving updates. tenstax

© persistQueryClientRestore — restores previously saved state into the client, discarding it if too old.

Taniack

*  persistQueryClient — does restore immediately, then subscribes for future changes. tursact

PersistQueryClientProvider is the React component that wraps that pattern safely in React. tanstax
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-307 - What persistQueryClientSave, persistQueryClientSubscribe , and

Metadata:
```text
source_id: S-307
image_use_id: IU-307
fileId_short: 2ec84b4c14
image_file: S-307__2ec84b4c14.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
What persistQueryClientSave, persistQueryClientSubscribe , and
persistQueryClientRestore actually are

They are utility functions, not persisters.

That is the main distinction:
+ persister = the storage adapter, like localStorage/AsyncStorage/IndexedDB-backed persister
+ persistQueryClientSave / Subscribe / Restore = functions that use your (QueryClient and your

persister to save/restore/query-subscribe behavior twa

So no, you do not create these and pass them as persister .

You pass a real persister, for example one created by:
*  createSyncStoragePersister
* createAsyncStoragePersister  Tensuct

Then these utilities use that persister.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-310 - Props / callbacks of PersistQueryClientProvider

Metadata:
```text
source_id: S-310
image_use_id: IU-310
fileId_short: 72bf95274c
image_file: S-310__72bf95274c.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Props / callbacks of PersistQueryClientProvider

It takes the same props as QueryClientProvider , plus these persistence-specific ones:

persistoptions
These are the persistence settings, essentially the options for persistQueryClient except you do not pass
the queryClient there because the provider already gets it via client . The docs say persistOptions
includes all options you can pass to persistQueryClient minus the QueryClient itself. tanstac
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-315 - With the provider, you instead do:

Metadata:
```text
source_id: S-315
image_use_id: IU-315
fileId_short: 46562dcbf3
image_file: S-315__46562dcbf3.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
With the provider, you instead do:
«> TypeScript oO
<PersistQueryClientProvider
client={queryClient}
persistOptions={{
persister,
maxAge,
buster,
dehydrateOptions,
hydrateOptions,
b
>
<App />
</PersistQueryClientProvider>
and the provider handles the restore/subscribe lifecycle for you. The docs say persistOptions on the
provider are basically the same options you pass to persistQueryClient , minus the queryClient itself,
because the provider already gets that as client. ms
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-316 - You call it manually.

Metadata:
```text
source_id: S-316
image_use_id: IU-316
fileId_short: 0d63534428
image_file: S-316__0d63534428.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
You call it manually.
Example idea:
«> TypeScript a)
persistQueryClient({
queryClient,
persister,
maxAge: 1000 * 60 * 60 * 24,
buster: ‘v1’,
»
This is lower-level / imperative. It restores immediately and subscribes immediately. (tanstack.com 7)
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-317 - What each one is for

Metadata:
```text
source_id: S-317
image_use_id: IU-317
fileId_short: 96dab1df5e
image_file: S-317__96dab1df5e.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
What each one is for
persistQueryClientSave
Use this when you want to save the current cache right now.
It:
*  dehydrates the current query/mutation cache
* stores it via the persister track
Example idea:
«> TypeScript ia)
await persistQueryClientSave({
queryClient,
persister,
buster: 'vi',
»
That means: “take current cache state and write it to storage now.”
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-319 - Common persistOptions fields are:

Metadata:
```text
source_id: S-319
image_use_id: IU-319
fileId_short: 3dfb2e8474
image_file: S-319__3dfb2e8474.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Common persistOptions fields are:
*  persister — required storage adapter used to save/restore the cache. tsa
© maxAge — max allowed age of the persisted cache; older caches are silently discarded. Default is 24
hours. GD
* buster — version string to invalidate old persisted caches when app/data format changes. tsa
* hydrateOptions — options passed to hydrate during restore. tnsax
*  dehydrateOptions — options passed to dehydrate when saving. tens
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-322 - PersistQueryClientProvider

Metadata:
```text
source_id: S-322
image_use_id: IU-322
fileId_short: 764ec95080
image_file: S-322__764ec95080.png
status: verified-visible-manual-fix
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
PersistQueryClientProvider

You declare it in React:

<PersistQueryClientProvider
  client={queryClient}
  persistOptions={{ persister, maxAge, buster }}
>
  <App />
</PersistQueryClientProvider>

This does the same kind of restore + subscribe flow, but with React-aware lifecycle handling. The docs specifically say it handles subscribing/unsubscribing properly and prevents race conditions where queries might start fetching before restore is done. During restore, queries stay `fetchStatus: 'idle'`.

So the answer is:

- same core persistence flow -> yes
- same implementation/lifecycle behavior details -> not exactly

Provider adds React-specific safety and convenience.
```

#### Notes

Manual visual read used because OCR timed out; source text is visible and not a placeholder.

---

### S-323 - Your code sample translated to provider form

Metadata:
```text
source_id: S-323
image_use_id: IU-323
fileId_short: d360a7d007
image_file: S-323__d360a7d007.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Your code sample translated to provider form
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-324 - onSuccess?: () => Promise | unknown

Metadata:
```text
source_id: S-324
image_use_id: IU-324
fileId_short: 1fd1c39efc
image_file: S-324__1fd1c39efc.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
onSuccess?: () => Promise | unknown

This runs when the initial restore finishes. The docs explicitly say it can be used to
resumePausedMutations() . If it returns a Promise, that Promise is awaited, and restoring is considered
ongoing until it resolves. tnsace

This is the most important callback in practice.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-325 - This:

Metadata:
```text
source_id: S-325
image_use_id: IU-325
fileId_short: 733425f1da
image_file: S-325__733425f1da.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
This:
«> TypeScript oO
persistQueryClient({
queryClient,
persister,
maxAge: 1000 * 60 * 60 * 24,
buster: 'build-42',
dehydrateOptions: {
shouldDehydrateQuery: (query) => query.state.status === ‘success’,
shouldDehydrateMutation: (mutation) => mutation.state.isPaused,
Lb
hydrateOptions: {
defaultOptions: {
queries: {
staleTime: 60_000,
Lb
Lb
Lb
»
Vv
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-330 - persistQueryClientRestore

Metadata:
```text
source_id: S-330
image_use_id: IU-330
fileId_short: cfb7f31c32
image_file: S-330__cfb7f31c32.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
persistQueryClientRestore
Use this when you want to restore previously saved cache right now.
It:
* reads persisted state from the persister
* hydrates it into the QueryClient
«discards it if expired, busted, empty, or invalid tansaa
Example idea:
«> TypeScript oO
await persistQueryClientRestore({
queryClient,
persister,
buster: 'vi',
maxAge: 1000 * 60 * 60 * 24,
»
That means: “load saved cache into this client, unless it's too old or version-mismatched.”
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-331 - What “dehydrate” means here

Metadata:
```text
source_id: S-331
image_use_id: IU-331
fileId_short: 679e04b899
image_file: S-331__679e04b899.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
What “dehydrate” means here
Dehydrate = convert the in-memory QueryClient state into a plain serializable object.
The hydration docs say dehydrate(queryClient, options) takes a QueryClient and optional
DehydrateOptions . Those options include:
© shouldDehydrateMutation
© shouldDehydrateQuery —tnstac -
Default dehydration behavior
By default:
+ only paused mutations are dehydrated
+ only successful queries are dehydrated tesa -
That is important:
* failed queries are not persisted by default
* active/non-paused mutations are not persisted by default
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-332 - Example:

Metadata:
```text
source_id: S-332
image_use_id: IU-332
fileId_short: 690055da26
image_file: S-332__690055da26.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example:
«> TypeScript oO
<PersistQueryClientProvider
client={queryClient}
persistOptions={{ persister }}
onSuccess={() => queryClient.resumePausedMutations()}
>
<App />
</PersistQueryClientProvider>
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-335 - Best mental model

Metadata:
```text
source_id: S-335
image_use_id: IU-335
fileId_short: 702382414d
image_file: S-335__702382414d.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Best mental model

Manual

restore -> subscribe -> save on changes

Provider

mount provider -> restore safely before fetches -> run restore callbacks -> subscribe -> save on
changes

So the provider is basically the React-safe version of the same persistence flow. (tanstack.com a)
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-336 - onError?: () => Promise | unknown

Metadata:
```text
source_id: S-336
image_use_id: IU-336
fileId_short: 3089a18359
image_file: S-336__3089a18359.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
onError?: () => Promise | unknown
This runs if an error is thrown during restoration. If it returns a Promise, that Promise is also awaited. —tenstack
Use it for:

«logging restore failures

*  dearing bad persisted data

* showing a message

* fallback recovery logic
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-337 - 1) Filtering with `meta`

Metadata:
```text
source_id: S-337
image_use_id: IU-337
fileId_short: ea74e9dd72
image_file: S-337__ea74e9dd72.png
status: verified-visible-manual-fix
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
1) Filtering with `meta`

The idea is:

- add a flag like `meta: { persist: true }` on queries you consider worth restoring
- during dehydration, include only queries whose `query.meta.persist` is truthy

`useQuery` supports a `meta` option, and the docs say it stores additional information on the query cache entry that is accessible wherever the query is available, and is also part of the `QueryFunctionContext`.

`dehydrate` accepts `shouldDehydrateQuery` / `shouldDehydrateMutation` functions that are called for each query/mutation in the cache. By default, dehydration includes only successful queries and paused mutations.
```

#### Notes

Manual visual read used because OCR timed out; source text is visible and not a placeholder.

---

### S-338 - becomes:

Metadata:
```text
source_id: S-338
image_use_id: IU-338
fileId_short: 9061540009
image_file: S-338__9061540009.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
becomes:
«> TypeScript oO
<PersistQueryClientProvider
client={queryClient}
persistOptions={{
persister,
maxAge: 1000 * 60 * 60 * 24,
buster: "build-42',
dehydrateOptions: {
shouldDehydrateQuery: (query) => query.state.status === ‘success’,
shouldDehydrateMutation: (mutation) => mutation.state.isPaused,
Lb
hydrateOptions: {
defaultOptions: {
queries: {
staleTime: 60_000,
Lb
Lb
Lb
b
>
<App />
</PersistQueryClientProvider> V
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-339 - persistQueryClientsubscribe

Metadata:
```text
source_id: S-339
image_use_id: IU-339
fileId_short: a23fad7b1e
image_file: S-339__a23fad7b1e.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
persistQueryClientsubscribe
Use this when you want to keep storage updated automatically whenever the cache changes.
It:
* subscribes to cache changes
«keeps saving updates
* returns an unsubscribe function tensa
Example idea:
«> TypeScript oO
const unsubscribe = persistQueryClientSubscribe({
queryClient,
persister,
buster: 'vi',
»
That means: “from now on, whenever cache changes, keep persisting it."
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-341 - dehydrateOptions

Metadata:
```text
source_id: S-341
image_use_id: IU-341
fileId_short: 86f6c97ef9
image_file: S-341__86f6c97ef9.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
dehydrateOptions

These are options passed to dehydrate(...) when saving. The persistence docs say dehydrateOptions is
used for save/subscribe, not restore. tanstack «

Main useful fields:

shouldDehydratequery

A function (query) => boolean that decides which queries get included in the persisted state. By default,
only successful queries are included. tase
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-342 - Related hook: `useIsRestoring`

Metadata:
```text
source_id: S-342
image_use_id: IU-342
fileId_short: 2256dc1fa3
image_file: S-342__2256dc1fa3.png
status: verified-visible-manual-fix
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Related hook: `useIsRestoring`

If you use `PersistQueryClientProvider`, you can also use `useIsRestoring()` to check whether restore is currently happening. The docs note that `useQuery` and related hooks already use this internally to avoid restore race conditions.

Very important configuration note

The docs strongly recommend setting `gcTime` on the `QueryClient` high enough when using persistence. If you do not, it defaults to 5 minutes for hydration behavior, and the stored cache may be discarded earlier than your persistence `maxAge`. They recommend setting `gcTime` to the same as or higher than `maxAge`, or even `Infinity`.
```

#### Notes

Manual visual read used because OCR timed out; source text is visible and not a placeholder.

---

### S-343 - Where can you access meta?

Metadata:
```text
source_id: S-343
image_use_id: IU-343
fileId_short: 1bd326b2ca
image_file: S-343__1bd326b2ca.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Where can you access meta?
You can access it in two common places:
A. In the query function
> TypeScript
useQuery({
queryKey: ['posts'],
queryFn: ({ meta }) => fetchPosts({ persist: meta?.persist === true }),
meta: { persist: true },
3)
meta is part of the QueryFunctionContext .  tnsack
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-344 - Example:

Metadata:
```text
source_id: S-344
image_use_id: IU-344
fileId_short: d3a05c5900
image_file: S-344__d3a05c5900.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example:
«> TypeScript oO
dehydrateOptions: {

shouldDehydrateQuery: (query) => query.queryKey[0] !== ‘debug*
3
Meaning:
© persist all successful queries except ["debug*, .--]
shouldDehydrateMutation
A function (mutation) => boolean that decides which mutations get included. By default, only paused
mutations are included. tanstac.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-346 - So how are these usually used?

Metadata:
```text
source_id: S-346
image_use_id: IU-346
fileId_short: 9ebc794e08
image_file: S-346__9ebc794e08.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
So how are these usually used?
Manual usage
If you want full control, the usual flow is:
«> TypeScript oO
await persistQueryClientRestore({ queryClient, persister, buster: 'v1' })
const unsubscribe = persistQueryClientSubscribe({
queryClient,
persister,
buster: 'vi',
»
Optionally you can call persistQueryClientSave(...) manually at specific times too. tanstac
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-347 - Minimal example

Metadata:
```text
source_id: S-347
image_use_id: IU-347
fileId_short: 90d6081ffb
image_file: S-347__90d6081ffb.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Minimal example
«> TypeScript ¢
import { QueryClient } from '@tanstack/react-query'
import { PersistQueryClientProvider } from '@tanstack/react-query-persist-client'
import { createSyncStoragePersister } from '@tanstack/query-sync-storage-persister'
const queryClient = new QueryClient({
defaultOptions: {
queries: {
gcTime: 1000 * 60 * 60 * 24,
hb
Lb
»
const persister = createSyncStoragePersister({
storage: window. localStorage,
»
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-348 - B. In dehydration filters

Metadata:
```text
source_id: S-348
image_use_id: IU-348
fileId_short: fadc3b9506
image_file: S-348__fadc3b9506.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
B. In dehydration filters
shouldDehydrateQuery receives the Query object, so you can inspect query-meta .

«> TypeScript oO

dehydrate(queryClient, {

shouldDehydrateQuery: (query) =>
query.state.status === 'success' && query.meta?.persist === true,

»

shouldDehydrateQuery is part of DehydrateOptions , and the function is called for each query in the cache.
Tanta +
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-349 - Example:

Metadata:
```text
source_id: S-349
image_use_id: IU-349
fileId_short: 8d02dc1462
image_file: S-349__8d02dc1462.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example:

«> TypeScript

dehydrateOptions: {

shouldDehydrateMutation: (mutation) => true

3
Meaning:
* persist all mutations, not just paused ones
So dehydrateOptions lets you control what gets saved.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-351 - React usage

Metadata:
```text
source_id: S-351
image_use_id: IU-351
fileId_short: 68590cce0c
image_file: S-351__68590cce0c.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
React usage

In React apps, you usually do not wire these manually.

Instead you use PersistQueryClientProvider , which handles restore + subscription lifecycle safely for you.
Tanta

So:
* manual utilities = lower-level building blocks
© PersistQueryClientProvider = React-friendly wrapper around that behavior
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-352 - What “hydrate” means here

Metadata:
```text
source_id: S-352
image_use_id: IU-352
fileId_short: 9421dfc650
image_file: S-352__9421dfc650.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
What “hydrate” means here
Hydrate = take previously dehydrated state and merge/restore it into a QueryClient .
The hydration docs say hydrate(client, dehydratedState, options) restores the state into the client.
Taniack
)
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-353 - function Root() {

Metadata:
```text
source_id: S-353
image_use_id: IU-353
fileId_short: bfdd0bf48e
image_file: S-353__bfdd0bf48e.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
function Root() {
return (
<PersistQueryClientProvider
client={queryClient}
persistOptions={{
persister,
maxAge: 1000 * 60 * 60 * 24,
buster: ‘v1',
aaa
onSuccess={() => {
queryClient.resumePausedMutations()
aaa
onError={() => {
console.error('Failed to restore persisted query cache")
aaa
>
<App />
</PersistQueryClientProvider>
)
3
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-355 - hydrateOptions

Metadata:
```text
source_id: S-355
image_use_id: IU-355
fileId_short: 263a9816d7
image_file: S-355__263a9816d7.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
hydrateOptions
These are options passed to hydrate(...) during restore. The persistence docs say hydrateOptions is used
on restore, not save. Tanstack +
From the hydration docs, HydrateOptions includes:
defaultoptions
Defaults to use for the hydrated entries:
© mutations: MutationOptions
* queries: QueryOptions tans
Example:
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-356 - 4) What about pruning?

Metadata:
```text
source_id: S-356
image_use_id: IU-356
fileId_short: fbc8550138
image_file: S-356__fbc8550138.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
4) What about pruning?
This part is more app-specific.
The persistence docs give you:
* selective dehydration via dehydrateOptions
© restore/discard controls via maxAge and buster
© apersister API with persistClient, restoreClient , and removeClient() — tmnsax -2
What they do not give you is a built-in “automatic localStorage LRU pruning strategy” in the standard
persistence API. That means pruning is usually something you implement yourself, either by:
* persisting less in the first place
* shortening maxAge
© dlearing invalid/outdated persisted state with buster
* or building a custom persister / save strategy. This last part is an inference from the documented API
surface. tnstack +2
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-357 - Best mental model

Metadata:
```text
source_id: S-357
image_use_id: IU-357
fileId_short: 95626c5870
image_file: S-357__95626c5870.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Best mental model
© Persistence = save the cache somewhere durable.
* Restore = load that saved cache back into QueryClient.
© PersistQueryClientProvider = React wrapper that restores safely, keeps saving updates, and exposes
onSuccess / onError around the restore step. tess:
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-359 - «> TypeScript oO

Metadata:
```text
source_id: S-359
image_use_id: IU-359
fileId_short: 56684bf115
image_file: S-359__56684bf115.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
«> TypeScript oO
hydrateOptions: {
defaultOptions: {
queries: {
retry: @,
staleTime: 60_000,
Lb
mutations: {
retry: 1,
Lb
Lb
3
Meaning:
when restoring persisted queries/mutations, apply these default options to them
So hydrateOptions lets you control how restored cache entries behave after restore.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-360 - The simplest pruning strategy

Metadata:
```text
source_id: S-360
image_use_id: IU-360
fileId_short: 7c337054a4
image_file: S-360__7c337054a4.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
The simplest pruning strategy
Do not persist most queries.
Good candidates to persist:
* user profile
app settings
*  static-ish reference data
© lists that are expensive but useful to restore
Bad candidates to persist:
«live notifications
* fast-changing feeds
* temporary search results
© giant paginated/infinite lists
That recommendation is an app-design inference, but it follows directly from the docs’ selective dehydration
hooks and storage constraints implied by browser storage use. tans -
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-361 - What buster is

Metadata:
```text
source_id: S-361
image_use_id: IU-361
fileId_short: 3071354b39
image_file: S-361__3071354b39.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
What buster is
buster is a version string that lets you force-invalidate old persisted caches.
The docs say if the restored cache does not have the same buster string, it is discarded. They also call this
“busted.” — tanstack
This is useful when:
* your API shape changed
* your cached data format changed
* you released a new app version and old persisted cache should no longer be trusted
Example:
«> TypeScript ia)
persistQueryClient ({
queryClient,
persister,
buster: ‘v2',
»
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-362 - 33.3 Selective persistence

Metadata:
```text
source_id: S-362
image_use_id: IU-362
fileId_short: e22d38f470
image_file: S-362__e22d38f470.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
33.3 Selective persistence
Do not persist everything blindly.
Some data may be:
* sensitive
* too large
* too short-lived
* not useful after restore
One approach is metadata-based filtering.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-364 - 5) Example: manual selective pruning by age/key before saving

Metadata:
```text
source_id: S-364
image_use_id: IU-364
fileId_short: bca292ecfa
image_file: S-364__bca292ecfa.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
5) Example: manual selective pruning by age/key before saving
You can go beyond meta.persist and skip large/old queries:
«> TypeScript oO
<PersistQueryClientProvider
client={queryClient}
persistOptions={{
persister,
maxAge: 1000 * 60 * 60 * 24,
dehydrateOptions: {
shouldDehydrateQuery: (query) => {
const persist = query.meta?.persist === true
const isSuccess = query.state.status === ‘success’
const isOld =
Date.now() - query.state.dataUpdatedAt > 1000 * 60 * 60 * 6
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-365 - «> TypeScript {

Metadata:
```text
source_id: S-365
image_use_id: IU-365
fileId_short: e6b95e6f80
image_file: S-365__e6b95e6f80.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
«> TypeScript {
useQuery({
queryKey: ['posts'],
queryFn: fetchPosts,
meta: { persist: true },
»
Then filter during dehydration based on meta-persist .
A good rule: persist only successful queries that are worth restoring.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-367 - Yes — ‘buster is usually a stable string that you change intentionally when you want to in

Metadata:
```text
source_id: S-367
image_use_id: IU-367
fileId_short: ac35ac2f49
image_file: S-367__ac35ac2f49.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Yes — ‘buster is usually a stable string that you change intentionally when you want to invalidate old
persisted cache.
A good way to think about it is:
* keep it constant across normal app runs
+ change it when your persisted data should no longer be trusted
Typical times to change it:
* you changed cache/data shape
* you changed query keys in a breaking way
* you released a new app version and want to throw away old persisted cache
* you fixed a bug that made old persisted state unsafe to restore
TanStack says that if the persisted cache’s buster does not match the current one, the cache is discarded.
stadt
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-368 - ee NE ON AN ONO II IIE EO III III OEE

Metadata:
```text
source_id: S-368
image_use_id: IU-368
fileId_short: 1ce1907fd2
image_file: S-368__1ce1907fd2.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
ee NE ON AN ONO II IIE EO III III OEE
// only persist successful, explicitly flagged, not-too-old queries
return persist && isSuccess && !isOld
Lb
Lb
b
>
<App />
</PersistQueryClientProvider>
This works because shouldDehydrateQuery runs per query, and the query object includes state and meta.
Tenstack +1
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-369 - 33.4 Storage quota issues

Metadata:
```text
source_id: S-369
image_use_id: IU-369
fileId_short: ea0f7aeaea
image_file: S-369__ea0f7aeaea.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
33.4 Storage quota issues
Local storage is limited.
If you persist too much, writes can fail.
A practical strategy is evicting older queries first.
General rule:
* persistence is not infinite storage
* be selective
* prune aggressively when needed
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-371 - Yes. query.state.dataUpdatedat is a built-in timestamp in TanStack Query’s query state. Th

Metadata:
```text
source_id: S-371
image_use_id: IU-371
fileId_short: 66852e288e
image_file: S-371__66852e288e.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Yes. query.state.dataUpdatedat is a built-in timestamp in TanStack Query’s query state. The docs list
dataUpdatedAt ON useQuery results as “the timestamp for when the query most recently returned the
status aS success .” It is also available via queryClient .getQueryState(...) , which returns the query state

object.

So in a dehydration filter like:

«> TypeScript oO
shouldDehydrateQuery: (query) => {
const isOld =
Date.now() - query.state.dataUpdatedAt > 1000 * 60 * 60 * 6
return query.meta?.persist === true && !isOld
3
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-372 - So yes, something like this is normal:

Metadata:
```text
source_id: S-372
image_use_id: IU-372
fileId_short: 9593d49fda
image_file: S-372__9593d49fda.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
So yes, something like this is normal:
«> TypeScript fa)
const PERSIST_BUSTER = ‘v1"

and later:
«> TypeScript fa)
const PERSIST_BUSTER = ‘v2"

when you want a clean break.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-374 - query.state.dataUpdatedAt is not something custom you invented — it is part of the built-i

Metadata:
```text
source_id: S-374
image_use_id: IU-374
fileId_short: 5cdaec07b5
image_file: S-374__5cdaec07b5.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
query.state.dataUpdatedAt is not something custom you invented — it is part of the built-in query state.
What it means:

* when a query successfully gets data, TanStack Query updates dataUpdatedat

* you can use it to estimate how old the cached data is

+ that makes it useful for selective persistence, manual pruning rules, or debugging freshness.
Related built-in timestamps/state you may also see:

© errorUpdatedAt

© status

© fetchStatus

* data

© error
So the short answer is: yes, dataUpdatedAt is built ir v
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

## Additional authoritative persistence transcript

## 3. React Query persistence

### Provider and persister

A persistent query client combines a `QueryClient`, a storage persister and restore options.

```tsx
<PersistQueryClientProvider
  client={queryClient}
  persistOptions={{
    persister,
    maxAge,
    buster,
    dehydrateOptions,
  }}
>
  <App />
</PersistQueryClientProvider>
```

A storage persister writes the dehydrated cache into sync or async storage.

```text
sync storage
    browser-style synchronous storage

async storage
    IndexedDB, React Native async storage or another promise-based adapter
```

The source notes that the exact helper package/API can vary by TanStack Query generation, so the canvas keeps both sync and async persister concepts rather than treating one helper name as permanent.

### Dehydration

`dehydrate` converts cache state into a plain serializable snapshot.

By default, persistence commonly includes successful queries and paused mutations. Filters control inclusion:

```ts
dehydrateOptions: {
  shouldDehydrateQuery: query =>
    query.state.status === "success"
    && query.meta?.persist === true,

  shouldDehydrateMutation: mutation =>
    mutation.state.isPaused,
}
```

`meta` can mark cache entries for persistence and can also be read inside a query function through query context.

```ts
useQuery({
  queryKey: ["posts"],
  meta: { persist: true },
  queryFn: ({ meta }) =>
    fetchPosts({
      persist: meta?.persist === true,
    }),
});
```

This avoids persisting every successful cache entry and prevents storage growth from debug, transient or private queries.

React Query selection is query/mutation-entry level. It is not a first-class field-level partialization API for arbitrary `query.data`. Field-level reduction requires a custom serializer/deserializer and must preserve cache invariants carefully.

### Hydration and restoration

`hydrate` restores a dehydrated snapshot into a `QueryClient`.

`useIsRestoring()` can prevent components from treating restore-time cache state as ordinary runtime fetching.

```tsx
const isRestoring =
  useIsRestoring();
```

The source emphasizes setting query `gcTime` at least as high as persistence `maxAge`; otherwise an inactive query can be removed from memory earlier than the persisted snapshot is allowed to live.

### `maxAge`

`maxAge` is checked while restoring a persisted cache. An expired snapshot is rejected rather than continuously deleted by a live timer.

```text
save
    snapshot receives persisted timestamp

restore
    current time - persisted timestamp > maxAge
        discard snapshot
```

It is a persisted-cache TTL.

### `buster`

`buster` is a hard invalidation token for persisted cache snapshots.

```ts
persistOptions: {
  persister,
  buster: BUILD_OR_SCHEMA_ID,
}
```

A mismatched buster means “this snapshot belongs to an incompatible app/data version; discard it.” This is closer to replacing a storage bucket or hard reset than to a schema migration function.

### Explicit save and throttling

A persistence subscriber can save whenever meaningful cache changes occur. The persister throttles/coalesces those saves to reduce serialization and storage I/O.

```text
many cache updates
    subscriber receives many events
    throttle collapses them
    one later persisted snapshot
```

For standard whole-client persistence, throttling is effectively global to that persisted client snapshot.

When per-query persistence behavior is required, use the dedicated per-query persister route supported by the installed TanStack Query generation rather than assuming whole-client persistence can throttle each query independently.

## What should be recallable

- How dehydration, persistence, restoration, maxAge, buster, and gcTime interact.
- How filters and pruning control what persisted cache state survives.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources
- Workspace: `_ai-conspects/persistance, zustand,rquery,redux/`
- Authoritative processed source: `01-final-transcript.md`, section 3
- Original source identity: `persistance, zustand,rquery,redux.svg` (canonical and raw SVGs exist locally under `source/` but are not tracked/resolvable from the current branch tree).


- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R14-persistence-hydration-pruning.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
