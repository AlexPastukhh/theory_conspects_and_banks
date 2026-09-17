# React Query selector purity, observers, and performance

Knowledge ID: `react-query.selector-purity-observers-and-performance`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R20-select-tracked-props-performance.md`


### S-427 - 7. Best mental model

Metadata:
```text
source_id: S-427
image_use_id: IU-427
fileId_short: f300d1e3f8
image_file: S-427__f300d1e3f8.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
7. Best mental model
Destructure less

Optimizes query result field tracking
select

Optimizes data subscription granularity
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-432 - 1. Two different things are being tracked

Metadata:
```text
source_id: S-432
image_use_id: IU-432
fileId_short: f9d115e85c
image_file: S-432__f9d115e85c.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
1. Two different things are being tracked
When you call useQuery , there are really two layers:
Layer A — the query result object
Things like:
° data
° isFetching
°  isError
° status
- error
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-434 - 4. Concrete comparison

Metadata:
```text
source_id: S-434
image_use_id: IU-434
fileId_short: 7af8af0e27
image_file: S-434__7af8af0e27.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
4. Concrete comparison
Without select
</> TypeScript
function UserName() {
const { data } = useQuery({
queryKey: [‘user’],
queryFn: fetchUser,
})
return <div>{data?.name}</div>
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-435 - 8. Example where select is very useful

Metadata:
```text
source_id: S-435
image_use_id: IU-435
fileId_short: 2ff8c1ed2c
image_file: S-435__2ff8c1ed2c.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
8. Example where select is very useful
Imagine query returns whole cart:
<> TypeScript O
type Cart = {
items: { id: string; price: number; qty: number }[]
couponCode: string | null
shippingAddress: string
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-439 - Component A only needs total count

Metadata:
```text
source_id: S-439
image_use_id: IU-439
fileId_short: f85216609d
image_file: S-439__f85216609d.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Component A only needs total count
</> TypeScript oO
function CartBadge() {
const { data: itemCount } = useQuery({
queryKey: [‘cart'],
queryFn: fetchCart,
select: (cart) => cart.items.reduce((sum, item) => sum + item.qty, 9),
})
return <span>{itemCount}</span>
t
If shipping address changes, but item count stays the same, badge may avoid rerender.
Without select , component would receive whole cart object and rerender more often.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-440 - Example:

Metadata:
```text
source_id: S-440
image_use_id: IU-440
fileId_short: f45203256b
image_file: S-440__f45203256b.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Example:
</> TypeScript O
const query = useQuery(...)
React Query can track which of these properties you used during render.
So if you only read:
<> TypeScript O
const { data } = useQuery(...)
and never read isFetching, then changes to isFetching may not force your component to rerender.
That is what tracked properties is about.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-442 - If server response changes from:

Metadata:
```text
source_id: S-442
image_use_id: IU-442
fileId_short: 9d94722eb4
image_file: S-442__9d94722eb4.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
If server response changes from:
<> TypeScript
{ name: ‘Alice’, email: ‘a@mail.com’ }
to
<> TypeScript
{ name: ‘Alice’, email: ‘new@mail.com' }
your component may rerender because data changed.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-449 - Layer B — the data value itself

Metadata:
```text
source_id: S-449
image_use_id: IU-449
fileId_short: c34c30d1ff
image_file: S-449__c34c30d1ff.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Layer B — the data value itself
Inside data , maybe you have:
</> TypeScript
sf
id: ‘1’,
name: ‘Alice’,
email: ‘a@mail.com’,
settings: {..-},
posts: [...]
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-450 - With select

Metadata:
```text
source_id: S-450
image_use_id: IU-450
fileId_short: 354cfa90ec
image_file: S-450__354cfa90ec.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
With select
</> TypeScript
function UserName() {
const { data: name } = useQuery({
queryKey: [‘user’],
queryFn: fetchUser,
select: (user) => user.name,
})
return <div>{name}</div>
}
Same backend change:
</> TypeScript
{ name: ‘Alice’, email: ‘a@mail.com' }
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-451 - 15. Another useful pattern: select for IDs only

Metadata:
```text
source_id: S-451
image_use_id: IU-451
fileId_short: 118de21a71
image_file: S-451__118de21a71.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
15. Another useful pattern: select for IDs only
If full list objects change often, but IDs stay stable, you can subscribe to IDs.
</> TypeScript oO
function TodolIds() {
const { data: ids } = useQuery({
queryKey: [‘todos'],
queryFn: fetchTodos,
select: (todos) => todos.map((t) => t-.id),
})
return <div>{ids?.join(', ')}</div>
t
This can reduce rerenders if object content changes but list membership/order stays same.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-453 - Important rule

Metadata:
```text
source_id: S-453
image_use_id: IU-453
fileId_short: 69361022f8
image_file: S-453__69361022f8.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Important rule

Avoid rest destructuring:
</> TypeScript OD
const { data, ...rest } = useQuery(...)

This can defeat tracked-property optimization because it touches many fields.

Prefer:
</> TypeScript O
const query = useQuery(...)
const { data, isFetching } = query

or destructure only what you need.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-456 - If your component only cares about name , destructuring like this:

Metadata:
```text
source_id: S-456
image_use_id: IU-456
fileId_short: 8c2777d94e
image_file: S-456__8c2777d94e.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
If your component only cares about name , destructuring like this:
</> TypeScript O
const { data } = useQuery(...)
const name = data?-.name
does not automatically mean React Query can subscribe only to name .
From React Query’s point of view, your component still subscribed to data.
So if email changes, or posts changes, the data object may change, and your component can rerender.
That is where select matters.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-459 - to

Metadata:
```text
source_id: S-459
image_use_id: IU-459
fileId_short: ec416766ce
image_file: S-459__ec416766ce.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
to
‘) TypeScript O
{ name: ‘Alice’, email: ‘new@mail.com' }
Selected result is still:
‘) TypeScript OD
"Alice’
So React Query can say:
e selected value did not change
* no need to rerender this component
That is the real benefit.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-460 - 16. select + child components

Metadata:
```text
source_id: S-460
image_use_id: IU-460
fileId_short: d773e1a9ce
image_file: S-460__d773e1a9ce.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
16. select + child components
A powerful pattern is:
e parent subscribes to IDs
e children subscribe to details separately
</> TypeScript
function TodoList() {
const { data: todoIds } = useQuery({
queryKey: [‘todos'],
queryFn: fetchTodos,
select: (todos) => todos.map((t) => t-.id),
})
return (
<ul>
{todoIds?.map((id) => (
<TodoItem key={id} id={id} />
))}
</ul>
)
}
NY
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-462 - 2. Why destructuring is not enough

Metadata:
```text
source_id: S-462
image_use_id: IU-462
fileId_short: 18fbb6e056
image_file: S-462__18fbb6e056.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
2. Why destructuring is not enough
Let’s say query returns:
</> TypeScript
type User = {
id: string
name: string
email: string
notifications: number
t
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-466 - function TodoItem({ id }: { id: string }) {

Metadata:
```text
source_id: S-466
image_use_id: IU-466
fileId_short: dca612dbc2
image_file: S-466__dca612dbc2.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
function TodoItem({ id }: { id: string }) {
const { data: todo } = useQuery({
queryKey: [‘todo', id],
queryFn: () => fetchTodo(id),
})
return <1li>{todo?.text}</1li>
}
This makes updates more local.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-468 - and component does:

Metadata:
```text
source_id: S-468
image_use_id: IU-468
fileId_short: 572bca185e
image_file: S-468__572bca185e.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
and component does:
<) TypeScript OD
function UserName() {
const { data } = useQuery({
queryKey: [‘user’],
queryFn: fetchUser,
})
return <div>{data?.name}</div>
}
You might think:
“| only use name , so why rerender if email changes?”
Because React Query gave you the whole data object.
Your component is subscribed to the query result containing that data.
If the fetched data changes, React Query may deliver anew data reference, and your component
rerenders.
Even though your JSX only displays name .
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-474 - Example

Metadata:
```text
source_id: S-474
image_use_id: IU-474
fileId_short: 78182e8040
image_file: S-474__78182e8040.png
stage6a_group: R20
stage6c_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6c visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Example
Inline selector
<> TypeScript O
function UserName() {
const { data } = useQuery({
queryKey: [‘user'],
queryFn: fetchUser,
select: (user) => user.name,
})
return <div>{data}</div>
t
If UserName rerenders because its parent rerendered, this inline function is created again.
So even if cached user data is unchanged, React Query now sees a new selector reference.
That can cause the selection step to run again.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## Authoritative claim transcript: `R20-v002-performance-select-correction.md`


### S-426 - 26. Performance: structural sharing, observers, select

Metadata:
```text
source_id: S-426
image_use_id: IU-426
fileId_short: 0798cdbadb
image_file: S-426__0798cdbadb.png
stage6a_group: R19
stage6b_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
26. Performance: structural sharing, observers, select
26.1 Structural sharing
If only part of the data changes, unchanged parts can keep the same references.
Benefits:
e plays nicely with React .memo
e works better in dependency arrays
e helps prevent unnecessary rerenders
The important thing is whether the content changed, not whether every object is freshly recreated.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-431 - 26.2 Observers

Metadata:
```text
source_id: S-431
image_use_id: IU-431
fileId_short: c327c603e8
image_file: S-431__c327c603e8.png
stage6a_group: R19
stage6b_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
26.2 Observers
Observers connect the query cache to React components.
They live outside the component tree and determine when subscribed components should update.
26.3 select
Use select when a component only needs part of the data.
‘> TypeScript ‘eo
const { data } = useQuery({
queryKey: [‘user'],
queryFn: fetchUser,
select: (data) => ({ name: data-.name }),
})
This lets the component subscribe to a smaller slice.
If unrelated fields change, the component may avoid rerendering.
v
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-443 - 26.4 Memoize expensive selectors

Metadata:
```text
source_id: S-443
image_use_id: IU-443
fileId_short: 0e6acb8429
image_file: S-443__0e6acb8429.png
stage6a_group: R19
stage6b_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
26.4 Memoize expensive selectors
‘> TypeScript ‘eo
const selectName = React.useCallback((data: User) => data.name, [])
const { data: name } = useQuery({
queryKey: [‘user'],
queryFn: fetchUser,
select: selectName,
})
26.5 Tracked properties
React Query tracks which fields of the query result are actually accessed during render.
That means a component does not have to rerender just because some unused field changed.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## Authoritative claim transcript: `R20-v003-selector-purity-memoization-tail.md`


### S-477 - 14. Very important caveat: selectors should be pure

Metadata:
```text
source_id: S-477
image_use_id: IU-477
fileId_short: fa55186e8d
image_file: S-477__fa55186e8d.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
14. Very important caveat: selectors should be pure

Aselector should:

* not mutate data

* not cause side effects

© just derive a value from input data

Good:
> TypeScript oO
select: (user) => user.name

Good:
«> TypeScript ia’)
select: (todos) => todos.filter((t) => !t.done)

Dod
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-478 - Stable selector

Metadata:
```text
source_id: S-478
image_use_id: IU-478
fileId_short: 4ffdc9f2a6
image_file: S-478__4ffdc9f2a6.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Stable selector
«> ‘TypeScript ia’)
const selectUserName = (user: User) => user.name
function UserName() {
const { data } = useQuery({
queryKey: ['user'],
queryFn: fetchUser,
select: selectUserName,
vn
return <div>{data}</div>
+
Now the selector reference stays the same, so if the cached data is also the same, React Query has less
reason to recompute selection just because of component rerender.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-481 - Bad:

Metadata:
```text
source_id: S-481
image_use_id: IU-481
fileId_short: 206b5fe9bc
image_file: S-481__206b5fe9bc.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Bad:
«> TypeScript oO
select: (todos) => {
todos-push({ id: 'x', text: "bad" })
return todos
t
Bad:
> ‘TypeScript oO
select: (data) => {
console. log(‘sending analytics’) // side effect
return data
t
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-483 - What “nothing happened” really means

Metadata:
```text
source_id: S-483
image_use_id: IU-483
fileId_short: b4fb47dabb
image_file: S-483__b4fb47dabb.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
What “nothing happened” really means
This part matters:
If by “nothing happened” you mean:
* no new fetch
* no cache update
* no query status change
* only parent rerender or some other unrelated local rerender
then yes, an inline (select) can still be rerun because React Query sees a new select function reference.
So the recomputation is not because data changed.
It is because the selection definition changed by reference.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-487 - Yes — when you pass an inline arrow function, that is usually a new function reference on every render.

Metadata:
```text
source_id: S-487
image_use_id: IU-487
fileId_short: 22b0387b6b
image_file: S-487__22b0387b6b.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Yes — when you pass an inline arrow function, that is usually a new function reference on every render.

So these two are different in practice:

Inline arrow
«> TypeScript ia’)
select: (data) => expensive(data)

This creates a new selector function each render.

Stable function reference
> TypeScript ia’)
select: expensive

This passes the same function reference, as long as (expensive) itself is stable.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-491 - 1. Can | access data if | pass just a function?

Metadata:
```text
source_id: S-491
image_use_id: IU-491
fileId_short: d39fb9c20b
image_file: S-491__d39fb9c20b.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
1. Can | access data if | pass just a function?
Yes.
Because (Select) expects a function that React Query will call with the query data.
So this:
«> ‘TypeScript
function selectUserName(user: User) {
return user.name
}
useQuery({
queryKey: ['user'],
queryFn: fetchUser,
select: selectUserName,
»
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-494 - works exactly like this:

Metadata:
```text
source_id: S-494
image_use_id: IU-494
fileId_short: 9b8b4fe78d
image_file: S-494__9b8b4fe78d.png
stage6a_group: R21
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
works exactly like this:
«> ‘TypeScript
useQuery({
queryKey: [user],
queryFn: fetchUser,
select: (user) => username,
vn
React Query does the call for you.
So:
* you do not call it yourself
* React Query calls it with the fetched data
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-508 - 41. Selector purity

Metadata:
```text
source_id: S-508
image_use_id: IU-508
fileId_short: a8033950fd
image_file: S-508__a8033950fd.png
stage6a_group: R23
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
41. Selector purity
* pure transforms only
* no mutation
* no side effects
* same input — same output
* deterministic derived data
42. Selector stability
* inline selector = new function reference per render
* stable external selector
* memoized selector with |useCallback
* function identity vs result memoization
43. Result memoization vs selector memoization
© (useCallback memoizes function reference
© (useMemo memoizes derived result
* expensive selector work vs stable selector identity
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-531 - 38. Observers

Metadata:
```text
source_id: S-531
image_use_id: IU-531
fileId_short: 7952ebff78
image_file: S-531__7952ebff78.png
stage6a_group: R23
stage6d_region: R20
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
38. Observers
* glue between query cache and React components
* outside component tree
* determine update propagation
39. select
* subscribe to smaller slice of data
* transform query data before component receives it
* reduce rerenders from unrelated data changes
* pure selectors only
stable selector references
* external selector functions
* useCallback for selectors depending on props/state
40. Tracked properties
* React Query tracks which result fields were read
* rerender only when used fields change
* avoid rest destructuring
«  destructure only what you need
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## What should be recallable

- How observers, tracked properties, structural sharing, and select affect rerenders.
- Why selectors should be pure and when stable references or memoization matter.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R20-select-tracked-props-performance.md`, source-transcript section
- Authoritative processed source: `regions/R20-v002-performance-select-correction.md`, source-transcript section
- Authoritative processed source: `regions/R20-v003-selector-purity-memoization-tail.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
