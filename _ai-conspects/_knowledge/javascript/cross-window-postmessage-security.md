# Secure cross-window communication with `postMessage`

Knowledge ID: `javascript.cross-window-postmessage-security`

Topic: `javascript`

Same-origin browsing contexts can call functions or manipulate one another's DOM, although an explicit message interface is often less coupled. Cross-origin communication should use `window.postMessage` because arbitrary DOM, storage, and variable access is blocked by the same-origin policy.

## Send and receive

Send to a known window reference and an exact expected origin:

```javascript
targetWindow.postMessage(
  { type: "configure", requestId, payload },
  "https://trusted.example"
);
```

Avoid `"*"` when the destination origin is known. Structured-clone-compatible data does not need manual JSON serialization, and transferable objects such as `MessagePort` can establish a dedicated channel.

Receiving a `message` is the start of validation, not proof that the content is trustworthy:

```javascript
function onMessage(event) {
  if (event.origin !== "https://trusted.example") return;
  if (event.source !== expectedWindow) return;
  if (!isKnownMessage(event.data)) return;

  handleKnownMessage(event.data);
}

window.addEventListener("message", onMessage);
// Remove onMessage when this lifecycle ends.
```

Validate:

- `event.origin` against an allowlist;
- `event.source` when one iframe or popup is expected;
- the data schema, message type, and permitted command;
- the owning lifecycle, removing listeners when it ends.

`postMessage` delivery alone does not authenticate the message contents. Never evaluate received strings as code.

## Handshake and request/response flow

A child can announce readiness after initialization. The parent should validate origin and source before returning configuration. Use versioned message types instead of arbitrary commands, and attach correlation IDs when messages form request/response pairs.

```text
child ready
-> parent validates origin + source + schema
-> parent sends configuration
-> later messages carry versioned types and correlation IDs
```

Other communication mechanisms—shared backend state, `BroadcastChannel`, `MessageChannel`, or service workers—fit different scopes, but do not remove the need for an explicit trust boundary.

## Related knowledge

- `javascript.browsing-contexts-popups-and-targets` — iframe/popup references, origins, targets, and lifecycle.

## What should be recallable

- Why a window reference does not grant cross-origin DOM access.
- Why `targetOrigin`, `event.origin`, `event.source`, and message-schema checks are separate safeguards.
- What a ready/configuration handshake and correlation ID contribute.
- Why listener cleanup and refusal to evaluate message strings belong to the contract.

## Sources

- Workspace: `_ai-conspects/iframe,cross window communication,target/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01 and R03
- Original SVG: `source/iframe,cross window communication,target.svg`
