# One-to-many transformations with flatMap

Knowledge ID: `javascript.array-flatmap`

Topic: `javascript`

## Core model

`flatMap` applies a callback to every input and flattens the callback results by exactly one level. Conceptually it is `array.map(callback).flat(1)` without requiring the same explicit intermediate mapped array.

The callback can produce:

```text
one value       -> one-to-one mapping;
an array        -> one-to-many mapping;
an empty array  -> remove that input from the output.
```

```js
const values = [1, 2, 3, 4];

values.flatMap(value =>
  value % 2 === 0 ? [value, value * 10] : []
);
// [2, 20, 4, 40]
```

Nested arrays inside a returned segment are not recursively flattened. Use an additional `flat`, a recursive algorithm, or another explicit transformation for deeper structures.

## Reasoning and combinations

Reason about each callback result as the output segment contributed by one source element, then concatenate those segments in source order.

```js
const variants = colors.flatMap(color =>
  sizes.map(size => ({ color, size }))
);
```

Here the inner `map` creates one array of variants per color, and the outer `flatMap` removes that single array level.

## Alternatives

Use `flatMap` when its one-level semantics match the transformation. Use `reduce` for a more general accumulator and a direct loop when branching is complex or measurements justify tighter control. Repeated `concat` can allocate a new array each iteration.

## What should be recallable

- How is `flatMap` related to `map(...).flat(1)`?
- How can its callback express zero, one, or many outputs?
- Why is it not a recursive flattening API?
- How does nested `flatMap`/`map` express combinations?
- When are `reduce` or a loop clearer alternatives?

## Related knowledge

- `javascript.array-flat` — explicit flattening depth and shallow-copy behavior.

## Sources

- Workspace: `_ai-conspects/FLAT FLATMAP/`
- Processed source: `05-full-combined-final-transcript.md`, R02–R04
- Original SVG: `source/FLAT FLATMAP.svg`
