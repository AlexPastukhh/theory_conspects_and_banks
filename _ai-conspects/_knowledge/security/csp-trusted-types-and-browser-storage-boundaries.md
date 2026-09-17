# CSP, Trusted Types, and browser-storage boundaries

Knowledge ID: `security.csp-trusted-types-and-browser-storage-boundaries`

Topic: `security`

Content Security Policy is a response-header defense-in-depth layer. A strict policy limits script sources, removes broad inline-script permission, and can require a per-response nonce or stable hash:

```http
Content-Security-Policy: default-src 'self'; script-src 'self' 'nonce-{random}'; object-src 'none'; base-uri 'none'; frame-ancestors 'none'
```

Generate an unpredictable nonce per response and put the same value on scripts intentionally allowed to execute. Hashes fit static inline content. `object-src`, `base-uri`, and `frame-ancestors` close separate execution/navigation/embedding boundaries. Deploy restrictive changes with `Content-Security-Policy-Report-Only`, collect violations, remove accidental dependencies, then enforce; reporting alone does not block anything. Avoid falling back to `'unsafe-inline'` as a permanent compatibility shortcut.

Trusted Types can require DOM XSS sinks to receive a typed value produced by an approved policy rather than an arbitrary string. The policy is a chokepoint, not magic: a policy that returns unsafe input unchanged defeats the protection. Combine it with contextual encoding, sanitizer review, and CSP.

Moving a token among `localStorage`, `sessionStorage`, memory, or ordinary JavaScript state does not make it unreadable to code already executing in the origin. Lifetimes and persistence differ, but XSS can read accessible storage and act through the application. HttpOnly cookies reduce direct token theft while introducing cookie/CSRF/session design concerns; storage choice cannot replace prevention of executable sinks.

## Sources

- Workspace: `_ai-conspects/xss, csp/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R04
- Original SVG: `source/xss, csp.svg`
