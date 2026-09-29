# Authentication credentials and challenges

Knowledge ID: `http.authentication-headers`

Topic: `http`

## Core model

The request `Authorization` header carries credentials or proof for an authentication scheme:

```http
Authorization: Basic <credentials>
Authorization: Bearer <token>
```

Basic credentials are encoded rather than encrypted and require transport protection. A bearer token grants access to its possessor, making storage, transport, expiration, and scope important.

For Basic authentication, the encoded payload represents `username:password`. Base64 is reversible encoding, so the credential is replayable and HTTPS is mandatory. A receiver must reject malformed Base64 and split at the intended credential separator rather than treating arbitrary decoded text as valid. Do not log the raw header or password.

The response side uses `WWW-Authenticate` to issue a challenge, commonly with `401 Unauthorized`:

```http
HTTP/1.1 401 Unauthorized
WWW-Authenticate: Basic realm="admin"
```

The challenge identifies an accepted scheme and its parameters. `realm` describes a protection space or challenge scope; it is not an application role and does not itself authorize anything.

## Boundaries

An `Authorization` header and a `Cookie` are different credential transport mechanisms. Authentication headers also interact with redirects, caching, CORS/preflight, and proxies, so request and response responsibilities must remain distinct.

Basic authentication is useful for controlled scripts, internal tools, simple machine clients, and integrations, but is generally weaker than token-based or federated authentication for modern public applications. Client credential caching and preauthentication are client-specific; an explicitly supplied header is predictable, while a credential-aware handler may manage challenge/retry behavior.

## What should be recallable

- What information travels in `Authorization`, and what travels in `WWW-Authenticate`?
- How do Basic and Bearer security assumptions differ?
- What does `realm` mean, and what does it not mean?
- Why are authorization headers and cookies not interchangeable concepts?

## Sources

- Workspace: `_ai-conspects/headers/`
- Integrated source: `FINAL_TRANSCRIPT.md`, section 4
- Regional evidence: `regions/R02-expect-referer-authorization-and-www-authenticate-realm.md`
- Original SVG: `source/headers.svg`
- Workspace: `_ai-conspects/basic auth/`
- Authoritative processed source: `regions/R01R02R03-basic-authentication-final.md`, R01 and protocol/client portions of R03
- Original SVG: `source/basic auth.svg`
- Workspace: `_ai-conspects/primary httphandler optoins, socket/`
- Authoritative processed source: `01-final-transcript.md`, sections 4-5 (Basic, integrated credentials and application-managed Bearer tokens)
- Original SVG: `source/primary httphandler optoins, socket.svg`
