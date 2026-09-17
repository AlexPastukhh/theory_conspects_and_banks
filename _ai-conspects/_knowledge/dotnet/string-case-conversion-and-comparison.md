# .NET string case conversion and comparison

Knowledge ID: `dotnet.string-case-conversion-and-comparison`

Topic: `dotnet`

Case conversion can follow the current culture or the invariant culture:

```csharp
var s = "HeLLo";

var lower = s.ToLower();
var upper = s.ToUpper();

var lowerInvariant = s.ToLowerInvariant();
var upperInvariant = s.ToUpperInvariant();
```

`ToLower()` and `ToUpper()` use `CultureInfo.CurrentCulture`. Their result can vary by culture; Turkish casing is a familiar example. That behavior is appropriate when transforming user-facing text according to the user's locale.

`ToLowerInvariant()` and `ToUpperInvariant()` use invariant casing and therefore give stable results across machines and current-culture settings. They fit technical normalization such as logging keys, protocol-like strings, and other non-user-facing values.

Case conversion is not the preferred way to compare strings case-insensitively:

```csharp
// Avoid creating normalized copies only for comparison.
if (a.ToLower() == b.ToLower()) { }

// State the comparison contract directly.
if (string.Equals(a, b, StringComparison.OrdinalIgnoreCase)) { }
```

An explicit `StringComparison` avoids the two lowercase allocations, avoids accidental culture behavior, and makes the comparison intent clear. Choose another explicit comparison mode when ordinal-ignore-case is not the intended contract.

## What should be recallable

- Current-culture versus invariant case conversion.
- User-facing casing versus stable technical normalization.
- Why lowercasing both operands is inferior to an explicit case-insensitive comparison.

## Sources

- Workspace: `_ai-conspects/STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT/`
- Authoritative reconstructed source: `regions/R01-string-case-conversion-final-transcript-v001.md`, complete transcript
- Original SVG: `source/STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT.svg`
