# Memory, sessionStorage, and localStorage lifetimes

Knowledge ID: `javascript.browser-storage-lifetimes-and-security`

Topic: `javascript`

## Core model

Choose client-side storage by required lifetime, sharing behavior, and security consequences.

```text
in-memory state
  lifetime: current page instance
  survives refresh: no
  shared across tabs: no;

sessionStorage
  lifetime: current tab/page session
  survives refresh in that tab: yes
  shared across normal tabs: no;

localStorage
  lifetime: persistent until removed or cleared
  survives browser restart: yes
  shared by same-origin documents: yes.
```

All three remain readable by malicious JavaScript executing in the page. Memory reduces persistence but is not immune to XSS.

`sessionStorage` fits per-tab drafts, wizard progress, redirect flags, and temporary UI state. `localStorage` fits non-sensitive preferences and small cached state.

Persistent bearer or refresh tokens in `localStorage` increase XSS impact because stolen values can be reused. Security-sensitive designs may prefer short-lived memory state plus protected cookie-based renewal, depending on the threat model.

## What should be recallable

- Which storage survives refresh, tab closure, and browser restart?
- Which storage is shared across same-origin documents?
- Why does in-memory storage reduce persistence without defeating XSS?
- Which use cases fit `sessionStorage` and `localStorage`?
- Why can persistent bearer tokens increase XSS impact?

## Related knowledge

- `javascript.web-storage-api` — string storage and safe serialization.

## Sources

- Workspace: `_ai-conspects/memory vs localstorage vs sessionstorage, session storage and local storage api methods/`
- Processed source: `01-final-transcript.md`, R02 and lifetime-specific examples from R03
- Original SVG: `source/memory vs localstorage vs sessionstorage, session storage and local storage api methods.svg`
- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `01-final-transcript.md`, R03 (short-lived in-memory access token and protected-cookie renewal boundary)
- Original SVG: `source/jwt auth.svg`
