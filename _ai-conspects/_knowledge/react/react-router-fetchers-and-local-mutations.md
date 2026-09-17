# React Router fetchers and local mutations

Knowledge ID: `react.react-router-fetchers-and-local-mutations`

Topic: `react`

## What a fetcher is

`useFetcher()` performs data-router work without navigating:

```jsx
const fetcher = useFetcher();
```

It can:

```text
submit to an action
load a route loader
expose local state and returned data
participate in revalidation
keep the current URL unchanged
```

Fetcher state:

```text
idle
submitting
loading
```

Each fetcher instance has isolated state, which makes it suitable for multiple rows, cards, dialogs or inline mutations.

## `fetcher.Form`

```jsx
const fetcher = useFetcher();

<fetcher.Form
  method="post"
  action="/projects/star"
>
  <input
    type="hidden"
    name="projectId"
    value={project.id}
  />

  <button disabled={fetcher.state !== "idle"}>
    {fetcher.state === "submitting"
      ? "Saving..."
      : "Star"}
  </button>
</fetcher.Form>
```

The URL does not change. The matching action runs, fetcher state updates, and relevant loaders can revalidate.

Use it for:

```text
inline edits
favorite/star toggles
row deletion
autosave
modal form
operations that should not navigate
```

## Imperative `fetcher.submit()`

```jsx
const fetcher = useFetcher();

function star(projectId) {
  const formData = new FormData();
  formData.set("projectId", projectId);

  fetcher.submit(formData, {
    method: "post",
    action: "/projects/star",
  });
}
```

Use imperative submission when:

```text
there is no visible form
the payload is computed
submission starts from a button or custom interaction
```

`fetcher.Form` is preferable when real form semantics are appropriate.

## `fetcher.load()`

`fetcher.load(href)` runs the loader for a matching route without navigation:

```jsx
const fetcher = useFetcher();

fetcher.load(`/api/search?q=${query}`);
```

Constraints:

```text
the href must match a route
that route must have a loader
the loader receives a normal request for that URL
```

It is not a generic replacement for `fetch()`; it invokes route-loader infrastructure.

## Fetcher versus navigation

```text
<Form>
    submission belongs to navigation
    global useNavigation state changes
    commonly changes URL or redirects
    suited to page-level workflows

fetcher.Form
    no navigation by default
    local fetcher state changes
    suited to component-level work
```

Fetcher mutations may still revalidate loaders. A redirect returned by the action can still navigate.

## What should be recallable

- How does a fetcher perform loader/action work without changing the URL?
- When should code use fetcher.Form, fetcher.submit, or fetcher.load?
- How do local fetcher state, global navigation state, revalidation, and redirects interact?

## Related knowledge

- `react.react-router-revalidation-navigation-state-and-redirects`
- `react.react-router-forms-react-hook-form-and-history`

## Sources

- Workspace: `_ai-conspects/react router/`
- Authoritative processed source: `regions/R01R02R03R04-react-router-final-v001.md`
- Original SVG: `source/react router.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
