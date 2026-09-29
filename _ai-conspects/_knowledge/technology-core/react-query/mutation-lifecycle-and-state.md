# React Query mutation lifecycle and state

Knowledge ID: `react-query.mutation-lifecycle-and-state`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R10-mutations.md`


This section contains verified visible text/code. Entries marked `verified-from-sheet-crop` were checked against available sheet/crop images rather than standalone original PNGs.

### MUT-S001 - image 130 - `488e3dbdf9.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: mutation variable flow and optimistic update overview

#### Verified visible text

```text
`mutate(variables)` and `mutateAsync(variables)` both pass those variables into `onMutate`, `mutationFn`, `onSuccess`, `onError`, and `onSettled`. `onMutate` runs before the mutation function, which is why it's the right place to do the optimistic cache update and return rollback info for later callbacks.

So the flow you described is right:

1. call `mutate(...)` or `mutateAsync(...)`
2. `onMutate` gets the same variables
3. optimistically write to cache before server responds
4. return previous state or rollback context
5. if server mutation fails, `onError` uses that returned value to restore state
6. `onSettled` usually invalidates to resync with server truth.
```

#### Notes

Source chips like `TanStack +1` are visible but omitted from transcript body.

---

### MUT-S002 - image 005 - `55a51e51f4.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: optimistic update code example

#### Verified visible text

```text
Example:

That exact pattern is straight from the docs.
```

#### Verified visible code

```ts
const mutation = useMutation({
  mutationFn: updateTodo,
  onMutate: async (newTodo, context) => {
    await context.client.cancelQueries({ queryKey: ['todos'] })

    const previousTodos = context.client.getQueryData(['todos'])

    context.client.setQueryData(['todos'], (old) => [...old, newTodo])

    return { previousTodos }
  },
  onError: (err, newTodo, onMutateResult, context) => {
    context.client.setQueryData(['todos'], onMutateResult.previousTodos)
  },
  onSettled: (_data, _error, _vars, _result, context) => {
    context.client.invalidateQueries({ queryKey: ['todos'] })
  },
})
```

#### Notes

This image appears twice in the mutation region; also used by MUT-S009.

---

### MUT-S003 - image 003 - `5bec075fe3.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: cancelQueries / optimistic update race

#### Verified visible text

```text
2) Why `cancelQueries` matters in optimistic updates

TanStack's optimistic update guide literally says to cancel outgoing refetches so they don't overwrite your optimistic update.

The problem without cancellation

Imagine this timeline:

1. `['todos']` query is on screen
2. a refetch is already in flight
3. user edits/adds a todo
4. you optimistically call `setQueryData` and show the new todo immediately
5. the older in-flight refetch finishes with stale server data
6. that old response writes into cache and wipes out your optimistic change

That is the race you are preventing.

So the idea is:

cancel old fetches first, then write optimistic data, then later sync with the server result.
```

#### Notes

Visually checked against original PNG.

---

### MUT-S004 - image 150 - `73b5e8fd66.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: mutate vs mutateAsync / mutate

#### Verified visible text

```text
`mutate` vs `mutateAsync`

`mutate`

Use when you want the callback-style flow and do not need to `await` the mutation result directly.

You usually rely on:

- `onSuccess`
- `onError`
- `onSettled`

for follow-up behavior. The docs describe `mutate` as returning `void`.
```

#### Verified visible code

```ts
mutation.mutate(newTodo)
```

#### Notes

Visually checked against original PNG.

---

### MUT-S005 - image 004 - `f128bccab6.png`

Metadata:

- status: `verified-visible-partial`
- readability: `high`
- cut off: `yes`
- confidence: `high-for-visible-text`
- theme: standard optimistic update flow

#### Verified visible text

```text
3) Standard optimistic update flow with `cancelQueries`

TanStack's documented flow is:

1. `onMutate`
2. cancel outgoing refetches
3. snapshot previous cache value
4. write optimistic value with `setQueryData`
5. if mutation fails, roll back using the snapshot
6. on settled, invalidate/refetch to sync with server.

Example:
```

#### Notes

The screenshot is cut off below `Example:`. Do not infer the missing example from this screenshot; the example is visible in MUT-S002/MUT-S009.

---

### MUT-S006 - image 149 - `7de4e030ee.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: mutate UI example

#### Verified visible code

```ts
function RenameButton() {
  const mutation = useMutation({
    mutationFn: updateUser,
  })

  return (
    <button
      onClick={() => mutation.mutate({ id: '1', newName: 'Alice' })}
      disabled={mutation.isPending}
    >
      {mutation.isPending ? 'Saving...' : 'Rename'}
    </button>
  )
}
```

#### Notes

Code-only screenshot. Visually checked against original PNG.

---

### MUT-S007 - image 151 - `a7ac382dd0.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: mutateAsync

#### Verified visible text

```text
`mutateAsync`

Use when you want a Promise and prefer `await` / `try-catch`.

The docs say `mutateAsync` is similar to `mutate` but returns a Promise that resolves on success or throws on error.
```

#### Verified visible code

```ts
try {
  const result = await mutation.mutateAsync(newTodo)
} catch (err) {
  // handle error
}
```

#### Notes

Visually checked against original PNG.

---

### MUT-S008 - image 148 - `8641ca8bc2.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: immutable updates only

#### Verified visible text

```text
21.2 Immutable updates only

Always return a new object/array.

Good

Bad

If you return the same reference after mutating it, observers may not update correctly.
```

#### Verified visible code

```ts
// Good
queryClient.setQueryData(['user', id], (prev: any) =>
  prev ? { ...prev, name: newName } : prev
)

// Bad
queryClient.setQueryData(['user', id], (prev: any) => {
  prev.name = newName
  return prev
})
```

#### Notes

Original screenshot has separate Good/Bad TypeScript blocks; transcript keeps them together while preserving content.

---

### MUT-S009 - image 005 - `55a51e51f4.png`

Metadata:

- status: `verified-duplicate-of-MUT-S002`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: optimistic update code example

#### Verified visible text

```text
Example:

That exact pattern is straight from the docs.
```

#### Verified visible code

```ts
const mutation = useMutation({
  mutationFn: updateTodo,
  onMutate: async (newTodo, context) => {
    await context.client.cancelQueries({ queryKey: ['todos'] })

    const previousTodos = context.client.getQueryData(['todos'])

    context.client.setQueryData(['todos'], (old) => [...old, newTodo])

    return { previousTodos }
  },
  onError: (err, newTodo, onMutateResult, context) => {
    context.client.setQueryData(['todos'], onMutateResult.previousTodos)
  },
  onSettled: (_data, _error, _vars, _result, context) => {
    context.client.invalidateQueries({ queryKey: ['todos'] })
  },
})
```

#### Notes

Same underlying PNG as MUT-S002.

---

### MUT-S010 - image 152 - `e7fe1b2b60.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: when to use mutate

#### Verified visible text

```text
When to use which

Use `mutate` when:

- you are happy with mutation callbacks
- you trigger the mutation from UI events
- you do not need the result inline in surrounding code
```

#### Notes

Visually checked against original PNG.

---

### MUT-S011 - image 153 - `7ec1a778b8.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: when to use mutateAsync

#### Verified visible text

```text
Example:

Use `mutateAsync` when:

- you want to `await` the result
- you need sequential async logic
- you want `try/catch/finally` style code
```

#### Verified visible code

```ts
const saveTodo = () => {
  mutation.mutate({ id: 1, title: 'New' })
}
```

#### Notes

Visually checked against original PNG.

---

### MUT-S012 - image 131 - `69bab5a10b.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: best mental model for lifecycle callbacks

#### Verified visible text

```text
9. Best mental model

- `onMutate` = prepare optimistic state before server call
- `mutationFn` = do the actual write
- `onSuccess` = handle confirmed success
- `onError` = rollback failure
- `onSettled` = always-run final synchronization/cleanup
```

#### Notes

Visible source chip `TanStack +1` omitted from transcript body.

---

### MUT-S013 - image 147 - `c11c8e7392.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: manual updates get hard

#### Verified visible text

```text
21.3 When manual updates get hard

Manual updates become painful when the same entity appears in:

- sorted lists
- filtered lists
- detail page
- summary cards
- dashboard data

If an update changes sort order or filter membership, you may need to update many caches.

That is a sign to prefer invalidation.
```

#### Notes

Visually checked against original PNG.

---

### MUT-S014 - image 006 - `850109ec0c.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: useQuery v5 callbacks removed / mutation callbacks remain

#### Verified visible text

```text
In v5, `useQuery` does not have `onError`, `onSuccess`, or `onSettled`. Those query callbacks were removed in v5; they still exist for mutations, not queries.

So for optimistic updates, you usually do not "handle cancellation in `useQuery onError`", because there is no such callback in v5. Instead, you handle it by:

- canceling the relevant queries before your optimistic write,
- optionally making that cancellation silent,
- snapshotting previous cache data,
- writing optimistic data,
- rolling back in the mutation `onError`,
- invalidating/refetching in `onSettled`.
```

#### Notes

Visible source chips `tanstack.com +1` and `tanstack.com +2` omitted from transcript body.

---

### MUT-S015 - image 154 - `4b9ba54f93.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: mutate vs mutateAsync example

#### Verified visible text

```text
Example:

That's the cleanest difference:

- `mutate` = fire and let callbacks handle lifecycle
- `mutateAsync` = await the mutation like a normal Promise.
```

#### Verified visible code

```ts
const saveTodo = async () => {
  try {
    const saved = await mutation.mutateAsync({ id: 1, title: 'New' })
    console.log(saved)
  } catch (err) {
    console.error(err)
  }
}
```

#### Notes

Visually checked against original PNG. Source chip `TanStack +1` omitted from transcript body.

---

### MUT-S016 - image 145 - `9373bdbda3.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: what onMutate returns

#### Verified visible text

```text
4. What do we return from `onMutate`, and why?

You return rollback or context data that later callbacks may need.

In v5 docs, the value returned from `onMutate` is passed to:

- `onSuccess`
- `onError`
- `onSettled`

as the `onMutateResult` argument.

Typical returned values:

- previous cached data
- temporary optimistic IDs
- metadata needed for rollback
- anything you want later callbacks to know
```

#### Notes

Visually checked against original PNG.

---

### MUT-S017 - image 007 - `37ac0e6a45.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: cancellation handling in mutation callbacks

#### Verified visible text

```text
Do I need to do anything special in `useQuery` for cancellation?

Usually, no.

For optimistic updates, the recommended handling is:

- call `cancelQueries` in `onMutate`
- prefer `{ silent: true }`
- rollback in the mutation's `onError`
- refetch/invalidate in `onSettled`
```

#### Notes

Visible source chip `tanstack.com +2` omitted from transcript body.

---

### MUT-S018 - image 144 - `6759acc16a.png`

Metadata:

- status: `verified`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: onMutate signature

#### Verified visible text

```text
5. Callback arguments, one by one

`onMutate`

Signature in v5:

The docs describe it as receiving the same variables as the mutation function and firing before `mutationFn`.
```

#### Verified visible code

```ts
onMutate: (variables, context) => Promise<TOnMutateResult | void> | TOnMutateResult | void
```

#### Notes

Visually checked against original PNG. Source chip `TanStack` omitted from transcript body.

---

### MUT-S019 - image 146 - `a6d0648cd6.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `medium-high`
- cut off: `no`
- confidence: `high-for-visible-text`
- theme: why invalidate in onSettled

#### Verified visible text

```text
Why do we invalidate in `onSettled`?

`onSettled` runs whether the mutation succeeds or fails. TanStack defines it as the callback that fires when the mutation either succeeds or encounters an error.

You invalidate there because the optimistic cache is only a temporary guess. After the mutation is done, you want the real server state to become the source of truth again. TanStack's optimistic update docs show invalidation in `onSettled`, and even note that you should return that Promise if you want the mutation to stay pending until the refetch completes.

So:

- if mutation succeeds, invalidation refetches and confirms the final server state
- if mutation fails, `onError` rolls back, and invalidation can still refresh to the true server state if needed
```

#### Notes

Verified from available sheet/crop image, not standalone original PNG. Source chips omitted.

---

### MUT-S020 - image 143 - `ae6ed651d2.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `medium-high`
- cut off: `bottom-partially-cropped-in-sheet`
- confidence: `high-for-visible-text / medium-for-second-code-block`
- theme: variables argument

#### Verified visible text

```text
Arguments

`variables`

This is the value you passed to `mutate(...)`.

Example:

Then inside `onMutate`, `variables` is:
```

#### Verified visible code

```ts
mutation.mutate({ id: 5, title: 'New title' })

{ id: 5, title: 'New title' }
```

#### Notes

Second code block was low in the sheet crop; content is readable but kept medium confidence.

---

### MUT-S021 - image 155 - `db2d4aae55.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: return invalidateQueries Promise keeps pending

#### Verified visible text

```text
if your `onSettled` returns the Promise from `queryClient.invalidateQueries(...)`, React Query will keep the mutation itself in the `pending` state until that invalidation-triggered refetch finishes. The official optimistic updates guide says to return that Promise "so that the mutation stays in `pending` state until the refetch is finished."
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S022 - image 156 - `e2bb07761c.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: without returning invalidation Promise

#### Verified visible text

```text
Without returning the Promise

What happens:

1. mutation request finishes
2. `onSettled` runs
3. invalidation/refetch is started
4. but `onSettled` itself finishes immediately
5. mutation is no longer pending, even though the follow-up refetch may still be running.

So your mutation state may become:

- `isPending = false`

while the query is still refetching in background.
```

#### Verified visible code

```ts
onSettled: () => {
  queryClient.invalidateQueries({ queryKey: ['todos'] })
}
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S023 - image 142 - `507dbfa569.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: context.client

#### Verified visible text

```text
`context`

This is a mutation function context object. In the optimistic update examples/docs, it includes `client`, which is the `QueryClient` you use for things like:

- `cancelQueries`
- `getQueryData`
- `setQueryData`
- `invalidateQueries`

So in practice:
```

#### Verified visible code

```ts
onMutate: async (variables, context) => {
  context.client.setQueryData(...)
}
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S024 - image 157 - `35935e7b35.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `visible-code-only`
- confidence: `high`
- theme: returning the Promise code snippet

#### Verified visible text

```text
Returning the Promise
```

#### Verified visible code

```ts
onSettled: () => {
  return queryClient.invalidateQueries({ queryKey: ['todos'] })
}
```

#### Notes

Verified from available sheet/crop image. Only the visible snippet is transcribed.

---

### MUT-S025 - image 158 - `c8aefd2cea.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `top-slightly-cropped`
- confidence: `high-for-visible-text`
- theme: returning Promise behavior steps

#### Verified visible text

```text
or shorter:

Now what happens:

1. mutation request finishes
2. `onSettled` runs
3. `invalidateQueries` starts the refetch and returns a Promise
4. React Query waits for that Promise
5. mutation stays `pending` until that Promise resolves, meaning until the refetch work is done.
```

#### Verified visible code

```ts
onSettled: () => queryClient.invalidateQueries({ queryKey: ['todos'] })
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S026 - image 141 - `5f990bee01.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: mutationFn

#### Verified visible text

```text
`mutationFn`

This is the actual async function that performs the server write.

Example:

It receives the same `variables` you passed to `mutate`. Mutations are used to create/update/delete data or cause side-effects.
```

#### Verified visible code

```ts
mutationFn: (newTodo) => api.updateTodo(newTodo)
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S027 - image 140 - `ed4ef609cc.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: onSuccess signature and data argument

#### Verified visible text

```text
`onSuccess`

Signature in v5:

It runs when the mutation succeeds.

Arguments

`data`

The resolved result of `mutationFn`.
```

#### Verified visible code

```ts
onSuccess: (data, variables, onMutateResult, context) => Promise<unknown> | unknown
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S028 - image 159 - `9d4d2d9cfa.png`

Metadata:

- status: `verified-visible-partial-from-original-png`
- readability: `medium / cut off`
- cut off: `yes`
- confidence: `high-for-visible-text / incomplete-source`
- theme: why pending matters / cut off

#### Verified visible text

```text
Why this matters

Suppose you are showing an optimistic todo row while:
```

#### Verified visible code

```ts
mutation.isPending
```

#### Notes

Original PNG is cut off at the bottom. A partial line `is true` is visible below the code block, but the continuation is not visible.

---

### MUT-S029 - image 139 - `57a7aa95ed.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: data returned from mutationFn

#### Verified visible text

```text
Example:

If server returns:

then `data` is that returned payload.
```

#### Verified visible code

```ts
mutationFn: (todo) => api.updateTodo(todo)

{ id: 5, title: 'Saved', updatedAt: '...' }
```

#### Notes

Verified from available sheet/crop image.

---

### MUT-S030 - image 138 - `27b93b199a.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `top-context-may-be-cropped`
- confidence: `high-for-visible-text`
- theme: variables / onMutateResult availability

#### Verified visible text

```text
The original variables passed to `mutate(...)`.

`onMutateResult`

Whatever `onMutate` returned.

Example:

then in `onSuccess`:
```

#### Verified visible code

```ts
return { previousTodos }

onSuccess: (data, variables, onMutateResult, context) => {
  // onMutateResult.previousTodos is available
}
```

#### Notes

Verified from available sheet/crop image. Top context may be cropped.

---

### MUT-S031 - image 137 - `c35292d43d.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: onSuccess typical usage

#### Verified visible text

```text
`context`

Again, mutation function context, including `client`.

Typical `onSuccess` usage:

- replace optimistic item with server-confirmed item
- invalidate related queries
- do success side effects
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S032 - image 136 - `56c5c8888e.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `bottom-slightly-cropped`
- confidence: `high-for-visible-text`
- theme: onError signature and arguments

#### Verified visible text

```text
`onError`

Signature in v5:

It runs if the mutation errors.

Arguments

`err`

The mutation error thrown/rejected by `mutationFn`.

`variables`

The original mutation variables.

`onMutateResult`

The value returned from `onMutate`.

This is why rollback data is returned from `onMutate`.
```

#### Verified visible code

```ts
onError: (err, variables, onMutateResult, context) => Promise<unknown> | unknown
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S033 - image 135 - `82af270795.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: onError rollback usage

#### Verified visible text

```text
`context`

Mutation context, including `client`.

Typical `onError` usage:

- rollback optimistic cache
- show error toast
- log failure

Example:

That is the classic rollback path.
```

#### Verified visible code

```ts
onError: (err, newTodo, onMutateResult, context) => {
  context.client.setQueryData(['todos'], onMutateResult.previousTodos)
}
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S034 - image 134 - `c7dccde3bc.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `bottom-cropped-after-variables`
- confidence: `high-for-visible-text / partial-source`
- theme: onSettled signature and arguments

#### Verified visible text

```text
`onSettled`

Signature in v5:

It runs whether the mutation succeeded or failed.

Arguments

`data`

Mutation result if successful, otherwise typically undefined.

`error`

Mutation error if failed, otherwise typically null/undefined depending on typing/runtime shape.

`variables`

Original mutation variables.
```

#### Verified visible code

```ts
onSettled: (data, error, variables, onMutateResult, context) => Promise<unknown> | unknown
```

#### Notes

Verified from available sheet/crop image. Bottom content after `variables` is cropped.

---

### MUT-S035 - image 133 - `1cb0706b7f.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: onMutateResult / context / onSettled example

#### Verified visible text

```text
`onMutateResult`

The value returned from `onMutate`.

`context`

Mutation context, including `client`.

Typical `onSettled` usage:

- invalidate related queries
- do "always cleanup" logic
- resync with server after optimistic update

Example:

The optimistic updates guide uses `onSettled` for invalidation so the cache is synchronized with the true server state after the mutation is done.
```

#### Verified visible code

```ts
onSettled: (_data, _error, _vars, _onMutateResult, context) => {
  return context.client.invalidateQueries({ queryKey: ['todos'] })
}
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

### MUT-S036 - image 132 - `af1044b3cf.png`

Metadata:

- status: `verified-from-sheet-crop`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: async callbacks are awaited

#### Verified visible text

```text
8. One subtle detail: async callbacks are awaited

The docs say if `onMutate`, `onSuccess`, `onError`, or `onSettled` return a promise, it is awaited before proceeding.

That means:

is not just stylistic. TanStack Query will wait for it.

That is useful because in optimistic updates you usually want:

- cancel old refetches first
- then write optimistic cache

In that exact order.
```

#### Verified visible code

```ts
onMutate: async (...) => {
  await context.client.cancelQueries(...)
  ...
}
```

#### Notes

Verified from available sheet/crop image. Source chip omitted.

---

## Stage 4i correction addendum - R10 v006

Generated: 2026-06-01 22:02:02 UTC

### Direction check

Goal: finish the audited correction for R10 under the no-image-loss boundary rules.
Now: R10 mutation transcript is mostly complete, but audit found two missed mutation-area screenshots and one duplicate-use coverage issue.
This step: add `S-240/S-241` and explicitly record duplicate image use `S-237/S-246`.
Why: mutation cache/offlineFirst notes belong to the mutation area, and duplicate placements must not disappear from coverage.

### 0.2 Coverage / boundary review update

Added in R10 v006:

```text
S-240 -> When you may need MutationCache
S-241 -> Best mental model for offlineFirst
```

Duplicate-use coverage note:

```text
S-237 and S-246 share the same fileId/content (`55a51e51f4`).
The optimistic update code example is already transcribed, but both placements are now recorded so neither image use disappears.
```

### R10-S240 / S-240 - `d5efd6d469`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `same-area-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: MutationCache - when you may need it

#### Verified visible text

```text
When you may need it

Mostly advanced situations:

- custom mutation monitoring
- tooling/devtools-like behavior
- observing global mutation lifecycle
- custom offline/persistence integrations

Example idea

Mental model:

- `MutationCache` = low-level storage for all mutation records
- `QueryClient` methods are the usual higher-level way to interact with them
```

#### Verified visible code

```ts
const mutationCache = queryClient.getMutationCache()
```

### R10-S241 / S-241 - `8fdcc18b67`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `same-area-continuation`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: offlineFirst best mental model

#### Verified visible text

```text
Best mental model

`offlineFirst` means:

“Try now, even offline, because some local/network cache might satisfy the request.”

It does not mean:

“The data is guaranteed current.”
```

### R10 v006 interpretation update

MutationCache is a lower-level mechanism for mutation records and advanced monitoring/integration use cases. `offlineFirst` means the system tries immediately because a cache/local/offline path may satisfy the request; it does not guarantee the returned data is current.

## What should be recallable

- How mutate and mutateAsync expose mutation state and outcomes.
- How mutation keys, defaults, retries, scope, reset, and authoritative corrections participate in lifecycle.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R10-mutations.md`, source-transcript section and correction addendum
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
