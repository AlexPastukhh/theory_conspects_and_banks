# React Query defaults, key factories, and option factories

Knowledge ID: `react-query.query-defaults-key-and-option-factories`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R18-query-defaults-key-factories.md`


### S-385 - 24. Query defaults

Metadata:
```text
source_id: S-385
image_use_id: IU-385
fileId_short: 5fc37cd9db
image_file: S-385__5fc37cd9db.png
stage6a_group: R18
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
24. Query defaults
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-387 - 24.1 Global defaults

Metadata:
```text
source_id: S-387
image_use_id: IU-387
fileId_short: d878621922
image_file: S-387__d878621922.png
stage6a_group: R18
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
24.1 Global defaults
‘> TypeScript oO
const queryClient = new QueryClient({
defaultOptions: {
queries: {
staleTime: 10 * 1000,
retry: 2,
ts
ts
})
24.2 Defaults for a subset of keys
‘> TypeScript oO
queryClient.setQueryDefaults(['todos', ‘detail'], {
staleTime: 10 * 1000,
})
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-391 - 24.3 Per-query override

Metadata:
```text
source_id: S-391
image_use_id: IU-391
fileId_short: 8c70db8566
image_file: S-391__8c70db8566.png
stage6a_group: R18
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
24.3 Per-query override
‘> TypeScript ‘eo
useQuery({
queryKey: [‘todos', ‘detail’, id],
queryFn: () => fetchTodo(id),
staleTime: 60 * 1000,
})
Any option except queryKey itself can effectively be centralized and reused.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-397 - 25. Query key factories

Metadata:
```text
source_id: S-397
image_use_id: IU-397
fileId_short: 155177db8b
image_file: S-397__155177db8b.png
stage6a_group: R18
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
25. Query key factories
This is one of the best structural patterns.
‘> TypeScript c
export const todoKeys = {
all: () => [‘todos'] as const,
allLists: () => [-..todoKeys.all(), ‘list'] as const,
list: (sort: string) => [...todoKeys.allLists(), { sort }] as const,
detail: (id: string) => [...todoKeys.all(), ‘detail’, id] as const,
; v
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-400 - Use them everywhere:

Metadata:
```text
source_id: S-400
image_use_id: IU-400
fileId_short: 78143a8e93
image_file: S-400__78143a8e93.png
stage6a_group: R18
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Use them everywhere:
</> TypeScript
useQuery({
queryKey: todoKeys.list(sort),
queryFn: () => fetchTodos(sort),
})
‘> TypeScript
queryClient . invalidateQueries({
queryKey: todoKeys-.allLists(),
})
Principle
Create one factory per feature.
Keep all keys in that feature under the same prefix.
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-406 - 25.1 Query option factories

Metadata:
```text
source_id: S-406
image_use_id: IU-406
fileId_short: 246e85f82c
image_file: S-406__246e85f82c.png
stage6a_group: R19
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
25.1 Query option factories
You can go further and return full option objects.
‘> TypeScript ‘eo
const todoQueries = {
list: (sort: string) => ({
queryKey: todoKeys.list(sort),
queryFn: () => fetchTodos(sort),
staleTime: 5000,
3),
detail: (id: string) => ({
queryKey: todoKeys.detail(id),
queryFn: () => fetchTodo(id),
staleTime: 5000,
3),
}
llceana-
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

### S-415 - Usage:

Metadata:
```text
source_id: S-415
image_use_id: IU-415
fileId_short: 7f54e43053
image_file: S-415__7f54e43053.png
stage6a_group: R19
stage6b_region: R18
status: verified-visible-ocr-assisted
transcript_method: Stage6b visible read from source image; OCR-assisted
```

#### Verified visible text
```text
Usage:
‘> TypeScript ‘eo
useQuery(todoQueries.list('‘date'))
Or with overrides:
‘> TypeScript oO
useQuery({
...todoQueries.list('‘date'),
refetchInterval: 10 900,
})
```

#### Notes

Visible text present; OCR-assisted read, not an OCR-timeout/error placeholder.

---

## What should be recallable

- How global defaults and per-query overrides compose.
- How key and option factories centralize query identity and configuration.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R18-query-defaults-key-factories.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
