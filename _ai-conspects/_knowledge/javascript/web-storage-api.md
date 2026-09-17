# Web Storage API and string serialization

Knowledge ID: `javascript.web-storage-api`

Topic: `javascript`

## Core model

`localStorage` and `sessionStorage` expose the same synchronous `Storage` API:

```js
storage.setItem(key, value);
storage.getItem(key);       // string | null
storage.removeItem(key);
storage.clear();
storage.key(index);         // string | null
storage.length;
```

Every stored value is a string. Encode numbers and booleans deliberately; serialize structured values with JSON.

```js
localStorage.setItem("user", JSON.stringify(user));

const raw = localStorage.getItem("user");
const restored = raw ? JSON.parse(raw) : null;
```

`getItem()` can return `null`, and `JSON.parse()` can throw for corrupt, manually edited, or outdated data. A safe reader handles both and returns a chosen fallback.

The API is synchronous, so large or frequent operations can block the main thread. Use Web Storage for small values, not large datasets or high-throughput caches.

## What should be recallable

- Which operations form the shared `Storage` API?
- What type does `getItem()` return?
- Why must structured values be serialized explicitly?
- Which two failures must a safe JSON reader handle?
- Why should stored data remain small?

## Related knowledge

- `javascript.browser-storage-lifetimes-and-security` — selecting memory, session, or persistent storage.
- `javascript.web-storage-events-and-failures` — cross-tab notifications and write failures.

## Sources

- Workspace: `_ai-conspects/memory vs localstorage vs sessionstorage, session storage and local storage api methods/`
- Processed source: `01-final-transcript.md`, R01 and API/helper material from R03
- Original SVG: `source/memory vs localstorage vs sessionstorage, session storage and local storage api methods.svg`
