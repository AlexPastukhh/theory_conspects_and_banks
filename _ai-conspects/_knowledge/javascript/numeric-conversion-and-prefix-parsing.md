# Numeric conversion and prefix parsing

Knowledge ID: `javascript.numeric-conversion-and-prefix-parsing`

Topic: `javascript`

Unary `+` and `Number(value)` convert the entire value. Valid surrounding whitespace is ignored; `""`, whitespace-only strings, and `null` become `0`; booleans become `1`/`0`; `undefined` and mixed text such as `"123abc"` become `NaN`. Use this family when the complete input must be numeric, guarding unwanted coercions explicitly.

`parseInt(input, 10)` parses an integer prefix: `"123abc"` and `"123.45"` produce `123`, while `"abc123"` fails. It stops before the fraction rather than rounding. `parseFloat` also parses a prefix but retains a valid fraction, so `"123.45abc"` produces `123.45`. Invalid results are `NaN`; use `Number.isNaN(result)` when failure is possible.

For one contractually ASCII digit, direct conversion can avoid general parsing:

```js
function charToDigitAscii(ch) {
  if (typeof ch !== "string" || ch.length !== 1) return NaN;
  const code = ch.charCodeAt(0);
  return code >= 48 && code <= 57 ? code - 48 : NaN;
}
```

ASCII `0…9` occupy consecutive codes `48…57`; this fast path does not support other Unicode digits.

## Sources
- Workspace: `_ai-conspects/parse string to int, convert char/`
- Processed source: `01-detailed-near-literal-transcript.md`, complete transcript

