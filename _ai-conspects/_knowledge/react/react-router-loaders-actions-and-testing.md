# React Router loaders, actions, and router-aware testing

Knowledge ID: `react.react-router-loaders-actions-and-testing`

Topic: `react`

## Loaders

A loader is attached to a route and runs before that route renders:

```jsx
export async function userLoader({
  params,
  request,
}) {
  const response = await fetch(
    `/api/users/${params.userId}`,
    { signal: request.signal },
  );

  if (!response.ok) {
    throw new Response("User not found", {
      status: response.status,
    });
  }

  return response.json();
}
```

Route:

```jsx
{
  path: "users/:userId",
  element: <UserPage />,
  loader: userLoader,
}
```

Component:

```jsx
function UserPage() {
  const user = useLoaderData();
  return <h1>{user.name}</h1>;
}
```

Loader arguments include:

```text
params
request
context, when configured by the router/framework
```

The loader `request` is a Fetch API `Request`. It provides:

```text
request.url
request.method
request.headers
request.signal
```

Read query parameters through `request.url`:

```jsx
const url = new URL(request.url);
const page = url.searchParams.get("page") ?? "1";
```

## Loader versus `useEffect`

Both can fetch data, but their lifecycle differs.

```text
loader
    route-driven and centralized
    runs before route rendering
    participates in navigation state
    receives params/request/signal
    integrates with errors and revalidation

useEffect
    component-driven
    runs after render
    useful for client-only effects, subscriptions and non-route work
```

Prefer a loader for data required to render a route. Prefer `useEffect` for browser-only side effects and data unrelated to route navigation.

## Actions and `<Form>`

An action handles route mutations:

```jsx
export async function profileAction({ request }) {
  const formData = await request.formData();
  const name = formData.get("name");

  const response = await fetch("/api/profile", {
    method: "POST",
    body: formData,
  });

  if (!response.ok) {
    throw new Response("Save failed", {
      status: response.status,
    });
  }

  return { ok: true };
}
```

Route:

```jsx
{
  path: "profile",
  element: <ProfilePage />,
  loader: profileLoader,
  action: profileAction,
}
```

Form:

```jsx
<Form method="post">
  <input name="name" />
  <button type="submit">Save</button>
</Form>
```

React Router intercepts `<Form>` submission:

```text
no full-page reload
submission is matched to a route action
navigation/submission state is exposed
loaders can be revalidated afterward
redirects can change the route
```

Actions are registered on route objects just like loaders.

## Router-aware tests

For data-router behavior, prefer a memory router:

```jsx
const router = createMemoryRouter(
  routes,
  { initialEntries: ["/register"] },
);

render(<RouterProvider router={router} />);
```

This allows tests to assert:

```text
which route rendered
navigation result
loader/action behavior
route errors
redirects
```

A plain `MemoryRouter` is sufficient for UI that does not require data-router APIs.

## What should be recallable

- What lifecycle and arguments belong to loaders?
- When is a loader preferable to `useEffect`?
- How do route actions and `<Form>` integrate with mutation, redirects, and revalidation?
- Why do data-router tests use `createMemoryRouter` and `RouterProvider`?

## Related knowledge

- `react.react-router-revalidation-navigation-state-and-redirects`
- `react.react-router-route-errors-and-action-data`

## Sources

- Workspace: `_ai-conspects/react router/`
- Authoritative processed source: `regions/R01R02R03R04-react-router-final-v001.md`
- Original SVG: `source/react router.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
