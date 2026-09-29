# DateTime offset, Kind, conversion, and arithmetic

Knowledge ID: `dotnet.datetime-offset-kind-conversion-and-arithmetic`

Topic: `dotnet`

## 4. Offset semantics and `LocalDateTime`

The offset in `DateTimeOffset` is the difference between that represented time and UTC.

Examples:

```text
+00:00 means same as UTC
+02:00 means 2 hours ahead of UTC
-05:00 means 5 hours behind UTC
```

Formula:

```text
UTC = local time - offset
```

Examples:

```text
14:00 +02:00 -> UTC is 12:00
14:00 -05:00 -> UTC is 19:00
```

So `DateTimeOffset` is "a date/time value, plus how far it is from UTC", which makes it less ambiguous than plain `DateTime`.

The format:

```text
2025-01-10T14:00:00+00:00
```

breaks down as year, month, day, `T` separator, time, and offset from UTC. It means January 10, 2025 at 14:00:00 with zero offset from UTC.

`dto.LocalDateTime` is local to the machine running the code:

```csharp
var local = dto.LocalDateTime;
```

In a server app, that usually means the server timezone, not the end user's timezone. If the ASP.NET app runs on a UTC server, `.LocalDateTime` often gives UTC-like server-local time. If it runs in New York, it gives New York local time.

## 5. `Kind`, `SpecifyKind`, and conversion

If you know a `DateTime` value is actually UTC, you can mark the `Kind` using `SpecifyKind`:

```csharp
var dt = new DateTime(2025, 1, 10, 14, 0, 0);
var utc = DateTime.SpecifyKind(dt, DateTimeKind.Utc);
```

This does not shift the clock. It says "interpret this value as UTC".

If you know it is local:

```csharp
var dt = new DateTime(2025, 1, 10, 14, 0, 0);
var local = DateTime.SpecifyKind(dt, DateTimeKind.Local);
var utc = local.ToUniversalTime();
```

When converting `DateTime` to UTC:

```text
Kind == Utc         -> ToUniversalTime() is effectively no real change.
Kind == Local       -> .NET converts using the machine's local timezone rules.
Kind == Unspecified -> .NET must assume; in practice ToUniversalTime() treats it like local time.
```

That makes `Unspecified` risky: if the server is UTC+2 and the value was meant to be 14:00 UTC, `.ToUniversalTime()` may incorrectly turn it into 12:00 UTC.

For UTC to local:

```csharp
var utc = DateTime.UtcNow;
var local = utc.ToLocalTime();
```

This converts to the machine's local timezone, not automatically the user's timezone.

The notes also make explicit that ASP.NET Core runs on an OS: Windows Server, Linux server, Docker on Linux, local dev machine, Azure/App Service/VM, AWS EC2, and so on. That matters because "local" is the machine/OS local zone of the process.

## 6. Adding, subtracting, comparing, and expiration

Adding and subtracting:

```csharp
var tomorrow = DateTimeOffset.UtcNow.AddDays(1);
var nextHour = DateTimeOffset.UtcNow.AddHours(1);
var nextMonth = DateTimeOffset.UtcNow.AddMonths(1);
```

Difference between two timestamps gives a `TimeSpan`:

```csharp
TimeSpan diff = end - start;
```

Example:

```csharp
var start = DateTimeOffset.UtcNow;
var end = start.AddMinutes(90);
TimeSpan duration = end - start;
```

Comparing times:

```csharp
if (a < b) { }
if (a > b) { }
if (a == b) { }
```

Expiration check:

```csharp
if (DateTimeOffset.UtcNow >= expiresAt)
{
    // expired
}
```

Duration check:

```csharp
if (elapsed > TimeSpan.FromSeconds(30))
{
    // too slow
}
```

Expiration pattern:

```csharp
var expiresAt = DateTimeOffset.UtcNow.AddMinutes(30);
bool expired = DateTimeOffset.UtcNow >= expiresAt;
```

Sliding window pattern:

```csharp
var lastSeen = DateTimeOffset.UtcNow;
var idleTimeout = TimeSpan.FromMinutes(20);

bool isExpired = DateTimeOffset.UtcNow - lastSeen > idleTimeout;
```

## What should be recallable

- What an offset means, what DateTime.Kind changes, and what SpecifyKind does not convert.
- How instant comparison, expiration, adding, and subtracting depend on the chosen model.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R01-core-types-offset-ticks-unix-js.md`, listed sections
- Original SVG: `source/time.svg`
