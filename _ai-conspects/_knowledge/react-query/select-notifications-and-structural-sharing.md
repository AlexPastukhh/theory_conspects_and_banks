# React Query select, notifications, and structural sharing

Knowledge ID: `react-query.select-notifications-and-structural-sharing`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R03-notify-select-structural-sharing.md`


### R03-S001 / S-029 - `905bfe2c8b`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-notifyonchangeprops-default-tracked`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: notifyOnChangeProps and default tracked properties

#### Verified visible text
```text
`notifyOnChangeProps` is a `useQuery` option that controls which returned query fields are allowed to trigger a component re-render.

By default, TanStack Query uses tracked properties: it watches which fields from the query result your component actually reads, and only re-renders when one of those used fields changes.

So this:

means your component usually re-renders when `data` or `isLoading` changes, because those are the fields you used. If `isFetching` changes but you never read it, that alone should not cause a re-render.
```

#### Verified visible code
```tsx
const { data, isLoading } = useQuery(...)
```

#### Notes
Verified from R03 contact sheet/source image.

---

### R03-S002 / S-035 - `b7b12231ee`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-notifyonchangeprops-explicit`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: Explicit notifyOnChangeProps restricts re-render fields

#### Verified visible text
```text
You can override that behavior with `notifyOnChangeProps`.

This means: re-render this component only when `data` or `error` changes. Changes to `isFetching`, `isStale`, `status`, and other fields will not trigger a re-render for this observer.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  notifyOnChangeProps: ['data', 'error'],
})
```

#### Notes
Verified from R03 source image.

---

### R03-S003 / S-041 - `ca846784a5`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-select-reduces-observed-data-shape`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: select subscribes observer to selected result

#### Verified visible text
```text
If you use `select`, your component subscribes to the selected result, not the whole original data shape. So if the underlying query data changes, but the value returned by `select` does not meaningfully change, the component does not need to re-render for that reason. TanStack Query documents this with the example of selecting `data.length`: the component re-renders only when the length changes, not when a todo's name changes.

Example:

If one todo title changes but the array length stays the same, this component should not re-render because of `data`, since the selected value is still the same count.

Now to the main question: then why do we need `notifyOnChangeProps` at all?
```

#### Verified visible code
```tsx
const { data: count } = useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  select: (todos) => todos.length,
})
```

#### Notes
Verified from R03 source image.

---

### R03-S004 / S-046 - `cfea23af3a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-select-vs-notifyonchangeprops`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: select and notifyOnChangeProps solve different problems

#### Verified visible text
```text
Because `select` and `notifyOnChangeProps` solve different problems.

- `select` controls what data value this observer sees
- `notifyOnChangeProps` controls which fields from the `useQuery` result are allowed to trigger a re-render

So `select` helps with the `data` part.
`notifyOnChangeProps` helps with the whole result object: `data`, `error`, `isFetching`, `isPending`, `status`, `isStale`, and so on.

By default, TanStack Query already does smart tracking with a Proxy: it only re-renders if a property your component actually used changes. So if you do not read `isFetching`, then changes to `isFetching` should not re-render your component anyway.

That is why, in normal code, you often do not need `notifyOnChangeProps`. The default behavior is already optimized.
```

#### Notes
Verified from R03 source image.

---

### R03-S005 / S-055 - `224e1a8e1a`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-when-notifyonchangeprops-useful-fixed-list`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: notifyOnChangeProps useful for explicit fixed observer fields

#### Verified visible text
```text
So when is `notifyOnChangeProps` useful?

One case is when you want to be explicit and lock the observer to a fixed list, like only `data` and `error`.

That means even if the component accidentally starts touching some other field later, only `data` and `error` are supposed to trigger updates.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['todos'],
  queryFn: fetchTodos,
  notifyOnChangeProps: ['data', 'error'],
})
```

#### Notes
Verified from R03 source image.

---

### R03-S006 / S-058 - `25af0ad09e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-notifyonchangeprops-empty-prefetch-like`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: notifyOnChangeProps empty list for prefetch-like hook observer

#### Verified visible text
```text
Another important case is when you intentionally use a query only to kick off fetching/prefetching, but do not want that hook to re-render the component at all.

TanStack Query shows this as an optimization for prefetch-like usage. The query runs, but this component does not subscribe to result changes.

And another subtle reason: the tracked-props optimization depends on which properties get accessed. The docs note that certain patterns like object rest destructuring can defeat that optimization. In those cases, setting `notifyOnChangeProps` manually gives you precise control.
```

#### Verified visible code
```tsx
useQuery({
  queryKey: ['article-comments', id],
  queryFn: getArticleCommentsById,
  notifyOnChangeProps: [],
})
```

#### Notes
Verified from R03 source image.

---

### R03-S007 / S-059 - `d1b9ca270e`

Metadata:

- status: `verified-from-extracted-svg-image`
- candidate_type: `r03-prefetchquery-vs-usequery-empty-notify`
- readability: `high`
- cut_off: `no`
- confidence: `high`
- theme: prefetchQuery versus useQuery with notifyOnChangeProps empty

#### Verified visible text
```text
The main difference is this:

- `prefetchQuery()` means: fetch and cache this query, but don't subscribe any component to it. It returns `Promise<void>`, does not return data, and does not throw errors. That is exactly what prefetching is for.
- `useQuery({ notifyOnChangeProps: [] })` means: create a query observer in this component, start the fetch, but suppress re-render notifications from this observer. The fetch still happens and the cache is still populated, but you are still using a render hook for something that is not really being rendered from. This is why docs describe it as “prefetch-like.”

So your instinct is right: in many cases, use `queryClient.prefetchQuery()` instead.

Why would someone still use the `useQuery(... notifyOnChangeProps: [])` version?

One reason is convenience inside a component. If you are already in component code and want a child query to start as soon as the parent renders, this hook-based version can be dropped in without wiring up `useQueryClient`, `useEffect`, or an event handler. It behaves like “start fetching during this render path, but don't make this component care about the result.” That can help avoid request waterfalls.
```

#### Notes
Verified from R03 source image.

---

## Authoritative claim transcript: `R03-v002-notify-select-correction.md`


### S-065 - select/default tracked props/notifyOnChangeProps mental model

Metadata:
```text
source_id: S-065
image_use_id: IU-065
fileId_short: 1a557e01c2
image_file: S-065__1a557e01c2.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
So the practical answer is:

- If you don't use `isPending`, `isLoading`, `isFetching`, etc., you usually don't need `notifyOnChangeProps` to suppress them — default tracking already does that.
- If you do use them, then their changes should re-render the component, because you asked for them.
- You use `notifyOnChangeProps` when you want stricter/manual control over which fields can trigger re-renders, or when you want zero subscription behavior like `[]`.

A good mental model is:

- `select` = “give me only this slice of `data`”
- default tracked props = “re-render only for query result fields I actually read”
- `notifyOnChangeProps` = “ignore automatic tracking and use this exact whitelist instead”
```

#### Notes

Readable correction card; belongs to R03, not R09.

---

### S-066 - useQuery notifyOnChangeProps [] vs prefetchQuery timing

Metadata:
```text
source_id: S-066
image_use_id: IU-066
fileId_short: 3b93be2992
image_file: S-066__3b93be2992.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Another reason is timing. `useQuery` participates naturally in the component lifecycle, while `prefetchQuery` is often used in:

- event handlers
- route loaders / router integration
- effects
- explicit preloading logic

So the practical advice is:

- If you want true prefetching, especially from a click, hover, route transition, loader, or explicit preload step, use `queryClient.prefetchQuery()`.
- If you want a component to kick off another query during render but not subscribe to updates from it, `useQuery({ notifyOnChangeProps: [] })` is a valid special-case pattern.
```

#### Notes

Readable correction card; belongs to R03 prefetch-like discussion.

---

## What should be recallable

- How select, tracked properties, notifyOnChangeProps, and structural sharing interact.
- Why the authoritative correction changes the default-tracking mental model.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R03-notify-select-structural-sharing.md`, source-transcript section
- Authoritative processed source: `regions/R03-v002-notify-select-correction.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
