# Field registration, unregistration, and submission lifecycle

Knowledge ID: `react-hook-form.field-registration-and-lifecycle`

Topic: `react-hook-form`

## Registration connects an input to the form registry

`register(name, options)` connects a native or uncontrolled input through its field name, ref, and change/blur handlers.

Use stable dot-path names such as `user.email` or `items.0.title` so submitted values have the intended object shape. Registration options can also contain built-in rules such as `required`, length and pattern constraints, plus custom `validate` functions.

The props returned by `register` already carry the field contract. Do not overwrite `name`, `ref`, `onChange`, or `onBlur` unless an adapter deliberately merges those responsibilities.

## Unregistration and unmounting are separate decisions

`unregister(name)` removes a field from the form registry. Options can retain or remove its value, error, dirty state, touched state, and validation state.

Unmounting a component does not automatically mean that the field must disappear from form values. The form-wide lifecycle policy and explicit unregister calls decide what happens.

With the usual retained-value behavior, an unmounted field can remain in form values. With `shouldUnregister: true`, unmounting behaves more like a native form and removes the value from submission state.

Choose this policy from the product contract:

```text
wizard step temporarily hidden
    -> retaining values can be useful

mutually exclusive conditional branch
    -> removing the hidden branch can prevent stale submission
```

Per-field or Controller settings should not contradict the form-wide lifecycle without a specific reason.

## Disabled, read-only, and submitted values are different concerns

A disabled registered field is generally omitted or represented as `undefined` rather than submitted as an ordinary value.

Use `readOnly` when a value must stay in submitted form data while the user is prevented from editing it. A disabled `fieldset` is useful when temporarily disabling a group during submission.

Do not use a disabled input as the only source of a required server value. Client-side omission is not authorization or integrity; the server still enforces its contract.

Before final submission, normalize conditional branches so stale values cannot survive from a section that is no longer applicable.

## Conditional-field lifecycle

Watch only the discriminator that controls visibility.

When a hidden branch must not submit, unregister it or use an appropriate `shouldUnregister` policy. When the value should survive toggling, keep it registered or restore it deliberately. Clear dependent validation errors when a hidden branch becomes irrelevant.

Dynamic mount/unmount behavior deserves tests because component timing can change submitted data.

## What should be recallable

- What contract does `register(name, options)` establish for a native or uncontrolled input?
- Why should field names use stable paths that match the intended submitted shape?
- How does explicit `unregister` differ from merely unmounting a field?
- What does `shouldUnregister: true` change?
- When should a hidden conditional branch retain versus remove its value?
- Why is a disabled input different from a read-only input for submission?
- Why can client-side omission never replace server authorization or integrity checks?
- Why should dynamic field lifecycle be covered by tests?

## Related knowledge

- `react-hook-form.validation-errors-and-criteria`
- `react-hook-form.subscriptions-and-render-isolation`
- `react-hook-form.controlled-field-adapters`
- `react-hook-form.field-array-identity-and-operations`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R01 plus conditional-field lifecycle in R08 and dynamic-lifecycle testing guidance in R09
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
