# Testing React Query with QueryClient and MSW

Knowledge ID: `react-query.testing-with-queryclient-and-msw`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R19-testing-msw.md`


### S-430 - 36. Testing

Metadata:
```text
source_id: S-430
image_use_id: IU-430
fileId_short: 05b7498309
image_file: S-430__05b7498309.png
stage6a_group: R19
stage6b_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
36. Testing
36.1 Fresh client per test
Do not share one client across all tests unless you reset it carefully.
‘> TypeScript ‘eo
import { QueryClient, QueryClientProvider } from ‘@tanstack/react-query'
import { render } from ‘@testing-library/react'
function createTestQueryClient() {
return new QueryClient({
defaultOptions: {
queries: {
retry: false,
ts
ts
3) NY
}
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-441 - function renderWithClient(ui: React.ReactElement) {

Metadata:
```text
source_id: S-441
image_use_id: IU-441
fileId_short: d086ba0a5e
image_file: S-441__d086ba0a5e.png
stage6a_group: R19
stage6b_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
function renderWithClient(ui: React.ReactElement) {
const testClient = createTestQueryClient()
return render(
<QueryClientProvider client={testClient}>{ui}</QueryClientProvider>
)
}
Retries are usually disabled in tests.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-445 - 36.2 Mock the network layer, not useQuery

Metadata:
```text
source_id: S-445
image_use_id: IU-445
fileId_short: a3a53e14ef
image_file: S-445__a3a53e14ef.png
stage6a_group: R19
stage6b_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
36.2 Mock the network layer, not useQuery
Preferred:
e MSW
e mocked API module / query function
e seeded cache
Avoid mocking useQuery directly because it is brittle and easy to fake incorrectly.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## Authoritative claim transcript: `R19-v002-testing-msw-cache-seeding.md`


### S-448 - 2. What is MSW

Metadata:
```text
source_id: S-448
image_use_id: IU-448
fileId_short: 97fc0cac7a
image_file: S-448__97fc0cac7a.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
2. What is MSW
MSW means Mock Service Worker.
Itis a tool for mocking HTTP/network requests in tests and development.
Instead of mocking your query hook directly, you let the component make a real fetch call, but MSW
intercepts it and returns fake data.
So from the component's point of view:
© it really called | /api/todos
* it really got a response
* React Query behaves normally
But no real backend is used.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-452 - 36.3 MSW example

Metadata:
```text
source_id: S-452
image_use_id: IU-452
fileId_short: c0d79a464d
image_file: S-452__c0d79a464d.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
36.3 MSW example
«> TypeScript ia’)
import { http, HttpResponse } from 'msw'
import { setupServer } from ‘msw/node*
const server = setupServer(
http.get(‘/api/posts', () > {
return HttpResponse.json([{ id: '1', title: ‘Hello’ }])
vn
)
beforeAll(() => server. listen())
afterEach(() => server.resetHandlers())
afterAll(() => server.close())
Override per test:
«> TypeScript ia’)
server.use(
http.get(‘/api/posts', () > {
return new HttpResponse(null, { status: 500 })
vn
) Vv
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-455 - Why MSW is so useful

Metadata:
```text
source_id: S-455
image_use_id: IU-455
fileId_short: 9f0168a4d5
image_file: S-455__9f0168a4d5.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Why MSW is so useful
Because it tests the app closer to how it really works.
Your actual flow remains:

* component renders

© (useQuery runs

© queryFn runs

* fetch request happens

* response arrives

* cache updates

© loading/success/error states happen naturally
That is much better than faking the hook result manually.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-461 - 36.4 Seed cache in tests

Metadata:
```text
source_id: S-461
image_use_id: IU-461
fileId_short: 43d3cbe592
image_file: S-461__43d3cbe592.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
36.4 Seed cache in tests
Useful for specific state setups.
«> TypeScript ia’)
const client = createTestQueryClient()
client .setQueryData(['posts'], [{ id: '1', title: 'Prefilled' }])
Good for controlled scenarios, but if you constantly need huge cache seeding, your abstraction may need
deanup.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-463 - 2. Do you need to install it?

Metadata:
```text
source_id: S-463
image_use_id: IU-463
fileId_short: 90c5d6a45a
image_file: S-463__90c5d6a45a.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
2. Do you need to install it?
Yes.
Usually:

«” Bash

npm install -D msw
or

«” Bash

yarn add -D msw
or

«” Bash

pnpm add -D msw
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-467 - 36.5 Testing mutations

Metadata:
```text
source_id: S-467
image_use_id: IU-467
fileId_short: 3eb24d26dd
image_file: S-467__3eb24d26dd.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
36.5 Testing mutations
Same principles as queries:
* render with real query client
* mock network
* trigger Ul action
© assert final Ul/cache behavior
If a mutation invalidates and refetches, make sure your mocked server returns the updated state.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-470 - Step 1: your real query function exists

Metadata:
```text
source_id: S-470
image_use_id: IU-470
fileId_short: 17b1958ff6
image_file: S-470__17b1958ff6.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 1: your real query function exists
Example:
«” TypeScript
export async function fetchTodos() {
const response = await fetch('/api/todos')
if (!response.ok) {
throw new Error('Failed to fetch todos')
t
return response.json()
+
This is real application code.
No mocking inside it.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-473 - Step 2: your component uses useQuery

Metadata:
```text
source_id: S-473
image_use_id: IU-473
fileId_short: 7af4c6f67b
image_file: S-473__7af4c6f67b.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 2: your component uses useQuery
«> TypeScript
import { useQuery } from '@tanstack/react-query’
import { fetchTodos } from './api'
export function Todos() {
const { data, isPending, isError } = useQuery({
querykey: ['todos'],
queryFn: fetchTodos,
vn
if (isPending) return <div>Loading. ..</div>
if (isError) return <div>Error loading todos</div>
return (
<ul>
{data.map((todo: any) => (
<li key={todo.id}>{todo.text}</li>
)t
</ul>
)
+
Still real application code.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-476 - Step 3: create MSW handlers

Metadata:
```text
source_id: S-476
image_use_id: IU-476
fileId_short: 26768fa11d
image_file: S-476__26768fa11d.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 3: create MSW handlers
Handlers describe fake API responses.
Example file: mocks/handlers.ts
«” TypeScript
import { http, HttpResponse } from 'msw'
export const handlers = [
http.get(‘/api/todos', () => {
return HttpResponse.json([
{ id: 1, text: ‘Buy milk’ },
{ id: 2, text: ‘Read book" },
1D)
n,
1
This says:
* if code makes |GET /api/todos
* MSW should return this fake JSON
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-480 - Step 4: create MSW server for tests

Metadata:
```text
source_id: S-480
image_use_id: IU-480
fileId_short: 57ccecac25
image_file: S-480__57ccecac25.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 4: create MSW server for tests
Example file: (mocks/sepver lis

«> TypeScript

import { setupServer } from 'msw/node'

import { handlers } from './handlers'

export const server = setupServer(..-handlers)
This creates the test server that will intercept requests.
Step 5: connect MSW to test lifecycle
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-484 - In your test setup file, for example |setupTests.ts or |vitest_setup_ts :

Metadata:
```text
source_id: S-484
image_use_id: IU-484
fileId_short: 9908e75ea8
image_file: S-484__9908e75ea8.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
In your test setup file, for example |setupTests.ts or |vitest_setup_ts :
” TypeScript
import { beforeAll, afterAll, afterEach } from 'vitest'
import { server } from './mocks/server'
beforeAll(() => server. listen())
afterEach(() => server.resetHandlers())
afterAll(() => server.close())
What this means:
beforeAll(() => server.listen())
Start intercepting requests before tests run.
afterEach(() => server.resetHandlers())
After each test, restore handlers to default state.
This prevents one test’s custom override from leaking into another.
afterall(() => server.close())
Stop interception after all tests finish.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-488 - Step 6: create a test QueryClient

Metadata:
```text
source_id: S-488
image_use_id: IU-488
fileId_short: 4c176eaa61
image_file: S-488__4c176eaa61.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 6: create a test QueryClient
Because React Query needs a provider.
«> TypeScript
import { QueryClient } from '@tanstack/react-query'
export function createTestQueryClient() {
return new QueryClient({
defaultOptions: {
queries: {
retry: false,
Lb
Lb
vn
+
Retries are often disabled in tests to make them faster and more predictable.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-492 - Step 7: create render helper

Metadata:
```text
source_id: S-492
image_use_id: IU-492
fileId_short: 9e681381b1
image_file: S-492__9e681381b1.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 7: create render helper
«> TypeScript
import { QueryClientProvider } from '@tanstack/react-query'
import { render } from '@testing-library/react'
import { createTestQueryClient } from './testQueryClient'
export function renderWithClient(ui: React.ReactElement) {
const queryClient = createTestQueryClient()
return render(
<QueryClientProvider client={queryClient}>
{ui}
</QueryClientProvider>
)
+
This gives every test a fresh QueryClient.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-495 - Step 8: write the actual test

Metadata:
```text
source_id: S-495
image_use_id: IU-495
fileId_short: 49f8026ec0
image_file: S-495__49f8026ec0.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Step 8: write the actual test

«> TypeScript

import { screen } from '@testing-library/react'

import { Todos } from './Todos'

import { renderWithClient } from './test-utils'

test(‘renders todos from API', async () => {
renderWithClient(<Todos />)
expect (screen.getByText( ‘Loading. ..')).toBeInTheDocument()
expect(await screen. findByText('Buy milk'))-toBeInTheDocument()
expect(await screen. findByText('Read book" )).toBeInTheDocument()

vn
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-497 - 5. Why this is better than mocking useQuery

Metadata:
```text
source_id: S-497
image_use_id: IU-497
fileId_short: 541ce1e192
image_file: S-497__541ce1e192.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
5. Why this is better than mocking useQuery
Because the whole real chain is preserved:
* component render
* useQuery
© query function
*° fetch
© response parsing
* loading state
* success/error state
* rerender
Only the network layer is fake.
That is much more realistic.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-500 - 6. How to test an error case

Metadata:
```text
source_id: S-500
image_use_id: IU-500
fileId_short: f5131ef58a
image_file: S-500__f5131ef58a.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
6. How to test an error case
You can override handlers in a single test.
> TypeScript oO
import { http, HttpResponse } from ‘msw’
import { server } from './mocks/server"
test(‘shows error when API fails', async () => {
server.use(
http.get('/api/todos', () => {
return new HttpResponse(null, { status: 500 })
D)
)
renderwithClient(<Todos />)
expect(await screen.findByText(‘Error loading todos')).toBeInTheDocument()
»
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-502 - Flow:

Metadata:
```text
source_id: S-502
image_use_id: IU-502
fileId_short: 33dba8ec9f
image_file: S-502__33dba8ec9f.png
stage6a_group: R21
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Flow:
default handler is temporarily replaced for this test
request now gets 500
© | fetchTodos throws
React Query goes to error state
© component shows error UI
After test ends:
« TypeScript
afterEach(() => server.resetHandlers())
restores defaults.
v
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-512 - 7. How to test loading state more clearly

Metadata:
```text
source_id: S-512
image_use_id: IU-512
fileId_short: 38e6e187bc
image_file: S-512__38e6e187bc.png
stage6a_group: R23
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
7. How to test loading state more clearly
You can add delay.
«> TypeScript
server .use(
http.get('/api/todos', async () => {
await new Promise((resolve) => setTimeout(resolve, 300))
return HttpResponse.json([{ id: 1, text: ‘Delayed todo’ }])
>)
)
Now loading UI stays visible long enough to assert more clearly.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-513 - 69. Testing basics

Metadata:
```text
source_id: S-513
image_use_id: IU-513
fileId_short: a01d3c2b86
image_file: S-513__a01d3c2b86.png
stage6a_group: R23
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
69. Testing basics
* fresh QueryClient per test
do not reuse query cache across tests
© disable retries in tests
* isolate query state
70. Test render utilities
*  createTestQueryClient
© renderWithClient
* wrap with QueryClientProvider
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-516 - 8. Browser mode vs test mode

Metadata:
```text
source_id: S-516
image_use_id: IU-516
fileId_short: 2ceec70ba6
image_file: S-516__2ceec70ba6.png
stage6a_group: R23
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
8. Browser mode vs test mode
This is important.
In tests
You usually use:

«” TypeScript

import { setupServer } from 'msw/node'
This is Node test interception.
No browser Service Worker registration needed.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-524 - 71. MSW

Metadata:
```text
source_id: S-524
image_use_id: IU-524
fileId_short: 38a80c8868
image_file: S-524__38a80c8868.png
stage6a_group: R23
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
71. MSW
* network-layer mocking
* request interception
* handlers
*  setupServer
* success/error/loading simulation
+ keeps real React Query behavior
72. MSW test lifecycle
© server. listen()
*  server.resetHandlers()
«| server.close()
* override handlers per test
73. What to mock
* best: network layer with MSW
* okay: mock API/query function
* avoid: mocking useQuery
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-535 - 74. Why avoid mocking useQuery

Metadata:
```text
source_id: S-535
image_use_id: IU-535
fileId_short: 41a015d3af
image_file: S-535__41a015d3af.png
stage6a_group: R23
stage6d_region: R19
status: verified-visible-ocr-assisted
transcript_method: Stage6d visible read from source image; OCR-assisted
```

#### Verified visible text
```text
74. Why avoid mocking useQuery
«bypasses real query lifecycle
* bypasses cache behavior
* brittle fake hook objects
*  implementation-coupled tests
75. Seeding cache in tests
* setQueryData before render
* test cached states
* test stale/prefetched states
* useful but can signal over-coupling if overused
76. Testing mutations
* real interaction
* mock network
* invalidation/refetch-aware assertions
* fresh client per test L
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## What should be recallable

- How to isolate a QueryClient per test and configure deterministic retries.
- Why network-level MSW handlers are preferred to mocking useQuery, and when cache seeding helps.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R19-testing-msw.md`, source-transcript section
- Authoritative processed source: `regions/R19-v002-testing-msw-cache-seeding.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
