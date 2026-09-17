# HTML sanitization and contextual output

Knowledge ID: `security.html-sanitization-and-contextual-output`

Topic: `security`

Escaping and sanitization solve different problems. Contextual output encoding renders data inert in one output context; sanitization accepts HTML and removes markup/attributes that violate an allowlist. Validation decides whether input satisfies a business rule. Applying one as if it were the others leaves gaps.

HTML text, HTML attributes, URLs, JavaScript strings, and CSS each have different encoding rules. Prefer frameworks and DOM APIs that encode by default:

```jsx
<p>{untrustedText}</p>              // React escapes text
```

```js
element.textContent = untrustedText; // creates text, not markup
```

If the product intentionally accepts HTML, use a maintained parser-based sanitizer. Regex replacement is not an HTML parser and is vulnerable to malformed markup, nested encodings, SVG/MathML, event attributes, URL schemes, and style-based payloads. Define an allowlist for elements, attributes, protocols, SVG/MathML, and styles, and test hostile boundary cases.

```jsx
const clean = DOMPurify.sanitize(untrustedHtml, sanitizerOptions);
return <article dangerouslySetInnerHTML={{ __html: clean }} />;
```

Track raw and sanitized values explicitly so already trusted output is not confused with unreviewed input. Decide whether sanitization occurs at ingestion, rendering, or both, and version the policy when stored content may need re-sanitization after a security update. Server-side sanitization protects every client; client-side sanitization still matters when a browser creates HTML from data the server did not render.

## Sources

- Workspace: `_ai-conspects/xss, csp/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01-R02
- Original SVG: `source/xss, csp.svg`
