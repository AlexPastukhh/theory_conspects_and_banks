# Zod refinements and cross-field errors

Knowledge ID: `typescript.zod-refinements-and-cross-field-errors`

Topic: `typescript`

Built-in schemas cover common constraints. Refinements add application-specific validation while preserving structured issues and useful error paths.

## One boolean rule with `refine`

```ts
const Password = z
  .string()
  .min(8)
  .refine(
    value => /[A-Z]/.test(value),
    {
      message: "Must contain an uppercase letter",
    },
  );
```

`refine` is concise when one predicate produces one custom validation result. Common options include `message`, `path`, and `params`; a path attaches the issue to the field where a consumer should display it.

## Cross-field and multi-issue validation

Object-level validation receives the validated object. Its properties are ordinary JavaScript values and can be destructured normally.

```ts
const SignupSchema = z
  .object({
    password: z.string().min(8),
    confirm: z.string(),
  })
  .superRefine((value, context) => {
    if (value.password !== value.confirm) {
      context.addIssue({
        code: z.ZodIssueCode.custom,
        path: ["confirm"],
        message: "Passwords do not match",
      });
    }
  });
```

Use `superRefine` when validation needs to emit several issues, coordinate several fields, attach issues to different paths, or supply custom issue codes or metadata:

```ts
Schema.superRefine((value, context) => {
  if (firstRuleFails(value)) {
    context.addIssue(firstIssue);
  }

  if (secondRuleFails(value)) {
    context.addIssue(secondIssue);
  }
});
```

The important boundary is not merely schema size:

```text
one boolean-style custom rule
    -> refine

cross-field or multiple structured issues
    -> superRefine + context.addIssue
```

## What should be recallable

- Which validation shape makes `refine` appropriate?
- How does `path` improve field-level error presentation?
- Why is password confirmation an object-level rule?
- When does `superRefine` add value beyond one predicate?
- How can one validation pass emit several independent issues?

## Related knowledge

- `typescript.zod-schema-validation-and-inference`
- `typescript.zod-form-input-coercion-and-transforms`

## Sources

- Workspace: `_ai-conspects/zod/`
- Authoritative processed source: `01-final-transcript.md`, R03
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R03
- Original SVG: `source/zod.svg`
