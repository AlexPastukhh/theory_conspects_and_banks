# React Query cache, browser cache, and HTTP cache boundaries

Knowledge ID: `react-query.cache-http-and-browser-boundaries`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R01-react-query-browser-http-cache.md`


### R01-S001 / S-001 - `d6b1d01150`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-seed`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: practical SPA recommendation: ETag + Cache-Control no-cache + React Query staleTime

#### Verified visible text

```text
7. A very practical recommendation

For most SPA APIs:

Good baseline

Backend:

- send ETag
- send Cache-Control: no-cache

Frontend:

- use normal fetch
- configure React Query staleTime based on UI needs

Why this works well:

- React Query controls UI freshness
- browser avoids full payload downloads when data is unchanged
- you get correctness + efficiency
```

#### Notes

Verified from extracted SVG image.

---

### R01-S002 / S-002 - `33ee5bc86f`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `left-column-seed`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: browser does not automatically manage ETag for API calls

#### Verified visible text

```text
Right — browsers don't automatically "manage" your ETag for API calls in the way you might hope.

Whether you must send it manually depends on how you're making the request and which header (If-None-Match vs If-Match) you're talking about.

1) If you're calling your API with fetch / axios

ETag response header

- The browser will receive the ETag header.
- Your JS code must read it and store it (memory/localStorage/state/etc.) if you want to use it later.
```

#### Verified visible code

```js
const res = await fetch("/products/1");
const etag = res.headers.get("ETag"); // you store it yourself
```

#### Notes

Verified from extracted SVG image.

---

### R01-S003 / S-003 - `3ba9d991a7`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-seed`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: React Query does not understand browser cache headers

#### Verified visible text

```text
8. What React Query does not know

React Query does not directly understand browser cache headers as freshness rules for your UI.

It does not automatically say:

- "browser says max-age 60, so I will set staleTime 60s"

These are separate systems.

So you still choose staleTime yourself.

That means you can have:

- React Query says data is stale
- browser still returns cached/revalidated response cheaply

That is normal and often desirable.
```

#### Notes

Verified from extracted SVG image.

---

### R01-S004 / S-004 - `6368f8adce`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `left-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: sending ETag back later with If-None-Match / If-Match

#### Verified visible text

```text
Sending it back later

You must manually include it on subsequent requests:

- For caching / "only give me if changed":
  - send If-None-Match: "<etag>"
- For optimistic concurrency / "only update if unchanged":
  - send If-Match: "<etag>"

So for SPA/API usage: yes, manual for both If-None-Match and If-Match.
```

#### Verified visible code

```js
await fetch("/products/1", {
  method: "PATCH",
  headers: { "If-Match": etag, "Content-Type": "application/json" },
  body: JSON.stringify(patch)
});
```

#### Notes

Verified from extracted SVG image.

---

### R01-S005 / S-005 - `cf6c2e813c`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: main idea: browser cache and React Query cache are different layers

#### Verified visible text

```text
For an SPA with React Query, the main idea is:

browser cache and React Query cache are different layers, and you should usually use both deliberately, not let them fight each other.
```

#### Notes

Verified from extracted SVG image.

---

### R01-S006 / S-006 - `335ef6b606`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: browser cache layer

#### Verified visible text

```text
1. The two caches

Browser cache

Controlled by HTTP headers like:

- Cache-Control
- ETag
- Last-Modified

It lives below your app, at the network/browser level.

It can:

- avoid downloading data again
- return cached responses
- revalidate with server
- make reload/navigation faster
```

#### Notes

Verified from extracted SVG image.

---

### R01-S007 / S-007 - `a9a9655e93`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `left-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: HTTP cache and revalidation

#### Verified visible text

```text
HTTP cache is the browser's built-in system for reusing GET/HEAD responses so it doesn't have to hit the network every time. It's driven by cache headers from the server and (sometimes) heuristics.

What the browser HTTP cache does

When you GET /products/1:

1. First request: browser downloads the response and may store it in its cache.
2. Later request for the same URL:
   - If the cached entry is still fresh, browser may serve it directly from cache (no network).
   - If it's stale, browser may revalidate: it asks the server "is my cached copy still valid?" instead of downloading the whole body again.

How revalidation works (ETag / If-None-Match)

If the server previously returned:

- ETag: "abc123"

Then for revalidation the browser can send:

- If-None-Match: "abc123"

Server replies:

- 304 Not Modified (no body) -> browser keeps using cached response
- or 200 OK with new body + new ETag -> browser updates cache

That's what I meant by "browser can automatically do conditional GETs with If-None-Match for cache revalidation."
```

#### Notes

Verified from extracted SVG image.

---

### R01-S008 / S-009 - `a7f13d6d3d`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `top-title-slightly-cropped`
- confidence: `high-for-visible-text`
- theme: React Query cache layer

#### Verified visible text

```text
React Query cache

Controlled by your app with:

- staleTime
- gcTime
- invalidation
- setQueryData
- refetch triggers

It lives in memory in your app.

It can:

- keep data between component mounts
- show stale data instantly
- refetch in background
- coordinate UI state
```

#### Notes

Top is slightly cropped before the title; visible content is transcribed.

---

### R01-S009 / S-010 - `b62d140856`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `left-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: why many API requests are treated as not using cache

#### Verified visible text

```text
Why "many API requests are effectively treated as don't use cache"

Because lots of APIs send headers like:

- Cache-Control: no-store (common for authenticated/user-specific data)
- or Cache-Control: no-cache
- or they vary by Authorization and choose not to cache
- or the request method isn't cacheable (POST/PATCH/PUT typically not cached)

Also, your fetch call can influence caching via the cache option:

- cache: "default" -> normal HTTP caching rules
- cache: "no-store" -> bypass cache, don't store
- cache: "reload" -> bypass cache and re-download
- cache: "no-cache" -> revalidate (like "must check with server")

So depending on server headers + fetch options, the browser may not reuse cached data the way it does for images/css/navigation.
```

#### Notes

Verified from extracted SVG image.

---

### R01-S010 / S-014 - `95f917ba2d`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `left-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: why HTTP cache revalidation does not solve API concurrency

#### Verified visible text

```text
Why this doesn't solve API concurrency (If-Match)

HTTP cache revalidation (If-None-Match) is about:

"Can I reuse my cached GET response?"

Optimistic concurrency (If-Match) is about:

"Only apply this UPDATE if the resource hasn't changed."

Browsers do not automatically send If-Match for writes, because:

- it's application logic (you decide what version you're updating)
- caching is separate from write preconditions

So for an SPA:

- you might get an ETag on GET
- you must store it and send it back yourself on PATCH/PUT as If-Match
```

#### Notes

Verified from extracted SVG image.

---

### R01-S011 / S-015 - `ad441bf8f8`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: practice and default mental model

#### Verified visible text

```text
2. What to do in practice

General rule

Let:

- browser cache optimize transport/network
- React Query optimize UI/data lifecycle

Do not try to replace one with the other.

3. Best default mental model

For API data in an SPA:

- React Query decides when your app wants to ask for data
- browser cache decides whether the network request really needs full download

So if React Query refetches, that does not automatically mean a full expensive network transfer happened.

The browser may answer from cache or revalidate cheaply.
```

#### Notes

Verified from extracted SVG image.

---

### R01-S012 / S-019 - `ac0d680857`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `right-edge-slightly-cropped-no-text-loss`
- confidence: `high`
- theme: backend pattern A: revalidation cache

#### Verified visible text

```text
4. What you usually should do on the backend

For API responses, configure HTTP caching intentionally.

Common good patterns:

Pattern A — revalidation cache

Good for frequently changing API data.

Example idea:
```

#### Verified visible code

```http
Cache-Control: no-cache
ETag: "abc123"
```

#### Notes

Right edge is slightly cropped but no visible text appears lost.

---

### R01-S013 / S-028 - `46476e445e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: revalidation cache implications

#### Verified visible text

```text
This means:

- browser may store the response
- next request revalidates with server
- if unchanged, server returns 304 Not Modified
- browser reuses cached body

This is often a very good fit with React Query.

Why:

- React Query can refetch whenever it wants
- browser makes repeated requests cheaper
```

#### Notes

Verified from extracted SVG image.

---

### R01-S014 / S-031 - `859a4e5afc`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: backend pattern B: short-lived freshness

#### Verified visible text

```text
Pattern B — short-lived freshness

Good for data that can be reused briefly.

Example idea:

This means:

- browser can reuse response for 30s without asking server
- then can serve stale while revalidating

Useful for semi-fresh public/read-heavy endpoints.
```

#### Verified visible code

```http
Cache-Control: max-age=30, stale-while-revalidate=120
```

#### Notes

Verified from extracted SVG image.

---

### R01-S015 / S-038 - `c764d1651a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: backend pattern C: long cache for versioned static assets

#### Verified visible text

```text
Pattern C — very long cache for versioned static assets

For JS/CSS/images, not normal dynamic API data.

Example:

Use for:

- hashed bundle files
- versioned static assets

Not for normal user-specific JSON APIs.
```

#### Verified visible code

```http
Cache-Control: public, max-age=31536000, immutable
```

#### Notes

Verified from extracted SVG image.

---

### R01-S016 / S-044 - `b00992d67d`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: React Query settings for frequently changing data

#### Verified visible text

```text
5. What to do with React Query settings

Now match React Query to the data type.

Frequently changing data

Use low/moderate staleTime.

Even if React Query refetches, browser revalidation can make it cheap.
```

#### Verified visible code

```ts
useQuery({
  queryKey: ['notifications'],
  queryFn: fetchNotifications,
  staleTime: 10_000,
})
```

#### Notes

Verified from extracted SVG image.

---

### R01-S017 / S-049 - `3442b4b77e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: React Query settings for rarely changing data

#### Verified visible text

```text
Rarely changing data

Use longer staleTime.

If data barely changes, let React Query avoid unnecessary refetches.
```

#### Verified visible code

```ts
useQuery({
  queryKey: ['countries'],
  queryFn: fetchCountries,
  staleTime: 1000 * 60 * 60,
})
```

#### Notes

Verified from extracted SVG image.

---

### R01-S018 / S-053 - `a1969014c7`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `bottom-ui-arrow-visible-no-text-loss`
- confidence: `high-for-visible-text`
- theme: server-push / realtime apps and React Query cache settings

#### Verified visible text

```text
Server-push / realtime apps

You may use:

and rely on:

- websocket events
- invalidation
- setQueryData

In that case browser cache matters less for freshness, more for reload/network efficiency.
```

#### Verified visible code

```ts
const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: Infinity,
    },
  },
})
```

#### Notes

Bottom UI arrow visible; no obvious text loss.

---

### R01-S019 / S-060 - `74e165828c`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: do not fight browser cache accidentally: plain fetch

#### Verified visible text

```text
6. Important thing: don't fight the browser cache accidentally

A lot depends on your fetch options.

Usually fine

Plain fetch:

This lets browser HTTP caching work normally.
```

#### Verified visible code

```ts
fetch('/api/todos')
```

#### Notes

Verified from extracted SVG image.

---

### R01-S020 / S-064 - `662677caa9`

Metadata:

- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `right-column-continuation`
- readability: `high`
- cut_off: `bottom-ui-arrow-visible-no-text-loss`
- confidence: `high-for-visible-text`
- theme: be careful with fetch cache no-store

#### Verified visible text

```text
Be careful with

This disables normal browser response caching benefits.

Use no-store only when you truly need it.

For most SPA + React Query API calls, you usually do not want to force no-store unless the data is very sensitive or must never be cached.
```

#### Verified visible code

```ts
fetch('/api/todos', { cache: 'no-store' })
```

#### Notes

Bottom UI arrow visible; no obvious text loss.

---

## What should be recallable

- How the React Query cache differs from browser and HTTP caches.
- Which cache layer owns freshness, reuse, and invalidation decisions.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R01-react-query-browser-http-cache.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
