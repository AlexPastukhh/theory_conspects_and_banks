# C# by-reference parameters, aliases, and lifetimes

Knowledge ID: `dotnet.byref-parameters-aliases-and-lifetimes`

Topic: `dotnet`

## Values versus storage aliases

A normal parameter receives a copy of its argument value. For a class, that copied value is an object reference; for a struct, the struct data is copied.

```text
normal -> copied value, no alias to caller variable
ref    -> initialized caller storage, callee reads/writes
in     -> initialized caller storage, readonly by-reference intent
out    -> caller need not initialize, callee must assign
```

Passing a large struct with `in` or `ref` can avoid copying, but by-reference indirection is not an automatic win for tiny primitives; measure hot paths.

## `ref`, `in`, and aliases

`ref` shares one variable storage. The caller must definitely assign it, both sides use `ref`, and callee writes change the caller's variable.

```csharp
static void Increment(ref int value) => value++;
int number = 10;
Increment(ref number);
```

`in` supplies initialized storage for readonly access. For a non-readonly struct, calling a mutating member through an `in`/readonly reference can create a defensive copy. Readonly structs and readonly members reduce that surprise.

A normal property or value-returning indexer is a value, not a storage location, so it cannot normally be passed to `ref`/`out`. Copy it to a local or expose an intentional ref return. Arrays expose element storage; other collections need an explicit ref-returning API.

```csharp
ref int alias = ref array[index];
alias = 42; // updates that array slot
```

Ref returns and ref locals alias existing storage rather than copy it. The storage must outlive the alias; the compiler prevents returning a reference to a local that will disappear.

## `out` and the Try pattern

An `out` parameter is produced by the callee. Its previous caller value is irrelevant, it must be assigned on every successful return path, and the call site uses `out`.

```csharp
if (int.TryParse(text, out var number)) { }
if (int.TryParse(text, out _)) { }
```

The strongest fit is `Try...`: the Boolean reports success and `out` carries the result. Interop/low-level APIs also use it. For several ordinary meaningful return values, a tuple or result type is often clearer than multiple `out` parameters.

## What should be recallable

- What gets copied for normal struct and class parameters?
- Which definite-assignment/read/write rules distinguish `ref`, `in`, and `out`?
- Why can a readonly reference to a mutable struct create a defensive copy?
- Why can ordinary properties not be passed as storage aliases?
- Which lifetime rule governs ref returns and locals?
- When is the success-plus-result Try pattern preferable to a tuple/result object?

## Sources

- Workspace: `_ai-conspects/ref in out/`
- Authoritative processed source: `regions/R01R02R03-final-coverage-transcript.md`, R01–R03
- Original SVG: `source/ref in out.svg`
