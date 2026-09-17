# TypeScript decorator wrapping and semantics

Knowledge ID: `typescript.decorator-wrapping-and-semantics`

Topic: `typescript`

Decorators run when declarations are processed, not per instance. Class/method/accessor/property/parameter signatures and replacement powers differ; legacy TypeScript and modern ECMAScript models/configuration must not be mixed. Metadata emission is separate and may require a runtime shim.

A legacy method wrapper stores `descriptor.value` and calls `original.apply(this,args)` to preserve receiver/arguments; arrow wrappers often break instance `this`. The descriptor may be mutated or returned according to the chosen pattern; preserve its flags and the method's type contract. Runtime decorator validation complements but cannot replace compile-time type checking. Async logging must observe completion/rejection, and must not leak secrets/PII.

Decorator expressions evaluate top-to-bottom and decorator functions apply bottom-to-top. Legacy class processing also has defined phases: parameter decorators precede the corresponding member decorator, instance members are processed before static members, constructor parameter decorators follow, and the class decorator is applied last. Keep order-dependent stacks small and documented.

Class decorators may replace constructors while preserving prototype/statics; method/accessor decorators replace descriptors. Legacy property/parameter decorators mainly record metadata and ignore returns. Keep business flow visible, test normal invocation/composition order, and expect legacy-to-modern migration may require redesign.

## Sources
- Workspace: `_ai-conspects/decorator/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
