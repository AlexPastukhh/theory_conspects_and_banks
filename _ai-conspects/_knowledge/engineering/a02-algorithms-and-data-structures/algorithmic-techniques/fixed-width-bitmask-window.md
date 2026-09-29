# Fixed-width rolling windows with a low-bit mask

Knowledge ID: `algorithms.fixed-width-bitmask-window`

Topic: `algorithms`

The mask

```csharp
int mask = (1 << k) - 1;
```

contains exactly `k` low-order one bits. `1 << k` is one followed by `k` zero bits; subtracting one turns those lower zeros into ones:

```text
k = 3: 1000 - 1 = 0111
k = 5: 100000 - 1 = 011111
```

ANDing a rolling value with this mask discards every bit older than the latest `k` positions:

```text
rolling code = 1101
k-bit mask   = 0111
result       = 0101  -> latest three bits are 101
```

A fixed-width update shifts the existing window, keeps only its permitted width, and appends the next binary digit:

```csharp
code = ((code << 1) & mask) | (currentChar - '0');
```

The next iteration repeats the same operation. This avoids constructing substring objects while keeping one integer representation of the current bit window.

The numeric type has fixed width. Ensure `1 << k`, the mask, and the rolling value fit it; choose a larger type or another strategy near the width limit. `k = 0` needs an explicit interpretation from the problem contract. If input is not guaranteed to contain only `'0'` and `'1'`, validate before relying on character subtraction.

## Related knowledge

- `algorithms.binary-code-coverage-sliding-window` — uses this mask to track all observed length-`k` binary codes.

## What should be recallable

- Why subtracting one from `1 << k` creates `k` low-order one bits.
- How AND removes bits outside a fixed-width rolling window.
- How shift, mask, OR, and character conversion compose one update.
- The numeric-width, `k = 0`, and input-alphabet caveats.

## Sources

- Workspace: `_ai-conspects/problem2/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R04 and R05
- Original SVG: `source/problem2.svg`
