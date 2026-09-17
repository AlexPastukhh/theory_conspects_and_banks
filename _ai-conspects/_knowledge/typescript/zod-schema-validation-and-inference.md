# Zod schema validation, composition, and type inference

Knowledge ID: `typescript.zod-schema-validation-and-inference`

Topic: `typescript`

Install the schema library and, when React Hook Form integration is needed, its resolver package:

```bash
npm i zod
npm i @hookform/resolvers
```

Zod defines runtime schemas from which TypeScript types can also be inferred. A schema validates external values and returns its validated or transformed output.

## Parse results

```ts
import { z } from "zod";

const UserSchema = z.object({
  name: z.string().min(2),
  age: z.number().int().nonnegative(),
});

const user = UserSchema.parse({
  name: "Ali",
  age: 20,
});
```

`parse` returns output or throws `ZodError`. At an untrusted boundary, `safeParse` exposes failure as a discriminated result:

```ts
const result = UserSchema.safeParse(input);

if (result.success) {
  console.log(result.data);
} else {
  console.log(result.error.issues);
}
```

## Primitive and constrained schemas

The captured source uses schemas for primitives, exact values, string enums and TypeScript enum-like values:

```ts
z.string();
z.number();
z.boolean();
z.bigint();
z.date();
z.null();
z.undefined();

z.literal("ADMIN");
z.literal(42);
z.literal(true);

z.enum(["ADMIN", "USER"]);
z.nativeEnum(Role);
```

Representative string and number constraints include:

```ts
z.string().min(2).max(50);
z.string().email();
z.string().url();
z.string().uuid();
z.string().regex(/^\d+$/);
z.string().trim();

z.number().int();
z.number().positive();
z.number().nonnegative();
z.number().min(0).max(100);
z.number().multipleOf(5);
```

URL validation checks syntax, not remote-resource existence. Floating-point `multipleOf` checks can be affected by precision; financial rules are often safer in integer minor units.

## Collections and presence

Container schemas validate both the outer structure and their element or value schema:

```ts
z.array(z.string());

z.tuple([
  z.string(),
  z.number(),
]);

z.record(z.string());
z.map(z.string(), z.number());
z.set(z.string());
```

Presence modifiers express different contracts:

```ts
z.string().optional(); // undefined is allowed
z.string().nullable(); // null is allowed
z.string().nullish();  // null or undefined is allowed
z.string().default("x");
```

A default applies when input is `undefined`, including a missing object property.

## Transform output and derived schemas

Validation and normalization can produce an output type different from the input type:

```ts
const NormalizedName = z
  .string()
  .trim()
  .transform(value => value.toLowerCase());
```

Object helpers derive related schemas without repeating every property:

```ts
const Base = z.object({
  a: z.string(),
  b: z.number(),
});

Base.pick({ a: true });
Base.omit({ b: true });

Base.extend({
  c: z.boolean(),
});

Base.merge(
  z.object({
    d: z.string(),
  }),
);

Base.partial();
Base.deepPartial();
```

`deepPartial`, `nativeEnum`, and some other helper signatures above are the APIs shown by the captured authoritative source. Treat them as source/version-specific when choosing APIs for an installed Zod version; this migration does not invent a newer-version replacement.

Infer the schema's output type with `z.infer`:

```ts
type User = z.infer<typeof UserSchema>;
```

When preprocessing or transforming changes the contract, distinguish both sides:

```ts
type Input = z.input<typeof Schema>;
type Output = z.output<typeof Schema>;
```

## What should be recallable

- How do `parse` and `safeParse` represent failure?
- What runtime work does a Zod schema add beyond a TypeScript type?
- How do literal, enum and container schemas constrain values?
- How do optional, nullable, nullish and default differ?
- Which caveats belong to URL and floating-point `multipleOf` validation?
- Why can schema input and output types differ?
- How do object helpers and `z.infer` avoid duplicate contracts?

## Related knowledge

- `typescript.any-vs-unknown-external-data`
- `typescript.zod-form-input-coercion-and-transforms`
- `typescript.zod-refinements-and-cross-field-errors`
- `typescript.zod-discriminated-union-validation`

## Sources

- Workspace: `_ai-conspects/zod/`
- Authoritative processed source: `01-final-transcript.md`, R01 and R05
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R01 and R05
- Original SVG: `source/zod.svg`
