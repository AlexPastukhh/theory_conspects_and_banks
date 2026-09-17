# Index signatures, assertions, and finite records

Knowledge ID: `typescript.index-signatures-assertions-and-records`

Topic: `typescript`

A type assertion changes the compiler's view, not the runtime value. Narrow from `unknown` only after evidence; a double assertion through `unknown` is an escape hatch, not validation. DOM values likewise need runtime narrowing when the element type is uncertain.

`keyof T` produces known property keys. A dependent generic preserves their value types:

```ts
function get<T, K extends keyof T>(value: T, key: K): T[K] {
  return value[key];
}
```

Overloads can preserve literal-dependent return types when a simple generic is insufficient.

An index signature models a broad, open key domain, so reads may need `undefined`; `noUncheckedIndexedAccess` makes that risk explicit. Named properties must be compatible with the index value type. A finite literal union cannot be used as the parameter type of an index signature: use `Record<K, V>` or a mapped type for a closed key set instead.

```ts
type Status = "idle" | "loading" | "done";
type Labels = Record<Status, string>;
```

`Object.keys(value) as (keyof T)[]` assumes runtime keys match the static model, but structurally typed objects can contain extra properties. Use the cast only where that boundary is controlled.

Likewise, a `for...in` loop produces `string`, which is normally too broad for indexed access on a finite object type. Narrow or validate the key instead of silently asserting every runtime string is a `keyof T`.

## Sources
- Workspace: `_ai-conspects/index sign, keyof, type assertions, records to solve index sign issues/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R01 (`Record<K, V>`)
- Original SVG: `source/utility types.svg`
