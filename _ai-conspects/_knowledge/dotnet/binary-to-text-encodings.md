# Binary-to-text encodings for storage and transport

Knowledge ID: `dotnet.binary-to-text-encodings`

Topic: `dotnet`

## Security and representation are separate layers

`IDataProtector.Protect(...)` returns arbitrary protected bytes. A SHA-256 hash is also bytes. Hex, Base64, and Base64Url only represent those bytes as text; they add no encryption, hashing, confidentiality, integrity, or authentication.

A typical protected-token flow is: build a payload such as user ID, security stamp, timestamp, or expiry; encode it to bytes; protect the bytes; then use `WebEncoders.Base64UrlEncode(...)` only when the result must cross a text boundary such as a route, query, cookie, header, email link, or JSON value.

If the database can store bytes directly in `VARBINARY`, no textual encoding is needed. Encode at boundaries that require text.

## Choosing the representation

Hex uses two characters per byte. It is easy to inspect, copy, compare, and debug, but is approximately twice the binary size. It suits logs, diagnostics, manually inspected hashes, and configuration.

Standard Base64 is more compact than hex and works well in textual database columns, JSON, headers, and protocols that safely accept `+`, `/`, and optional `=` padding.

Base64Url retains Base64 compactness but replaces URL-sensitive characters and removes padding. It suits URLs, query strings, path segments, and email links without extra escaping.

```text
binary database column -> raw bytes
text database column or JSON -> usually Base64
query/path token -> Base64Url
human-facing diagnostics -> hex
```

Neither hex nor Base64 is more secure. URL safety is required because of the transport, not because the bytes are encrypted or hashed.

## What should be recallable

- Why Data Protection/hash security properties are independent from binary-to-text encoding.
- When encoding is unnecessary and when a text boundary requires it.
- Hex, Base64, and Base64Url alphabet/size/transport tradeoffs and the practical selection rule.

## Sources

- Workspace: `_ai-conspects/url save base 64 for db, hex string/`
- Processed source: `regions/R01R02-final-coverage.md`, R01–R02
- Original SVG: `source/url save base 64 for db, hex string.svg`
