# ASP.NET Core WebSocket endpoint lifecycle and security

Knowledge ID: `aspnet-core.websocket-endpoint-lifecycle-and-security`

Topic: `aspnet-core`

A WebSocket endpoint must validate the HTTP upgrade and remain alive for the complete connection lifetime:

```csharp
app.UseWebSockets();

app.Map("/ws", async context =>
{
    if (!context.WebSockets.IsWebSocketRequest)
    {
        context.Response.StatusCode = StatusCodes.Status400BadRequest;
        return;
    }

    using var socket =
        await context.WebSockets.AcceptWebSocketAsync("chat.v1");

    await RunConnectionAsync(socket, context.RequestAborted);
});
```

Returning immediately after `AcceptWebSocketAsync` abandons the connection scope and can dispose request-scoped resources too early. The handler coordinates receive/send loops, outbound-queue completion, cancellation, close, and disposal.

## Authentication and browser-origin checks happen before acceptance

ASP.NET Core authentication runs during the HTTP upgrade. A matching authentication cookie follows its normal `Domain`, `Path`, `Secure`, and `SameSite` rules, and the resulting `HttpContext.User` remains available to connection code. Authenticate and authorize before `AcceptWebSocketAsync`.

Browser WebSocket upgrades do not use ordinary CORS preflight, so enabling CORS middleware is not a WebSocket cross-site defense. For a browser endpoint, validate `Origin` before acceptance:

```csharp
var origin = context.Request.Headers.Origin.ToString();

if (!AllowedOrigins.Contains(origin))
{
    context.Response.StatusCode = StatusCodes.Status403Forbidden;
    return;
}
```

Authentication answers who the client is; `Origin` validation answers which browser site initiated the connection. A non-browser client can forge `Origin`, so it does not replace authentication.

Native browser WebSocket cannot set a general `Authorization` header. If bearer authentication extracts `access_token` from the query string, limit extraction to the WebSocket path, require `wss://`, use a short-lived or one-time connection token, redact query strings from logs, never place a long-lived refresh token in the URL, and retain normal signature/issuer/audience/lifetime validation.

Representative protected shape:

```csharp
app.UseAuthentication();
app.UseAuthorization();
app.UseWebSockets();

app.Map("/ws", async context =>
{
    if (context.User.Identity?.IsAuthenticated != true)
    {
        context.Response.StatusCode = StatusCodes.Status401Unauthorized;
        return;
    }

    if (!IsAllowedOrigin(context.Request.Headers.Origin))
    {
        context.Response.StatusCode = StatusCodes.Status403Forbidden;
        return;
    }

    if (!context.WebSockets.IsWebSocketRequest)
    {
        context.Response.StatusCode = StatusCodes.Status400BadRequest;
        return;
    }

    using var socket =
        await context.WebSockets.AcceptWebSocketAsync("chat.v1");

    await RunConnectionAsync(
        socket,
        context.User,
        context.RequestAborted);
})
.RequireAuthorization();
```

## Coordinated shutdown

`RequestAborted` can stop normal connection work, but close cleanup often needs a separate short timeout or `CancellationToken.None` because the request token may already be cancelled. A coordinator should stop new outbound writes, complete or cancel the queue, finish/cancel the send and receive loops, attempt a bounded graceful close, abort only when graceful completion is impossible, and dispose connection-owned buffers/resources.

Record connection/user IDs, selected subprotocol, close code/reason, loop termination cause, queue depth/drops, origin result, and protocol/application failures. Keep tokens, cookies, full query strings, and confidential payloads out of logs.

## Related knowledge

- `aspnet-core.jwt-bearer-event-lifecycle`
- `dotnet.channels-producer-consumer-lifecycle`
- `http.websocket-message-framing`

## What should be recallable

- Why must the endpoint await the complete socket lifetime?
- Which checks happen before `AcceptWebSocketAsync`?
- Why are authentication, CORS, and WebSocket `Origin` validation different controls?
- Which restrictions make a query-string connection token less dangerous?
- Why can graceful close cleanup need a token other than `RequestAborted`?

## Sources

- Workspace: `_ai-conspects/websockets/`
- Authoritative processed source: `regions/R01R02R03-websockets-corrected-final-v003.md`, sections 7-9, 20-23 and 25-26
- Original SVG: `source/websockets.svg`
