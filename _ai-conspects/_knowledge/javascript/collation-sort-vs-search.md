# Collation for sorting versus search matching

Knowledge ID: `javascript.collation-sort-vs-search`

Topic: `javascript`

## Core model

Collation for ordering and collation for matching have different goals.

```text
usage: "sort"
  -> produce a consistent order;

usage: "search"
  -> decide whether values are equivalent for matching/filtering.
```

Use a sort collator as an `Array.sort` comparator:

```ts
const collator = new Intl.Collator("de", {
  usage: "sort",
  sensitivity: "variant",
});

names.sort(collator.compare);
```

Use a search collator to test equivalence:

```ts
const collator = new Intl.Collator("en", {
  usage: "search",
  sensitivity: "base",
});

const matches = items.filter(
  item => collator.compare(item, query) === 0,
);
```

Do not use a search collator as the comparator for `Array.sort`. Search rules can classify distinct strings as equivalent, producing surprising ordering rather than the strict, consistent order sorting needs.

## Practical presets

Case- and accent-insensitive matching:

```ts
new Intl.Collator(locale, {
  usage: "search",
  sensitivity: "base",
});
```

Natural sorting of user-visible numbered strings:

```ts
new Intl.Collator(locale, {
  usage: "sort",
  sensitivity: "variant",
  numeric: true,
});
```

The required semantics determine the preset: ordering uses sort rules, equivalence/filtering uses search rules, and sensitivity must be chosen deliberately.

## What should be recallable

- How do `usage: "sort"` and `usage: "search"` differ?
- Why should a search collator not be passed to `Array.sort`?
- Which settings fit case- and accent-insensitive matching?
- Which settings fit natural user-visible sorting?
- Why must sensitivity be an explicit product decision?

## Related knowledge

- `javascript.intl-collator` — comparison API, sensitivity, and other collation options.

## Sources

- Workspace: `_ai-conspects/js sorting/`
- Processed source: `01-final-transcript.md`, R03
- Original SVG: `source/js sorting.svg`
