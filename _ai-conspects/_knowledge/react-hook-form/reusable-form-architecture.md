# Reusable React Hook Form architecture and testing boundaries

Knowledge ID: `react-hook-form.reusable-form-architecture`

Topic: `react-hook-form`

## Reuse should preserve distinct field responsibilities

Reusable form code separates several different concerns instead of hiding the whole library behind one generic abstraction:

```text
native registration
controlled adapters
repeated sections
asynchronous edit flows
server-error mapping
```

A native input wrapper can accept a typed field name, label, and registration rules, obtain registration/errors from props or context, and render the accessible field/error pair together. Visual styling should remain independent from the schema library.

A controlled select or date-picker adapter can use `useController`, translate the widget value into the form's domain value, expose field-state errors, and forward refs when focus management is supported.

A repeated-section component can receive `control` and a typed array path, render rows using `field.id`, and encapsulate append/remove/move behavior without confusing internal field-array identity with server IDs.

## The form screen owns the complete submission lifecycle

A practical composition is:

```text
Form screen
├── useForm<TValues>()
├── FormProvider
│   ├── registered native inputs
│   ├── useController adapters
│   ├── useWatch conditional sections
│   └── useFieldArray repeated sections
├── handleSubmit
│   ├── normalize UI values
│   ├── send API command
│   └── map server errors with setError
└── reset(savedValues) after successful persistence
```

The UI form shape is not automatically the API command shape. Map a loaded DTO into form values and normalize form values into the submitted command rather than sending internal UI state blindly.

After successful persistence, resetting to the saved representation makes the form's dirty baseline reflect the persisted result.

## Server errors belong to stable form paths

Map field-level API validation errors with `setError`. Use a root/form error when a failure is not tied to one field.

Clear or replace stale server errors after editing or resubmission. Stable API field paths make this mapping predictable.

## Testing should cover lifecycle, not only happy-path submission

A reusable form architecture should test:

- default and asynchronously loaded values;
- dynamic mount/unmount behavior and submitted omissions;
- all-criteria error rendering;
- field-array add, remove, reorder, and persistence IDs;
- controlled adapters;
- server-error mapping.

These tests protect the boundaries where form lifecycle, registration, identity, and server contracts can diverge.

## Keep abstractions narrow

Reusable abstractions must preserve React Hook Form's value and ref contracts.

Do not hide every form operation behind one oversized generic component. Separate abstractions by actual responsibility so native registration, controlled adaptation, repeated structures, asynchronous state, and submission errors remain understandable.

## What should be recallable

- Which responsibilities should reusable form code keep separate?
- What belongs in a native field wrapper versus a controlled adapter?
- Why should server IDs remain domain data inside a reusable field-array section?
- What is the practical ownership tree around `useForm`, `FormProvider`, conditional sections, arrays, submit, and reset?
- Why should loaded DTOs, internal form values, and submitted API commands be mapped deliberately?
- Why reset to the saved representation after persistence?
- How should field-level versus root server errors be represented?
- Which lifecycle behaviors deserve explicit tests?
- Why is one oversized generic form component a poor abstraction boundary?

## Related knowledge

- `react-hook-form.field-registration-and-lifecycle`
- `react-hook-form.validation-errors-and-criteria`
- `react-hook-form.defaults-reset-and-async-edit-flows`
- `react-hook-form.controlled-field-adapters`
- `react-hook-form.field-array-identity-and-operations`
- `react-hook-form.form-context-and-nested-fields`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R09
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
