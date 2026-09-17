# DeepPartial is an application-specific recursive contract

Knowledge ID: `typescript.deep-partial-recursive-contracts`

Topic: `typescript`

A minimal recursive partial makes object properties optional at every level:

```ts
type DeepPartial<T> = {
  [K in keyof T]?:
    T[K] extends object
      ? DeepPartial<T[K]>
      : T[K];
};
```

That definition is too broad for many production contracts because `object` also includes arrays, functions, `Date`, maps, sets, and other built-ins. Each category needs an intentional policy.

The authoritative source gives this more explicit version:

```ts
type Primitive =
  | string
  | number
  | boolean
  | bigint
  | symbol
  | null
  | undefined;

type DeepPartial<T> =
  T extends Primitive
    ? T
    : T extends Date
      ? T
      : T extends (...args: any[]) => any
        ? T
        : T extends Map<infer K, infer V>
          ? Map<DeepPartial<K>, DeepPartial<V>>
          : T extends Set<infer U>
            ? Set<DeepPartial<U>>
            : T extends ReadonlyArray<infer U>
              ? ReadonlyArray<DeepPartial<U>>
              : T extends Array<infer U>
                ? Array<DeepPartial<U>>
                : T extends object
                  ? {
                      [K in keyof T]?: DeepPartial<T[K]>
                    }
                  : T;
```

There is an important branch-order consequence in that exact source-shaped definition: every mutable `Array<T>` also extends `ReadonlyArray<T>`. The `ReadonlyArray` branch therefore matches first, and the later mutable `Array` branch is unreachable for ordinary arrays. Its actual contract turns mutable arrays into readonly arrays.

If the intended policy is to preserve the mutable-versus-readonly distinction, test the narrower mutable case first:

```ts
type ArrayPart<T> =
  T extends Array<infer U>
    ? Array<DeepPartial<U>>
    : T extends ReadonlyArray<infer U>
      ? ReadonlyArray<DeepPartial<U>>
      : T;
```

That still does not preserve tuple positions; tuple handling would need another explicit branch. Other decisions are also contract-specific:

```text
Should Date stay Date?
Should functions remain callable?
Should readonly arrays remain readonly?
Should tuples preserve their positions?
Should Map keys, or only Map values, become partial?
```

There is no universal `DeepPartial`. Define and test the categories that the application's input contract actually permits.

## Sources
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R04
- Authoritative technical correction: `02-technical-corrections-v001.md`, TC-001
