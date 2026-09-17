# TypeScript control-flow type narrowing

Knowledge ID: `typescript.control-flow-type-narrowing`

Topic: `typescript`

```ts
if (value == null) return;            // null and undefined
if (!value) return;                   // also empty string/falsy values
if (typeof value !== "string") return;
```

TypeScript tracks types per reachable branch. After `if (maybeName === undefined) return`, later statements see `string`; reassigning a union value can invalidate that fact. Early `return` contributes `undefined` while a successful string call contributes `string`, often inferring `string | undefined`.

Choose a guard by valid domain values: truthiness is too broad when empty strings are valid.

## Sources
- Workspace: `_ai-conspects/type narrowing/`
- Processed source: `01-source-preserving-transcript-v001.md`, complete transcript
