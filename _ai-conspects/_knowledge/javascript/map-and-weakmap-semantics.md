# JavaScript Map and WeakMap semantics

Knowledge ID: `javascript.map-and-weakmap-semantics`

Topic: `javascript`

`Map` preserves insertion order and supports `set/get/has/delete/clear/size`; `set` returns the same Map for chaining, `get` returns value or `undefined`, `has` distinguishes missing from stored `undefined`, `delete` reports whether an entry existed, and `clear` returns `undefined`. Iteration exposes entries/keys/values; `forEach` receives value then key. Same-value-zero equality compares object keys by reference.

```js
const map = new Map([["a", 1]]);
for (const [key, value] of map) { }
const fromObject = new Map(Object.entries(inputObject));
const outputObject = Object.fromEntries(map);
```

Object conversion cannot faithfully round-trip arbitrary Map keys, and `JSON.stringify(new Map())` does not serialize entries automatically.

`WeakMap` accepts object keys weakly: entries may disappear after no strong key reference remains. It intentionally has no size, iteration, key/value/entry enumeration, or clear because those expose GC timing. Use it for object-lifetime metadata, private state, memoization, and caches that must not retain keys. Weakness applies to keys.

Map has no public initial-capacity constructor. Creating a million placeholder pairs creates a million real entries.

Counting and grouping reuse the stored value or initialize a default:

```js
map.set(key, (map.get(key) ?? 0) + 1);

const bucket = map.get(groupKey) ?? [];
bucket.push(item);
map.set(groupKey, bucket);
```

## Sources

- Workspace: `_ai-conspects/map and weakmap js/`
- Processed source: `01-final-transcript.md`, complete transcript and examples
