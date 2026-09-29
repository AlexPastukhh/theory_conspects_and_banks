# Timezone-aware date math and DST

Knowledge ID: `dotnet.timezone-date-math-and-dst`

Topic: `dotnet`

## 6. Date math pitfalls

The main warning is:

```text
"If I take a local time and do AddDays(1), I will always get the same clock time tomorrow in the user's timezone."
```

That is not always safe when real timezones and DST are involved.

A timezone can change offset during the year because of daylight saving time. A region may have one offset before the DST change and another offset after it.

So these are different requirements:

```text
exact elapsed duration: add 24 hours
same local wall-clock time next day: tomorrow at 09:00 in the user's timezone
```

Example elapsed duration:

```csharp
var later = dto.AddDays(1);
```

This moves forward by one day of elapsed time.

But a scheduling rule like:

```text
tomorrow at 9:00 AM in New York
```

is a wall-clock rule in a real timezone. Around DST transitions, the UTC instant behind that local time may not be exactly 24 hours later.

## 7. Recreate local wall-clock values instead of mutating instants

The notes emphasize a safer pattern: when you need a specific local time, recreate the local clock value instead of just adding to an instant.

For example, convert the current instant into the user's timezone, choose the target local calendar date, create a local wall-clock `DateTime` with `DateTimeKind.Unspecified`, then convert that local time to UTC using the user's timezone.

Example pattern:

```csharp
var tz = TimeZoneInfo.FindSystemTimeZoneById("Asia/Tokyo");
var utcNow = new DateTimeOffset(2025, 3, 31, 18, 30, 0, TimeSpan.Zero);

var localNow = TimeZoneInfo.ConvertTime(utcNow, tz); // 2025-04-01 03:30 +09:00

var targetDate = localNow.Date.AddDays(1);

var nextLocal = new DateTime(
    targetDate.Year,
    targetDate.Month,
    targetDate.Day,
    9, 0, 0,
    DateTimeKind.Unspecified);

var nextUtc = TimeZoneInfo.ConvertTimeToUtc(nextLocal, tz);
```

The core idea is:

```text
instant -> user's local calendar/clock -> intended local wall-clock value -> UTC instant
```

not:

```text
instant + guessed duration
```

## 8. Next month / next scheduled occurrence

For "same wall-clock time next month", use the user's timezone and local calendar first.

Example shape:

```csharp
var tz = TimeZoneInfo.FindSystemTimeZoneById("Europe/Berlin");
var localNow = TimeZoneInfo.ConvertTime(DateTimeOffset.UtcNow, tz);

var localNextMonthDate = localNow.Date.AddMonths(1);

var scheduledLocal = new DateTime(
    localNextMonthDate.Year,
    localNextMonthDate.Month,
    localNextMonthDate.Day,
    9, 0, 0,
    DateTimeKind.Unspecified);

var scheduledUtc = TimeZoneInfo.ConvertTimeToUtc(scheduledLocal, tz);
```

For "next 09:00 in user's timezone":

```csharp
var day = localNow.TimeOfDay >= TimeSpan.FromHours(9)
    ? localNow.Date.AddDays(1)
    : localNow.Date;

var nextLocal = new DateTime(
    day.Year, day.Month, day.Day,
    9, 0, 0,
    DateTimeKind.Unspecified);

var nextUtc = TimeZoneInfo.ConvertTimeToUtc(nextLocal, tz);
```

## 9. Same instant, different calendar date

A single UTC instant can be a different calendar date in another timezone.

Example from the source:

```text
Instant on the timeline:
2025-03-31 22:30:00 UTC

Tokyo:
2025-04-01 07:30 (+09:00)
```

Same moment, different calendar date.

This is why date-only assumptions can be wrong at timezone boundaries. If the user is in Tokyo, their "today" may already be tomorrow compared with UTC.

## 10. `DateTimeKind.Local` and explicit timezones

When using `TimeZoneInfo.ConvertTimeToUtc(localDateTime, timeZone)`, the `DateTime.Kind` matters.

Typical behavior:

```text
DateTimeKind.Unspecified -> interpret this wall-clock value in the provided timezone.
DateTimeKind.Local       -> this value is already local to the machine.
DateTimeKind.Utc         -> this value is already UTC.
```

If `Kind.Local` is used with a `timeZone` that is not the machine's local timezone, .NET can throw an `ArgumentException`.

The notes paraphrase the reason:

```text
"You told me this DateTime is already Local, so why are you also asking me to interpret it as Berlin?"
```

Practical rule:

```text
When constructing a user's local wall-clock time for a specific timezone, use DateTimeKind.Unspecified.
```

## 11. `IsDaylightSavingTime`

`IsDaylightSavingTime` is useful when you want to inspect or react to whether a specific local time is in DST.

It answers:

```text
for this date/time in this zone, is daylight saving currently in effect?
```

Useful cases:

```text
display/debugging
analytics
showing labels
conditional policy decisions
```

But it should not be treated as the whole timezone conversion engine. For conversion, scheduling, invalid/ambiguous detection, and edge-case policies, use the appropriate `TimeZoneInfo` APIs and explicit policy.

## What should be recallable

- Why wall-clock recurrence should be reconstructed in the target timezone rather than produced by mutating an instant.
- How month changes, calendar dates, DateTimeKind, and daylight-saving checks affect scheduling.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R04-timezones-conversion-json-model-binding-dst.md`, listed sections
- Original SVG: `source/time.svg`
