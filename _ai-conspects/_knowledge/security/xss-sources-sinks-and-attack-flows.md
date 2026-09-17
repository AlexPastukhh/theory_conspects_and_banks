# XSS sources, sinks, and attack flows

Knowledge ID: `security.xss-sources-sinks-and-attack-flows`

Topic: `security`

An XSS review follows data, not only page templates:

```text
untrusted source -> transformations/storage -> executable sink -> browser execution
```

Sources include form and query input, API/database values, URL fragments, `localStorage`, `postMessage`, and third-party data. Dangerous sinks include `innerHTML`, `outerHTML`, `insertAdjacentHTML`, `document.write`, React `dangerouslySetInnerHTML`, `eval`, string-taking timers, script creation/URLs, and `javascript:` navigation. Safer alternatives include `textContent`, DOM node construction, fixed callbacks, and validated URL/protocol handling. A safe sink can become unsafe when its output is later reinterpreted as markup or code, so retain provenance through the whole flow.

Stored XSS persists a payload and later serves it to victims. Reflected XSS places request data in the immediate response. DOM XSS occurs when client code moves browser-controlled data into an executable sink. The categories can overlap; the useful invariant is whether attacker-controlled bytes reach an execution context without the correct encoding/sanitization boundary.

Consequences include account actions in the current origin, data disclosure, UI deception, and propagation through stored content. `HttpOnly` prevents direct JavaScript reads of that cookie, but injected code can still make authenticated same-origin requests and read accessible page/API data; it is damage reduction, not an XSS fix.

## Sources

- Workspace: `_ai-conspects/xss, csp/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R03 and R05
- Original SVG: `source/xss, csp.svg`
