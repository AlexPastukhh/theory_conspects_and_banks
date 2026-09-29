# Value subscriptions, form-state subscriptions, and render isolation

Knowledge ID: `react-hook-form.subscriptions-and-render-isolation`

Topic: `react-hook-form`

## Choose the smallest subscription that matches the UI need

React Hook Form exposes several different read models:

```text
watch / useWatch
    -> subscribe to values

formState / useFormState
    -> subscribe to metadata

getValues
    -> read a snapshot without subscribing

callback-style subscription
    -> observe changes for side effects without a render dependency
```

The chosen API determines which component rerenders.

## `watch` and `useWatch`

`watch(name)` reads a value and subscribes the component that owns `useForm` to relevant changes. Calling `watch()` without a name observes the whole form and can create broad rerenders.

Provide `defaultValues` or a watch fallback when the first render must not be `undefined`.

Use a narrow `watch` when root render logic genuinely needs a value. For a deep child that renders one field or projection, prefer `useWatch` in that child or custom hook so rerenders stay local.

`useWatch` can receive `control` explicitly or obtain it from form context. Subscribe to the narrowest field path or computed projection the component actually needs.

## Non-rendering subscriptions

For analytics, persistence, or external synchronization, a callback-style subscription can avoid making rendered JSX depend on the observed value.

Keep the returned unsubscribe function and dispose it during effect cleanup. Depending on the installed React Hook Form version, this may be exposed through a `watch` callback or a dedicated `subscribe` API.

Filter changes before causing external or React updates. A broad subscription that writes the same observed value repeatedly can create an update loop.

## Form-state subscriptions are also scoped

Useful form-state properties include `isDirty`, `dirtyFields`, `touchedFields`, `isValid`, `isSubmitting`, `isSubmitted`, and `submitCount`.

Form state is subscription-based. Read only the properties a component needs. In children, `useFormState` can isolate errors, dirty state, or touched state rather than making the form root depend on all metadata.

A deep child that only needs one value should normally use `useWatch`; a child that only needs error/dirty metadata should use `useFormState`.

## Performance rules follow subscription ownership

Avoid whole-form `watch()` in the root unless the entire root truly depends on every field. Broad root-level error rendering can also rerender the form for every validation change.

Validation on every change can become expensive with complex schemas. Debounce remote checks, cancel stale requests, and keep synchronous validators fast.

Development tools and verbose logging can exaggerate render cost during profiling. Measure with realistic form size before adding custom caching. Premature memoization can make the form harder to understand; correct lifecycle and validation behavior come first.

## What should be recallable

- What is the difference between `watch`, `useWatch`, `getValues`, and a callback subscription?
- Why can `watch()` without a name cause broad rerenders?
- Why does `useWatch` improve render isolation in deep children?
- Why must callback subscriptions be unsubscribed during cleanup?
- How can a subscription create an update loop?
- Why is `formState` also subscription-based?
- When should a child use `useFormState` rather than reading broad form state?
- Why should performance work start from narrow subscriptions before custom caching?
- Why should profiling use realistic form size?

## Related knowledge

- `react-hook-form.field-registration-and-lifecycle`
- `react-hook-form.defaults-reset-and-async-edit-flows`
- `react-hook-form.form-context-and-nested-fields`
- `react-hook-form.controlled-field-adapters`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R03; form-state subscription details in R04 and R07; subscription, validation-cost, and profiling guidance in R08
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
