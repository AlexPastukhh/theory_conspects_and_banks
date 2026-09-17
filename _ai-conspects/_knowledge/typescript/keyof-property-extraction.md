# Generic property extraction with keyof

Knowledge ID: `typescript.keyof-property-extraction`

Topic: `typescript`

```ts
function getProperty<T extends object, K extends keyof T>(
  items: readonly T[], key: K): T[K][] {
  return items.map(item => item[key]);
}
```

The array infers `T`; `keyof T` restricts keys; the literal infers `K`; `T[K]` preserves the exact selected value type. Optional properties retain `undefined`, while union keys produce unions of their value types. Keep `T extends HasID` only when the domain needs it.

A variable widened to `string` is too broad; preserve the literal with `const`/`as const` or type it as `keyof T`. Once `T` is inferred, IntelliSense can offer its valid keys.

## Sources
- Workspace: `_ai-conspects/typescript generic get prop from aray of users, k extends keyof T/`
- Processed source: `01-final-transcript.md`, complete transcript
