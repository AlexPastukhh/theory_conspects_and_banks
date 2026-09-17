# Type aliases, unions, and interfaces

Knowledge ID: `typescript.type-aliases-unions-and-interfaces`

Topic: `typescript`

Interfaces describe object/call/construct shapes and support extension/declaration merging. Their properties may use unions, but an interface cannot itself equal a union, primitive, tuple, conditional, or mapped expression. A `type` alias can name any such expression and can also describe an object.

```ts
interface Guitarist { albums: (string | number)[]; }
type Id = string | number;
```

Parentheses matter: `(string | number)[]` is an array of mixed elements; `string | number[]` is one string or an array of numbers. Aliasing an alias creates another structural name, not a new nominal incompatible type. Prefer interface for extensible/mergeable public object contracts and type for general expressions; either can suit an ordinary object.

## Sources
- Workspace: `_ai-conspects/type aliases, unions,iterfaces/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
