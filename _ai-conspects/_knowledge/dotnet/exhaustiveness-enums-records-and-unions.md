# Exhaustiveness with enums, records, and explicit unions

Knowledge ID: `dotnet.exhaustiveness-enums-records-and-unions`

Topic: `dotnet`

An enum switch expression without a discard arm can keep omitted named cases visible to compiler/analyzer diagnostics. If no arm matches at runtime, it normally throws `SwitchExpressionException`. Enums can still contain unnamed underlying numeric values, and diagnostics depend on compiler/analyzer configuration.

A throwing `_` arm provides deliberate runtime failure and useful argument information, but it matches everything. Adding a later named enum member no longer makes that switch non-exhaustive, so the compile-time omission signal is lost. Choose between missing-case visibility and controlled unknown-value handling, reinforced by tests/analyzers at trust boundaries.

An abstract base record plus derived records carries case-specific payloads and enables type-pattern switches, but ordinary inheritance is open: the compiler does not generally know the complete global subtype set. A new subtype therefore need not create a new diagnostic. Control the construction boundary or use analyzers/source generators/library union types for stronger closure.

An explicit `OneOf<A,B,C>`-style library makes the finite case list part of the type, at the cost of a dependency. Record hierarchies, enum switches, and explicit unions provide different closure guarantees rather than interchangeable syntax.

## Sources
- Workspace: `_ai-conspects/exaustiveness check with sicr union for enums,classes with inher/`
- Processed source: `05-source-preserving-transcript-v002.md`, complete transcript

