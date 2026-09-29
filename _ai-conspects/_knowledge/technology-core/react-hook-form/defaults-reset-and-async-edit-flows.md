# Defaults, reset semantics, and asynchronous edit flows

Knowledge ID: `react-hook-form.defaults-reset-and-async-edit-flows`

Topic: `react-hook-form`

## `defaultValues` define the dirty-state baseline

`defaultValues` establish the baseline used by dirty-state comparisons and should match the final nested field-name structure.

Prefer defined defaults for controlled values instead of using `undefined` as a normal controlled-input default.

Defaults are cached by the form instance rather than re-read from changing props on every render. This makes server data, form defaults, and current values three distinct concepts.

`isDirty` compares current values with the default baseline, so incomplete defaults can produce confusing dirty-state results.

## Asynchronous edit data should establish a deliberate baseline

For an edit screen, load the record and call:

```ts
reset(loadedValues)
```

when it arrives.

Some React Hook Form versions support asynchronous `defaultValues` and can expose loading state while those defaults resolve.

A reactive `values` option can synchronize external data, but it should be used deliberately because new external values can overwrite local edits.

When the selected record changes, cancel or ignore stale requests so an older response cannot replace the current form state.

## `reset` changes values and baseline semantics

`reset()` restores the current default baseline.

`reset(newValues)` replaces the current values and normally establishes a new default baseline.

Reset options can retain selected metadata such as errors, dirty values, or touched state for targeted workflows.

Call reset after form subscriptions are initialized, commonly from an effect that responds to loaded data or successful persistence. Repeatedly resetting from changing props can erase user edits.

## Imperative helpers have different responsibilities

- `setValue` updates a field and can request validation, dirty, and touched calculations.
- `getValues` reads a snapshot without subscribing.
- `trigger` runs validation for selected fields or the whole form.
- `resetField` resets one field without resetting the entire form.

Choose the smallest operation that represents the intended state transition.

## Asynchronous edit-flow pattern

A reusable edit flow separates transport data from form state:

```text
load server record
-> map DTO to form values
-> reset(mapped values)
-> user edits current form values
-> normalize UI values into an API command
-> persist
-> reset(saved representation)
```

Resetting to the saved representation after success makes dirty state reflect what is actually persisted.

Background refreshes must not silently destroy unsaved user edits.

## What should be recallable

- What does `defaultValues` establish for dirty-state comparisons?
- Why are server data, defaults, and current values separate concepts?
- Why should controlled fields avoid an ordinary `undefined` default?
- How should an edit screen establish values after asynchronous loading?
- What risk comes with reactive external `values` or repeated reset calls?
- What is the difference between `reset()` and `reset(newValues)`?
- What responsibilities belong to `setValue`, `getValues`, `trigger`, and `resetField`?
- Why reset to the saved representation after successful persistence?
- Why must stale loads and background refreshes be handled deliberately?

## Related knowledge

- `react-hook-form.subscriptions-and-render-isolation`
- `react-hook-form.reusable-form-architecture`
- `react-hook-form.field-array-identity-and-operations`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R04 plus the asynchronous edit-form pattern in R09
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
