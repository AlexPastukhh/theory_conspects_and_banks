# React Router route errors and action data

Knowledge ID: `react.react-router-route-errors-and-action-data`

Topic: `react`

## Route errors

A route can define an error boundary:

```jsx
{
  path: "/profile",
  element: <ProfilePage />,
  loader: profileLoader,
  action: profileAction,
  errorElement: <RouteError />,
}
```

The nearest matched route with `errorElement` handles errors from:

```text
loader
action
route element rendering
```

Read the value with:

```jsx
const error = useRouteError();
```

Example:

```jsx
function RouteError() {
  const error = useRouteError();

  if (isRouteErrorResponse(error)) {
    return (
      <>
        <h2>{error.status}</h2>
        <p>{error.statusText}</p>
      </>
    );
  }

  return <p>{String(error)}</p>;
}
```

Nearest matching error boundary wins, so parent routes can provide a shared fallback and children can override it.

## `throw Response` versus returning validation data

Throw a `Response` for route-level failure:

```jsx
throw new Response("Not Found", {
  status: 404,
});
```

This stops normal rendering for the route and sends control to `errorElement`.

Return structured data for expected inline errors:

```jsx
return {
  fieldErrors: {
    email: "Email is invalid",
  },
};
```

Read returned action data using `useActionData()`.

Rule of thumb:

```text
expected user-fixable problem -> return structured action data
page/route failure -> throw Response or Error
```

`isRouteErrorResponse()` distinguishes Response-like route errors and exposes status information.

## `useActionData()`

`useActionData()` reads the return value of the most recent action for the current route:

```jsx
const actionData = useActionData();
```

Typical uses:

```text
field validation errors
saved/success message
returned server values
recoverable business-rule feedback
```

Action data is commonly undefined before the first submission.

## Mapping server errors back into React Hook Form

```jsx
useEffect(() => {
  if (!actionData?.fieldErrors) {
    return;
  }

  for (const [field, message] of
    Object.entries(actionData.fieldErrors)) {
    setError(field, {
      type: "server",
      message: String(message),
    });
  }
}, [actionData, setError]);
```

The flow becomes:

```text
RHF validates client-side
useSubmit submits through React Router
route action validates server-side
recoverable errors are returned
useActionData receives them
setError maps them back to form fields
```

## Return versus throw from an action

Return inline problems:

```jsx
return {
  ok: false,
  fieldErrors: {
    email: "Already registered",
  },
};
```

Throw page-level failures:

```jsx
throw new Response("Server unavailable", {
  status: 503,
});
```

This cleanly separates:

```text
validation/business feedback -> current page UI
route/page failure -> errorElement
```

## What should be recallable

- Which failures reach the nearest route error boundary?
- When should an action throw a Response versus return structured data?
- How does returned action data become field errors in React Hook Form?

## Related knowledge

- `react.react-router-forms-react-hook-form-and-history`
- `react.react-router-loaders-actions-and-testing`

## Sources

- Workspace: `_ai-conspects/react router/`
- Authoritative processed source: `regions/R01R02R03R04-react-router-final-v001.md`
- Original SVG: `source/react router.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
