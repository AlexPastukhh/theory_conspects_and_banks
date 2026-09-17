# Locale-aware comparison with Intl.Collator

Knowledge ID: `javascript.intl-collator`

Topic: `javascript`

## Core model

Use locale-aware comparison for human-readable text such as names, titles, labels, and localized UI strings. `String.prototype.localeCompare` is convenient for an occasional comparison, while `Intl.Collator` centralizes the locale and options in a reusable comparator.

```ts
const result = a.localeCompare(
  b,
  "en",
  { sensitivity: "base" },
);
```

Interpret only the sign of the result:

```text
negative -> a comes before b
zero     -> equal under the chosen collation rules
positive -> a comes after b
```

Do not depend on the exact values being `-1`, `0`, and `1`.

For repeated operations, construct and reuse a collator:

```ts
const collator = new Intl.Collator("en", {
  usage: "sort",
  sensitivity: "variant",
  numeric: true,
});

items.sort(collator.compare);
```

Reuse keeps the comparison policy explicit and avoids recreating it throughout sorting or filtering code.

## Sensitivity

```text
base
  ignores case and accents;

accent
  ignores case but distinguishes accents;

case
  distinguishes case and often ignores accent differences at base level;

variant
  distinguishes case and accents.
```

For case-insensitive but accent-sensitive comparison:

```ts
const collator = new Intl.Collator("en", {
  sensitivity: "accent",
});
```

## Other options

- `numeric: true` orders embedded number sequences naturally, such as `file2` before `file10`.
- `ignorePunctuation` controls whether punctuation differences participate.
- `caseFirst` controls uppercase/lowercase ordering where supported.
- `collation` requests a locale-specific collation.
- `localeMatcher` controls locale lookup strategy.

Not every locale supports every requested behavior identically. For technical identifiers requiring byte or code-point predictability, ordinary comparison or explicit normalization may be more appropriate.

## What should be recallable

- When is `localeCompare` sufficient, and when is a reusable `Intl.Collator` preferable?
- What part of the comparison return value is portable?
- How do `base`, `accent`, `case`, and `variant` sensitivity differ?
- What does `numeric: true` change?
- Why might locale collation be inappropriate for machine identifiers?

## Related knowledge

- `javascript.collation-sort-vs-search` — choosing comparison rules for ordering or equivalence matching.

## Sources

- Workspace: `_ai-conspects/js sorting/`
- Processed source: `01-final-transcript.md`, R01 and R02
- Original SVG: `source/js sorting.svg`
