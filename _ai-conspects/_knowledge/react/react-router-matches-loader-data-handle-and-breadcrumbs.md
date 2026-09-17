# React Router matches, shared loader data, handle, and breadcrumbs

Knowledge ID: `react.react-router-matches-loader-data-handle-and-breadcrumbs`

Topic: `react`

## `useRouteLoaderData()`

A descendant can read loader data from another matched route by route id:

```jsx
const appData =
  useRouteLoaderData("app");
```

The route must have an explicit or generated id:

```jsx
{
  id: "app",
  path: "/app",
  element: <AppLayout />,
  loader: appLoader,
}
```

Use it when a parent loader owns shared data such as:

```text
current user
permissions
notifications
application configuration
```

This avoids refetching the same data in every child.

## `useMatches()`

`useMatches()` returns the chain of currently matched routes.

Each match can expose:

```text
id
pathname
params
data
handle
```

Use it for:

```text
breadcrumbs
permission checks
shared layout metadata
page titles
analytics
route-aware navigation UI
```

## `handle`

`handle` stores arbitrary static route metadata:

```jsx
{
  id: "users",
  path: "users",
  element: <UsersLayout />,
  loader: usersLoader,
  handle: {
    crumb: () => "Users",
    roles: ["admin"],
  },
}
```

React Router does not interpret `handle`; application code decides what it means.

Good use cases:

```text
breadcrumb label or builder
page title
layout/header configuration
roles and permissions
feature flags
analytics metadata
sidebar visibility
menu grouping
```

`loader` answers “what data is needed to render?”
`handle` answers “how should the application describe or treat this route?”

## Breadcrumbs

Breadcrumbs are a navigation trail such as:

```text
Home / Users / Alice
```

A common pattern combines:

```text
static metadata from match.handle
dynamic values from match.data
target URL from match.pathname
```

Example:

```jsx
function Breadcrumbs() {
  const matches = useMatches();

  const crumbs = matches
    .filter((match) => match.handle?.crumb)
    .map((match) => {
      const label =
        typeof match.handle.crumb === "function"
          ? match.handle.crumb(match.data)
          : match.handle.crumb;

      return {
        label,
        to: match.pathname,
      };
    });

  return (
    <nav>
      {crumbs.map((crumb) => (
        <Link key={crumb.to} to={crumb.to}>
          {crumb.label}
        </Link>
      ))}
    </nav>
  );
}
```

Keep static metadata out of loaders when no network or computation is required.

## What should be recallable

- How can descendants read a matched parent route's loader data?
- Which values are exposed by useMatches?
- What belongs in static handle metadata rather than a loader?
- How do match data, handles, and pathnames compose breadcrumbs?

## Related knowledge

- `react.react-router-route-tree-and-navigation`
- `react.react-router-loaders-actions-and-testing`

## Sources

- Workspace: `_ai-conspects/react router/`
- Authoritative processed source: `regions/R01R02R03R04-react-router-final-v001.md`
- Original SVG: `source/react router.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
