# Short-lived signed download URL handoff

Knowledge ID: `security.signed-download-url-handoff`

Topic: `security`

A large file behind a bearer-authenticated API creates a tradeoff: normal navigation streams efficiently but cannot attach an arbitrary `Authorization` header, while fetching a Blob can buffer the whole response in browser-managed memory.

A signed-URL handoff keeps authorization in the protected API and gives the large transfer back to browser-native navigation:

```text
frontend calls protected prepare endpoint with Authorization
-> backend validates permission for one file/action
-> backend returns a short-lived signed download URL
-> browser navigates to that URL
-> storage/server validates the signature and streams the file
```

```ts
const { url } = await api.post(
  "/reports/42/prepare-download",
);

window.location.href = url;
```

The issued URL should be:

- short lived;
- scoped to one resource and action;
- unpredictable;
- HTTPS-only;
- designed for the required replay policy;
- excluded from unnecessary logs where practical.

This pattern does not move the permission decision into the browser. The protected preparation endpoint validates the caller first; the signed URL conveys only the narrow, temporary download capability produced by that decision.

Use ordinary navigation for a cookie-authenticated simple GET, fetch/Blob when request customization or response inspection matters, and a signed-URL handoff when bearer authorization and browser-native handling of a very large file are both required.

## Related knowledge

- `javascript.browser-download-navigation-and-blob-urls`

## What should be recallable

- Why do bearer-authenticated large downloads create a navigation-versus-buffering tradeoff?
- Which component performs the original permission check?
- What scope and lifetime should the returned URL have?
- Why should signed download URLs be kept out of unnecessary logs?
- Which part of the flow streams the file?

## Sources

- Workspace: `_ai-conspects/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable/`
- Authoritative processed source: `regions/R01R02R03R04R05-semantic-transcript-final-v001.md`, R03 signed-URL pattern and decision guide
- Original SVG: `source/donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg`

