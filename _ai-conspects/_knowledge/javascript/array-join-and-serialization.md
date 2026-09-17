# JavaScript array join and serialization boundaries

Knowledge ID: `javascript.array-join-and-serialization`

Topic: `javascript`

`join` converts each element to text and inserts a separator:

```js
const numbers = [1, 2, 3, 4, 5];
numbers.join();    // "1,2,3,4,5"
numbers.join(" "); // "1 2 3 4 5"
numbers.join("-"); // "1-2-3-4-5"
numbers.join("");  // "12345"
```

For arrays, `toString()` behaves similarly to `join(",")`, but `join` communicates and controls separator intent.

Format elements before joining when needed:

```js
const text = numbers
  .map(value => `(${value})`)
  .join(" ");
```

`JSON.stringify(numbers)` produces `"[1,2,3,4,5]"` and preserves array structure for storage/protocols. `join` produces human-readable delimited text, not JSON.

Undefined, null, and missing slots become empty fields:

```js
[1, undefined, null, 4].join(","); // "1,,,4"
```

Normalize explicitly when empty fields are not intended.

## What should be recallable

- Default/custom/empty separators and element-to-text conversion.
- Array `toString` comparison and `map + join` formatting.
- Delimited text versus JSON structure.
- Sparse/null/undefined empty-field behavior.

## Sources

- Workspace: `_ai-conspects/string join/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/string join.svg`
