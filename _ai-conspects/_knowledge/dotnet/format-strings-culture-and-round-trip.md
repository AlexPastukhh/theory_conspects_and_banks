# .NET format strings, culture, and round-trip output

Knowledge ID: `dotnet.format-strings-culture-and-round-trip`

Topic: `dotnet`

Formatting converts values to text through the type-specific `ToString(format, provider)` contract. Parameterless numeric `ToString()` is generally similar to the general representation. Standard numeric formats include `G` general, `F` fixed, `N` grouped number, `C` currency, `P` percent (multiplies by 100), `E` exponential, integer-only `D`/`X`, and supported round-trip `R`. Precision is format-specific: `F2` means two decimals, `D5` at least five decimal digits, and `X4` at least four hexadecimal digits.

```csharp
1234.5.ToString("F2"); // 1234.50
0.1234.ToString("P1"); // 12.3 % (culture-dependent)
255.ToString("X4");    // 00FF
42.ToString("D5");     // 00042
```

Culture controls separators, symbols, and names. Use UI culture for user-facing output and an explicit invariant representation for protocols/interchange. Custom tokens include required `0`, optional `#`, `.` as a decimal placeholder, `,` as a group separator or scaling marker, percent, and per-mille. Formattable types include integral/floating numbers, `decimal`, `BigInteger`, `DateTime`, `DateTimeOffset`, `DateOnly`, `TimeOnly`, and `TimeSpan`; date/time types have their own syntax (`yyyy-MM-dd`, `TimeSpan` `@"hh\:mm\:ss"`). `Guid` supports `N/D/B/P`; enums support name/general, decimal, and hex forms. Custom types can implement `IFormattable` or a formatter/provider.

Some types—including `Uri`, `Version`, exceptions, and framework-specific objects—have a meaningful parameterless `ToString()` but no standard format-string language. A useful `ToString()` override does not imply support for arbitrary format specifiers.

Round-trip formatting aims to parse back to the same value; it is not decimal-place rounding or display formatting. `R`, or explicit sufficient general precision such as `G17` for `double` and `G9` for `float`, serves exact recovery scenarios. `float` has roughly 7 decimal digits of precision and `double` roughly 15–16.

## Date/time standard and custom format transcript

## 5. Custom parse/format strings

You can use custom formats with `ParseExact`:

```csharp
var dt = DateTime.ParseExact(
    "2026-04-20",
    "yyyy-MM-dd",
    CultureInfo.InvariantCulture);
```

Common custom patterns:

```text
yyyy-MM-dd
yyyy-MM-dd HH:mm:ss
yyyy-MM-ddTHH:mm:ss
yyyy-MM-ddTHH:mm:sszzz
```

Example with offset:

```csharp
var dto = DateTimeOffset.ParseExact(
    "2026-04-20T14:36:00+02:00",
    "yyyy-MM-ddTHH:mm:sszzz",
    CultureInfo.InvariantCulture);
```

Custom format strings must match the text exactly. If the input contains `T`, `-`, `:`, offset, fractional seconds, or AM/PM, the pattern must account for them.

## 6. Formatting with standard formats

You can format `DateTime` and `DateTimeOffset` with standard format strings:

```csharp
DateTimeOffset dto = DateTimeOffset.UtcNow;

Console.WriteLine(dto.ToString("O"));
Console.WriteLine(dto.ToString("R"));
Console.WriteLine(dto.ToString("s"));
Console.WriteLine(dto.ToString("u"));
```

Useful rules:

```text
DateTimeOffset is usually better when you care about a real instant plus offset.
DateTime is fine, but it depends on Kind and whether it represents local/UTC/unspecified time.
```

Format cheat sheet:

```text
O / o -> round-trip ISO 8601 style, includes enough precision/offset info
R / r -> RFC 1123 / GMT style
s     -> sortable, like yyyy-MM-ddTHH:mm:ss
u     -> universal sortable, UTC-style output
```

## 7. Why plain `ToString()` is not enough

Calling `ToString()` on `DateTimeOffset` without a format uses the current culture's default pattern.

That means the same value may look different on different machines/cultures:

```text
4/20/2026 7:46:05 AM +02:00
02.04.2026 14:05:00 +02:00
```

This is usually not what you want for:

```text
APIs
persistence
headers
logs
machine-to-machine strings
sorting strings
```

For stable machine output, use explicit formats: `O`, `R`, `s`, `u`, or a custom invariant format.

## 8. Sortable and universal sortable formats

`"s"` is the sortable date/time pattern. It produces a fixed, culture-invariant shape like:

```text
yyyy-MM-ddTHH:mm:ss
```

Example output:

```text
2026-04-02T14:25:36
```

It sorts lexicographically because the components are ordered from most significant to least significant:

```text
year -> month -> day -> hour -> minute -> second
```

But `"s"` does not include an offset, so it is not enough when timezone/offset information must travel with the value.

`"u"` is the universal sortable pattern:

```text
yyyy-MM-dd HH:mm:ssZ
```

It produces a UTC-style stable output and is useful when you need sortable UTC text. The source notes that `u` is not usually the default for ASP.NET public APIs because JSON serializers already handle ISO 8601 well.

## 9. Round-trip / ISO format

`"O"` / `"o"` is the round-trip format.

For `DateTimeOffset`, it preserves enough information to round-trip the instant and offset:

```csharp
var dto = DateTimeOffset.UtcNow;
string text = dto.ToString("O");

var parsed = DateTimeOffset.ParseExact(
    text,
    "O",
    CultureInfo.InvariantCulture);
```

Typical shape:

```text
2026-04-20T14:35:06.0000000+00:00
```

Use `"O"` when you need a stable exact machine string that can be parsed back.

## 10. RFC 1123

Use RFC 1123 / `"R"` for HTTP-date style strings.

Typical consumers:

```text
HTTP headers
Last-Modified
Expires
```

Example:

```text
Tue, 17 Apr 2026 12:34:56 GMT
```

In .NET:

```csharp
var text = DateTimeOffset.UtcNow.ToString("R");
```

Do not use RFC 1123 for normal JSON bodies unless you have a specific reason. It is mainly an HTTP header format.

## 11. Unix time as a format choice

Unix time is a numeric timestamp, not a formatted local string.

Example:

```text
1736517600
```

It is seconds since the Unix epoch:

```text
1970-01-01T00:00:00Z
```

Use Unix time when:

```text
both sides are tightly controlled
you want compact numeric timestamps
you are doing frontend/client comparisons
you work with systems that already use epoch timestamps
```

Downsides:

```text
not human-readable
unit ambiguity: seconds vs milliseconds vs microseconds
no explicit timezone info in the value itself
easier for clients to misuse
```

If Unix time is used in an API, document the unit clearly:

```text
expiresAtUnixSeconds
expiresAtUnixMs
```

Do not leave it ambiguous.

## 12. Custom format tokens: date parts

Most useful date tokens:

```text
yyyy -> 4-digit year
yy   -> 2-digit year
M    -> month number
MM   -> zero-padded month
MMM  -> abbreviated month name
MMMM -> full month name
d    -> day number
dd   -> zero-padded day
ddd  -> abbreviated day name
dddd -> full day name
```

Examples:

```csharp
dt.ToString("yyyy");  // 2026
dt.ToString("yy");    // 26

dt.ToString("M");     // 4
dt.ToString("MM");    // 04
dt.ToString("MMM");   // Apr
dt.ToString("MMMM");  // April

dt.ToString("d");     // 2
dt.ToString("dd");    // 02
dt.ToString("ddd");   // Thu
dt.ToString("dddd");  // Thursday
```

## 13. Custom format tokens: time parts

24-hour clock:

```text
H  -> hour, 0-23
HH -> zero-padded hour, 00-23
```

12-hour clock:

```text
h  -> hour, 1-12
hh -> zero-padded hour, 01-12
```

Minutes and seconds:

```text
m  -> minute
mm -> zero-padded minute
s  -> second
ss -> zero-padded second
```

Examples:

```csharp
dt.ToString("HH:mm");    // 14:05
dt.ToString("hh:mm tt"); // 02:05 PM
```

Important: use `HH` for 24-hour time. Use `hh ... tt` for 12-hour time. Do not mix `HH` with `tt`.

## 14. Fractional seconds

`f` tokens require fractional-second digits:

```text
f       -> 1 digit
ff      -> 2 digits
fff     -> 3 digits / milliseconds
fffffff -> 7 digits
```

Example:

```csharp
dt.ToString("HH:mm:ss.fff"); // 14:05:06.123
```

`F` tokens are optional fractional-second digits. They print only significant digits and trim trailing zeros:

```text
F
FF
FFF
FFFFFFF
```

This is useful when you want fractions only when needed.

## 15. AM/PM, offset, era, separators, literals, escaping

AM/PM:

```text
tt -> AM/PM designator
```

Offset tokens:

```text
z   -> hour offset
zz  -> zero-padded hour offset
zzz -> hour and minute offset
```

Use offset tokens when formatting a `DateTimeOffset`, or a `DateTime` value with meaningful zone handling.

Era token:

```text
g -> era designator
```

Separators:

```text
: -> time separator
/ -> date separator
```

They use culture-specific separators in custom patterns.

Literal text can be put in quotes:

```csharp
dt.ToString("yyyy-MM-dd 'at' HH:mm:ss")
```

Escaping is needed when a character that is normally a format token should be treated as a literal.

Example:

```csharp
dt.ToString("yyyy-MM-dd'T'HH:mm:ss")
```

The quoted `T` is literal text, not a format token.

### Stage3 correction: escaping one character with backslash

During R04 boundary review, `S-158` was found to be a formatting screenshot, not timezone material.
It completes the custom-format escaping road.

Backslash escaping can make one normally meaningful format character literal:

```csharp
dt.ToString("HH\\h mm\\m ss\\s")
```

Output shape:

```text
14h 05m 06s
```

Without escaping, `h`, `m`, and `s` would be interpreted as formatting tokens.
Another example escapes literal colons:

```csharp
dt.ToString("yyyy-MM-ddTHH\\:mm\\:ss")
```

Meaning: `\\:` means literal colon.

## Composite formatting and interpolation

`string.Format` uses zero-based numbered placeholders that select arguments after the format string:

```csharp
string.Format("{0} is {1} years old", "Alice", 30);
// "Alice is 30 years old"
```

```text
{0} -> "Alice"
{1} -> 30
```

Its replacement arguments are supplied through `params object[]`. An array passed in that position can therefore supply multiple placeholder values:

```csharp
string[] name = ["Peter", "Jacob"];
string[] pattern = [
    "Nobody likes this",
    "{0} likes this",
    "{0} and {1} like this"
];

string result = string.Format(pattern[name.Length], name);
// "Peter and Jacob like this"
```

In a pattern table, one index can choose the format string while the array supplies `{0}`, `{1}`, and later values.

Interpolation and composite formatting can produce the same output shape:

```csharp
var name = "Alex";
var age = 25;

var interpolated = $"Name={name}, Age={age}";
var composite = string.Format("Name={0}, Age={1}", name, age);
```

Use interpolation when values are directly available and readability is central. `string.Format` is useful when the pattern is data-driven, selected dynamically, localized, or stored separately from its values.

## Sources
- Workspace: `_ai-conspects/time/`
- Authoritative processed source: `regions/R03-parsing-formatting-cheat-sheets.md`, sections 5-15 including the S158 escaping correction
- Original SVG: `source/time.svg`

- Workspace: `_ai-conspects/formatting, numeric formatting, what can be formatted/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/STRING FORMAT,INTERPOLATION/`
- Authoritative reconstructed source: `regions/R01-string-format-interpolation-final-transcript-v001.md`, complete transcript
- Original SVG: `source/STRING FORMAT,INTERPOLATION.svg`
