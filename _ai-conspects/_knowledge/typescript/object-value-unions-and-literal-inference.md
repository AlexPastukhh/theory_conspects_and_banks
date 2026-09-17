# Object value unions and literal inference

Knowledge ID: `typescript.object-value-unions-and-literal-inference`

Topic: `typescript`

A value union can be derived from an object type by indexing it with the union of its keys:

```ts
type ValueOf<T> = T[keyof T];
```

`keyof T` produces the key union; `T[keyof T]` then produces the union of the corresponding property values.

For an enum-like runtime object, preserve literal values with `as const`:

```ts
const REQUEST_STATUS = {
  idle: "IDLE",
  loading: "LOADING",
  success: "SUCCESS",
  error: "ERROR",
} as const;

type RequestStatus = ValueOf<typeof REQUEST_STATUS>;
// "IDLE" | "LOADING" | "SUCCESS" | "ERROR"
```

Without `as const`, mutable object properties commonly widen to `string`, so the derived type loses the useful literal union. The same pattern works for route names, feature flags, event names, permission codes, and analytics identifiers that must exist both as runtime values and compile-time types.

This helper changes no runtime behavior. It derives a static union from an object that already exists at runtime.

## Sources
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R04 `ValueOf` and R05 literal-inference claims

