# Client/server roles, listening endpoints, and HTTP flow

Knowledge ID: `http.client-server-roles-listening-and-request-flow`

Topic: `http`

## S-008 — What a server really is

**Known limits:** none

### Near-literal normalized transcript

A server is not automatically “a whole computer.”

It can mean:

- a physical machine;
- a virtual machine;
- a container;
- most often in programming discussion, the server process/application listening for network traffic.

Examples:

- Kestrel listening on `https://localhost:7143`;
- Vite dev server listening on `https://localhost:5173`;
- Nginx listening on port `443`;
- SQL Server listening for database connections.

So “server” often means:

> software that is waiting for incoming requests.

### Study meaning

Server describes a network role and a listening process that can run on many host types.

### Recall questions

1. Name the three host forms listed.
2. What four listening-server examples are shown?
3. What concise definition closes the source?

## S-009 — What it means for a server to listen

**Known limits:** none

### Near-literal normalized transcript

A server binds to:

- an IP address or hostname;
- a port.

Example:

```text
https://localhost:7143
```

means roughly:

- protocol: HTTPS;
- host: `localhost`;
- port: `7143`.

When the server runs, it opens that port and waits.

```text
client -> connect to host:port -> send request -> get response
```

### Study meaning

A listening endpoint combines address, port, and expected protocol.

### Recall questions

1. Decompose `https://localhost:7143`.
2. What does the server do after opening the port?
3. Write the conceptual client/server sequence.

## S-010 — How the browser makes requests

**Known limits:** none

### Near-literal normalized transcript

The browser is a client.

When a user enters a URL or JavaScript executes `fetch(...)`, the browser:

1. determines the target URL;
2. opens a network connection to the host and port;
3. sends an HTTP request;
4. waits for an HTTP response;
5. processes the response.

### Study meaning

Browser networking is a concrete client workflow: target, connect, request, wait, process.

### Recall questions

1. List the five steps in order.
2. Which step occurs before HTTP bytes are sent?
3. What happens after the response arrives?

## S-011 — Concrete browser request and response

**Known limits:** none

### Near-literal normalized transcript

Example request:

```http
GET /api/weather HTTP/1.1
Host: localhost:7143
```

The browser sends it to the server listening on `localhost:7143`.

Example response:

```http
HTTP/1.1 200 OK
Content-Type: application/json

{"temp":22}
```

The browser is a client that knows how to make HTTP requests and render or process responses.

### Study meaning

Host and port select the endpoint; the path selects the application resource.

### Recall questions

1. What path is requested?
2. What Host header is shown?
3. What status, content type, and JSON body are returned?

## S-012 — How servers call other servers

**Known limits:** none

### Near-literal normalized transcript

A server can also act as a client.

Example:

- the browser calls ASP.NET Core;
- ASP.NET Core calls another API;
- that API calls a database.

One program can be:

- a server for incoming requests;
- and a client for outgoing requests.

### Study meaning

Client and server are roles in a particular exchange, not permanent identities.

### Recall questions

1. Give the three-hop example.
2. How can ASP.NET Core be both server and client?
3. Why are these roles contextual?

## S-013 — Role changes in an end-to-end flow

**Known limits:** none

### Near-literal normalized transcript

```text
Browser -> ASP.NET Core app -> external API -> response back
```

ASP.NET Core is:

- server relative to the browser;
- client relative to the external API.

That is why “client” and “server” are roles, not permanent identities.

### Study meaning

The same process changes role depending on which connection is described.

### Recall questions

1. Relative to whom is ASP.NET Core the server?
2. Relative to whom is it the client?
3. Why should diagrams label each hop?

## S-014 — Examples of development servers and hosts

**Known limits:** none

### Near-literal normalized transcript

Examples shown:

- Vite dev server — serves the React application in development;
- IIS Express — local Windows web server / host;
- ASP.NET Core application;
- depending on hosting mode, Kestrel may also run behind IIS Express.

### Study meaning

Several processes can participate in local development; identify each by role and endpoint.

### Recall questions

1. What does Vite serve?
2. What role can IIS Express play?
3. How can Kestrel relate to IIS Express?

## What should be recallable

- What does server mean as a process and network role?
- How do protocol, host, port, path, request, and response fit together?
- How can one process be a server on one hop and a client on another?
- Which distinct local-development processes can participate in one flow?

## Related knowledge

- `architecture.forward-and-reverse-proxy-roles`

## Sources

- Workspace: `_ai-conspects/proxy, server, vite dev server proxy/`
- Authoritative processed source: `regions-v003/R02-server-client-listening-and-http-flow.md`, S-008–S-014
- Original SVG: `source/source-complete-v002.svg` (SHA-256 `4988d37a8d2fa56f111a902f3ade024e32f8585b35381875293069e7df598b12`; Git blob `4bf0e9b670abc70d79dc3d7c59e1b867d18c0a53`).
