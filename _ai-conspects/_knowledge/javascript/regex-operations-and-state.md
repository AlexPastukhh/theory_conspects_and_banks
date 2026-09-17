# JavaScript regex operations and state

Knowledge ID: `javascript.regex-operations-and-state`

Topic: `javascript`

JavaScript exposes operations with different result shapes:

- `test` returns a boolean;
- `search` returns the first match index or `-1`;
- `exec` returns one detailed match and supports manual global/sticky iteration;
- `matchAll` returns an iterator of all matches/groups and requires a global regex;
- `match` changes behavior and result shape with `g`;
- `replace` and `replaceAll` transform matches, while `split` accepts a regex delimiter.

Global/sticky expressions mutate `lastIndex`, so shared repeated `test` or `exec` calls are stateful and can alternate results. Reset `lastIndex` or isolate instances.

Literals suit static patterns; `new RegExp(pattern, flags)` suits runtime construction. Constructor strings undergo JavaScript escaping before regex parsing, often requiring doubled backslashes. Escape user input as a regex fragment, validate flags/no duplicates, and distinguish this from URL/HTML/shell escaping.

Flags change distinct parts of matching:

```text
g  find all matches; makes exec/test stateful through lastIndex
i  case-insensitive matching
m  ^ and $ operate at line boundaries
s  dot also matches line terminators
u  Unicode-aware pattern parsing semantics
y  match must begin exactly at lastIndex
d  expose match indices in supporting engines
```

Groups may be numeric or named; `(?:...)` groups alternatives without capturing, and backreferences require captured text to repeat. Anchor complete-value validation, prefer readable fragments, isolate stateful regexes, and avoid catastrophic or deeply nested grammar patterns. Unicode case-insensitive behavior can vary in surprising ways across languages.

Cache/reuse dynamically constructed expressions only when reuse is significant, and handle stateful `g`/`y` instances deliberately. When business rules exceed regex readability, separate parsing from validation instead of expanding one monolithic expression.

## Sources
- Workspace: `_ai-conspects/js regex/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
