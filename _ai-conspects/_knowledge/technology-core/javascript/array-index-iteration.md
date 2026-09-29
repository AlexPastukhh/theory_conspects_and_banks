# JavaScript array index iteration

Knowledge ID: `javascript.array-index-iteration`

Topic: `javascript`

`Array.prototype.entries()` yields `[index, value]` pairs. Destructure them in `for...of` when both are needed:

```js
const arr = ["a", "b", "c"];

for (const [index, value] of arr.entries()) {
  console.log(`Index ${index}: ${value}`);
}
```

The numeric indexes are `0`, `1`, and `2`, paired with `a`, `b`, and `c`. This resembles a `foreach` loop while retaining the array position without a manual counter.

`arr.keys()` yields numeric array indexes only:

```js
for (const index of arr.keys()) {
  console.log(`Index ${index}: ${arr[index]}`);
}
```

Use `entries()` when both position and value are central; use `keys()` when the index drives a separate lookup or operation.

`for...in` is different:

```js
for (const index in arr) {
  console.log(`Index ${index}: ${arr[index]}`);
  // index is a string
}
```

It enumerates enumerable property keys as strings and can include additional enumerable properties. It is therefore normally avoided for ordinary array-value iteration.

## What should be recallable

- What `entries()` yields and how destructuring exposes numeric index and value.
- What `keys()` yields and why array lookup is still needed.
- Why `for...in` keys are strings and may include non-element enumerable properties.
- How to choose `entries()`, `keys()`, or another value-oriented loop.

## Sources

- Workspace: `_ai-conspects/js loops, for, for of, entries, index, for in/`
- Processed source: `01-source-preserving-transcript-v001.md`, S-001–S-002
- Original SVG: `source/js loops, for, for of, entries, index, for in.svg`
- Workspace: `_ai-conspects/js iterate, index/`
- Authoritative reconstructed source: `regions/R01-array-index-iteration-final-transcript-v001.md`, complete transcript
- Original SVG: `source/js iterate, index.svg`
