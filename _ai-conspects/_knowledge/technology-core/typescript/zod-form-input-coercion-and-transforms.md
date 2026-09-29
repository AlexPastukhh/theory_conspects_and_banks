# Zod form-input coercion, preprocessing, and transforms

Knowledge ID: `typescript.zod-form-input-coercion-and-transforms`

Topic: `typescript`

Browser form controls usually produce raw strings rather than domain values:

```text
text input      -> string
number input    -> usually string unless a form library converts it
select          -> string
textarea        -> string
checkbox        -> omitted or a configured value such as "on"
radio           -> selected string value
```

The schema or form adapter therefore needs an explicit conversion owner.

## Coercion and preprocessing

Plain numeric validation rejects a numeric string:

```ts
z.number().parse("42");
```

The captured source uses coercion when normal JavaScript conversion is appropriate:

```ts
z.coerce.number().parse("42");

z.coerce.number();
z.coerce.date();
z.coerce.boolean();
z.coerce.string();
```

Boolean coercion deserves care because JavaScript truthiness makes non-empty strings truthy. Checkbox payloads often need an explicit rule instead.

`preprocess` owns application-specific raw-input normalization before a target schema validates:

```ts
const OptionalAge = z.preprocess(
  value =>
    value === "" || value === undefined
      ? undefined
      : value,
  z.coerce.number().int().min(0).optional(),
);
```

Besides empty values and custom boolean representations, preprocessing can normalize custom date formats, reshape legacy payloads, and make a missing-value policy explicit before validation.

The processing order is:

```text
raw input
-> preprocess
-> target-schema validation
-> transform
-> final output
```

Use the stages deliberately:

```text
z.coerce.*
    common built-in conversion before validation

z.preprocess(...)
    custom raw-input conversion before validation

.transform(...)
    output conversion after prior validation
```

## Choosing the form conversion owner

React Hook Form can convert a registered field:

```tsx
<input
  type="number"
  {...register("age", {
    valueAsNumber: true,
  })}
/>
```

Related registration options include `valueAsDate` and `setValueAs`. Alternatively, leave raw conversion to the schema:

```ts
const FormSchema = z.object({
  age: z.coerce
    .number()
    .int()
    .min(0),
});
```

Avoid converting the same field independently in both layers unless that double conversion is deliberate.

With `zodResolver`, the full flow is:

```text
DOM / React Hook Form raw values
-> resolver
-> preprocess or coerce
-> validation
-> transform
-> validated submit-handler output
```

The transformed output is supplied to the valid-submit handler; the resolver does not automatically rewrite the DOM input to the normalized value.

Input and output types can be expressed explicitly:

```ts
const form = useForm<
  z.input<typeof FormSchema>,
  unknown,
  z.output<typeof FormSchema>
>({
  resolver: zodResolver(FormSchema),
});
```

## Empty numbers and checkboxes

JavaScript numeric conversion can turn an empty string into `0`, which is often not the domain meaning. Normalize it before coercion:

```ts
const AgeSchema = z.preprocess(
  value =>
    value === ""
      ? undefined
      : value,
  z.coerce.number().int().min(1).optional(),
);
```

A required terms checkbox can normalize the accepted representations and then require literal `true`:

```ts
const TermsSchema = z.object({
  accepted: z.preprocess(
    value =>
      value === "on" ||
      value === "true" ||
      value === true,
    z.literal(true),
  ),
});
```

For an ordinary optional boolean, choose whether a missing value means `false`, `undefined`, or a validation error. Do not let that policy emerge accidentally from truthiness.

## What should be recallable

- Which raw values do common browser controls submit?
- Why does `z.number()` reject `"42"` while `z.coerce.number()` accepts it?
- Why is boolean coercion especially easy to misread?
- In what order do preprocess, validation and transform run?
- When should conversion belong to RHF versus Zod?
- Why can an empty numeric input accidentally become zero?
- Which policy choices exist for an omitted checkbox?

## Sources

- Workspace: `_ai-conspects/zod/`
- Authoritative processed source: `01-final-transcript.md`, R02 and R05 React Hook Form integration
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R02 and R05
- Original SVG: `source/zod.svg`
