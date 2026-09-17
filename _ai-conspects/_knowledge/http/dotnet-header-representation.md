# HTTP header ownership and .NET representations

Knowledge ID: `http.dotnet-header-representation`

Topic: `http`

## Core model

HTTP headers are request or response metadata. Content headers describe the body representation and belong to the content object rather than the general message-header collection.

In `HttpClient`, ownership is explicit:

```text
HttpRequestMessage.Headers
HttpRequestMessage.Content.Headers
HttpResponseMessage.Headers
HttpResponseMessage.Content.Headers
```

ASP.NET Core exposes request and response headers through `IHeaderDictionary`. Each name maps to `StringValues`, which can represent zero, one, or multiple values without always allocating an array.

## Raw collection operations

```csharp
headers.ContainsKey(name);
headers.TryGetValue(name, out var values);
headers[name] = value;
headers.Remove(name);
headers.Append(name, value);
```

`Add` requires the key to be absent, whereas `Append` adds a value. Indexer access is convenient but can obscure absence or multiplicity; `TryGetValue` makes the presence check explicit. Header names are case-insensitive.

Comma-separated helpers should be used only when the header grammar permits list values. Multiple field values are not universally interchangeable with one comma-joined value.

## Typed versus raw access

Typed APIs represent structured grammar and help with parsing, validation, formatting, dates, quality factors, entity tags, ranges, and media types. Examples include `Accept`, `Authorization`, `ETag`, `Location`, `ContentType`, and `ContentLength`, plus ASP.NET Core's `GetTypedHeaders()` models.

Raw collections remain necessary for custom or unsupported fields:

```csharp
request.Headers.TryAddWithoutValidation("X-Custom", "value");
response.Headers.TryGetValues("X-Custom", out var values);
```

`TryAddWithoutValidation` bypasses normal validation, so the caller must already understand the wire syntax. `HeaderNames` constants reduce spelling errors when raw access is appropriate.

## What should be recallable

- Why are message headers and content headers stored on different .NET objects?
- How do `StringValues`, `TryGetValue`, `Add`, and `Append` differ?
- When are comma-separated helpers unsafe?
- When should typed header APIs be preferred over raw collections?
- What responsibility comes with `TryAddWithoutValidation`?

## Sources

- Workspace: `_ai-conspects/headers/`
- Integrated source: `FINAL_TRANSCRIPT.md`, sections 1, 8–10, and 12
- Regional evidence: `regions/R03-asp-net-core-header-abstractions-stringvalues-operations-and-common-typed-proper.md` and `regions/R04-typed-headers-cookieheadervalue-setcookieheadervalue-and-comparers.md`
- Original SVG: `source/headers.svg`
