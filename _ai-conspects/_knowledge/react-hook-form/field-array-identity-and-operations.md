# Field-array identity, ordering, and structural operations

Knowledge ID: `react-hook-form.field-array-identity-and-operations`

Topic: `react-hook-form`

## `useFieldArray` separates React identity from submitted indexes

Create one field array with a stable path:

```ts
useFieldArray({ control, name })
```

The returned `fields` carry an internal stable identifier. Render rows with:

```tsx
key={field.id}
```

not the current array index.

Registration paths still use the current submitted index, for example:

```text
items.${index}.name
```

These are different identities:

```text
field.id
    -> stable React component identity while items move

index in field path
    -> current position in the submitted array

business/server ID
    -> domain identity that should be persisted separately
```

Using the index as the React key can make values and local component state jump between rows.

## Structural operations change array shape

Common operations include:

```text
append
prepend
insert
remove
swap
move
update
replace
```

Append or insert complete item objects rather than partial placeholders. Several operations can request focus for a newly inserted field.

Avoid stacking many structural operations in one synchronous handler unless the resulting order is deliberately tested.

After `move` or `swap`, render from the new `fields` order and keep registration paths based on the current index.

## `update`, `setValue`, `replace`, and reset have different costs

`update(index, value)` can unmount and remount the targeted row.

Use `setValue` for a narrow field change when row remounting is undesirable.

Use `replace` when the entire array comes from a new external source.

Resetting the whole form is appropriate when both array defaults and non-array defaults change together.

## Nested and typed arrays

Nested arrays compose paths such as:

```text
sections.${sectionIndex}.items
```

Typed code may require literal-path assertions so the name remains a specific `FieldPath`.

A field-array name should remain stable during the component lifetime. Extract nested row components so subscriptions and rendering remain local.

Typical use cases include order lines, contacts, addresses, questions, steps, permission rows, and edit forms that preserve existing server IDs while adding client-side rows.

Combining `shouldUnregister` with reorder/unmount behavior requires careful testing.

## Reusable repeated sections

A reusable field-array section can receive `control` and a typed array name, render rows by `field.id`, encapsulate append/remove/move controls, and keep row-level validation local.

Preserve server IDs as ordinary domain fields instead of reusing React Hook Form's internal field-array key.

Tests should cover add, remove, reorder, and persistence-ID behavior.

## What should be recallable

- Why must field-array rows use `field.id` rather than the index as the React key?
- What does the current index represent in the registration path?
- Why must business IDs remain separate from the internal field-array ID?
- Which structural operations are available?
- Why should appended or inserted values normally be complete objects?
- How do `update`, `setValue`, `replace`, and whole-form reset differ?
- What changes after `move` or `swap`?
- What constraints apply to nested typed field-array paths?
- Why is `shouldUnregister` risky around reorder/unmount behavior?
- Which field-array behaviors should tests cover?

## Related knowledge

- `react-hook-form.field-registration-and-lifecycle`
- `react-hook-form.defaults-reset-and-async-edit-flows`
- `react-hook-form.controlled-field-adapters`
- `react-hook-form.reusable-form-architecture`

## Sources

- Workspace: `_ai-conspects/Rhf react hook form/`
- Authoritative processed source: `10-full-combined-final-transcript.md`, R06 plus the stable-key performance reminder in R08 and reusable-section/testing guidance in R09
- Original SVG: not physically resolved in the current workspace; the current `source/` directory exposes extracted images only
