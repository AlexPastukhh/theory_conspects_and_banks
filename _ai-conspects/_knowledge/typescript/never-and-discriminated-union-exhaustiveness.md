# never and discriminated-union exhaustiveness

Knowledge ID: `typescript.never-and-discriminated-union-exhaustiveness`

Topic: `typescript`

`never` is the bottom type: no runtime value can have it. It is assignable to every type precisely because there is no possible `never` value to violate the target type. A function that always throws or provably loops forever returns `never`; a normal no-result function returns `void`. After a `never` call, control flow cannot continue, but do not use it to hide a reachable missing-return bug.

A discriminated union gives every variant one shared literal field. After all variants are handled, the remainder narrows to `never`:

```ts
function assertNever(value: never): never {
  throw new Error(`Unexpected value: ${JSON.stringify(value)}`);
}

function render(result: Result) {
  switch (result.status) {
    case "loading": return "Loading";
    case "success": return String(result.data);
    case "error": return result.error.message;
    default: return assertNever(result);
  }
}
```

Adding a union member now produces a compile-time error until the switch is extended, while the throw still protects runtime trust boundaries. Literal, required discriminants give the strongest narrowing; broad casts can bypass it.

When a runtime helper is unnecessary, a local `const exhaustive: never = value` performs the compile-time check; some codebases use `value satisfies never`. Keep the throwing form where untrusted runtime data can violate the static model.

Plain unions can use `in`, `typeof`, `instanceof`, or custom predicates, but overlapping optional fields are fragile. Prefer a discriminant for states, commands, results, reducers, and serialized events, and validate external JSON before treating it as the union.

## Sources
- Workspace: `_ai-conspects/never type, exhaustion check with discriminated union/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
