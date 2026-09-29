# .NET time types and model selection

Knowledge ID: `dotnet.time-types-and-model-selection`

Topic: `dotnet`

## 1. Common rule and API model choices

The opening rule is: for backend apps, APIs, and databases, treat timestamps as instants and keep them unambiguous.

Good default:

```csharp
var now = DateTimeOffset.UtcNow;
```

A good DTO uses `DateTimeOffset` for timestamps, nullable `DateTimeOffset?` for optional timestamp fields, and `TimeSpan` for durations:

```csharp
public class OrderDto
{
    public DateTimeOffset CreatedAt { get; set; }
    public DateTimeOffset? PaidAt { get; set; }
    public TimeSpan ProcessingTime { get; set; }
}
```

A plain `DateTime` timestamp is marked as "often not ideal" unless the project has a strict UTC policy:

```csharp
public class OrderDto
{
    public DateTime CreatedAt { get; set; } // ambiguous unless strict UTC policy
}
```

For date-only input, use `DateOnly`:

```csharp
public class ReportRequest
{
    public DateOnly StartDate { get; set; }
    public DateOnly EndDate { get; set; }
}
```

## 2. Core .NET time types

### `DateTime`

`DateTime` represents a date and time, but its meaning depends on `Kind`.

A `DateTime` can be:

```text
Utc
Local
Unspecified
```

Example:

```csharp
var utc = DateTime.UtcNow;                 // Kind = Utc
var local = DateTime.Now;                  // Kind = Local
var unspec = new DateTime(2025, 1, 1);     // Kind = Unspecified
```

The important warning is that `Unspecified` is ambiguous in APIs.

Prefer:

```csharp
DateTime utc = DateTime.UtcNow;
```

Avoid ambiguous constructed values when the meaning is not attached:

```csharp
DateTime ambiguous = new DateTime(2025, 1, 1, 10, 0, 0);
```

### `DateTimeOffset`

`DateTimeOffset` is a date/time plus an offset from UTC.

Examples:

```csharp
DateTimeOffset dto = DateTimeOffset.UtcNow;
DateTimeOffset dto2 = DateTimeOffset.Now;
```

Offset examples:

```text
2025-01-10T14:00:00+00:00
2025-01-10T09:00:00-05:00
```

Use it for:

```text
API request/response timestamps
audit fields
created/updated dates
logs
scheduling timestamps
```

### `TimeSpan`

`TimeSpan` is duration, not a point in time.

```csharp
TimeSpan duration = TimeSpan.FromMinutes(90);
```

Use it for timeout values, elapsed time, expiration periods, and intervals.

### `DateOnly` and `TimeOnly`

`DateOnly` is for a date without a time:

```csharp
DateOnly birthday = new DateOnly(1990, 5, 10);
```

Use for birthdays, holidays, due dates, business dates.

`TimeOnly` is for time of day without date:

```csharp
TimeOnly opening = new TimeOnly(9, 30);
```

Use for store opening hours, daily schedule times, recurring time-of-day values.

## 3. What to use when

Use `DateTimeOffset` for values like:

```text
CreatedAt
UpdatedAt
token expiration instants
event timestamps
request timestamps
```

Example:

```csharp
public DateTimeOffset CreatedAtUtc { get; set; }
```

Use `DateTime` only when integrating with older APIs/libraries, when a library specifically requires it, or when `Kind` is controlled carefully.

Use `TimeSpan` for durations:

```csharp
TimeSpan ttl = TimeSpan.FromHours(1);
```

Use `DateOnly` / `TimeOnly` for business/domain values that are not timestamps.

## What should be recallable

- How DateTime, DateTimeOffset, TimeSpan, DateOnly, and TimeOnly represent different domains.
- Which type to choose for instants, offsets, durations, dates, and wall-clock times.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R01-core-types-offset-ticks-unix-js.md`, listed sections
- Original SVG: `source/time.svg`
