# Independent transcript audit - registry rows 31-80

Date: 2026-07-04  
Registry used only as scope: `C:\Users\alexa\Downloads\svg-conspects-checked-scope-register-1-229-corrected.md`  
Repository folder: `C:\Users\alexa\obs\_ai-conspects`

## Scope control

```text
registry rows: 50 (31-80)
unique SVG entries: 50
duplicate registry rows: 0
matching repo folders: 50
entries without matching folder: 0
overlap with earlier audited batches in this workspace: 0
entries outside corrected registry: 0
```

I did not carry over old `READY`, `complete`, `verified`, `source-preserving`, `missing: 0`, or similar statuses. Existing files such as `CURRENT_SOURCE_OF_TRUTH.md`, `MANIFEST.md`, coverage audit files and ledgers were used only as navigation/context, not as proof of quality.

## Method

- Matched each registry SVG name to one repository folder using only allowed normalization: case, spaces, punctuation, hyphen/underscore and suffix differences.
- Looked for the actual authoritative transcript candidate, not just the newest status file.
- Treated short `stage*-final-coverage-transcript.md` files as non-transcripts when they only say that a transcript was created elsewhere.
- Checked whether the transcript can support repeating the conspect, making repetition questions, and reproducing code/API names/parameters/sequences without constant SVG lookup.
- Compared transcript claims to local source evidence: source inventories, image-use counts, region/contact-sheet structure, extracted image/source lists, and spot checks of visible transcript code/API sections.
- Looked especially for OCR/code damage, broken identifiers, missing operators, Unicode/mojibake, placeholders, generic summaries, damaged Markdown fences and disclaimers that the SVG is still required for exact code.

## Summary

```text
Good / usable as main study source: 28
Usable but not near-literal; needs source spot fixes: 13
Bad / no real transcript or too incomplete: 9
```

Most serious pattern: several folders contain only Stage0/source-check plus a tiny final-coverage note. Those are not usable transcripts even if the note says coverage is closed.

Second serious pattern: some otherwise useful transcripts explicitly say the screenshots/SVG remain authoritative for exact punctuation, code, API-version details or constructor overloads. Those are useful summaries, but not yet "almost source-preserving".

## Register

| # | SVG from registry | Matched folder | Main transcript inspected | State | Score | Audit note |
|---:|---|---|---|---|---:|---|
| 31 | `view discovery conventions.svg` | `view discovery conventions` | `01-stage1-r01r02-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 has 13 image uses and candidate regions, but the only Stage1 file is a short closure note saying no regions remain. Cannot repeat the conspect from transcript. |
| 32 | `find index array string.svg` | `find index array string` | `01-source-preserving-transcript-v001.md` | GOOD | 4/5 | Short but actual source-preserving transcript with code fences. Good for review/questions; should still spot-check exact JS syntax if used as copy source. |
| 33 | `when need to add content type, encoding.svg` | `when need to add content type, encoding` | `01-stage1-r01r02-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 lists content-type/charset/content-encoding regions, but Stage1 is only a closure note. |
| 34 | `adddataprotection, encryption, password recovery.svg` | `adddataprotection, encryption, password recovery` | `regions/final-transcript.md` | USABLE | 3/5 | Contains actual semantic content, but not enough evidence of near-literal code/API recovery. Good for topic repetition, weaker for exact snippets. |
| 35 | `CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg` | same | `regions/final-transcript.md` | GOOD | 4/5 | Large semantic transcript with many code fences. Looks useful for content negotiation, formatters and XML/JSON review; still needs exact-code spot pass before treating as source-preserving. |
| 36 | `scroll block css.svg` | `scroll block css` | `04-full-combined-final-transcript.md` | USABLE | 3/5 | Real multi-region transcript, but it states screenshots remain authoritative for exact source code/punctuation/version details. Good for concepts, not final for exact CSS snippets. |
| 37 | `vitest mocking.svg` | `vitest mocking` | `regions/final-transcript.md` | GOOD | 4/5 | Actual concise transcript with code fences. Sufficient for review questions and likely enough to recreate core examples. |
| 38 | `map and weakmap js.svg` | `map and weakmap js` | `regions/final-transcript.md` | GOOD | 4/5 | Actual transcript with JS examples and enough structure for repetition. |
| 39 | `composite key.svg` | `composite-key` | `01-stage1-final-coverage-transcript.md` | BAD | 2/5 | Contains real text, but it is too compressed and preserves noisy labels like `???` plus typo `hasforignkey`. Not enough for exact EF Core reproduction. |
| 40 | `react render + useEffect.svg` | same | `regions/final-transcript.md` | GOOD | 4/5 | Real transcript with many code fences. Good study source for render/effect sequence. |
| 41 | `jwt auth.svg` | `jwt auth` | `regions/final-transcript.md` | USABLE | 3/5 | Actual transcript but relatively short for auth material. Good for high-level review; exact middleware/config snippets need source spot-check. |
| 42 | `REFLECTION.svg` | `REFLECTION` | `regions/final-transcript.md` | GOOD | 4/5 | Large transcript with extensive code/API coverage. Suitable for repetition, with normal exact-code caution. |
| 43 | `PUT,PATCH.svg` | `PUT,PATCH` | `01-semantic-transcript-v001.md` | USABLE | 3/5 | Meaningful semantic transcript, but code fence count is low for a large REST/API SVG. Good for concepts; not near-literal enough for code/API exactness. |
| 44 | `typescript generic get prop from aray of users, k extends keyof T.svg` | same | `regions/final-transcript.md` | GOOD | 4/5 | Short, code-oriented transcript; enough for `keyof T` repetition and question generation. |
| 45 | `js url safe, encodeuri.svg` | same | `regions/final-transcript.md` | GOOD | 4/5 | Compact transcript with examples; enough for URL/encoding repetition. |
| 46 | `ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` | same | `14-full-transcript.md` | GOOD | 4/5 | Very large real transcript, covers 475 text elements / 426 screenshot uses. Excellent for study, but explicitly says source SVG/screenshots remain authoritative for exact code/API-version details/punctuation. |
| 47 | `ef migrations, dotnet-counters.svg` | `ef migrations, dotnet-counters` | `04-full-svg-semantic-transcript-v002.md` | USABLE | 3/5 | Actual transcript, but command-line/API exactness should be rechecked before relying on it for reproduction. |
| 48 | `content disposition header.svg` | `content disposition header` | `01-stage1-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 has 2 image uses; final file is only a closure note. |
| 49 | `router and redirect tests.svg` | same | `04-full-combined-final-transcript.md` | GOOD | 4/5 | Real multi-region transcript; useful for tests, redirects and router behavior. |
| 50 | `uintarray,blob, arraybuffer,dataview,endianness.svg` | same | `regions/final-transcript.md` | GOOD | 4/5 | Actual code-heavy transcript. Good for typed arrays, Blob/ArrayBuffer/DataView and endianness review. |
| 51 | `basic auth.svg` | `basic auth` | `01-stage1-r01r02r03-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 lists 24 image uses and 6 labels, but Stage1 is only a short final semantic/coverage note. |
| 52 | `window funcs.svg` | `window funcs` | `04-full-combined-final-transcript.md` | GOOD | 4/5 | Real transcript with code examples; good for study/questions. |
| 53 | `lock, monitor.svg` | `lock-monitor` | `04-source-preserving-transcript-v002.md` | GOOD | 4/5 | Strong source-preserving transcript candidate. Good for C# locking/monitor review. |
| 54 | `SORTING,MAPPING SERVICE.svg` | same | `05-full-combined-final-transcript.md` | GOOD | 4/5 | Real multi-region transcript with sorting/mapping service code structure. Good study source. |
| 55 | `cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS.svg` | same | `01-semantic-transcript-v001.md` | USABLE | 3/5 | Large semantic transcript. Useful for cache concepts and flows, but exact headers/directives/ETag examples need source spot pass. |
| 56 | `editor,display templates.svg` | `editor,display templates` | `01-stage1-r01-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 says 5 image uses; Stage1 is a closure note only. |
| 57 | `utf8 string  literal.svg` | `utf8 string  literal` | `01-stage1-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 says 4 image uses; final file is only a closure note. |
| 58 | `sheet dict.svg` | `sheet dict` | `regions/final-transcript.md` | GOOD | 4/5 | Actual transcript with many code fences; good for repetition. |
| 59 | `query filters ef core.svg` | same | `02-stage2-corrected-source-preserving-transcript-v002.md` | GOOD | 4/5 | Strong corrected/source-preserving transcript candidate. Good for EF Core query filters. |
| 60 | `membernotnull attribute,NULL.svg` | `membernotnull attribute,NULL` | `regions/final-transcript.md` | USABLE | 3/5 | Actual transcript with code, probably enough for review; exact nullable annotations/API names should be spot-checked. |
| 61 | `EXPRESSION TREES.svg` | `EXPRESSION TREES` | `06-full-combined-final-transcript.md` | GOOD | 4/5 | Real combined transcript; enough for expression tree review and question generation. |
| 62 | `xor operator.svg` | `xor operator` | `04-full-combined-final-transcript.md` | GOOD | 4/5 | Real transcript; good for repetition. |
| 63 | `BEM.svg` | `BEM` | `04-full-combined-final-transcript.md` | GOOD | 4/5 | Real transcript; good for BEM naming and organization review. |
| 64 | `iframe,cross window communication,target.svg` | same | `06-full-combined-final-transcript.md` | GOOD | 4/5 | Real transcript; good for iframe/postMessage/target repetition. |
| 65 | `redis, idatabase,iserver.svg` | `redis, idatabase,iserver` | `08-full-combined-final-transcript.md` plus region files | USABLE | 3/5 | Combined transcript is a high-level semantic integration; detailed region files exist. It explicitly keeps SVG/recovered screenshots authoritative for exact punctuation. Good for concepts; not final for exact StackExchange.Redis calls. |
| 66 | `root document.svg` | `root document` | `02-full-combined-final-transcript.md` | USABLE | 3/5 | Real but compact transcript. Good for main idea; exact DOM/API details should be spot-checked. |
| 67 | `-all.svg` | `-all` | `07-full-combined-final-transcript.md` | GOOD | 4/5 | Real combined transcript, good enough for review/questions. |
| 68 | `svg.svg` | `svg` | `02-full-combined-final-transcript.md` | USABLE | 3/5 | Real but short transcript. Enough for basic repetition, weaker for exact SVG API/code reproduction. |
| 69 | `options pattern.svg` | `options pattern` | `regions/*.md` | USABLE | 3/5 | Real source-preserving regional transcripts exist and are detailed, but root `02-stage2-next01-full-transcript.md` is only a processed-sources/closure file. Region files contain visible mojibake such as `вЂњOptionsвЂќ`. Needs Unicode cleanup and a true integrated index/full transcript. |
| 70 | `animation keyframes.svg` | `animation keyframes` | `regions/final-transcript.md` | GOOD | 4/5 | Actual transcript with CSS/code examples; good for repetition. |
| 71 | `date.svg` | `date` | `05-full-combined-final-transcript.md` | GOOD | 4/5 | Real combined transcript; good for date-related review/questions. |
| 72 | `identity.svg` | `identity` | `06-detailed-near-literal-full-transcript-v002.md` | USABLE | 3/5 | Detailed near-literal candidate exists, but identity/auth content is high-risk; exact API names and code should be source-checked before relying on it as final. |
| 73 | `imemorycache.svg` | `imemorycache` | `01-stage1-r01r02r03-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 lists 20 image uses and 7 labels; Stage1 is only a closure note. |
| 74 | `axios.svg` | `axios` | `07-full-combined-final-transcript.md` | GOOD | 4/5 | Large useful transcript. It still says extracted screenshots remain authoritative for exact code punctuation, so not fully source-preserving. |
| 75 | `cookie auth, antiforgery.svg` | same | `regions/final-transcript.md` | USABLE | 3/5 | Actual transcript but short for security material. Good for review, needs exact code/source spot pass. |
| 76 | `splice.svg` | `splice` | `05-full-combined-final-transcript.md` | GOOD | 4/5 | Real transcript; good for JS splice review/questions. |
| 77 | `PAGING.svg` | `PAGING` | `regions/final-transcript.md` | GOOD | 4/5 | Real transcript with many code fences; good for paging repetition. |
| 78 | `alternate key.svg` | `alternate-key` | `01-stage1-r01r02r03-final-coverage-transcript.md` | BAD | 1/5 | No real transcript found. Stage0 lists 24 image uses and 8 text labels; Stage1 is only a closure note. |
| 79 | `binary primitives.svg` | `binary primitives` | `01-final-transcript.md` | GOOD | 4/5 | Real concise transcript; likely enough for review, with exact API spot-check if copying code. |
| 80 | `default values of funcs, how to call, rest params in funcs.svg` | same | `04-full-combined-final-transcript.md` | GOOD | 4/5 | Real combined transcript; good for JS function defaults/rest/spread review. |

## Highest-priority fixes

1. Create real transcripts for rows 31, 33, 48, 51, 56, 57, 73 and 78. These currently have source inventories and closure/coverage notes, not usable transcript content.
2. Rework row 39 `composite key.svg`: expand from compressed semantic text into source-preserving EF Core transcript; fix noisy labels such as `???` and identifier typo `hasforignkey`.
3. Clean Unicode/mojibake in row 69 `options pattern.svg` regional transcripts, e.g. `вЂњOptionsвЂќ`; then add a proper integrated full transcript pointing to/including the region content.
4. For rows 36, 46, 65 and 74, decide whether semantic transcript is acceptable or whether exact code/API punctuation must be recovered into the transcript itself. Current files explicitly defer exactness back to SVG/screenshots.
5. For security/API-heavy rows 41, 43, 47, 55, 72 and 75, run a focused exact-code/API pass before marking them reliable for reproduction.

## Bottom line

This batch is mixed. 28 of 50 are usable as the main study source now, 13 are useful but not trustworthy as near-literal source, and 9 should not be trusted for repetition without returning to the SVG/source images.
