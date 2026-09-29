# Storage events, quotas, and failure handling

Knowledge ID: `javascript.web-storage-events-and-failures`

Topic: `javascript`

## Core model

When one same-origin document changes `localStorage`, other documents can receive a `storage` event:

```js
window.addEventListener("storage", event => {
  if (event.key === "theme") {
    console.log("Changed in another tab:", event.newValue);
  }
});
```

The event normally fires in other documents or tabs, not in the same document that performed the write. It exposes the key, old and new values, storage area, and URL. This supports cross-tab preference or logout synchronization.

## Write failures

Storage is quota-limited and browser-dependent. `setItem()` can throw when quota is exceeded or storage is unavailable:

```js
try {
  localStorage.setItem("large-data", hugeString);
} catch (error) {
  console.error("Storage write failed", error);
}
```

Applications should keep values small, handle write failures, and not treat Web Storage as a secure secret store.

## What should be recallable

- Which documents receive a `storage` event?
- Why does the writing document not normally receive that event?
- Which values identify the change?
- What can make `setItem()` throw?
- Which cross-tab behaviors can use this event?

## Related knowledge

- `javascript.web-storage-api` — storage operations and parsing failures.
- `javascript.browser-storage-lifetimes-and-security` — persistence and XSS trade-offs.

## Sources

- Workspace: `_ai-conspects/memory vs localstorage vs sessionstorage, session storage and local storage api methods/`
- Processed source: `01-final-transcript.md`, R04
- Original SVG: `source/memory vs localstorage vs sessionstorage, session storage and local storage api methods.svg`
