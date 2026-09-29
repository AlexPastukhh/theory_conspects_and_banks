# Conditional React Query execution and UI

Knowledge ID: `react-query.conditional-query-execution-and-ui`

Topic: `react-query`

The source IDs are retained so each migrated claim remains traceable. When a later correction transcript is included, it is authoritative over conflicting earlier wording.

## Authoritative claim transcript: `R02B-enabled-disabled-conditional-ui.md`


### R02B-S001 / S-026 - `29e9da2f37`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-disabled-query-state-explanation`
- readability: `high`
- cut off: `top-continuation-from-r02a-status-visible`
- confidence: `high`
- theme: Disabled query can be pending but not loading

#### Verified visible text
```text
So it is only `true` when the query is in its first actual fetch.

That makes the three flags:

- `isPending`: there is no resolved result yet
- `isFetching`: a fetch is currently running
- `isLoading`: the query is doing its initial fetch right now

So your combination:

- `isPending === true`
- `isLoading === false`
- `fetchStatus === 'idle'`

means:

the query has no data yet, but it is not currently fetching.

That usually happens when the query is waiting to be allowed to run, not actively loading.
```

#### Notes
Top continuation ties to R02A status explanation; the enabled/disabled meaning is visible and belongs in R02B.

---

### R02B-S002 / S-027 - `048f7ed433`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-hooks-not-conditional-wrong`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Wrong conditional hook call

#### Verified visible text
```text
12. Conditional queries with `enabled`

Hooks must not be called conditionally.

Wrong
```

#### Verified visible code
```tsx
function useIssues(search: string) {
  if (search) {
    return useQuery({
      queryKey: ['issues', search],
      queryFn: () => fetchIssues(search),
    })
  }
}
```

#### Notes
Verified from extracted SVG image.

---

### R02B-S003 / S-032 - `d812eda414`

Metadata:
- status: `verified-visible-partial-from-extracted-svg-image`
- candidate_type: `r02b-enabled-basic-example`
- readability: `high`
- cut off: `top-and-bottom-continuation-cropped`
- confidence: `high-for-visible-code`
- theme: Most common enabled example with missing id

#### Verified visible text
```text
Most common cases:
```

#### Verified visible code
```tsx
const query = useQuery({
  queryKey: ['user', id],
  queryFn: fetchUser,
  enabled: !!id,
})
```

#### Notes
Top continuation from S-026 and bottom continuation are cropped; visible code is clear.

---

### R02B-S004 / S-033 - `796e9f55f7`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-hooks-not-conditional-correct`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Correct enabled query pattern

#### Verified visible text
```text
Correct
```

#### Verified visible code
```tsx
function useIssues(search: string) {
  return useQuery({
    queryKey: ['issues', search],
    queryFn: () => fetchIssues(search),
    enabled: search !== '',
  })
}
```

#### Notes
Verified from extracted SVG image.

---

### R02B-S005 / S-037 - `202c0dd895`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-missing-id-disabled-state`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Disabled query state when id is missing

#### Verified visible text
```text
If `id` is missing:

- `status: 'pending'`
- `isPending: true`
- `fetchStatus: 'idle'`
- `isFetching: false`
- `isLoading: false`

Why? Because React Query is saying:

“I don’t have data yet, but I’m also not fetching, because this query is disabled for now.”
```

#### Notes
Verified from extracted SVG image.

---

### R02B-S006 / S-042 - `0035fc7737`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-ui-why-disabled-query-state-matters`
- readability: `high`
- cut off: `right-edge-card-crop-no-text-loss`
- confidence: `high`
- theme: Why disabled query state matters in UI

#### Verified visible text
```text
Why this matters in UI

If you do this:

then when `search` is empty:

- query is disabled
- `isLoading` is false
- so spinner does not show

That is good, because there is nothing to load yet.
```

#### Verified visible code
```tsx
const query = useQuery({
  queryKey: ['issues', search],
  queryFn: fetchIssues,
  enabled: !!search,
})

if (query.isLoading) return <Spinner />
```

#### Notes
Right edge/card border crop visible; text and code are readable.

---

### R02B-S007 / S-047 - `441233c7df`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-separate-ui-for-no-input`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Render no-input UI instead of mounting disabled query

#### Verified visible text
```text
What the second screenshot means

They are saying: for “no input yet”, don’t treat it like a loading state.

Example:
```

#### Verified visible code
```tsx
function IssueSearch() {
  const [search, setSearch] = React.useState('')

  return (
    <div>
      <input value={search} onChange={(e) => setSearch(e.target.value)} />

      {search ? (
        <IssueList search={search} />
      ) : (
        <div>Please enter a search term</div>
      )}
    </div>
  )
}
```

#### Notes
Verified from extracted SVG image.

---

### R02B-S008 / S-056 - `7e756912a0`

Metadata:
- status: `verified-from-extracted-svg-image`
- candidate_type: `r02b-why-separate-ui-better`
- readability: `high`
- cut off: `no`
- confidence: `high`
- theme: Why no-input UI is better than interpreting disabled query state

#### Verified visible text
```text
Why this is better

When `search` is empty, there is no real query to run yet.

So instead of:

- mounting a disabled query
- then trying to interpret its odd state

you just render a separate UI:

- no search term → show “Please enter a search term”
- search term exists → render component that uses the query

This is simpler because “no user input yet” is a UI state, not a server-loading state.
```

#### Notes
Verified from extracted SVG image.

---

## What should be recallable

- What enabled and disabled queries do.
- How conditional execution differs from conditional rendering.

## Related knowledge

- `react-query.cache-observers-and-auth-refresh`

## Sources

- Workspace: `_ai-conspects/react query,rquery/`
- Authoritative processed source: `regions/R02B-enabled-disabled-conditional-ui.md`, source-transcript section
- Original source identity: `full.svg` (named by the canvas-wide map; not physically present in the current workspace/branch).
