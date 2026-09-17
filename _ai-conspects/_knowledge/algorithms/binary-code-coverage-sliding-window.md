# Binary-code coverage with a rolling sliding window

Knowledge ID: `algorithms.binary-code-coverage-sliding-window`

Topic: `algorithms`

The problem is to decide whether a binary string contains every possible binary code of length `k` as a substring. There are exactly `2^k` required codes.

## Reduce generation to observed windows

A brute-force solution recursively generates every length-`k` string by appending `0` and `1`, then searches the input for every generated code. Generation already has `2^k` leaves, stores many strings, and repeated substring search multiplies the work and allocation cost.

The input itself contains all candidate occurrences: its contiguous windows of length `k`. A string of length `n` has `n - k + 1` such windows. Scan those windows, record distinct codes that actually occur, and stop when the observed count reaches `2^k`.

```csharp
if (k > s.Length)
    return false;

int required = 1 << k;
int windows = s.Length - k + 1;

if (windows < required)
    return false;
```

The second check is a pigeonhole bound: fewer total windows cannot contain more distinct codes. It also avoids allocating an exponential tracker for an input that is already known to fail. The shift must fit the chosen numeric type and the problem constraints.

Only cardinality matters after a tracker prevents duplicate counting:

```csharp
int needed = 1 << k;
int seenCount = 0;

// Increment only on a code's first occurrence.
// Return true immediately when seenCount == needed.
```

## Choose a distinct-code tracker

A `HashSet` is flexible: insert each substring or encoded integer and duplicates are ignored. Substring keys add allocation and string-hashing cost; an integer set is generally a better fit for this binary problem.

When `k` is small and bounded, every code maps to an integer in `[0, 2^k)`, so a boolean array is faster and more compact:

```csharp
var seen = new bool[1 << k];

if (!seen[code])
{
    seen[code] = true;
    seenCount++;
}
```

Use a boolean array for a small bounded universe. Use a `HashSet<int>` when the universe is sparse or too large to allocate directly. The boolean array still costs `O(2^k)` memory, so constraints must be checked before shifting and allocating.

## Encode each window without substrings

A rolling integer represents the current `k` bits. Shift the previous code left, append the new bit with OR, and mask away bits older than the window:

```csharp
int code = 0;
int mask = (1 << k) - 1;

for (int i = 0; i < s.Length; i++)
{
    code = ((code << 1) & mask) | (s[i] - '0');

    if (i >= k - 1)
    {
        if (!seen[code])
        {
            seen[code] = true;
            seenCount++;

            if (seenCount == required)
                return true;
        }
    }
}

return false;
```

Binary characters have consecutive character codes, so subtracting `'0'` maps `'0'` to `0` and `'1'` to `1`.

The scan is `O(n)`. The boolean tracker uses `O(2^k)` memory, and each rolling update is constant time. Use a wider numeric type or a different representation when `k` approaches the integer bit width.

## Related knowledge

- `algorithms.fixed-width-bitmask-window` — why `(1 << k) - 1` retains exactly the latest `k` bits.

## What should be recallable

- Why scanning observed windows replaces recursive generation and repeated search.
- The `k > n` and `n - k + 1 < 2^k` early-failure checks.
- Why a count works only together with duplicate-aware tracking.
- Boolean-array versus integer-`HashSet` tradeoffs.
- The shift, mask, append, and early-success mechanics of the rolling implementation.
- Its `O(n)` time and `O(2^k)` boolean-tracker cost.

## Sources

- Workspace: `_ai-conspects/problem2/`
- Authoritative processed source: `06-full-combined-final-transcript.md`, R01–R04
- Original SVG: `source/problem2.svg`
