# Portable Set algebra

Knowledge ID: `javascript.set-algebra`

Topic: `javascript`

## Core model

Portable set operations can be built from iteration, construction, filtering, and membership checks.

```ts
function union<T>(a: Set<T>, b: Set<T>): Set<T> {
  return new Set([...a, ...b]);
}

function intersection<T>(a: Set<T>, b: Set<T>): Set<T> {
  return new Set([...a].filter((value) => b.has(value)));
}

function difference<T>(a: Set<T>, b: Set<T>): Set<T> {
  return new Set([...a].filter((value) => !b.has(value)));
}
```

A symmetric difference contains members found in either input but not both:

```ts
function symmetricDifference<T>(a: Set<T>, b: Set<T>): Set<T> {
  return new Set([
    ...[...a].filter((value) => !b.has(value)),
    ...[...b].filter((value) => !a.has(value)),
  ]);
}
```

A subset test checks that every member of one set exists in the other:

```ts
function isSubsetOf<T>(a: Set<T>, b: Set<T>): boolean {
  return [...a].every((value) => b.has(value));
}
```

To compare two sets by value, compare their sizes and membership rather than using `===`.

## What should be recallable

- How are union, intersection, and difference expressed with standard iterable operations?
- What distinguishes difference from symmetric difference?
- What condition establishes that one set is a subset of another?
- How should two sets be compared by their members?

## Sources

- Workspace: `_ai-conspects/set js/`
- Processed source: `01-final-transcript.md`, R03 — portable set operations
- Original SVG: `source/set js.svg`
