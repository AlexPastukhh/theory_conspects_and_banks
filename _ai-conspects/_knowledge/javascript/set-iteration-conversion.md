# Set iteration and conversion

Knowledge ID: `javascript.set-iteration-conversion`

Topic: `javascript`

## Core model

A `Set` is iterable in insertion order, but it has no numeric indexing. Use direct iteration for membership-oriented work and convert to an array when indexed access or array-specific operations are needed.

```ts
for (const value of set) {
  // insertion order
}

set.forEach((value) => {});
set.values();
set.keys();    // yields the same values
set.entries(); // yields [value, value]
```

`set[0]` does not retrieve the first member.

## Conversion patterns

```ts
const array = [...set];
const unique = [...new Set(array)];
const joined = [...set].join(", ");
```

The spread conversion exposes array indexing and transformations; constructing a `Set` from an array removes duplicate values according to Set membership semantics.

## What should be recallable

- In what order does a `Set` iterate?
- What do `values`, `keys`, and `entries` yield for a `Set`?
- How do you convert a `Set` to an array or deduplicate an array?
- Why does `set[0]` not provide indexed access?

## Sources

- Workspace: `_ai-conspects/set js/`
- Processed source: `01-final-transcript.md`, R02 — iteration and conversion
- Original SVG: `source/set js.svg`
