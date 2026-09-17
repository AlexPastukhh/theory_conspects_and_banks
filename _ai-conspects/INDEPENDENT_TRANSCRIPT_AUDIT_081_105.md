# Independent transcript audit - registry rows 81-105

Date: 2026-07-04  
Registry used only as scope: `C:\Users\alexa\Downloads\svg-conspects-checked-scope-register-1-229-corrected.md`  
Repository folder: `C:\Users\alexa\obs\_ai-conspects`

## Scope control

```text
registry rows: 25 (81-105)
unique SVG entries: 25
duplicate registry rows: 0
matching repo folders: 25
entries without matching folder: 0
overlap with earlier audited batches in this workspace: 0
entries outside corrected registry: 0
```

Old status values were ignored. `CURRENT_SOURCE_OF_TRUTH.md`, `MANIFEST.md`, coverage audits and ledgers were used only for navigation and source-file discovery.

## Method

- Matched registry SVG names to repo folders using only name normalization.
- Chose actual transcript candidates instead of closure/status files.
- Checked whether each transcript can support repetition, question generation, and code/API/header/parameter reproduction without constantly opening SVG.
- Ran a text scan for mojibake, placeholders, final-only coverage notes, and exactness disclaimers.
- Spot-read high-risk short files and source-preserving candidates.

## Summary

```text
Good / usable as main study source: 12
Usable but not near-literal; needs source spot fixes: 13
Bad / no real transcript or too incomplete: 0
```

This batch is much healthier than rows 31-80: every checked entry has some real transcript content. The main recurring problem is not missing transcript, but semantic-only exactness: many files explicitly keep PNG/SVG authoritative for exact code punctuation, source-version details, or exact syntax.

## Register

| # | SVG from registry | Matched folder | Main transcript inspected | State | Score | Audit note |
|---:|---|---|---|---|---:|---|
| 81 | `objectpool,arraypool,memorypool.svg` | `objectpool,arraypool,memorypool` | `09-full-combined-final-transcript.md` | USABLE | 3/5 | Real integrated transcript with region files. It explicitly says SVG/recovered screenshots remain authoritative for exact punctuation/syntax; good for concepts, weaker for exact API/code reproduction. |
| 82 | `returning iqueryable,problems when returning ienumerable without tolist, async enumerable problems,yield.svg` | `returning-iqueryable-problems-when-returning-ienumerable-without-tolist-async-enumerable-problems-yield` | `regions/RIQ*.md` | GOOD | 4/5 | Detailed regional transcripts with many code fences. Root `02-stage2-next01-full-transcript.md` is mostly processing summary, but the region files are good study material. Some cropped/dark screenshot caveats remain. |
| 83 | `istringlocalizer iviewlocalizer.svg` | `istringlocalizer iviewlocalizer` | `regions/R01-final-transcript.md` | USABLE | 3/5 | Coherent compact transcript for `IStringLocalizer<T>`, `IViewLocalizer`, resources and culture selection. It says exact code punctuation remains in source images, so not near-literal. |
| 84 | `EXCEPTIONHANDLERS.svg` | `EXCEPTIONHANDLERS` | `04-stage4-corrected-source-preserving-transcript.md` | GOOD | 4/5 | Strong corrected source-preserving transcript with many code fences. Remaining risk: many mojibake hits in typographic punctuation and exact punctuation caveats for cropped/ambiguous code. |
| 85 | `CASE INSENS,collate.svg` | `CASE INSENS,collate` | `05-full-combined-final-transcript.md` | USABLE | 3/5 | Real transcript, good for collations/case-insensitive search/sargability. It is an authoritative semantic transcript and defers exact punctuation/details to SVG/screenshots. |
| 86 | `cookies, general theo, plain cookie options.svg` | `cookies-general-theo-plain-cookie-options` | `02-source-preserving-transcript-v002.md` | GOOD | 4/5 | Large source-by-source transcript with extensive coverage. Useful for repetition and options/API recall; needs Unicode/mojibake cleanup before being fully polished. |
| 87 | `working with bytes, streams to bytes, to array readexactly,readatleast.svg` | same | `regions/BYTES-R*.md` | USABLE | 3/5 | Detailed regional source-level semantic transcripts, but repeatedly says exact code punctuation is not guaranteed and PNGs remain source of truth. Good for study, not final exact code source. |
| 88 | `stacking contexts, zindex.svg` | `stacking contexts, zindex` | `05-full-combined-final-transcript.md` | USABLE | 3/5 | Real semantic transcript for stacking contexts/z-index. Very light code fencing and exact source details remain in screenshots. |
| 89 | `CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT.svg` | same | `01-final-transcript.md` | GOOD | 4/5 | Real code-heavy semantic transcript with many fences. Useful for `POST`, `Location`, `CreatedAtAction`/creation flow review; exact source punctuation still image-authoritative. |
| 90 | `hybrydcache.svg` | `hybrydcache` | `04-stage4-corrected-source-preserving-transcript.md` | GOOD | 4/5 | Strong corrected near-literal/source-preserving transcript for HybridCache, `GetOrCreateAsync`, tags and invalidation. Mojibake remains in punctuation/headings, but core code/API coverage is solid. |
| 91 | `remove from arr, copy.svg` | `remove from arr, copy` | `05-full-combined-final-transcript.md` | USABLE | 3/5 | Real transcript, but semantic and explicitly screenshot-authoritative for exact code/punctuation in regional files. Good for concepts and review questions. |
| 92 | `lazy loading.svg` | `lazy loading` | `05-full-combined-final-transcript.md` | USABLE | 3/5 | Useful semantic transcript for EF lazy loading, proxies, `ILazyLoader`, N+1 and aggregate side effects. Exact code punctuation/version details remain source-authoritative. |
| 93 | `middleware, writeasjson.svg` | `middleware-writeasjson` | `regions/R01R02R03-middleware-writeasjson-final.md` | GOOD | 4/5 | Substantial transcript with many code fences and ASP.NET Core middleware/`WriteAsJsonAsync` examples. It still flags exact code punctuation confidence as medium-high, so a source spot pass is needed for final code trust. |
| 94 | `pivot unpivot.svg` | `pivot unpivot` | `04-full-combined-final-transcript.md` | USABLE | 3/5 | Real semantic transcript for SQL `PIVOT`/`UNPIVOT`, but light code fencing and exact source-code caveat. Good for concepts, weaker for exact SQL reconstruction. |
| 95 | `REPLACE.svg` | `REPLACE` | `01-final-transcript.md` | GOOD | 4/5 | Compact, useful transcript with concrete `string.Replace` and `Regex.Replace` examples. Good enough for this small one-screenshot topic despite semantic status. |
| 96 | `ETAG, e tag.svg` | `ETAG, e tag` | `01-final-transcript.md` | GOOD | 4/5 | Large code/header-heavy semantic transcript with many fences. Good for ETag and cache validation review; exact header punctuation/source examples should still be source-checked if copied. |
| 97 | `decoding, bytes memory, start of x byte character.svg` | same | `01-final-transcript.md` | USABLE | 3/5 | Clear conceptual transcript for UTF-8 leading/continuation-byte patterns. Exact bit diagrams are preserved as images, so transcript alone is weaker for bit-level visual reconstruction. |
| 98 | `parse string to int, convert char.svg` | same | `01-detailed-near-literal-transcript.md` | GOOD | 4/5 | Detailed near-literal transcript with parse/convert examples and code fences. Good for repetition and API/code recall. |
| 99 | `vitest test errors.svg` | `vitest test errors` | `01-final-transcript.md` | USABLE | 3/5 | Useful semantic transcript for Vitest/rendering/environment errors. It is explicitly semantic and source screenshots remain authoritative for exact package/runtime versions and signatures. |
| 100 | `principles,practises,patterns.svg` | `principles,practises,patterns` | `regions/R01-domain-modeling-many-to-many-ownership-final.md` | USABLE | 3/5 | Real transcript with one useful C# relationship method example. Good for domain-modeling review; small and not near-literal/source-by-source enough for full code recovery. |
| 101 | `partially initialized antipattern and possible partial inits inside repositories.svg` | same | `01-final-transcript.md` | USABLE | 3/5 | Coherent conceptual transcript for partial entities/projections/repository contracts, but no code fences. Good for questions and ideas, weak for exact code/API reproduction. |
| 102 | `scopes and idisposable.svg` | `scopes and idisposable` | `05-stage5-corrected-source-preserving-transcript-v002.md` | GOOD | 4/5 | Strong corrected source-preserving transcript with region files and code coverage. Needs mojibake cleanup but is a good main study source. |
| 103 | `viTst existance assert test.svg` | `viTst existance assert test` | `04-full-combined-final-transcript.md` | USABLE | 3/5 | Real transcript for Testing Library/Vitest existence assertions. It remains semantic and defers exact punctuation/details to screenshots. |
| 104 | `problem details.svg` | `problem details` | `06-stage6-source-preserving-transcript-pass1-v002`, `09-stage9-integrated-study-transcript-v003` | GOOD | 4/5 | Strong source-preserving plus integrated study transcript exists. However, `11-remaining-literal-source-gap-v003.md` indicates remaining literal gaps, so do not mark fully final. |
| 105 | `react query rerenders + setting and getting data from cache outside of react.svg` | same | `01-final-transcript.md` | GOOD | 4/5 | Real semantic transcript with many code fences for React Query rerenders/cache access. Good for repetition and API recall; exact code punctuation remains source-check territory. |

## Highest-priority fixes

1. Clean mojibake in the stronger source-preserving files: especially `EXCEPTIONHANDLERS`, `cookies-general-theo-plain-cookie-options`, `hybrydcache`, `scopes and idisposable`, and `problem details`.
2. For rows 81, 85, 87, 88, 91, 92, 94, 99 and 103, decide whether semantic transcript is enough. If exact code/API reproduction is required, add a source-preserving pass or exact-code appendix.
3. For row 82, add or promote a true integrated full transcript/index so users do not mistake the root `02-stage2-next01-full-transcript.md` processing summary for the actual study transcript.
4. For row 104, close or summarize the remaining literal-source gaps before calling it fully final.

## Bottom line

Rows 81-105 are broadly usable. Unlike the previous batch, none are empty coverage-only folders. The main quality gap is exactness rather than existence: many transcripts are good study notes but still not self-contained source-preserving replacements for the SVG.
