# React Router forms, React Hook Form, and history

Knowledge ID: `react.react-router-forms-react-hook-form-and-history`

Topic: `react`

## `<Form>` versus `<fetcher.Form>`

Use `<Form>` when:

```text
it is the main form for the page
successful submission should navigate or redirect
URL/search parameters should change
page-level submitting/loading UI is desired
history behavior is part of the workflow
```

Examples:

```text
login
registration
create/edit page
checkout
search form that changes the URL
```

Use `<fetcher.Form>` when:

```text
the operation should stay on the same page
state should be local to one row/card/modal
many operations may run independently
optimistic UI is useful
the operation is autosave or inline edit
```

Examples:

```text
favorite button
delete row
modal edit
add-to-cart
background draft save
```

A normal HTML form without React Router performs document navigation/reload unless intercepted manually. React Router `<Form>` preserves SPA behavior and route integration.

## `useSubmit()`

`useSubmit()` submits programmatically through the router:

```jsx
const submit = useSubmit();

function save(formElement) {
  submit(formElement, {
    method: "post",
  });
}
```

It can submit:

```text
HTMLFormElement
FormData
URLSearchParams
plain serializable values supported by the API
```

Use it when the router should own submission, but native `<Form>` initiation is not sufficient:

```text
React Hook Form callback
submit on change
custom keyboard shortcut
computed data
custom confirmation flow
```

When React Hook Form calls `handleSubmit`, the callback receives values and an event. The form element can be submitted through React Router:

```jsx
const submit = useSubmit();

const onValid = (values, event) => {
  submit(event.currentTarget, {
    method: "post",
  });
};
```

Or build a `FormData` payload explicitly when computed values or another action URL are required.

## React Hook Form and Zod

Client validation can happen before router submission:

```jsx
const schema = z.object({
  name: z.string().min(2),
  email: z.string().email(),
});
```

The route action must still validate on the server:

```jsx
export async function profileAction({
  request,
}) {
  const formData = await request.formData();
  const values = Object.fromEntries(formData);

  const parsed = schema.safeParse(values);

  if (!parsed.success) {
    return {
      ok: false,
      fieldErrors:
        mapZodIssues(parsed.error.issues),
      values,
    };
  }

  const response = await saveProfile(parsed.data);

  if (!response.ok) {
    throw new Response("Profile save failed", {
      status: response.status,
    });
  }

  return { ok: true };
}
```

Client validation improves responsiveness; server validation remains authoritative.

## History behavior

A router `<Form method="get">` usually changes the URL and creates navigation history appropriate for search/filter workflows.

A router `<Form method="post">` submits to an action. The resulting action redirect determines the final URL/history entry.

`fetcher.Form` does not create a history entry by itself because it does not navigate. A redirect returned from its action may still navigate.

## Decision checklist

```text
Should successful submission change page/URL?
    yes -> <Form>
    no  -> fetcher.Form or fetcher.submit

Should global page navigation UI react?
    yes -> <Form> + useNavigation
    no  -> fetcher + fetcher.state

Can many operations run independently?
    yes -> one fetcher per operation/component

Does submission come from RHF/custom code?
    useSubmit or fetcher.submit

Is the problem recoverable inside the page?
    return structured action data

Is the route unable to render correctly?
    throw Response/Error and use errorElement
```

## Practical checklist

```text
[ ] choose a data router when loaders/actions/fetchers are required
[ ] render nested routes through Outlet
[ ] use index routes for parent default content
[ ] use NavLink for active navigation styling
[ ] separate path params from query-string state
[ ] use loaders for route-required data
[ ] use actions for route mutations
[ ] let actions trigger normal loader revalidation
[ ] use shouldRevalidate only for deliberate exceptions
[ ] use useNavigation for global router work
[ ] use fetcher state for local non-navigation work
[ ] throw Response for route-level failures
[ ] return structured data for inline validation errors
[ ] use useRouteLoaderData for shared parent data
[ ] use useMatches + handle for breadcrumbs and metadata
[ ] validate on both client and server
[ ] map action field errors back into React Hook Form
[ ] test data-router behavior with createMemoryRouter
```

## What should be recallable

- When should submission navigate and affect global state versus remain local?
- How can React Hook Form submit through the router while retaining authoritative server validation?
- What history behavior follows GET forms, POST actions, fetchers, and redirects?
- Which decision checklist selects Form, fetcher, useSubmit, returned data, or thrown errors?

## Related knowledge

- `react.react-router-fetchers-and-local-mutations`
- `react.react-router-route-errors-and-action-data`

## Sources

- Workspace: `_ai-conspects/react router/`
- Authoritative processed source: `regions/R01R02R03R04-react-router-final-v001.md`
- Original SVG: `source/react router.svg` (present in the local workspace and named by `CURRENT_SOURCE_OF_TRUTH.md`; excluded from Git and not resolvable from the current branch tree).
