# Array flattening depth and semantics

Knowledge ID: `javascript.array-flat`

Topic: `javascript`

## Core model

`Array.prototype.flat()` creates a new shallow array by flattening nested arrays to a chosen depth. The default is one level, and the source array is not modified.

```js
const source = [1, [2, [3, 4]], 5];

source.flat();          // [1, 2, [3, 4], 5]
source.flat(2);         // [1, 2, 3, 4, 5]
source.flat(Infinity);  // [1, 2, 3, 4, 5]
```

`flat(0)` returns a shallow copy without flattening nested arrays. Only actual array elements are flattened; an ordinary iterable or array-like value is not expanded merely because it is iterable.

Sparse holes are removed at levels being flattened. Nested objects are not deep-cloned, so their references remain shared.

## Choosing depth

Prefer a known numeric depth when the data contract has a predictable shape. `Infinity` can hide unexpectedly deep or malformed structures, and flattening is inappropriate when nesting carries domain meaning.

## What should be recallable

- What depth does `flat()` use by default?
- What do `flat(0)`, `flat(2)`, and `flat(Infinity)` mean?
- Which values are eligible for flattening?
- Why is the result not a deep clone?
- When can flattening destroy meaningful structure?

## Related knowledge

- `javascript.array-flatmap` — mapping followed by exactly one level of flattening.

## Sources

- Workspace: `_ai-conspects/FLAT FLATMAP/`
- Processed source: `05-full-combined-final-transcript.md`, R01
- Original SVG: `source/FLAT FLATMAP.svg`
