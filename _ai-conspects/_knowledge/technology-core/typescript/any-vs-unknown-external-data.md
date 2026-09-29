# TypeScript `any` versus `unknown` at external-data boundaries

Knowledge ID: `typescript.any-vs-unknown-external-data`

Topic: `typescript`

`any` disables type checking for a value. TypeScript permits arbitrary property access and calls even when they can fail at runtime:

```typescript
const badUser = await response.json(); // often inferred as any
badUser.anything.deep().call();        // compiles, may fail at runtime
```

The useful mental model is:

```text
any = trust me; do not check this value
```

This is especially dangerous for external JSON because the compiler cannot establish the runtime shape and `any` removes the remaining protection.

`unknown` also represents a value whose type is not known yet, but it requires proof before use:

```typescript
const goodUser: unknown = await response.json();
// goodUser.name; // compile-time error

if (
  typeof goodUser === "object" &&
  goodUser !== null &&
  "name" in goodUser
) {
  // Property access is now guarded; production code usually adds stronger typing.
}
```

```text
unknown = prove the shape before using the value
```

For external JSON, prefer `unknown`, then narrow or validate. A production boundary commonly strengthens hand-written guards with a schema validator such as Zod, io-ts, Valibot, or a custom guard. Use `any` only when disabling checking at that boundary is deliberate.

## What should be recallable

- How `any` disables checking and can move an external-data failure to runtime.
- How `unknown` forces narrowing before property access.
- Why `response.json()` should be treated as an untrusted runtime boundary.
- Where runtime guards or schema validation enter the flow.

## Sources

- Workspace: `_ai-conspects/typescript any unknown/`
- Authoritative reconstructed source: `regions/R01-any-vs-unknown-final-transcript-v001.md`, complete transcript
- Original SVG: `source/typescript any unknown.svg`
