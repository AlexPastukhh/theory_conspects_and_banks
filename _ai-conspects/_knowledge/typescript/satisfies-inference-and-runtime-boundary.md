# TypeScript satisfies, inference, and runtime boundary

Knowledge ID: `typescript.satisfies-inference-and-runtime-boundary`

Topic: `typescript`

An annotation (`const value: Target = expression`) checks the expression and then exposes the variable as `Target`, potentially widening or hiding specific property information. `expression satisfies Target` checks assignability while preserving the expression's useful inferred shape; object literals still receive missing/extra/misspelled-property diagnostics.

```ts
const routes = {
  home: { path: "/", auth: false },
  profile: { path: "/profile", auth: true },
} as const satisfies Record<RouteName, RouteConfig>;

routes.profile.path; // "/profile"
```

Use annotations when a variable/public field should intentionally expose an abstraction, and `satisfies` for configuration/maps needing both contract validation and precise keys/literals. `as const` preserves readonly literals but may be unsuitable for mutable configuration; broad index signatures weaken typo detection. Contextual typing can still influence inferred members.

`satisfies` is not an assertion or runtime check. `as Type` can override compiler knowledge; JSON, network data, and environment variables remain untrusted and need schema/parser validation. Functions normally use explicit parameter/return types, and mutable values may need intentional widening.

The operator requires TypeScript 4.9+ syntax support. Align IDE, build, lint, and dependency parsers; an older parser may reject syntax even if `tsc` accepts it. Critical public APIs may need type tests because compiler upgrades can adjust inference details.

## Sources
- Workspace: `_ai-conspects/typescript explicit type annotations vs satisfies/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
