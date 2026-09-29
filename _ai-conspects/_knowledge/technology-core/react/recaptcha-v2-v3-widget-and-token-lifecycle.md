# React reCAPTCHA v2/v3 widget and token lifecycle

Knowledge ID: `react.recaptcha-v2-v3-widget-and-token-lifecycle`

Topic: `react`

React owns component DOM and render lifecycle, while Google's reCAPTCHA API owns an external script and widget state. A reliable integration makes that boundary explicit and sends the resulting short-lived token with the protected application request. The backend must still verify it; a React callback is never the security decision.

The browser-visible site key can come from frontend environment configuration. Never place the secret key in the bundle.

## v2 checkbox: wrapper or explicit widget ownership

A React wrapper such as `react-google-recaptcha` exposes the widget through a ref:

```jsx
const recaptchaRef = useRef(null);

<ReCAPTCHA sitekey={SITE_KEY} ref={recaptchaRef} />
```

On submit, prevent the form's default navigation, read `recaptchaRef.current?.getValue()`, require a token, and include it as `recaptchaToken` in the API payload. If the application request fails, call `reset()` so the next attempt obtains a fresh response.

Without a wrapper, prefer Google's explicit-render mode over automatic scanning of a `g-recaptcha` div. Load `api.js?render=explicit`, wait for `grecaptcha.ready`, render once into a ref-owned empty container, and retain the returned `widgetId`:

```text
render(container, options) -> widgetId
getResponse(widgetId)      -> token
reset(widgetId)            -> fresh challenge
```

The ID disambiguates multiple widgets and prevents global calls from targeting the wrong instance. Guard the effect against duplicate rendering. Automatic rendering is more fragile because React can replace or remove DOM that Google's script mutated.

## v3: readiness, stable action, and just-in-time execution

v3 has no checkbox. Submission must wait until the API is ready, execute a stable endpoint-specific action immediately before the request, and send the returned token:

```js
const token = await execute("register");

await fetch("/api/auth/register", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ email, password, recaptchaToken: token })
});
```

Disable submission or show an explicit loading state until execution is available. The action string must match what the server verifies. Do not cache or reuse a previous token as an optimization.

A custom hook can expose `{ ready, execute }` after loading the script once. A package such as `react-google-recaptcha-v3` provides the same lifecycle through `GoogleReCaptchaProvider` and `useGoogleReCaptcha`; the hook's `executeRecaptcha` may initially be unavailable and must be guarded.

## Load the external script once

A manual loader should:

- reuse `window.grecaptcha` when already available;
- find and subscribe to an existing reCAPTCHA script;
- append a script only when neither exists;
- set `async` and `defer`;
- resolve on load and reject on error.

Keep script loading/widget activation in a hook or provider and keep email/password/request state in the form component. This separates external imperative lifecycle from application submission logic.

## What should be recallable

- Why does client token acquisition not replace backend verification?
- How do `getValue`/`reset` and explicit `widgetId` calls differ?
- Why can v2 automatic DOM rendering conflict with React?
- When should a v3 token be executed, and why must its action be stable?
- How should the UI behave before reCAPTCHA is ready?
- What responsibilities belong to a hook/provider versus the form?
- How does a script loader prevent duplicate elements and expose failures?

## Sources

- Workspace: `_ai-conspects/google recapcha and recapchas/`
- Authoritative processed source: `03-source-preserving-transcript-v003.md`, S-019-S-031 and S-044-S-053
- Semantic reconciliation: `04-full-svg-semantic-transcript-v002.md`, R02-R03
- Original SVG: `source/source-complete-v002.svg`
