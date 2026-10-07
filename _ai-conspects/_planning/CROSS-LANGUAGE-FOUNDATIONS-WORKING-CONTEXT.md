# Cross-Language Foundations — Working Context

Status: **temporary working context** for comparative learning across C#/.NET, TypeScript/JavaScript, Go, and Rust.

This file is intentionally non-authoritative. It is not a Knowledge Unit, Coverage owner, Question registry, Repetition item, or replacement for `EXPANSION_MAP.md`. It may be revised or removed once the learning direction has produced durable knowledge and the temporary curriculum context is no longer useful.

## Purpose

Learn the four language/platform models in parallel around shared engineering problems rather than as four isolated syntax courses.

Current comparison set:

- **C# / .NET** — language plus CLR/.NET runtime where runtime semantics matter;
- **TypeScript / JavaScript** — TypeScript type-system behavior must be separated from JavaScript runtime behavior; Browser/Node are introduced only where the execution environment matters;
- **Go** — language, standard toolchain, and Go runtime where the model is runtime-defined;
- **Rust** — language/toolchain plus explicit ecosystem/runtime dependencies where the language itself does not define the execution model (notably async executors).

Go and Rust are already selected expansion directions in `EXPANSION_MAP.md`. This file only gives the current comparative order for learning them alongside C# and TypeScript.

## Comparison rules

For every block:

1. Start with the underlying engineering problem or semantic responsibility.
2. Describe each language/platform model on its own terms before mapping analogies.
3. Distinguish:
   - genuine analogue;
   - partial analogue;
   - same surface, different underlying model;
   - `NO_USEFUL_DIRECT_EQUIVALENT`;
   - `NOT_APPLICABLE`.
4. Ask four recurring questions:
   - What does the compiler/type system guarantee?
   - What does the runtime/platform provide?
   - What remains programmer responsibility?
   - When and how does failure become observable?
5. Compare practical consequences, not only syntax.
6. Do not create durable Knowledge Units or repetition history merely because a block was studied. Durable material follows the normal learning/triage/materialization path when it is worth retaining.

## Foundations pass

### 0. Execution and toolchain model

Establish what actually runs before comparing language syntax.

Compare:

- source → compile/transpile/build → executable/runtime form;
- CLR/JIT/AOT boundaries in .NET;
- TypeScript erasure and JavaScript runtime ownership;
- Go native binaries plus Go runtime;
- Rust native compilation and where ecosystem runtimes are optional rather than language-defined;
- basic package/build tools: `dotnet`, `npm`/`tsc`, `go`, `cargo`.

Key question: **which behavior belongs to the language, compiler, runtime, standard library, or external ecosystem?**

### 1. Values, variables, types, and mutability

Compare:

- basic values and type inference;
- value/reference/object semantics;
- copy vs alias vs move;
- mutable vs immutable bindings;
- constants;
- assignment and equality/identity at a foundational level.

Important boundary: do not collapse C# value/reference types, JavaScript object references, Go value/pointer behavior, and Rust move/Copy semantics into one model.

### 2. Control flow and data shapes

Compare:

- conditionals and loops;
- `switch` / pattern matching;
- object/class/struct/record-like modeling;
- enums and tagged/discriminated alternatives;
- where data shape is nominal, structural, algebraic, or convention-driven.

### 3. Functions and methods

Compare:

- parameters and returns;
- methods vs free functions;
- first-class functions;
- lambdas at a basic level;
- tuples/multiple values and Go multiple returns;
- pass-by-value semantics and what the passed value actually represents in each model.

Deep closure/capture semantics are deferred until after memory/lifetime foundations.

### 4. Type abstraction and polymorphism

Compare:

- C# interfaces and generics;
- TypeScript structural typing and generics;
- Go implicit interface satisfaction and generics;
- Rust traits and generics;
- static vs dynamic dispatch where relevant;
- constraints/bounds;
- compile-time vs runtime representation.

Key question: **what must a type explicitly declare, and what can be satisfied structurally or implicitly?**

### 5. Absence and failure

Study absence and failure together because the languages make different choices about both.

Compare:

- C# nullable values/references and exceptions;
- TypeScript `null` / `undefined`, thrown errors, and promise rejection;
- Go `nil`, zero values, `error`, and multiple-return propagation;
- Rust `Option<T>`, `Result<T, E>`, `?`, and panic boundaries.

Key distinction: recoverable domain/operation failure vs programmer invariant failure vs process/runtime failure.

### 6. Memory, reachability, ownership, and lifetimes

This is a major comparison block.

Compare:

- C# GC, references, value types, reachability;
- JavaScript GC and object/reference reachability behind TypeScript;
- Go GC, pointers, escape behavior at a conceptual level;
- Rust ownership, borrowing, moves, `Copy`, and lifetimes;
- aliasing and mutation constraints;
- stack/heap only as implementation-relevant concepts, without treating them as the language-level ownership model.

Key question: **who is responsible for proving that a value/resource remains valid for each use?**

### 7. Deterministic resource lifetime

Keep resource cleanup separate from ordinary memory reclamation.

Compare:

- C# `IDisposable` / `using`;
- TypeScript/JavaScript API-specific cleanup and explicit lifecycle patterns;
- Go `defer` and explicit `Close` conventions;
- Rust RAII / `Drop` and ownership-driven cleanup.

Use files, sockets, locks, and other external resources as examples.

### 8. Closures and captured state

Now that value/ownership models are established, compare:

- captured variables and mutation;
- lifetime of captured state;
- loop/capture pitfalls where relevant;
- Rust `Fn` / `FnMut` / `FnOnce` and `move` closures;
- what is compiler-enforced vs runtime/convention behavior.

### 9. Collections and iteration

Compare:

- arrays and sequence-like structures;
- slices/views where relevant;
- maps/dictionaries;
- iteration protocols;
- lazy/eager transformations;
- LINQ, JavaScript iterables/array APIs, Go `range`, Rust iterators;
- ownership/copy/allocation consequences where they materially differ.

### 10. Modules, packages, visibility, and dependencies

Compare:

- namespaces/modules/packages/crates;
- imports/use statements;
- visibility/export rules;
- package identity and dependency resolution;
- project/workspace structure;
- NuGet, npm, Go modules, Cargo/crates at a foundational level.

### 11. Concurrency and parallel execution

Start with execution units before async I/O.

Compare:

- concurrency vs parallelism;
- C#/.NET threads, ThreadPool, Tasks as distinct concepts;
- JavaScript event-loop execution and Workers;
- Go goroutines and runtime scheduling;
- Rust OS threads and synchronization primitives;
- scheduler/runtime ownership and race possibilities.

Do not treat `Task`, `Promise`, goroutine, and `Future` as equivalent abstractions.

### 12. Synchronization, communication, and bounded work

Compare:

- mutex/lock-style coordination;
- atomics at a foundational level;
- channels/message passing;
- queues;
- bounded concurrency and backpressure;
- shared-state vs message-passing tradeoffs.

Allow missing direct analogues. A construct does not need to exist as a language primitive in every ecosystem.

### 13. Async I/O and asynchronous composition

Only after concurrency basics, compare:

- C#/.NET `Task` + `async`/`await` and asynchronous I/O ownership;
- JavaScript `Promise` + event loop and `async`/`await`;
- Go blocking-looking APIs over goroutine/runtime scheduling where appropriate;
- Rust `Future`, polling, executors, and the fact that executor/runtime choice is not fully defined by the language.

Key question: **what starts work, what represents eventual completion, and what actually owns scheduling/progress?**

### 14. Cancellation, time bounds, and failure propagation

Compare:

- .NET `CancellationToken`;
- JavaScript `AbortSignal` / environment-specific cancellation;
- Go `context.Context` and deadlines;
- Rust cooperative cancellation patterns, dropping futures/tasks, and runtime/ecosystem-specific mechanisms;
- timeouts;
- child-work ownership;
- structured-concurrency ideas where supported.

Do not invent a universal cancellation primitive where the ecosystem does not define one.

## Second layer — engineering manifestations

After the foundations pass, compare these as separate engineering topics rather than language fundamentals:

- filesystem and stream I/O;
- serialization/schema behavior;
- HTTP client and connection semantics;
- application/service startup and shutdown;
- request pipelines and backend hosting;
- testing strategy/tooling;
- debugging and profiling;
- logging/metrics/tracing;
- FFI/native boundaries;
- deployment/runtime packaging where useful.

These should follow the generic engineering responsibility first and then relevant manifestations.

## Applicability comparison

Maintain a separate synthesis pass for **where each language/platform is a natural fit**, without turning it into a universal ranking.

Compare dimensions such as:

- browser suitability;
- backend/service suitability;
- infrastructure/network-service suitability;
- systems/native suitability;
- runtime richness;
- GC dependency;
- memory/resource control;
- compile-time guarantees;
- concurrency model;
- startup/deployment characteristics;
- FFI/native integration;
- ecosystem/framework depth;
- operational simplicity;
- cost of correctness and learning complexity.

For every applicability claim, state the workload/property that makes the language a good or poor fit. Avoid conclusions of the form “language X is simply better.”

## Working session format

For an individual study session, use a small slice rather than attempting the entire block at once:

```text
Underlying problem
→ C#/.NET model
→ TypeScript/JavaScript model
→ Go model
→ Rust model
→ shared ideas
→ partial analogies
→ non-equivalences
→ practical consequence
→ questions/gaps discovered
```

When useful, implement the **same small task** in all four languages and run/build/test it locally. Code comparison should verify the semantic model rather than replace it.

## Temporary-context exit condition

This file has served its purpose when the comparative direction is stable enough that day-to-day learning can be driven directly by durable Knowledge Units, comparison Units, Coverage/Expansion, and ordinary learning batches.

At that point, either delete this file or reduce it to a small pointer. Do not preserve it merely because it once existed.
