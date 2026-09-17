# Invalid local-time resolution policies

Knowledge ID: `dotnet.invalid-local-time-resolution-policies`

Topic: `dotnet`

## 1. Invalid local time

An invalid local time is a wall-clock time that does not exist in a timezone.

This happens during spring-forward DST transitions.

Example idea:

```text
clock jumps from 02:00 to 03:00
02:30 never happens
```

In .NET, use `TimeZoneInfo.IsInvalidTime`:

```csharp
var tz = TimeZoneInfo.FindSystemTimeZoneById("Some/Timezone");
var localClockTime = new DateTime(2025, 3, 30, 2, 30, 0, DateTimeKind.Unspecified);

if (tz.IsInvalidTime(localClockTime))
{
    // local clock time does not exist in this timezone
}
```

Important: the local wall-clock `DateTime` should be `Unspecified`, because it is not machine-local and not UTC. It is a local clock value that you want to interpret in a specific `TimeZoneInfo`.

## 2. Invalid-time policy: move forward to next valid time

Policy:

```text
If requested local time does not exist, move forward to the next valid local time.
```

Example:

```text
wanted: 02:30
DST jump: 02:00 -> 03:00
actual run: 03:00
```

Good when the rule means:

```text
run as soon as possible after the intended local time
```

Common for:

```text
reminders
notifications
many user-facing schedules
```

Pseudo-code shape:

```csharp
while (tz.IsInvalidTime(localClockTime))
{
    localClockTime = localClockTime.AddMinutes(1);
}

var utc = TimeZoneInfo.ConvertTimeToUtc(localClockTime, tz);
```

## 3. Invalid-time policy: skip occurrence

Policy:

```text
If requested local time does not exist, do not run on that day.
```

Example:

```text
wanted: 02:30
that time does not exist
no run that day
```

Good when the rule means:

```text
only run if the exact local time exists
```

Common for:

```text
strict calendar rules
compliance-sensitive jobs
systems where inventing another time would be misleading
```

Pseudo-code shape:

```csharp
if (tz.IsInvalidTime(localClockTime))
{
    return NoOccurrenceForThisDay;
}
```

## 4. Invalid-time policy: move backward to previous valid time

Policy:

```text
If requested local time does not exist, move backward to the previous valid local time.
```

Example:

```text
wanted: 02:30
actual run: 01:59:59 or 02:00-ish depending on chosen rule
```

This is less common, but can be useful when the business meaning is:

```text
do it before the transition if the exact time disappears
```

## 5. Invalid-time policy: reject schedule as invalid

Policy:

```text
If the user configures a schedule that becomes invalid on DST transition days, reject it or force a clearer choice.
```

Example:

```text
user chooses "02:30 every day"
system says this time may be invalid on DST transition days
choose a rule
```

Good for:

```text
scheduling platforms
admin tools
advanced job schedulers
```

This is often the cleanest design when the system cannot safely infer the user's intent.

## What should be recallable

- Why DST gaps create invalid wall-clock values.
- How move-forward, skip, move-backward, and reject policies differ and why the policy must be explicit.

## Related knowledge

- `dotnet.format-strings-culture-and-round-trip`

## Sources

- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R05-invalid-ambiguous-time-policies.md`, listed sections
- Original SVG: `source/time.svg`
