# Date/time parsing exactness and standard formats

Knowledge ID: `dotnet.datetime-parsing-exactness-and-standard-formats`

Topic: `dotnet`

## 1. Big rule: flexible parse vs exact parse

Use `Parse` / `TryParse` when you can accept multiple common input shapes.

These are flexible, but they rely on the current culture or the culture you provide. They can recognize many valid date/time strings, but the accepted result can be surprising if the input is ambiguous.

Example flexible parse:

```csharp
string s = "Tue, 02 Apr 2026 12:45:06 GMT";

DateTimeOffset dto = DateTimeOffset.Parse(s);

Console.WriteLine(dto);
Console.WriteLine(dto.ToUniversalTime());
```

Safer version:

```csharp
string s = "Tue, 02 Apr 2026 12:45:06 GMT";

if (DateTimeOffset.TryParse(s, out var dto))
{
    Console.WriteLine(dto);
}
```

Use `ParseExact` / `TryParseExact` when the string must match one specific format:

```csharp
using System.Globalization;

string s = "2026-02-14";

DateTime dt = DateTime.ParseExact(
    s,
    "yyyy-MM-dd",
    CultureInfo.InvariantCulture);
```

TryParseExact version:

```csharp
if (DateTimeOffset.TryParseExact(
    text,
    "O",
    CultureInfo.InvariantCulture,
    DateTimeStyles.None,
    out var dto))
{
    Console.WriteLine(dto);
}
```

Practical rule:

```text
Parse/TryParse       -> input may be flexible / human-ish / culture-driven
ParseExact/TryParseExact -> input has a fixed contract
TryParse/TryParseExact -> prefer when invalid input is normal
```

## 2. What `DateTime.Parse` can parse

`DateTime.Parse` can parse common shapes:

```text
date + time
date only
month + day + year
month + day only
time only
hour + AM/PM
ISO 8601 strings with Z or offset
RFC 1123 / GMT strings
date/time strings with explicit time-zone offset
```

Examples include:

```text
04/20/2026 07:22:15
2026-04-20
4/20
07:22:15
7 PM
2026-04-20T07:22:15.0000000Z
Mon, 20 Apr 2026 07:22:15 GMT
2026-04-20 07:22:15 +02:00
```

But if an offset is part of the input and you need to preserve it, `DateTimeOffset.Parse` is usually the better model.

## 3. What `DateTimeOffset.Parse` can parse

`DateTimeOffset.Parse` can parse many of the same shapes, but it is especially appropriate when the input may contain an offset or when preserving the idea of an absolute instant plus offset is important.

Examples:

```csharp
var dto1 = DateTimeOffset.Parse("2026-04-10T07:22:15.0000000Z");
var dto2 = DateTimeOffset.Parse("2026-04-10T07:22:15.0000000+03:00");
var dto3 = DateTimeOffset.Parse("Fri, 10 Aug 2026 07:22:15 GMT");
```

The note in the source says to default to `DateTimeOffset` for API timestamps, request/response payloads, and cross-machine/cross-timezone data.

## 4. Standard format strings for exact parsing and formatting

`ParseExact` can use standard format specifiers.

Important standard formats in this area:

```text
R / r -> RFC 1123
O / o -> round-trip / ISO 8601-style
s     -> sortable date/time
u     -> universal sortable
G/g, F/f, D/d, T/t -> culture-based standard patterns
```

Example with RFC 1123:

```csharp
using System.Globalization;

var dto = DateTimeOffset.ParseExact(
    "Tue, 02 Apr 2026 12:45:06 GMT",
    "R",
    CultureInfo.InvariantCulture);
```

`R` works both ways:

```text
dto.ToString("R")                    -> formats to RFC 1123 text
ParseExact(text, "R", ...)           -> parses that same format back
```

## What should be recallable

- When Parse/TryParse or ParseExact/TryParseExact is appropriate.
- How DateTime and DateTimeOffset parsing differ and which standard formats support interchange.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R03-parsing-formatting-cheat-sheets.md`, listed sections
- Original SVG: `source/time.svg`
