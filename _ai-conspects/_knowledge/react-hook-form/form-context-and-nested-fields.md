# FormProvider, form context, and deeply nested fields

Knowledge ID: `react-hook-form.form-context-and-nested-fields`

Topic: `react-hook-form`

## One provider should represent one form lifecycle

Create the form once with `useForm` and pass its methods to `FormProvider`.

Wrap the subtree that contains the fields and submit controls. A child that belongs to the same submission should not create a second independent form instance.

Avoid unnecessary nested FormProviders for one logical form.

## `useFormContext` removes prop drilling without changing ownership

`useFormContext` reads the nearest provider's methods.

A reusable native input can obtain `register` and `formState.errors` without receiving the entire methods object through every parent.

A controlled adapter can obtain `control` and then use `useController`.

Use the same typed form-value model throughout the subtree so nested names remain valid field paths.

Deep fields can use names such as:

```text
profile.address.city
```

## Context does not mean every component should subscribe broadly

Keep layout components unaware of unrelated form state.

A deep child that renders one value should use `useWatch`. A child that needs only local error, dirty, or touched metadata should use `useFormState`.

This preserves the convenience of context while limiting rerenders.

Context removes prop drilling, but reading broad form state from every child can still create broad subscriptions.

## Effects should depend on stable responsibilities

Use stable individual methods such as `reset` in effects rather than depending on a freshly assembled wrapper object.

Do not call registration or reset conditionally in a way that changes React hook ordering.

Keep the provider close enough to make ownership clear but broad enough to contain all fields and submit actions for that form.

## What should be recallable

- Why should one logical form normally have one `useForm` instance and one provider lifecycle?
- What does `useFormContext` provide to nested inputs?
- How can native and controlled nested inputs consume context differently?
- Why must nested field names share the same typed form-value model?
- Why should deep children use `useWatch` or `useFormState` instead of broad state reads?
- Why can context still cause broad rerenders?
- Why should effects depend on stable individual form methods?
- What provider boundary keeps ownership coherent?

## Related knowledge

- `react-hook-form.subscriptions-and-render-isolation`
- `react-hook-form.controlled-field-adapters`
- `react-hook-form.reusable-form-architecture`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R07
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
