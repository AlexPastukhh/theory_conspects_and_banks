# JavaScript function defaults, rest, and spread

Knowledge ID: `javascript.function-defaults-rest-and-spread`

Topic: `javascript`

Defaults activate for omitted or explicit `undefined`, not `null`, false, zero, or empty string:

```js
function greet(name = "Guest") {
  return `Hello, ${name}`;
}

greet();          // default
greet(undefined); // default
greet(null);      // null is the supplied value
```

Expressions run per invocation, may reference earlier parameters, and create fresh objects. A later parameter is not safely available to an earlier default expression. Side effects obscure calls; function `.length` stops at the first default.

Pass `undefined` to skip an earlier position. A required parameter can technically follow a defaulted one, but reaching it requires that placeholder, so prefer required parameters first. For many optionals use an options object and default the object itself; destructuring an omitted/`undefined` object without that default throws.

```js
function connect({ host = "localhost", port = 80 } = {}) {
  return { host, port };
}
```

Changing positional order is a breaking API change.

A single final `...args` gathers only arguments remaining after earlier named parameters have consumed their positions:

```js
function log(prefix, ...values) {
  return values.map(value => `${prefix}: ${value}`);
}

const values = [2, 3];
fn(1, ...values, 4);
```

Call spread expands an iterable and can mix with explicit arguments before or after it, though huge spreads may hit engine argument limits. Rest works in arrows and is preferable to array-like `arguments`. Function-parameter rest and object-rest syntax are related but operate in different contexts. Use an array parameter when the input concept is one collection rather than variadic arguments.

## Sources
- Workspace: `_ai-conspects/default values of funcs, how to call, rest params in funcs/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
