# Ambiguous local-time scheduling and audit

Knowledge ID: `dotnet.ambiguous-local-time-scheduling-and-audit`

Topic: `dotnet`

## 6. Ambiguous local time

An ambiguous local time is a wall-clock time that happens twice in the same timezone.

This happens during fall-back DST transitions.

Example:

```text
clock goes backward
02:30 happens once with DST offset
then again with standard offset
```

In .NET:

```csharp
if (tz.IsAmbiguousTime(localClockTime))
{
    TimeSpan[] offsets = tz.GetAmbiguousTimeOffsets(localClockTime);
}
```

`GetAmbiguousTimeOffsets` returns the possible offsets for that local clock time.

Example conceptual output:

```text
+02:00
+01:00
```

The key point: the local clock value alone is not enough to know the UTC instant. You must choose one offset or a policy.

## 7. Ambiguous-time policy: choose earlier occurrence

Policy:

```text
Pick the earlier occurrence.
```

Meaning:

```text
choose the first time the wall clock shows that value
```

Example:

```text
02:30 DST
02:30 standard
earlier occurrence -> first one
```

Good when the rule means:

```text
run at the earliest instant when the wall clock first shows that time
```

Common for:

```text
alarms
reminders
"do it when the clock first reaches that value"
```

Pseudo-code shape:

```csharp
var offsets = tz.GetAmbiguousTimeOffsets(localClockTime);
var earlierUtc = offsets
    .Select(offset => new DateTimeOffset(localClockTime, offset).UtcDateTime)
    .Min();
```

## 8. Ambiguous-time policy: choose later occurrence

Policy:

```text
Pick the later occurrence.
```

Meaning:

```text
choose the second time the wall clock shows that value
```

Good when the rule means:

```text
run after the transition has fully settled
```

Pseudo-code shape:

```csharp
var offsets = tz.GetAmbiguousTimeOffsets(localClockTime);
var laterUtc = offsets
    .Select(offset => new DateTimeOffset(localClockTime, offset).UtcDateTime)
    .Max();
```

## 9. Ambiguous-time policy: run once by fixed rule

Policy:

```text
Run only once, always choosing earlier or always choosing later.
```

This is the most common practical choice because it prevents duplicate execution.

The important thing is consistency:

```text
always choose earlier
or always choose later
```

Use explicit names:

```text
ResolveAmbiguousTimeToEarlierUtc
ResolveAmbiguousTimeToLaterUtc
```

rather than hidden ad-hoc offset choices.

## 10. Ambiguous-time policy: run twice

Policy:

```text
Run once for each possible UTC instant.
```

This is uncommon but sometimes correct if the rule literally means:

```text
every time the wall clock displays 02:30
```

Usually not what users expect for reminders, but it can be valid for clock-driven automation or specialized systems.

Pseudo-code shape:

```csharp
var offsets = tz.GetAmbiguousTimeOffsets(localClockTime);

var utcInstants = offsets
    .Select(offset => new DateTimeOffset(localClockTime, offset).UtcDateTime)
    .OrderBy(x => x)
    .ToList();
```

## 11. Display and diagnostics

The notes include two practical uses of DST-related information:

```text
display / diagnostics
business rules
```

For display or logs, you may show:

```text
current offset is +02:00 because DST is active
current offset is +01:00 because standard time is active
```

For special business rules, a system might care because it has different tariffs, hour labels, or operational behavior depending on DST vs non-DST.

`IsDaylightSavingTime` can help explain or audit behavior:

```text
why did today's reminder fire at a different UTC time?
why did today have 23 hours?
```

## 12. Reporting and audit

It may be useful to label events as:

```text
occurred during daylight time
occurred during standard time
```

This is especially helpful for:

```text
billing
tariffs
support/debugging
financial/compliance reports
```

The policy decision should be visible in logs and data:

```text
requested local time
timezone id
invalid/ambiguous state
chosen policy
chosen offset
resolved UTC instant
```

## 13. Scheduling delays and `TimeSpan`

After resolving an invalid or ambiguous local time into one concrete UTC instant, scheduling/timers can use `TimeSpan`.

Delay example:

```csharp
await Task.Delay(timeSpan.FromSeconds(5), cancellationToken);
```

Timeout pattern:

```csharp
using var cts = new CancellationTokenSource(TimeSpan.FromSeconds(30));
await service.DoWorkAsync(cts.Token);
```

Use `TimeSpan` for:

```text
delays
timeouts
durations
```

But do not use a naked `TimeSpan` as the policy for "same local wall-clock time in a timezone" until the concrete instant has been chosen.

## 14. Practical resolver shape

A realistic resolver needs separate handling:

```csharp
DateTime ResolveLocalTime(
    DateTime localClockTime,
    TimeZoneInfo tz,
    InvalidTimePolicy invalidPolicy,
    AmbiguousTimePolicy ambiguousPolicy)
{
    if (tz.IsInvalidTime(localClockTime))
    {
        return ResolveInvalid(localClockTime, tz, invalidPolicy);
    }

    if (tz.IsAmbiguousTime(localClockTime))
    {
        return ResolveAmbiguous(localClockTime, tz, ambiguousPolicy);
    }

    return TimeZoneInfo.ConvertTimeToUtc(localClockTime, tz);
}
```

The exact policies depend on product behavior, but the important architecture is:

```text
detect invalid
detect ambiguous
resolve by explicit policy
only then convert / schedule
```

## What should be recallable

- Why DST overlap creates two candidate instants and how earlier/later/once/twice policies differ.
- What diagnostics, audit records, TimeSpan delays, and a practical resolver must preserve.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R05-invalid-ambiguous-time-policies.md`, listed sections
- Original SVG: `source/time.svg`
