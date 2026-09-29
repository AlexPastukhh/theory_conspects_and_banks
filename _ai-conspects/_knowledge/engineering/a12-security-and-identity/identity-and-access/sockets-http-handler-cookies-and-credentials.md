# SocketsHttpHandler cookies, credentials, and authentication ownership

Knowledge ID: `dotnet.sockets-http-handler-cookies-and-credentials`

Topic: `dotnet`

With `UseCookies = true`, `SocketsHttpHandler` uses its `CookieContainer` as a cookie jar:

```text
select cookies whose domain/path/security/expiry match the request URI
-> add the Cookie request header
-> receive Set-Cookie response headers
-> update the container
```

One handler can therefore carry a login session into later requests:

```csharp
var cookies = new CookieContainer();
var handler = new SocketsHttpHandler
{
    UseCookies = true,
    CookieContainer = cookies,
};

using var client = new HttpClient(handler);
await client.PostAsync("https://site.example/login", content);
var response = await client.GetAsync("https://site.example/profile");
```

Cookies can also be inserted explicitly:

```csharp
cookies.Add(
    new Uri("https://api.example.com/"),
    new Cookie("sessionid", "abc123"));
```

Cookie domain/path/security/expiration matching is different from `CredentialCache` matching. A credential cache associates credentials with a URI prefix and authentication scheme and chooses the longest matching prefix.

## Handler pooling and cookie-session ownership

`IHttpClientFactory` pools handlers. When a pooled handler owns a `CookieContainer`, clients created from the same named registration can share that jar. Unrelated logical users can then leak sessions to one another, and handler recycling can discard container state.

Safe choices depend on the client:

- disable cookies for a stateless API;
- manage cookie headers deliberately;
- or bind a dedicated handler/client and jar to one logical user session.

The useful mental model is one handler, one cookie jar, one logical session.

## Destination credentials and authentication schemes

`SocketsHttpHandler.Credentials` accepts `ICredentials`, including `NetworkCredential`, `CredentialCache`, and default Windows credentials. These participate in transport-managed HTTP authentication; they do not mint application bearer tokens.

Basic credentials are Base64-encoded rather than encrypted and require HTTPS:

```csharp
new SocketsHttpHandler
{
    Credentials = new NetworkCredential("alice", "secret"),
};
```

For Windows integrated authentication, `Negotiate` can select Kerberos or NTLM. Kerberos is the ticket-based preferred mechanism in a correctly configured domain; NTLM is the older challenge/response fallback. Where environment and policy allow it, explicit domain credentials can be represented as `new NetworkCredential(user, password, domain)`.

`CredentialCache.DefaultCredentials` represents the current process or Windows security context. In a server application that is normally the service or app-pool identity, not automatically the browser user's identity.

`CredentialCache` can select credentials by URI prefix and scheme:

```csharp
var credentials = new CredentialCache();

credentials.Add(
    new Uri("https://api.example.com/legacy/"),
    "Basic",
    new NetworkCredential("legacyUser", "legacyPass"));

credentials.Add(
    new Uri("https://api.example.com/intranet/"),
    "Negotiate",
    CredentialCache.DefaultNetworkCredentials);

var handler = new SocketsHttpHandler
{
    Credentials = credentials,
    PreAuthenticate = true,
};
```

`PreAuthenticate` may reuse known authorization information on later matching requests without waiting for another `401`. It cannot invent credentials, discover an unknown scheme in advance, or acquire/refresh a JWT.

## Bearer tokens remain application-managed

Bearer/JWT acquisition, attachment, `401` handling, refresh, and retry policy normally belong to application code:

```csharp
client.DefaultRequestHeaders.Authorization =
    new AuthenticationHeaderValue("Bearer", jwtToken);
```

Keep three models distinct:

```text
Basic / Digest / NTLM / Kerberos / Negotiate
    transport participates in an HTTP authentication scheme

Bearer / JWT
    application acquires and attaches a token

Cookies
    server emits Set-Cookie and the handler may return matching cookies later
```

Do not confuse a service process identity with the end user's bearer identity.

## What should be recallable

- Which attributes decide whether a `CookieContainer` cookie matches a request?
- Why can factory-pooled handlers share or later lose cookie state?
- What ownership model prevents cookie leakage between users?
- How does cookie URI matching differ from `CredentialCache` prefix/scheme matching?
- Whose identity does `DefaultCredentials` normally represent in a server process?
- What can `PreAuthenticate` reuse, and what can it not create?
- Why are bearer-token refresh and handler credentials separate mechanisms?

## Sources

- Workspace: `_ai-conspects/primary httphandler optoins, socket/`
- Authoritative processed source: `regions/R01R02R03R04R05-primary-httphandler-options-socket-corrected-final-v002.md`, sections 3-5, cookie/credential configurations in section 12, and related checklist claims
- Original SVG: `source/primary httphandler optoins, socket.svg`
