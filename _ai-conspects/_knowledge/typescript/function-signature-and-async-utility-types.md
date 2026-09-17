# Function signature and async utility types

Knowledge ID: `typescript.function-signature-and-async-utility-types`

Topic: `typescript`

TypeScript can derive argument and result types from an existing function instead of duplicating its signature.

```ts
function send(id: string, retry: number): boolean {
  return true;
}

type SendArgs = Parameters<typeof send>;
// [string, number]

type SendResult = ReturnType<typeof send>;
// boolean
```

`Parameters<F>` produces the function's parameter tuple. `ReturnType<F>` produces its declared return type.

For an `async` function, `ReturnType` is still the promise type:

```ts
async function loadUser() {
  return { id: "1", name: "Ada" };
}

type LoadUserPromise = ReturnType<typeof loadUser>;
// Promise<{ id: string; name: string }>

type User = Awaited<ReturnType<typeof loadUser>>;
// { id: string; name: string }
```

`Awaited<T>` models the result of awaiting and recursively unwraps nested promise-like values:

```ts
type NumberResult = Awaited<Promise<Promise<number>>>;
// number
```

This is useful at an API boundary that accepts either an immediate or promised value:

```ts
type MaybePromise<T> = T | Promise<T>;

async function toArray<T>(
  value: MaybePromise<T>,
): Promise<Awaited<T>[]> {
  const resolved = await value;
  return [resolved];
}
```

Use `Parameters` and `ReturnType` to inspect ordinary function signatures, and add `Awaited` when the desired contract is the eventual value rather than its promise wrapper.

## Sources
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R03

