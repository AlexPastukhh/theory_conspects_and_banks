# JavaScript array creation, holes, and fixed storage

Knowledge ID: `javascript.array-creation-holes-and-fixed-storage`

Topic: `javascript`

Prefer literals for ordinary arrays. `Array()` and `new Array()` are functionally equivalent. Their single-number form is special: `new Array(5)` creates five holes, not `[5]`; use `Array.of(5)` for one numeric element.

`Array.from(source, mapper)` creates an array from an iterable or array-like input and can map while creating. `{ length: n }` is one useful array-like source for initialized values and ranges:

```js
const values = Array.from({ length: 5 }, (_, index) => index);
const characters = Array.from("hello");
```

Holes read as `undefined` but are not own properties, and methods such as `map`, `forEach`, and `filter` skip them. Serialization and equality-related behavior can also differ from arrays containing explicit `undefined`. `fill(0)` initializes primitives, but `Array(3).fill([])` repeats one shared reference. Create independent rows with a factory:

```js
const matrix = Array.from(
  { length: rows },
  () => Array.from({ length: cols }, () => 0));
```

Normal arrays remain resizable regardless of initial length. Typed arrays such as `Uint8Array(16)` have fixed numeric element counts and zero initialization; an outer normal array of typed rows can still resize. `Object.freeze` prevents structural mutation of one normal array object but is not deep fixed-size numeric storage.

## Sources
- Workspace: `_ai-conspects/create array, fixed length/`
- Processed source: `regions/final-transcript.md`, complete transcript
