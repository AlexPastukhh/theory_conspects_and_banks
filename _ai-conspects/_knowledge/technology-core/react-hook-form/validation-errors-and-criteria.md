# Validation errors, criteria modes, and server error mapping

Knowledge ID: `react-hook-form.validation-errors-and-criteria`

Topic: `react-hook-form`

## Validation rules feed `formState.errors`

React Hook Form stores validation results in `formState.errors`.

Registration rules can cover required values, min/max, length, patterns, and custom `validate` functions. A custom validator can return `true`, `false`, or an explanatory message. Several named validation functions can be used when the UI needs stable identities for individual rules.

Schema resolvers can centralize cross-field or domain-shaped validation, but client validation remains a feedback mechanism rather than the authoritative server contract.

A field error commonly exposes:

```text
type
message
types   when all criteria are collected
```

Read nested errors through their field paths, for example `errors.user?.email`.

## First error versus all failed rules

`criteriaMode: 'firstError'` keeps the first failing rule for each field.

`criteriaMode: 'all'` collects all failed rules and exposes their messages through `error.types`. This fits password requirement lists and other detailed checklists. First-error mode is usually quieter and cheaper for simple forms.

Named validators create stable keys such as `uppercase`, `number`, and `minLength`. Render the values from `error.types` rather than depending on one assumed property order.

## Error rendering and accessibility

Render field errors close to the input and connect them with accessibility metadata such as `aria-describedby`.

An ErrorMessage-style helper can read a named field from the errors object and render its primary message. With all-criteria mode, use its render callback or the available `messages`/`types` data to render every failed rule.

The helper reduces repetitive optional chaining; it does not replace a consistent accessible error component. Avoid duplicate summaries and inline messages unless the design intentionally needs both.

## Server and cross-field errors use the same field paths

Use `setError` for server or cross-field failures and `clearErrors` when the external condition is resolved.

A reusable submission flow should map field-level API validation errors to stable field paths where possible. Failures that do not belong to one field can use a root/form error. Clear or replace stale server errors after the user edits or resubmits.

This works best when the API error contract uses stable paths compatible with the form model.

## Validation timing has a performance cost

Validation mode controls when errors appear. `mode: 'onChange'` validates frequently and can be expensive for large forms or complex schemas.

Use blur- or submit-driven validation when immediate feedback is unnecessary. Remote checks should be debounced and stale validation requests cancelled; synchronous validators should remain pure and fast.

## What should be recallable

- Which validation outcomes are stored in `formState.errors`?
- What can a custom `validate` function return?
- What changes between `criteriaMode: 'firstError'` and `'all'`?
- When does `error.types` matter?
- Why are named validators useful for detailed requirement lists?
- How should errors be connected to fields accessibly?
- What roles do `setError` and `clearErrors` have for server or cross-field failures?
- Why should API validation errors use stable field paths?
- Why can `onChange` validation become expensive?
- Why does server validation remain authoritative?

## Related knowledge

- `react-hook-form.field-registration-and-lifecycle`
- `react-hook-form.subscriptions-and-render-isolation`
- `react-hook-form.reusable-form-architecture`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R02 plus validation-cost guidance in R08 and server-error mapping/testing in R09
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
