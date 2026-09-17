# Custom mapped utilities: Prettify and XOR

Knowledge ID: `typescript.custom-mapped-utilities-prettify-and-xor`

Topic: `typescript`

Custom mapped and conditional types can improve editor display or express object alternatives that a plain union does not enforce clearly.

## Materializing a readable displayed shape

Intersections can appear awkward in editor tooltips:

```ts
type Combined = { id: string } & { name: string };
```

`Prettify<T>` remaps the keys so TypeScript commonly displays one object shape:

```ts
type Prettify<T> =
  T extends object
    ? { [K in keyof T]: T[K] } & {}
    : T;
```

It is a type-display helper only; it changes no runtime value or behavior.

## Excluding the other object branch

`Without<T, U>` marks keys unique to `T` as optional but impossible in the opposite branch:

```ts
type Without<T, U> = {
  [P in Exclude<keyof T, keyof U>]?: never;
};

type XOR<T, U> =
  T | U extends object
    ? (Without<T, U> & U) | (Without<U, T> & T)
    : T | U;
```

Example:

```ts
type ById = { id: string };
type ByEmail = { email: string };
type Lookup = XOR<ById, ByEmail>;

const a: Lookup = { id: "123" };
const b: Lookup = { email: "a@b.com" };

const invalid: Lookup = {
  id: "123",
  email: "a@b.com",
}; // error: both unique branches are present
```

A plain structural union `ById | ByEmail` can admit an object carrying both sets of properties in some assignment and excess-property situations. `XOR` makes the exclusion part of the type by assigning the other branch's unique keys to `never`. For non-object inputs, the helper falls back to the ordinary union.

## Sources
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R05

