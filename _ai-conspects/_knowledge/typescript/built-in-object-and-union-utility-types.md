# Built-in object and union utility types

Knowledge ID: `typescript.built-in-object-and-union-utility-types`

Topic: `typescript`

TypeScript's built-in utility types transform either an object's properties or the members of a union. Keeping those two domains separate makes the result easier to predict.

## Property modifiers are shallow

Given:

```ts
type User = {
  id: string;
  name: string;
  email: string;
};
```

`Partial<T>` makes every top-level property optional, `Required<T>` makes every property required, and `Readonly<T>` makes every property readonly:

```ts
type UserPatch = Partial<User>;
// { id?: string; name?: string; email?: string }

type CompleteUser = Required<User>;
type ImmutableUser = Readonly<User>;
```

These transformations are shallow. A nested object is not recursively made partial, required, or readonly.

`Pick<T, K>` keeps selected keys, while `Omit<T, K>` removes selected keys:

```ts
type PublicUser = Pick<User, "id" | "name">;
type UserWithoutEmail = Omit<User, "email">;
```

## Union-member filters

`Exclude<T, U>` removes union members assignable to `U`; `Extract<T, U>` keeps them. `NonNullable<T>` removes `null` and `undefined`.

```ts
type Role = "admin" | "user" | "guest";

type WithoutGuest = Exclude<Role, "guest">;
// "admin" | "user"

type Privileged = Extract<Role, "admin" | "guest">;
// "admin" | "guest"

type Defined = NonNullable<string | null | undefined>;
// string
```

The compact decision rule is:

```text
Pick / Omit
    transform keys of object types

Exclude / Extract / NonNullable
    filter members of union types
```

For a closed key set mapped to one value type, use `Record<K, V>`; that finite-record contract is covered with index signatures.

## Sources
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R01 (except the `Record` claim merged into the existing finite-record unit)

