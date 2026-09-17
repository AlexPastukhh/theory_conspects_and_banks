# .NET ticks, Unix time, and JavaScript display

Knowledge ID: `dotnet.ticks-unix-time-and-javascript-display`

Topic: `dotnet`

## 7. Ticks vs Unix time

A .NET tick is 100 nanoseconds:

```text
1 tick = 0.0000001 second
10,000 ticks = 1 millisecond
10,000,000 ticks = 1 second
```

Ticks are counted from:

```text
0001-01-01 00:00:00
```

Example:

```csharp
long ticks = DateTime.UtcNow.Ticks;
```

Convert ticks to `DateTime`:

```csharp
var dt = new DateTime(ticks, DateTimeKind.Utc);
```

Convert ticks to `DateTimeOffset`:

```csharp
var dto = new DateTimeOffset(ticks, TimeSpan.Zero);
```

Unix time is seconds or milliseconds since:

```text
1970-01-01T00:00:00Z
```

Current Unix time:

```csharp
long unixSeconds = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
long unixMs = DateTimeOffset.UtcNow.ToUnixTimeMilliseconds();
```

From Unix time:

```csharp
var dto1 = DateTimeOffset.FromUnixTimeSeconds(unixSeconds);
var dto2 = DateTimeOffset.FromUnixTimeMilliseconds(unixMs);
```

Convert to UTC `DateTime`:

```csharp
DateTime utc = DateTimeOffset.FromUnixTimeSeconds(unixSeconds).UtcDateTime;
```

Important warning:

```csharp
long x = DateTime.UtcNow.Ticks;
// x is NOT unix seconds
```

Rule:

```text
use .Ticks only when you really want .NET tick values
use ToUnixTimeSeconds() / ToUnixTimeMilliseconds() for Unix time
```

## 8. Unix time and frontend interop

JavaScript works naturally with epoch-based timestamps. JS `Date` is heavily based on milliseconds since the Unix epoch.

Backend and frontend often exchange time as:

```text
Unix milliseconds
ISO string
sometimes Unix seconds
```

Example idea:

```text
backend sends 1736517600
frontend turns it into a displayed date
```

ASP.NET backend example:

```csharp
app.MapGet("/session", () =>
{
    var expiresAt = DateTimeOffset.UtcNow.AddMinutes(30);

    return Results.Ok(new
    {
        expiresAtUnixMs = expiresAt.ToUnixTimeMilliseconds(),
        expiresAtIso = expiresAt.ToString("O")
    });
});
```

Possible JSON:

```json
{
  "expiresAtUnixMs": 1736519400000,
  "expiresAtIso": "2025-01-10T14:30:00.0000000+00:00"
}
```

JavaScript frontend:

```javascript
const res = await fetch("/session");
const data = await res.json();

const expiresAt = new Date(data.expiresAtUnixMs);

console.log(expiresAt);
console.log(expiresAt.toLocaleString());

const msLeft = data.expiresAtUnixMs - Date.now();
console.log("Milliseconds left:", msLeft);
```

Unix time is especially convenient when the frontend needs to compare times, sort by time, compute remaining duration, run countdowns, plot charts, handle JWT expiry, or avoid parsing custom date formats.

Practical rule for backend ↔ frontend:

```text
use ISO 8601 strings when human readability is helpful
use Unix milliseconds when frontend will do arithmetic or timers
```

## 9. JavaScript locale display

The important distinction is:

```text
storage/transport -> Unix time or ISO string
display           -> locale formatting methods
```

Display methods:

```text
toLocaleTimeString()
toLocaleString()
toLocaleDateString()
```

because display should match the user's locale/timezone.

In a chart example:

```javascript
console.log(new Date(p.x).toLocaleTimeString(), p.y);
```

Meaning:

```text
p.x is a Unix timestamp in milliseconds
new Date(p.x) creates a JS Date
toLocaleTimeString() converts it to a user-friendly local time string
p.y is the value associated with that time
```

`toLocaleString()` returns date + time in the user's locale:

```javascript
const d = new Date("2025-01-10T14:30:00Z");
console.log(d.toLocaleString());
```

Possible outputs:

```text
1/10/2025, 2:30:00 PM
10.1.2025, 15:30:00
```

`toLocaleTimeString()` returns only the time part:

```javascript
const d = new Date("2025-01-10T14:30:00Z");
console.log(d.toLocaleTimeString());
```

Possible outputs:

```text
2:30:00 PM
15:30:00
```

`toLocaleDateString()` returns only the date part:

```javascript
const d = new Date("2025-01-10T14:30:00Z");
console.log(d.toLocaleDateString());
```

Possible outputs:

```text
1/10/2025
10.1.2025
```

Use these only when producing user-facing display, not as storage formats.

## What should be recallable

- How .NET ticks differ from Unix seconds/milliseconds.
- How DateTimeOffset Unix APIs and JavaScript locale rendering connect backend instants to frontend display.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R01-core-types-offset-ticks-unix-js.md`, listed sections
- Original SVG: `source/time.svg`
