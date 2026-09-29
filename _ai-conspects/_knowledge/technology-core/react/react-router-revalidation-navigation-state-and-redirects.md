# React Router revalidation, navigation state, and redirects

Knowledge ID: `react.react-router-revalidation-navigation-state-and-redirects`

Topic: `react`

## Automatic loader revalidation

Loaders run:

```text
on initial matching navigation
when route matches or relevant params change
after actions, so mutation results can be reflected
when explicitly revalidated
on other router-defined revalidation triggers
```

After a successful action, React Router commonly re-runs loaders for current matches:

```text
submit mutation
action completes
relevant loaders run again
useLoaderData receives fresh values
```

This is route-data revalidation, not a general-purpose query cache like TanStack Query.

## Global navigation state

`useNavigation()` exposes what the router is doing globally:

```jsx
const navigation = useNavigation();
```

Important state values:

```text
idle
submitting
loading
```

Useful fields include:

```text
navigation.location
navigation.formMethod
navigation.formAction
navigation.formData
```

Example:

```jsx
const navigation = useNavigation();
const busy = navigation.state !== "idle";

return (
  <button disabled={busy}>
    {navigation.state === "submitting"
      ? "Saving..."
      : "Save"}
  </button>
);
```

Global navigation state is appropriate for:

```text
application-level progress bars
disabling navigation during a mutation
page-level loading indicators
global save state
```

A fetcher has its own local state and usually does not make `useNavigation().state` become `submitting`.

## `shouldRevalidate`

`shouldRevalidate` controls whether a specific route loader should run again.

```jsx
{
  path: "/app",
  loader: appLayoutLoader,
  shouldRevalidate(args) {
    const isProfilePost =
      args.formMethod?.toLowerCase() === "post"
      && args.formAction === "/app/profile";

    if (isProfilePost) {
      return false;
    }

    return args.defaultShouldRevalidate;
  },
}
```

Use it when:

```text
a child action should not refresh an expensive parent loader
search-param changes do not affect a loader
an action result proves data is already current
a route has domain-specific revalidation rules
```

Default to normal revalidation when uncertain. Overusing `shouldRevalidate` can leave stale route data.

## `useRevalidator()`

`useRevalidator()` manually re-runs loaders for current matches:

```jsx
const revalidator = useRevalidator();

<button
  onClick={() => revalidator.revalidate()}
  disabled={revalidator.state === "loading"}
>
  Refresh
</button>
```

Use it for:

```text
manual refresh button
external event such as WebSocket notification
refresh after a non-router mutation
```

It refreshes route data for current matches; it does not load an arbitrary resource. For a specific route/resource without navigation, use a fetcher.

## Redirects

Inside a loader or action:

```jsx
import { redirect } from "react-router-dom";

export async function action({ request }) {
  const result = await save(request);

  if (!result.ok) {
    throw new Response("Save failed", {
      status: result.status,
    });
  }

  return redirect("/app");
}
```

Redirects are router-native because they can:

```text
cancel current rendering
change location
participate in history behavior
stay consistent with route loading and revalidation
```

Inside components, use `useNavigate()` or `<Navigate />`.

Protected-route example:

```jsx
export async function protectedLoader() {
  const user = await getUser();

  if (!user) {
    return redirect("/login");
  }

  return user;
}
```

## What should be recallable

- Which events re-run matched loaders?
- What do idle, submitting, and loading mean in global navigation state?
- When should revalidation be suppressed or triggered manually?
- Why are loader/action redirects different from component navigation?

## Related knowledge

- `react.react-router-loaders-actions-and-testing`
- `react.react-router-fetchers-and-local-mutations`

## Sources

- Workspace: `_ai-conspects/react router/`
- Authoritative processed source: `regions/R01R02R03R04-react-router-final-v001.md`
- Original SVG: `source/react router.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
