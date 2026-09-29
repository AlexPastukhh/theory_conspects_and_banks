# JavaScript URL and component encoding

Knowledge ID: `javascript.url-encoding-components`

Topic: `javascript`

Use `encodeURI` for a complete URI when structural separators such as `:`, `/`, `?`, `&`, and `#` must retain their roles. Use `encodeURIComponent` for one path segment or query value:

```js
const full = encodeURI("https://example.com/a b?q=x y");
const search = `/search?q=${encodeURIComponent(query)}`;
```

Do not encode a whole URL with `encodeURIComponent` unless encoding every separator is intentional. Prefer structured construction:

```js
const url = new URL("/search", location.origin);
url.searchParams.set("q", query);
url.searchParams.set("page", String(page));
```

Base64url is different from percent-encoding. It commonly maps `+` to `-`, `/` to `_`, and removes or normalizes `=` padding. Use the protocol-defined Base64url form for binary tokens.

## What should be recallable

- Complete-URI versus component encoding.
- Why `URL` and `URLSearchParams` avoid separator mistakes.
- Base64url mapping and its distinction from percent-encoding.

## Sources

- Workspace: `_ai-conspects/js url safe, encodeuri/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/js url safe, encodeuri.svg`
