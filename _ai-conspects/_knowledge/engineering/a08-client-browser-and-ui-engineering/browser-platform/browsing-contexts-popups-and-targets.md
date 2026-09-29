# Browser browsing contexts, popups, and navigation targets

Knowledge ID: `javascript.browsing-contexts-popups-and-targets`

Topic: `javascript`

An iframe, popup, and parent page are separate browsing contexts. Each has its own `window`, document, history, and JavaScript global scope. An iframe is nested in the current page; a popup is a separate top-level context whose reference is commonly returned by `window.open`.

## References and origin boundaries

Contexts can be related through references:

- `window.parent` is the immediate parent frame;
- `window.top` is the top-level context;
- `window.opener` is the opener of a popup when that relationship exists;
- `iframe.contentWindow` is the iframe's window from the parent;
- `window.frames` exposes named or indexed child frames.

Same-origin pages—same scheme, host, and port—can generally inspect one another's DOM and JavaScript objects. Cross-origin contexts cannot read arbitrary DOM, storage, or variables. A cross-origin window reference still permits a limited safe set of operations, notably `postMessage` and navigation where policy allows it.

Wait for an iframe's `load` event before assuming its document or application is ready. The iframe may later navigate and replace its document while the browsing-context reference remains. Sandbox attributes can remove capabilities even from otherwise trusted content. Framing can also be denied by CSP `frame-ancestors` or `X-Frame-Options`.

## Iframe and popup choice

An iframe participates in page layout and can be created with `<iframe>` or DOM APIs. It is useful for embeds, isolated tools, payment/authentication widgets, and previews. Untrusted content should receive the smallest necessary sandbox and Permissions Policy capabilities. Validate every message from it; powerful sandbox exceptions can restore escape capabilities when combined carelessly.

A popup is opened through browser policy with `window.open`. It commonly needs a direct user gesture, and the call returns a `WindowProxy` or `null` if opening failed or was blocked. Popups fit OAuth, external workflows, print views, and secondary tools.

An opened page may have `window.opener` and may be able to navigate its opener. Use `noopener` when communication through the opener is unnecessary. Use `noreferrer` when the referrer should also be omitted. Cross-origin opener policies can further isolate browsing-context groups. Iframes and popups also affect privacy, focus, navigation, and accessibility.

## `window.open`

```javascript
const popup = window.open(url, target, features);
if (popup === null) {
  // Opening failed or was blocked.
}
```

- `url` is the initial navigation.
- `target` selects or names the browsing context.
- `features` is a comma-separated list of requested features.
- `popup`, `width`, `height`, `left`, and `top` are requests that a browser may ignore.
- `noopener` removes the opener relationship.
- `noreferrer` suppresses the referrer and typically implies opener isolation.

Call `window.open` synchronously from a trusted click or similar activation. An awaited delay can lose transient activation and trigger popup blocking. Opening a blank context first is appropriate only when an asynchronous workflow genuinely requires later URL preparation.

Check the returned reference, clean up polling timers and message listeners, and do not assume requested geometry was honored. `focus`, `blur`, and `close` remain subject to browser restrictions; `closed` reports whether a referenced popup has closed. Prefer messaging over frequent `popup.closed` polling when coordinating completion.

A window's `location` can navigate that context where browser policy permits, while cross-origin reads of the location are restricted. Its `name` identifies the browsing context and participates in the target-selection rules below.

## Navigation targets

- `_self` uses the current context and is the normal default for links and forms.
- `_blank` requests a new top-level context.
- `_parent` uses the immediate parent, or behaves like `_self` without one.
- `_top` uses the top-level context.
- Another non-empty name selects or creates a named context; later navigation with the same name can reuse it.

An iframe's `name` lets a link or form target that iframe. Use stable names only when reuse is intended. A link or form without `target` uses `_self`, while an omitted `window.open` target commonly requests a new unnamed context; do not assume their defaults are identical.

Ancestor navigation can be restricted by sandbox or browser policy. Target selection chooses a context but never bypasses same-origin rules. Isolate `_blank` openers unless communication is required, announce surprising new-window behavior for accessibility, and avoid names that can unexpectedly replace an unrelated user task.

## Related knowledge

- `javascript.cross-window-postmessage-security` — explicit message exchange across browsing-context boundaries.

## What should be recallable

- The iframe/popup distinction and the main window references.
- Same-origin inspection versus limited cross-origin operations.
- Popup activation, blocking, opener, and lifecycle constraints.
- `_self`, `_blank`, `_parent`, `_top`, named targets, and the HTML/`window.open` default difference.
- How sandbox, framing policy, and opener isolation constrain the contexts.

## Sources

- Workspace: `_ai-conspects/iframe,cross window communication,target/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01, R02, R03 window-reference/method/property claims, R04, and R05
- Original SVG: `source/iframe,cross window communication,target.svg`
- Workspace: `_ai-conspects/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable/`
- Authoritative processed source: `01-final-transcript.md`, R01 (current-tab navigation, `_blank` and `noopener`)
- Original SVG: `source/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg`
