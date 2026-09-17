# Zod discriminated-union validation

Knowledge ID: `typescript.zod-discriminated-union-validation`

Topic: `typescript`

A regular union tries alternatives until one schema succeeds. This is appropriate for unrelated or primitive alternatives:

```ts
const ValueSchema = z.union([
  z.string(),
  z.number(),
]);
```

On total failure, the result can contain branch-specific errors from several alternatives.

## Object variants

Object alternatives can also form a regular union:

```ts
const Circle = z.object({
  type: z.literal("circle"),
  radius: z.number(),
});

const Square = z.object({
  type: z.literal("square"),
  size: z.number(),
});

const Shape = z.union([
  Circle,
  Square,
]);
```

When every object variant has one stable literal branch key, make that contract explicit:

```ts
const Shape = z.discriminatedUnion(
  "type",
  [
    Circle,
    Square,
  ],
);
```

The discriminator selects one schema:

```text
type = "circle" -> Circle
type = "square" -> Square
```

The discriminated union does not validate every branch and then choose an error. It uses the discriminator lookup and validates only the selected schema. This gives a direct discriminator or selected-branch failure rather than a combined failure from unrelated branches.

Benefits for tagged object variants include:

```text
clearer errors
one selected branch
less ambiguity for overlapping object shapes
better scaling as variants grow
strong TypeScript narrowing from the same tag
```

Use a regular union when alternatives do not share a reliable literal key. Use a discriminated union when that stable domain discriminator is already part of the object contract.

## What should be recallable

- How does a regular union find a successful branch?
- Why can its failure contain several nested branch errors?
- What contract is required for a discriminated union?
- Does a discriminated union parse every branch?
- How do branch lookup and TypeScript narrowing reinforce each other?

## Related knowledge

- `typescript.never-and-discriminated-union-exhaustiveness`
- `typescript.zod-schema-validation-and-inference`

## Sources

- Workspace: `_ai-conspects/zod/`
- Authoritative processed source: `01-final-transcript.md`, R04
- Identical regional transcript: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R04
- Original SVG: `source/zod.svg`
- Workspace: `_ai-conspects/mfa/`
- Authoritative processed source: `regions/MFA-R00-foreign-zod-stray-cards.md`, complete stray-card transcript reassigned by semantic ownership
- Original source identity: `mfa.svg` (named by the workspace boundary review; not physically present in this workspace)
