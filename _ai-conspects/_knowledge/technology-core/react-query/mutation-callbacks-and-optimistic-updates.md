# React Query mutation callbacks and optimistic updates

Knowledge ID: `react-query.mutation-callbacks-and-optimistic-updates`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R11-mutations-callbacks-optimistic.md`


### S-224 - cancellation handling for optimistic updates

Metadata:
```text
source_id: S-224
image_use_id: IU-224
fileId_short: 37ac0e6a45
image_file: S-224__37ac0e6a45.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

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

Readable; duplicated later by S-254.

---

### S-233 - getMutationCache is lower-level mutation cache access

Metadata:
```text
source_id: S-233
image_use_id: IU-233
fileId_short: 7ace83dc39
image_file: S-233__7ace83dc39.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`getMutationCache()`

This returns the `MutationCache` connected to the `QueryClient`.

What the mutation cache is:

It is the low-level store for mutation entries:

- pending mutations
- paused mutations
- mutation state/status
- metadata and mutation execution

Just like with `getQueryCache()`, most app code does not need this directly. Usually you use:

- `useMutation`
- `isMutating`
- mutation defaults
- `resumePausedMutations`

instead of touching the mutation cache directly.
```

#### Notes

Readable.

---

### S-236 - onMutate receives variables and returns rollback context

Metadata:
```text
source_id: S-236
image_use_id: IU-236
fileId_short: 488e3dbdf9
image_file: S-236__488e3dbdf9.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`mutate(variables)` and `mutateAsync(variables)` both pass those variables into `onMutate`, `mutationFn`, `onSuccess`, `onError`, and `onSettled`. `onMutate` runs before the mutation function, which is why it's the right place to do the optimistic cache update and return rollback info for later callbacks.

So the flow you described is right:

1. call `mutate(...)` or `mutateAsync(...)`
2. `onMutate` gets the same variables
3. optimistically write to cache before server responds
4. return previous state or rollback context
5. if server mutation fails, `onError` uses that returned value to restore state
6. `onSettled` usually invalidates to resync with server truth
```

#### Notes

Readable.

---

### S-238 - cancel old fetches before optimistic update

Metadata:
```text
source_id: S-238
image_use_id: IU-238
fileId_short: 5bec075fe3
image_file: S-238__5bec075fe3.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Why `cancelQueries` matters in optimistic updates.

TanStack's optimistic update guide literally says to cancel outgoing refetches so they don't overwrite your optimistic update.

The problem without cancellation:

Imagine this timeline:

1. `["todos"]` query is on screen
2. a refetch is already in flight
3. user edits/adds a todo
4. you optimistically call `setQueryData` and show the new todo immediately
5. the older in-flight refetch finishes with stale server data
6. that old response writes into cache and wipes out your optimistic change

That is the race you are preventing.

So the idea is: cancel old fetches first, then write optimistic data, then later sync with the server result.
```

#### Notes

Readable.

---

### S-239 - mutate vs mutateAsync

Metadata:
```text
source_id: S-239
image_use_id: IU-239
fileId_short: 73b5e8fd66
image_file: S-239__73b5e8fd66.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

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
```tsx
mutation.mutate(newTodo)
```

#### Notes

Readable.

---

### S-242 - standard optimistic update flow with cancelQueries

Metadata:
```text
source_id: S-242
image_use_id: IU-242
fileId_short: f128bccab6
image_file: S-242__f128bccab6.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
3) Standard optimistic update flow with `cancelQueries`

TanStack's documented flow is:

1. `onMutate`
2. cancel outgoing refetches
3. snapshot previous cache value
4. write optimistic value with `setQueryData`
5. if mutation fails, roll back using the snapshot
6. on settled, invalidate/refetch to sync with server
```

#### Notes

Readable.

---

### S-243 - return full object from onMutate for callbacks

Metadata:
```text
source_id: S-243
image_use_id: IU-243
fileId_short: 7de4e030ee
image_file: S-243__7de4e030ee.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example where `onMutate` returns a full object. Later callbacks can use that object for rollback or local UI state.
```

#### Verified visible code
```tsx
function RenameButton() {
  const mutation = useMutation({
    mutationFn: updateUser,

    onMutate: (variables) => {
      return {
        rollback: () => mutation.mutate({ id: 1, name: 'Alice' }),
        disabledButton: isPending,
      }
    },
  })

  return (
    <button disabled={mutation.isPending}>
      Rename
    </button>
  )
}
```

#### Notes

Readable code card; exact demo variable names are less important than returned object idea.

---

### S-244 - mutateAsync returns Promise and can be awaited

Metadata:
```text
source_id: S-244
image_use_id: IU-244
fileId_short: a7ac382dd0
image_file: S-244__a7ac382dd0.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
`mutateAsync`

Use when you want a Promise and order with `await` / `try-catch`.

The docs say `mutateAsync` is similar to `mutate`, but returns a Promise that resolves on success or throws on error.
```

#### Verified visible code
```tsx
try {
  const result = await mutation.mutateAsync(newTodo)
  other(result)
} catch (err) {}
```

#### Notes

Readable.

---

### S-245 - immutable updates only for setQueryData

Metadata:
```text
source_id: S-245
image_use_id: IU-245
fileId_short: 8641ca8bc2
image_file: S-245__8641ca8bc2.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
21.2 Immutable updates only

Always return a new object/array.

Good:

Bad:

If you return the same reference after mutating it, observers may not update correctly.
```

#### Verified visible code
```tsx
// Good
queryClient.setQueryData(['users'], (old = []) => [
  ...old,
  { id: crypto.randomUUID(), name: 'Ann' },
])

// Bad
queryClient.setQueryData(['users'], (old = []) => {
  old.push(newUser)
  return old
})
```

#### Notes

Readable.

---

### S-247 - when to use mutate

Metadata:
```text
source_id: S-247
image_use_id: IU-247
fileId_short: e7fe1b2b60
image_file: S-247__e7fe1b2b60.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
When to use which

Use `mutate` when:

- you are happy with mutation callbacks
- you trigger the mutation from UI events
- you do not need the result inline in surrounding code
```

#### Notes

Readable.

---

### S-248 - when to use mutateAsync

Metadata:
```text
source_id: S-248
image_use_id: IU-248
fileId_short: 7ec1a778b8
image_file: S-248__7ec1a778b8.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example. Use `mutateAsync` when:

- you want to `await` the result
- you need sequential async logic
- you want `try/catch/finally` style code
```

#### Verified visible code
```tsx
const saveTodo = () => {
  return mutation.mutateAsync({ id, title: 'New' })
}
```

#### Notes

Readable.

---

### S-249 - mutation lifecycle mental model

Metadata:
```text
source_id: S-249
image_use_id: IU-249
fileId_short: 69bab5a10b
image_file: S-249__69bab5a10b.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

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

Readable.

---

### S-250 - manual cache updates get hard

Metadata:
```text
source_id: S-250
image_use_id: IU-250
fileId_short: c11c8e7392
image_file: S-250__c11c8e7392.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

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

Readable.

---

### S-251 - query callbacks removed but mutation callbacks remain

Metadata:
```text
source_id: S-251
image_use_id: IU-251
fileId_short: 850109ec0c
image_file: S-251__850109ec0c.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
In v5, `onSuccess`, `onError`, and `onSettled` were removed from `useQuery`, but still exist for mutations, not queries.

So for optimistic updates, you usually do not “handle cancellation in `useQuery` somehow,” because there is no such callback in v5. Instead, you handle it by:

- canceling the relevant queries before your optimistic write,
- optionally marking that cancellation silent,
- snapshotting previous cache data,
- writing optimistic data,
- rolling back in the mutation `onError`,
- invalidating/refetching in `onSettled`.
```

#### Notes

Readable.

---

### S-252 - mutate vs mutateAsync return behavior

Metadata:
```text
source_id: S-252
image_use_id: IU-252
fileId_short: 4b9ba54f93
image_file: S-252__4b9ba54f93.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Example. That's the clearest difference: `mutate` = fire and let callbacks handle lifecycle; `mutateAsync` = await the mutation like a normal Promise.
```

#### Verified visible code
```tsx
const savedTodo = await mutation.mutateAsync({
  id,
  title: 'New'
})
```

#### Notes

Readable.

---

### S-253 - onMutate return value is passed to later callbacks

Metadata:
```text
source_id: S-253
image_use_id: IU-253
fileId_short: 9373bdbda3
image_file: S-253__9373bdbda3.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
4. What do we return from `onMutate`, and why?

You return rollback or context data that later callbacks may need.

In v5 docs, the value returned from `onMutate` is passed to `onError` and `onSettled` as the `onMutateResult` argument.

Typical returned values:

- previous cached data
- temporary optimistic IDs
- metadata needed for rollback
- anything you want later callbacks to know
```

#### Notes

Readable.

---

### S-254 - duplicate cancellation guidance for optimistic updates

Metadata:
```text
source_id: S-254
image_use_id: IU-254
fileId_short: 37ac0e6a45
image_file: S-254__37ac0e6a45.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

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

Duplicate of S-224; kept as duplicate-source evidence rather than dropped.

---

### S-255 - callback arguments variables and context

Metadata:
```text
source_id: S-255
image_use_id: IU-255
fileId_short: 6759acc16a
image_file: S-255__6759acc16a.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
5. Callback arguments, one by one

`onMutate`

Signature in v5 shows that `onMutate` receives the same `variables` the mutation function received, plus context.
```

#### Verified visible code
```tsx
onMutate: (
  variables,
  context,
) => Promise<TOnMutateResult> | void | TOnMutateResult
```

#### Notes

Readable; lower edge cropped after signature.

---

### S-256 - why invalidation in onSettled

Metadata:
```text
source_id: S-256
image_use_id: IU-256
fileId_short: a6d0648cd6
image_file: S-256__a6d0648cd6.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Why do we invalidate in `onSettled`?

`onSettled` runs whether the mutation succeeds or fails. TanStack defines it as the callback that fires when the mutation either succeeds or encounters an error.

You invalidate there because the optimistic cache is only a temporary guess. After the mutation is done, you want the real server state to become the source of truth again. TanStack's optimistic update docs show invalidation in `onSettled`, and even note that you should return that Promise if you want the mutation to stay pending until the refetch completes.

So:

- if mutation succeeds, invalidation refetches and confirms the final server state
- if mutation fails, `onError` rolls back, and invalidation can still refetch to the true server state if needed
```

#### Notes

Readable.

---

### S-257 - variables argument is the value passed to mutate

Metadata:
```text
source_id: S-257
image_use_id: IU-257
fileId_short: ae6ed651d2
image_file: S-257__ae6ed651d2.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Arguments

`variables`

This is the value you passed to `mutate(...)`.

Example:

Then inside `onMutate`, `variables` is:
```

#### Verified visible code
```tsx
mutation.mutate({
  id: 5,
  title: 'New title',
})

// variables:
{
  id: 5,
  title: 'New title',
}
```

#### Notes

Readable.

---

### S-258 - return invalidateQueries promise to keep mutation pending

Metadata:
```text
source_id: S-258
image_use_id: IU-258
fileId_short: db2d4aae55
image_file: S-258__db2d4aae55.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
If your `onSettled` returns the Promise from `queryClient.invalidateQueries(...)`, React Query will keep the mutation itself in the pending state until that invalidation-triggered refetch finishes.

The official optimistic updates guide says to return that Promise “so that the mutation stays in `pending` state until the refetch is finished.”
```

#### Notes

Readable.

---

### S-259 - without returning promise mutation stops pending before refetch ends

Metadata:
```text
source_id: S-259
image_use_id: IU-259
fileId_short: e2bb07761c
image_file: S-259__e2bb07761c.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

#### Verified visible text
```text
Without returning the Promise:

What happens:

1. mutation request finishes
2. `onSettled` runs
3. invalidation/refetch is started
4. but `onSettled` itself finishes immediately
5. mutation is no longer pending, even though the follow-up refetch may still be running

So your mutation state may become:

- `isPending = false`
- while the query is still refetching in background
```

#### Verified visible code
```tsx
onSettled: () => {
  queryClient.invalidateQueries({ queryKey: ['todos'] })
}
```

#### Notes

Readable.

---

### S-260 - onMutate context includes client QueryClient

Metadata:
```text
source_id: S-260
image_use_id: IU-260
fileId_short: 507dbfa569
image_file: S-260__507dbfa569.png
status: verified-visible-from-contact-sheet
transcript_method: manually prepared from Stage4w2 contact sheet/source image
```

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
```tsx
onMutate: async (variables, context) => {
  const client = context.client
}
```

#### Notes

Readable.

---

## Authoritative claim transcript: `R11B-mutation-callbacks-tail.md`


### S-261 - Returning the Promise

Metadata:
```text
source_id: S-261
image_use_id: IU-261
fileId_short: 35935e7b35
image_file: S-261__35935e7b35.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Returning the Promise
“) TypeScript (
onSettled: () = {
return queryClient.invalidateQueries({ queryKey: [‘todos'] })
t
|.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-262 - or shorter:

Metadata:
```text
source_id: S-262
image_use_id: IU-262
fileId_short: c8aefd2cea
image_file: S-262__c8aefd2cea.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
or shorter:
“) TypeScript O
onSettled: () => queryClient.invalidateQueries({ queryKey: [‘todos'] })
Now what happens:
1. mutation request finishes
2. onSettled runs
3. invalidateQueries starts the refetch and returns a Promise
4. React Query waits for that Promise
5. mutation stays pending until that Promise resolves, meaning until the refetch work is done. — tanstack -:
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-263 - mutationFn

Metadata:
```text
source_id: S-263
image_use_id: IU-263
fileId_short: 5f990bee01
image_file: S-263__5f990bee01.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
mutationFn
This is the actual async function that performs the server write.
Example:
“) TypeScript O
mutationFn: (newlodo) => api.updateTodo(newTodo)
It receives the same variables you passed to mutate . Mutations are used to create/update/delete data or
cause side-effects. tanstac ~1
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-264 - onSuccess

Metadata:
```text
source_id: S-264
image_use_id: IU-264
fileId_short: ed4ef609cc
image_file: S-264__ed4ef609cc.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
onSuccess

Signature in v5:
“) TypeScript O
onSuccess: (data, variables, onMutateResult, context) => Promise<unknown> | unknown

It runs when the mutation succeeds. _ tanstack

Arguments

data

The resolved result of mutationFn .
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-265 - Why this matters

Metadata:
```text
source_id: S-265
image_use_id: IU-265
fileId_short: 9d4d2d9cfa
image_file: S-265__9d4d2d9cfa.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Why this matters

Suppose you are showing an optimistic todo row while:
“) TypeScript O
mutation. isPending

te train
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-266 - Example:

Metadata:
```text
source_id: S-266
image_use_id: IU-266
fileId_short: 57a7aa95ed
image_file: S-266__57a7aa95ed.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
Example:
«> TypeScript oO
mutationFn: (todo) => api.updateTodo(todo)

If server returns:
“) TypeScript O
{ id: 5, title: ‘Saved', updatedAt: *..." }

then data is that returned payload.
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-267 - variables

Metadata:
```text
source_id: S-267
image_use_id: IU-267
fileId_short: 27b93b199a
image_file: S-267__27b93b199a.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
variables
The original variables passed to mutate(...) .
onMutateResult
Whatever onMutate returned.
Example:
«> TypeScript oO
return { previousTodos }
then in onSuccess :
«> TypeScript 0
onSuccess: (data, variables, onMutateResult, context) => {
// onMutateResult.previousTodos is available
3
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-268 - context

Metadata:
```text
source_id: S-268
image_use_id: IU-268
fileId_short: c35292d43d
image_file: S-268__c35292d43d.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
context
Again, mutation function context, including client . tnstac
Typical onSuccess usage:

¢ replace optimistic item with server-confirmed item

¢ invalidate related queries

¢ do success side effects
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-269 - onError

Metadata:
```text
source_id: S-269
image_use_id: IU-269
fileId_short: 56c5c8888e
image_file: S-269__56c5c8888e.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
onError
Signature in v5:
«> TypeScript 0
onError: (err, variables, onMutateResult, context) => Promise<unknown> | unknown
It runs if the mutation errors. —tanstace
Arguments
err
The mutation error thrown/rejected by mutationFn .
variables
The original mutation variables.
onMutateResult
The value returned from onMutate .
This is why rollback data is returned from onMutate .
1
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-270 - context

Metadata:
```text
source_id: S-270
image_use_id: IU-270
fileId_short: 82af270795
image_file: S-270__82af270795.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
context
Mutation context, including client. tnstac
Typical onError usage:
e rollback optimistic cache
e show error toast
¢ log failure
Example:
“) TypeScript a)
onError: (err, newlodo, onMutateResult, context) => {
context .client.setQueryData([‘todos'], onMutateResult.previousTodos)
t
That is the classic rollback path. — tanstack ~:
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-271 - onSettled

Metadata:
```text
source_id: S-271
image_use_id: IU-271
fileId_short: c7dccde3bc
image_file: S-271__c7dccde3bc.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
onSettled
Signature in v5:
«> TypeScript ay)
onSettled: (data, error, variables, onMutateResult, context) => Promise<unknown> | unknown
It runs whether the mutation succeeded or failed. _tnsace
Arguments
data
Mutation result if successful, otherwise typically undefined.
error
Mutation error if failed, otherwise typically null/undefined depending on typing/runtime shape.
variables
Original mutation variables. Vv
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-272 - onMutateResult

Metadata:
```text
source_id: S-272
image_use_id: IU-272
fileId_short: 1cb0706b7f
image_file: S-272__1cb0706b7f.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
onMutateResult
The value returned from onMutate .
context
Mutation context, including client. tnstc
Typical onSettled usage:
* invalidate related queries
do “always cleanup” logic
© resync with server after optimistic update
Example:
«> TypeScript oO
onSettled: (_data, _error, _vars, _onMutateResult, context) => {
return context.client.invalidateQueries({ queryKey: ["todos'] })
3
The optimistic updates guide uses [onSettled for inv {tation so the cache is synchronized with the true
server state after the mutation is done. tenstax -
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

### S-273 - 8. One subtle detail: async callbacks are awaited

Metadata:
```text
source_id: S-273
image_use_id: IU-273
fileId_short: af1044b3cf
image_file: S-273__af1044b3cf.png
status: verified-visible-ocr-assisted
transcript_method: Stage5c visible read from source image; OCR-assisted with manual fixes where needed
```

#### Verified visible text
```text
8. One subtle detail: async callbacks are awaited
The docs say if onMutate , onSuccess, onError , Of onSettled return a promise, it is awaited before
proceeding. tsace
That means:
«> TypeScript ia)
onMutate: async (...) => {
await context .client.cancelQueries(...)
3
is not just stylistic. TanStack Query will wait for it.
That is useful because in optimistic updates you usually want:
* cancel old refetches first
«then write optimistic cache
in that exact order. tnsact -
```

#### Notes

Visible text present; no OCR timeout/error placeholder is used.

---

## What should be recallable

- How hook-level and call-level mutation callbacks are sequenced.
- How optimistic update snapshot, cancellation, rollback, and invalidation flow works.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R11-mutations-callbacks-optimistic.md`, source-transcript section
- Authoritative processed source: `regions/R11B-mutation-callbacks-tail.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
