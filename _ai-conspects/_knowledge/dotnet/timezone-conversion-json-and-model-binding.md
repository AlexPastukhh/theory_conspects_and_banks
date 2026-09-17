# .NET timezone conversion, JSON, and model binding

Knowledge ID: `dotnet.timezone-conversion-json-and-model-binding`

Topic: `dotnet`

## 1. UTC, local, and conversion

Basic `DateTime` conversion:

```csharp
var utc = localDateTime.ToUniversalTime();
var local = utcDateTime.ToLocalTime();
```

Important: for `DateTime`, these conversions depend on `DateTime.Kind`.

```text
Kind.Utc         -> already UTC
Kind.Local       -> machine/OS local timezone
Kind.Unspecified -> risky; conversion must assume an interpretation
```

`DateTimeOffset` can be converted to UTC:

```csharp
var utc = dto.ToUniversalTime();
```

and represented with another offset:

```csharp
var changed = dto.ToOffset(TimeSpan.FromHours(-5));
```

Important: `ToOffset` changes the displayed offset representation, not the instant in time.

Example:

```csharp
var utc = new DateTimeOffset(2025, 1, 10, 15, 0, 0, TimeSpan.Zero);
var est = utc.ToOffset(TimeSpan.FromHours(-5));
// same moment, different offset representation
```

## 2. Offset is not a full timezone

A value like:

```text
+02:00
```

is only an offset.

It does not tell:

```text
country
DST rules
timezone name
```

For real timezone conversion, use `TimeZoneInfo`.

Example:

```csharp
var tz = TimeZoneInfo.FindSystemTimeZoneById("Eastern Standard Time");
var local = TimeZoneInfo.ConvertTime(DateTimeOffset.UtcNow, tz);
```

Windows and Linux timezone IDs can differ:

```text
Windows: "Eastern Standard Time"
Linux/IANA: "America/New_York"
```

That means serious cross-platform timezone logic may need a mapping strategy. The practical rule in the notes is to keep UTC in storage and convert near UI/display boundaries.

## 3. Converting UTC to a user's local timezone

If the user has a timezone ID:

```csharp
var userTz = TimeZoneInfo.FindSystemTimeZoneById(user.TimeZoneId);
var local = TimeZoneInfo.ConvertTime(DateTimeOffset.UtcNow, userTz);
```

This is different from `.LocalDateTime` / `.ToLocalTime()` because those use the server's local timezone. In ASP.NET Core, the server could be Windows, Linux, Docker, Azure, AWS, or a dev machine. "Local" means the machine running the process, not the browser user's timezone.

For displaying a user's local time, use the user's timezone ID and `TimeZoneInfo.ConvertTime`.

## 4. JSON in ASP.NET Core

`System.Text.Json` handles common time types well:

```text
DateTime
DateTimeOffset
TimeSpan
DateOnly / TimeOnly in newer .NET versions
```

Example JSON timestamp:

```json
{
  "createdAt": "2025-01-10T14:30:00+00:00"
}
```

Best practice for API payloads:

```text
return ISO 8601 timestamps
prefer DateTimeOffset for timestamp values
```

`DateOnly` / `TimeOnly` can be used for domain values that are not instants.

## 5. Model binding in ASP.NET Core

ASP.NET Core can bind ISO 8601 values from query/body.

Example query binding with `DateTimeOffset`:

```csharp
[HttpGet]
public IActionResult Get([FromQuery] DateTimeOffset from)
{
    return Ok(from);
}
```

Request:

```text
/api/items?from=2025-01-10T14:30:00Z
```

For date-only values:

```csharp
[HttpGet]
public IActionResult Get([FromQuery] DateOnly date)
{
    return Ok(date);
}
```

This matches the R01/R03 rule: use type choice and format contracts intentionally. `DateTimeOffset` is good for instants; `DateOnly` is good for date-only input.

## What should be recallable

- Why an offset is not a timezone and how to convert a UTC instant for a user's zone.
- How ASP.NET Core JSON and model binding handle date/time values and why contracts need explicit semantics.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R04-timezones-conversion-json-model-binding-dst.md`, listed sections
- Original SVG: `source/time.svg`
