# Runtime, compiler, and SDK responsibilities

Knowledge ID: `architecture.runtime-compiler-and-sdk-responsibilities`

Topic: `architecture`

A runtime executes produced code and supplies execution-time services such as loading, memory management, garbage collection, JIT or interpreter behavior, threading, and platform integration.

A compiler transforms source or an intermediate representation and reports compile-time diagnostics. Compilation can be ahead of time, just in time, or part of a hybrid pipeline. A compiler error prevents or changes produced output; a runtime error occurs while that output executes.

An SDK/toolchain is broader than the runtime. It can include compilers, build commands, templates, package restore, analyzers, and development tooling. Installing only a compatible runtime can be sufficient to execute deployed output but is not necessarily enough to build its project.

Compatibility must be checked across the produced artifact, its target/runtime, and the SDK that builds it. A different SDK/runtime combination in deployment is one cause of “works on my machine.”

The same division applies in JavaScript systems: an engine/runtime executes JavaScript, while type checkers, transpilers, and bundlers validate or transform it during the build.

## What should be recallable

- Which responsibilities belong to a runtime, a compiler, and an SDK?
- How do compile-time and runtime failures differ?
- Why can a machine run an application but still be unable to build it?
- Which version boundaries must deployment compatibility consider?

## Sources

- Workspace: `_ai-conspects/server browser threads,memory, webworkers , runtime vs compiler , es/`
- Authoritative processed source: `regions/R05-runtime-versus-compiler-and-sdk-toolchain-responsibilities.md`
- Original SVG: `source/server browser threads,memory, webworkers , runtime vs compiler , es.svg`
