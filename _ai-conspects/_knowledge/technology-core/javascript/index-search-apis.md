# JavaScript index and search APIs

Knowledge ID: `javascript.index-search-apis`

Topic: `javascript`

For arrays, `indexOf(value)` returns the first matching index or `-1` and uses strict equality. It fits known primitive values:

```js
const arr = ["a", "b", "c", "b"];
arr.indexOf("b"); // 1
```

Use `findIndex(predicate)` when matching a condition or object property:

```js
const users = [{ id: 1 }, { id: 2 }];
users.findIndex(user => user.id === 2); // 1
```

It also returns `-1` when no element satisfies the predicate.

For strings, `indexOf(substring)` returns the first literal position or `-1`; `includes(substring)` returns only a boolean:

```js
const text = "hello world";
text.indexOf("o"); // 4
text.includes("o"); // true
```

`search` is intended for regular-expression matching and returns the match index or `-1`:

```js
text.search(/o/); // 4
```

JavaScript also accepts a non-RegExp argument and converts it to `RegExp`; therefore the source claim that it *must* receive regex is too strict. Still prefer `indexOf` for a literal substring and `search` when regex semantics are intended.

## What should be recallable

- Array `indexOf` strict-equality/value use versus predicate-based `findIndex`.
- Not-found result and the object example.
- String `indexOf` position versus `includes` boolean.
- Regex-oriented `search`, its return value, and the corrected non-RegExp behavior.

## Sources

- Workspace: `_ai-conspects/find index array string/`
- Processed source: `01-source-preserving-transcript-v001.md`, S-001–S-002
- Original SVG: `source/find index array string.svg`
