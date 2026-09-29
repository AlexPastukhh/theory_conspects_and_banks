# JavaScript Set basics and value identity

Knowledge ID: `javascript.set-basics`

Topic: `javascript`

## Core model

A JavaScript `Set` stores unique values and retains their insertion order. It is useful when uniqueness and membership are part of the data model.

```ts
const empty = new Set<number>();
const values = new Set([1, 2, 2, 3]); // {1, 2, 3}
```

The basic API is:

```ts
set.add(value);      // returns the same Set
set.has(value);      // boolean
set.delete(value);   // boolean
set.clear();         // undefined
set.size;            // number
```

Because `add` returns the same set, calls can be chained.

## Value identity

Set membership uses same-value-zero semantics. Object values are compared by reference, not by their structural content. Likewise, `a === b` compares the identities of two `Set` objects; it does not compare their members.

## What should be recallable

- How do you create an empty typed `Set` and a `Set` from an array?
- Which operations add, test, remove, and clear members, and what do they return?
- Why can two structurally identical objects both occur in one `Set`?
- Why does `a === b` not test whether two sets have equal members?

## Sources

- Workspace: `_ai-conspects/set js/`
- Processed source: `01-final-transcript.md`, R01 — creation and basic operations
- Original SVG: `source/set js.svg`
