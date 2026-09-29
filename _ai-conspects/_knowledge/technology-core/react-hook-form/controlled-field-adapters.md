# Controlled component adapters with Controller and useController

Knowledge ID: `react-hook-form.controlled-field-adapters`

Topic: `react-hook-form`

## Native registration and controlled adapters solve different integration problems

Native or uncontrolled inputs fit `register`.

Controlled third-party widgets usually need `Controller` or `useController` so their value/event contract can be adapted to React Hook Form.

`Controller` receives `name`, `control`, rules, and a render function. The render function exposes `field`, `fieldState`, and form-level state.

Pass the field contract to the widget in the shape it expects:

```text
field.value
field.onChange
field.onBlur
field.name
field.ref
```

When a widget emits a component-specific event object, translate that event into the actual form value at the adapter boundary.

## `useController` supports reusable adapters

`useController` exposes the same field and field-state primitives inside a reusable input component without requiring a render-prop wrapper.

This is useful for select, date-picker, and similar adapters that own layout, labels, accessibility, and error presentation.

Keep reusable adapters typed through their field `name`, `control`, and rule props. Forward a focusable ref when error focusing is required.

## Never double-register one field

Do not spread both:

```text
register(name)
```

and the `field` object from Controller onto the same input.

Controller already registers and manages the field. Double registration can duplicate handlers, refs, and validation behavior.

Choose one field model:

```text
native/uncontrolled input
    -> register

controlled third-party widget
    -> Controller / useController adapter
```

## Controlled-field lifecycle still matters

Controlled values should not use `undefined` as their normal empty value; use the appropriate empty string, `null`, or other documented widget value.

Disabled behavior still affects submission. Use `shouldUnregister` cautiously when a controlled field participates in reordered field arrays because unmount/remount can remove values.

Controller solves integration; it does not automatically solve performance. Keep controlled adapters close to the widget that needs them.

When props and subscriptions permit it, memoize heavy rows, but do not recreate large option arrays or adapter callbacks unnecessarily. Do not optimize before subscription ownership is understood.

## What should be recallable

- Why are `Controller` and `useController` mainly for controlled third-party widgets?
- Which field primitives must an adapter map to its widget?
- Why might `field.onChange` need event-to-value translation?
- When is `useController` preferable inside a reusable input component?
- Why is spreading both `register(name)` and Controller `field` onto one input wrong?
- Why should controlled empty values avoid ordinary `undefined`?
- Why can `shouldUnregister` be risky around reordered arrays?
- Why does Controller not automatically make a controlled form performant?

## Related knowledge

- `react-hook-form.field-registration-and-lifecycle`
- `react-hook-form.subscriptions-and-render-isolation`
- `react-hook-form.field-array-identity-and-operations`
- `react-hook-form.form-context-and-nested-fields`
- `react-hook-form.reusable-form-architecture`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R05 plus controlled-component performance guidance in R08 and reusable adapter guidance in R09
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
