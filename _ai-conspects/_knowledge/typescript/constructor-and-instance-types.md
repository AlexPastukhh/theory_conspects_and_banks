# Constructor and instance types

Knowledge ID: `typescript.constructor-and-instance-types`

Topic: `typescript`

In TypeScript, `ClassName` in a type position is the instance shape; `typeof ClassName` is the runtime constructor/static side, including `new` and statics.

```ts
function make<C extends new (...args: any[]) => any>(
  Ctor: C,
  ...args: ConstructorParameters<C>
): InstanceType<C> {
  return new Ctor(...args);
}
```

`ConstructorParameters<C>` preserves the argument tuple; `InstanceType<C>` is the object produced by constructor type `C`. If a generic already represents the instance (`new (...) => T`), return `T` directly.

In C#, `T` normally denotes the instance; `where T : new()` permits only parameterless `new T()`. Arbitrary constructor signatures are not generic constraints: prefer typed factory delegates, use DI for registered services, and reserve `Activator.CreateInstance` reflection for genuinely dynamic runtime-checked construction.

## Sources
- Workspace: `_ai-conspects/ctor type and instance type/`
- Processed source: `regions/final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/utility types/`
- Authoritative processed source: `01-final-transcript.md`, R02
- Original SVG: `source/utility types.svg`
