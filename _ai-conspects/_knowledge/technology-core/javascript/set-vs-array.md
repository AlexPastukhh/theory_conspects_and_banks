# Choosing Set or Array

Knowledge ID: `javascript.set-vs-array`

Topic: `javascript`

## Core model

Choose a `Set` when uniqueness, repeated membership checks, incremental insertion or deletion, or set-algebra operations are central. Choose an `Array` when numeric indexing, duplicates, sorting, array transformations, or a compact ordered sequence are central.

Set membership is typically optimized for efficient lookup, whereas an array membership check such as `includes` requires a scan. The useful choice follows the required invariant rather than syntax alone.

## Scaling detail

When two sets differ greatly in size, iterate the smaller one for intersection and subset-style checks to reduce work.

A `Set` limits membership duplication but does not automatically provide indexed access or array methods; convert it when those capabilities are required.

## What should be recallable

- Which requirements point toward a `Set`, and which point toward an `Array`?
- Why is a `Set` usually preferable for repeated membership checks?
- Why can iterating the smaller set reduce work in intersection or subset checks?
- When should a `Set` be converted to an array?

## Sources

- Workspace: `_ai-conspects/set js/`
- Processed source: `01-final-transcript.md`, R04 — performance and use cases
- Original SVG: `source/set js.svg`
