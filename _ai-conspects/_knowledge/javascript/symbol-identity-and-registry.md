# JavaScript Symbol identity and registry

Knowledge ID: `javascript.symbol-identity-and-registry`

Topic: `javascript`

Every `Symbol()` call creates a distinct primitive even when descriptions match; the description is debugging metadata, not identity. Symbols are collision-resistant property keys, but not secret: retrieve them with `Object.getOwnPropertySymbols` or `Reflect.ownKeys`. Ordinary `Object.keys`, `for...in`, and JSON serialization skip symbol-keyed properties.

```js
const internalId = Symbol("internalId");
const user = { name: "Alex", [internalId]: 42 };
Object.keys(user); // ["name"]
user[internalId];  // 42
```

`Symbol.for(key)` retrieves or creates a shared identity in the runtime-global registry; repeated calls with the same string return the same symbol, and `Symbol.keyFor` returns a registered key. Plain symbols are not registered. Use namespaced registry keys for cross-module protocols and local symbols when sharing is unnecessary. Well-known symbols such as `Symbol.iterator` define language protocols. Registry keys are neither private nor a place for secrets.

## Sources
- Workspace: `_ai-conspects/symbol/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
