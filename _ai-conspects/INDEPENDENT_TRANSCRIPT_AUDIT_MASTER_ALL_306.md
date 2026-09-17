# Independent Transcript Audit Master - all known SVG conspects

Date: 2026-07-05

## Scope

```text
zip SVG entries: 306
corrected registry rows: 229
master rows: 306
rows with matching workspace folder: 306
rows with independent audit verdict: 306
rows not audited yet: 0
```

This master file is a consolidation of the independent audit files created for all 306 known SVG entries. The extra 231-306 rows were checked in `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md`.

## Decision Legend

- `OK_FOR_STUDY`: usable as the main repetition/question source; no urgent rebuild, though minor cleanup may still help.
- `NEEDS_EXACT_PASS`: transcript exists and is useful, but code/API/header/regex/sequence exactness should be checked or strengthened.
- `NEEDS_REBUILD_OR_TRANSCRIPT`: missing, coverage-only, not ready, or too broken for the stated goal.
- `NOT_AUDITED_YET`: present in zip/workspace universe but not covered by the independent audit passes yet.

## Summary

```text
NEEDS_EXACT_PASS: 119
NEEDS_REBUILD_OR_TRANSCRIPT: 8
NOT_AUDITED_YET: 0
OK_FOR_STUDY: 179
NeedsWork=NO: 179
NeedsWork=YES: 127
```

## Local Source Exact-Pass Check - 2026-07-07

`LOCAL_SOURCE_EXACT_PASS_CHECK_122.md` checks all 122 rows marked `NEEDS_EXACT_PASS` against local source material. Result: no safe mass promotion; the rows remain exact-pass work because transcripts either defer exact code/punctuation to screenshots, miss visible SVG text labels, are semantic rather than near-literal, or need source attention. Source files are generally available locally, with the exceptions listed in that report.

## Master Register

| # | SVG | Corrected registry | Zip | Workspace folder | Audit verdict | Decision | Needs work | Audit file |
|---:|---|---|---|---|---|---|---|---|
| 1 | `regex, reusing, compiled.svg` | YES | YES | `regex, reusing, compiled` | B / usable with exactness caveat | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 2 | `hateoas.svg` | YES | YES | `hateoas` | B- / comprehensive semantic | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 3 | `modelstate.svg` | YES | YES | `modelstate` | C+ / too condensed for code recovery | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 4 | `return new ().svg` | YES | YES | `return new ()` | B / small and adequate | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 5 | `CUSTOM ROUTE CONSTRAINT.svg` | YES | YES | `CUSTOM ROUTE CONSTRAINT` | B+ / mostly reconstructable | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 6 | `totp, summary,theory.svg` | YES | YES | `totp, summary,theory` | B / concept complete, code summarized | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 7 | `rawconnections,dbconnection,sqlconnection,commands.svg` | YES | YES | `rawconnections,dbconnection,sqlconnection,commands` | A- / strong | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 8 | `any in exists.svg` | YES | YES | `any in exists` | A- / small and clear | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 9 | `interlocked,interlocked.read.svg` | YES | YES | `interlocked,interlocked.read` | C+ / high-level only | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 10 | `pointers.svg` | YES | YES | `pointers` | B / adequate semantic with code | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 11 | `span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types.svg` | YES | YES | `span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types` | B / broad but semantic | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 12 | `REST API BASICS.svg` | YES | YES | `REST API BASICS` | C+ as main file / B with regions | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 13 | `pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el.svg` | YES | YES | `pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el` | B- / concepts good, CSS exactness weak | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 14 | `SQL SERVER MARS.svg` | YES | YES | `sql-server-mars` | A / strong source-by-source | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 15 | `async processing of multiple calls,parallelism.svg` | YES | YES | `async processing of multiple calls,parallelism` | B+ / strong semantic with code | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 16 | `url save base 64 for db, hex string.svg` | YES | YES | `url save base 64 for db, hex string` | B / concept reliable | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 17 | `searching impl, ef core, full text search,sql server.svg` | YES | YES | `searching impl, ef core, full text search,sql server` | B+ / good corrected semantic | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 18 | `dbcontextpool, queryfilter.svg` | YES | YES | `dbcontextpool, queryfilter` | C+ / label-derived semantic | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 19 | `mfa.svg` | YES | YES | `mfa` | C / needs precision pass | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 20 | `redux rtk.svg` | YES | YES | `redux rtk` | B+ / useful with code | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 21 | `js yield, asyncenumerable, finally of generator.svg` | YES | YES | `js yield, asyncenumerable, finally of generator` | A- / strong | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 22 | `typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion.svg` | YES | YES | `typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion` | A- / strong | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 23 | `server resources,multipleinstances,microservices.svg` | YES | YES | `server resources,multipleinstances,microservices` | A- / strong evidence layer | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 24 | `set js.svg` | YES | YES | `set js` | A- / compact and usable | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 25 | `options requ.svg` | YES | YES | `options requ` | B+ / useful with HTTP/C# code | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 26 | `in any exist, some.svg` | YES | YES | `in any exist, some` | A- / good SQL transcript | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 27 | `ef core performance, diagnostics , compiled linq, batching, n + 1.svg` | YES | YES | `ef-core-performance-diagnostics-compiled-linq-batching-n-1` | C / too semantic for code/API reproduction | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 28 | `SUBSTRING.svg` | YES | YES | `SUBSTRING` | B- / concept adequate, exact examples absent | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 29 | `FLAT FLATMAP.svg` | YES | YES | `FLAT FLATMAP` | B+ / good semantic with JS examples | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 30 | `memory vs localstorage vs sessionstorage, session storage and local storage api methods.svg` | YES | YES | `memory vs localstorage vs sessionstorage, session storage and local storage api methods` | B+ / good API coverage | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_001_030.md` |
| 31 | `view discovery conventions.svg` | YES | YES | `view discovery conventions` | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 32 | `find index array string.svg` | YES | YES | `find index array string` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 33 | `when need to add content type, encoding.svg` | YES | YES | `when need to add content type, encoding` | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 34 | `adddataprotection, encryption, password recovery.svg` | YES | YES | `adddataprotection, encryption, password recovery` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 35 | `CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON.svg` | YES | YES | `CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 36 | `scroll block css.svg` | YES | YES | `scroll block css` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 37 | `vitest mocking.svg` | YES | YES | `vitest mocking` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 38 | `map and weakmap js.svg` | YES | YES | `map and weakmap js` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 39 | `composite key.svg` | YES | YES | `composite-key` | GOOD - Real final coverage transcript exists at `composite-key\regions\r01r02r03-final-coverage-transcript-v001.md`; closes 25 image uses and 18 text labels for EF Core composite keys. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_1.md` |
| 40 | `react render + useEffect.svg` | YES | YES | `react render + useEffect` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 41 | `jwt auth.svg` | YES | YES | `jwt auth` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 42 | `REFLECTION.svg` | YES | YES | `REFLECTION` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 43 | `PUT,PATCH.svg` | YES | YES | `PUT,PATCH` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 44 | `typescript generic get prop from aray of users, k extends keyof T.svg` | YES | YES | `typescript generic get prop from aray of users, k extends keyof T` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 45 | `js url safe, encodeuri.svg` | YES | YES | `js url safe, encodeuri` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 46 | `ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer.svg` | YES | YES | `ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part,  server part, pipereader pipewriter stream reader stream writer` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 47 | `ef migrations, dotnet-counters.svg` | YES | YES | `ef migrations, dotnet-counters` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 48 | `content disposition header.svg` | YES | YES | `content disposition header` | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 49 | `router and redirect tests.svg` | YES | YES | `router and redirect tests` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 50 | `uintarray,blob, arraybuffer,dataview,endianness.svg` | YES | YES | `uintarray,blob, arraybuffer,dataview,endianness` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 51 | `basic auth.svg` | YES | YES | `basic auth` | GOOD - Real regional transcript exists at `basic auth\regions\R01R02R03-basic-authentication-final.md`; covers theory, custom handler, challenge, clients and 24 image uses. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_1.md` |
| 52 | `window funcs.svg` | YES | YES | `window funcs` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 53 | `lock, monitor.svg` | YES | YES | `lock-monitor` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 54 | `SORTING,MAPPING SERVICE.svg` | YES | YES | `SORTING,MAPPING SERVICE` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 55 | `cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS.svg` | YES | YES | `cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 56 | `editor,display templates.svg` | YES | YES | `editor,display templates` | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 57 | `utf8 string  literal.svg` | YES | YES | `utf8 string  literal` | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 58 | `sheet dict.svg` | YES | YES | `sheet dict` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 59 | `query filters ef core.svg` | YES | YES | `query filters ef core` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 60 | `membernotnull attribute,NULL.svg` | YES | YES | `membernotnull attribute,NULL` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 61 | `EXPRESSION TREES.svg` | YES | YES | `EXPRESSION TREES` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 62 | `xor operator.svg` | YES | YES | `xor operator` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 63 | `BEM.svg` | YES | YES | `BEM` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 64 | `iframe,cross window communication,target.svg` | YES | YES | `iframe,cross window communication,target` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 65 | `redis, idatabase,iserver.svg` | YES | YES | `redis, idatabase,iserver` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 66 | `root document.svg` | YES | YES | `root document` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 67 | `-all.svg` | YES | YES | `-all` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 68 | `svg.svg` | YES | YES | `svg` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 69 | `options pattern.svg` | YES | YES | `options pattern` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 70 | `animation keyframes.svg` | YES | YES | `animation keyframes` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 71 | `date.svg` | YES | YES | `date` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 72 | `identity.svg` | YES | YES | `identity` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 73 | `imemorycache.svg` | YES | YES | `imemorycache` | GOOD - Real final transcript exists at `imemorycache\regions\R01R02R03-imemorycache-final.md`; covers registration, Get/Create, expiration, invalidation, tags/versioning and stampede protection. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_1.md` |
| 74 | `axios.svg` | YES | YES | `axios` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 75 | `cookie auth, antiforgery.svg` | YES | YES | `cookie auth, antiforgery` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 76 | `splice.svg` | YES | YES | `splice` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 77 | `PAGING.svg` | YES | YES | `PAGING` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 78 | `alternate key.svg` | YES | YES | `alternate-key` | GOOD - Real final transcript exists at `alternate-key\regions\R01R02R03-efcore-alternate-key-final.md`; closes 24 image uses / 8 labels for EF Core alternate/principal keys. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_1.md` |
| 79 | `binary primitives.svg` | YES | YES | `binary primitives` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 80 | `default values of funcs, how to call, rest params in funcs.svg` | YES | YES | `default values of funcs, how to call, rest params in funcs` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_031_080.md` |
| 81 | `objectpool,arraypool,memorypool.svg` | YES | YES | `objectpool,arraypool,memorypool` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 82 | `returning iqueryable,problems when returning ienumerable without tolist, async enumerable problems,yield.svg` | YES | YES | `returning-iqueryable-problems-when-returning-ienumerable-without-tolist-async-enumerable-problems-yield` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 83 | `istringlocalizer iviewlocalizer.svg` | YES | YES | `istringlocalizer iviewlocalizer` | CHECKED - useful compact transcript closes 7 images, but exact code punctuation remains in source/images; needs exact code appendix. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 84 | `EXCEPTIONHANDLERS.svg` | YES | YES | `EXCEPTIONHANDLERS` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 85 | `CASE INSENS,collate.svg` | YES | YES | `CASE INSENS,collate` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 86 | `cookies, general theo, plain cookie options.svg` | YES | YES | `cookies-general-theo-plain-cookie-options` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 87 | `working with bytes, streams to bytes, to array readexactly,readatleast.svg` | YES | YES | `working with bytes, streams to bytes, to array readexactly,readatleast` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 88 | `stacking contexts, zindex.svg` | YES | YES | `stacking contexts, zindex` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 89 | `CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT.svg` | YES | YES | `CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 90 | `hybrydcache.svg` | YES | YES | `hybrydcache` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 91 | `remove from arr, copy.svg` | YES | YES | `remove from arr, copy` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 92 | `lazy loading.svg` | YES | YES | `lazy loading` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 93 | `middleware, writeasjson.svg` | YES | YES | `middleware-writeasjson` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 94 | `pivot unpivot.svg` | YES | YES | `pivot unpivot` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 95 | `REPLACE.svg` | YES | YES | `REPLACE` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 96 | `ETAG, e tag.svg` | YES | YES | `ETAG, e tag` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 97 | `decoding, bytes memory, start of x byte character.svg` | YES | YES | `decoding, bytes memory, start of x byte character` | CHECKED - strong UTF-8 semantic transcript, but exact bit diagrams/byte examples remain image-authoritative. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 98 | `parse string to int, convert char.svg` | YES | YES | `parse string to int, convert char` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 99 | `vitest test errors.svg` | YES | YES | `vitest test errors` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 100 | `principles,practises,patterns.svg` | YES | YES | `principles,practises,patterns` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 101 | `partially initialized antipattern and possible partial inits inside repositories.svg` | YES | YES | `partially initialized antipattern and possible partial inits inside repositories` | CHECKED - conceptually strong transcript, but exact screenshot wording/code remains outside transcript. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 102 | `scopes and idisposable.svg` | YES | YES | `scopes and idisposable` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 103 | `viTst existance assert test.svg` | YES | YES | `viTst existance assert test` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 104 | `problem details.svg` | YES | YES | `problem details` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 105 | `react query rerenders + setting and getting data from cache outside of react.svg` | YES | YES | `react query rerenders + setting and getting data from cache outside of react` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_081_105.md` |
| 106 | `sheet exec order.svg` | YES | YES | `sheet exec order` | GOOD - exact-pass fixed: logical order now matches source diagram; pagination is step 8 and window-function area is represented as source-row note after HAVING. | `OK_FOR_STUDY` | NO | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 107 | `dbcontext interseptors savechanges , dbcommand.svg` | YES | YES | `dbcontext interseptors savechanges , dbcommand` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 108 | `ctor type and instance type.svg` | YES | YES | `ctor type and instance type` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 109 | `zustand.svg` | YES | YES | `zustand` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 110 | `react root error, trigger useeffect on route change.svg` | YES | YES | `react root error, trigger useeffect on route change` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 111 | `proxy, server, vite dev server proxy.svg` | YES | YES | `proxy, server, vite dev server proxy` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 112 | `google recapcha and recapchas.svg` | YES | YES | `google recapcha and recapchas` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 113 | `SYSTEM.TEXT.JSON SER SER.svg` | YES | YES | `SYSTEM.TEXT.JSON SER SER` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 114 | `Rhf react hook form.svg` | YES | YES | `Rhf react hook form` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 115 | `textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream.svg` | YES | YES | `textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream` | CHECKED - code-rich semantic transcript, but not source-preserving enough across streaming/chunk examples; needs exact source appendix. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 116 | `js loops, for, for of, entries, index, for in.svg` | YES | YES | `js loops, for, for of, entries, index, for in` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 117 | `computed columns.svg` | YES | YES | `computed columns` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 118 | `Lazy.svg` | YES | YES | `Lazy` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 119 | `ef has conversion, value converte,comparer.svg` | YES | YES | `ef has conversion, value converte,comparer` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 120 | `last element sharp.svg` | YES | YES | `last element sharp` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 121 | `hashcode.svg` | YES | YES | `hashcode` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 122 | `idistributedcache.svg` | YES | YES | `idistributedcache` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 123 | `useTransition full flow, usedebounce, useDefferedvalue.svg` | YES | YES | `useTransition full flow, usedebounce, useDefferedvalue` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 124 | `delete.svg` | YES | YES | `delete` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 125 | `typescript explicit type annotations vs satisfies.svg` | YES | YES | `typescript explicit type annotations vs satisfies` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 126 | `explicit interface inplementation.svg` | YES | YES | `explicit interface inplementation` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 127 | `uselocation.svg` | YES | YES | `uselocation` | CHECKED - complete semantic coverage, but transcript explicitly leaves exact source code/punctuation/version details to SVG/screenshots. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 128 | `context.svg` | YES | YES | `context` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 129 | `exaustiveness check with sicr union for enums,classes with inher.svg` | YES | YES | `exaustiveness check with sicr union for enums,classes with inher` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 130 | `type narrowing.svg` | YES | YES | `type narrowing` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 131 | `base mvc razor views example,tempdata viewdata viewbag, cache tag helper.svg` | YES | YES | `base-mvc-razor-views-example-tempdata-viewdata-viewbag-cache-tag-helper` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 132 | `type aliases, unions,iterfaces.svg` | YES | YES | `type aliases, unions,iterfaces` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 133 | `usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions.svg` | YES | YES | `usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 134 | `statuscodepages.svg` | YES | YES | `statuscodepages` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 135 | `header max width, sticky,fixed.svg` | YES | YES | `header max width, sticky,fixed` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 136 | `implicit operators  explicit operators.svg` | YES | YES | `implicit operators  explicit operators` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 137 | `hexadecimal base16 how  to convert to bytes easily.svg` | YES | YES | `hexadecimal base16 how  to convert to bytes easily` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 138 | `inset vs size,margins,formula.svg` | YES | YES | `inset vs size,margins,formula` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 139 | `ascii.svg` | YES | YES | `ascii` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 140 | `valuetask.svg` | YES | YES | `valuetask` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 141 | `cache control headers and response caching.svg` | YES | YES | `cache control headers and response caching` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 142 | `data shaping,expando.svg` | YES | YES | `data shaping,expando` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 143 | `FILTERING AND SEARCHING.svg` | YES | YES | `FILTERING AND SEARCHING` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 144 | `FULL CONTENT NEG + VALIDATION FLOW.svg` | YES | YES | `FULL CONTENT NEG + VALIDATION FLOW` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 145 | `HEAD REQUEST.svg` | YES | YES | `HEAD REQUEST` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 146 | `last modified header, implementation, expirational model.svg` | YES | YES | `last modified header, implementation, expirational model` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 147 | `owned entity.svg` | YES | YES | `owned entity` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 148 | `ROUTE NESTING.svg` | YES | YES | `ROUTE NESTING` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 149 | `ROUTE PARAMS,QUERY STRING BASICS.svg` | YES | YES | `ROUTE PARAMS,QUERY STRING BASICS` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 150 | `ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg` | YES | YES | `ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 151 | `vary header.svg` | YES | YES | `vary header` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 152 | `- EF CORE GENERAL  repo shit   entity shit   onmodelcreat shit  transactions shit  dbexceptions   db level invariants,protection, trigger.svg` | YES | YES | `ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 153 | `abstraction and encapsulation.svg` | YES | YES | `abstraction-and-encapsulation` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 154 | `account activation.svg` | YES | YES | `account activation` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 155 | `actiondescriptor,controlleractiondescriptor,endpoint,metadata, route or endpoint name, iapiendpointmetadata, ordered metadata.svg` | YES | YES | `actiondescriptor-controlleractiondescriptor-endpoint-metadata-route-or-endpoint-name-iapiendpointmetadata-ordered-metadata` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 156 | `allocations.svg` | YES | YES | `allocations` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 157 | `antiforgerytoken.svg` | YES | YES | `antiforgerytoken` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 158 | `apibehavioroptions.svg` | YES | YES | `apibehavioroptions` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 159 | `assplitquery.svg` | YES | YES | `assplitquery` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 160 | `AUTH EVENTS.svg` | YES | YES | `AUTH EVENTS` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 161 | `authenticaiton ticket, properties, context.User (claimsprincipal).svg` | YES | YES | `authenticaiton ticket, properties, context.User (claimsprincipal)` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 162 | `authentication,, oidc, flows , handlers , forwarding auth events.svg` | YES | YES | `authentication-oidc-flows-handlers-forwarding-auth-events` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 163 | `authorization flow,autorization options, framework, authorizationmiddlewareresulthandler.svg` | YES | YES | `authorization-flow-autorization-options-framework-authorizationmiddlewareresulthandler` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 164 | `AUTHORIZATION.svg` | YES | YES | `AUTHORIZATION` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 165 | `automatic problem details from modelstate,apicontroller filter invalidmodelstateresponsefactory.svg` | YES | YES | `automatic-problem-details-from-modelstate-apicontroller-filter-invalidmodelstateresponsefactory` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 166 | `BALANCING GROUPS .NET.svg` | YES | YES | `BALANCING GROUPS .NET` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 167 | `BINDING SOURCE ATTRIBUTES.svg` | YES | YES | `BINDING SOURCE ATTRIBUTES` | GOOD - exact-pass fixed: binding attributes transcript matches contact sheet and mojibake arrows in ApiController inference list were cleaned. | `OK_FOR_STUDY` | NO | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 168 | `Bitwise checking for all combinations.svg` | YES | YES | `Bitwise checking for all combinations` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 169 | `cancellation,async.svg` | YES | YES | `cancellation,async` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 170 | `changetracker.svg` | YES | YES | `changetracker` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 171 | `channel.svg` | YES | YES | `channel` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 172 | `claimstransformation.svg` | YES | YES | `claimstransformation` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 173 | `compression,decompression,request,response.svg` | YES | YES | `compression,decompression,request,response` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 174 | `CONCATENATE MULT ROWS AS AGGR,STUFF,STRING_AGG.svg` | YES | YES | `CONCATENATE MULT ROWS AS AGGR,STUFF,STRING_AGG` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 175 | `CONTAINS STARTSWITH ENDSWITH.svg` | YES | YES | `CONTAINS STARTSWITH ENDSWITH` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 176 | `conventions.svg` | YES | YES | `conventions` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 177 | `cookies auth ON REDIRECT  probmem details returning.svg` | YES | YES | `cookies auth ON REDIRECT  probmem details returning` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 178 | `cookies vs tokens sheet jswt in cookies.svg` | YES | YES | `cookies vs tokens sheet jswt in cookies` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 179 | `cors vs anti forgery.svg` | YES | YES | `cors vs anti forgery` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 180 | `CORS.svg` | YES | YES | `CORS` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 181 | `create array, fixed length.svg` | YES | YES | `create array, fixed length` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 182 | `creating base32 secret.svg` | YES | YES | `creating base32 secret` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 183 | `dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery.svg` | YES | YES | `dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 184 | `decorator.svg` | YES | YES | `decorator` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 185 | `donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable.svg` | YES | YES | `donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 186 | `ef core context.database, transaction object, savechanges, dbconnection,dbtransaction.svg` | YES | YES | `ef-core-context-database-transaction-object-savechanges-dbconnection-dbtransaction` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 187 | `ef core retry, savepoints.svg` | YES | YES | `ef core retry, savepoints` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 188 | `encapsulating dbcontext.svg` | YES | YES | `encapsulating-dbcontext` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 189 | `encoding, utf8, chunk processing.svg` | YES | YES | `encoding, utf8, chunk processing` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 190 | `Enumerable static methods.svg` | YES | YES | `Enumerable static methods` | GOOD - exact-pass fixed: Enumerable source examples now match source image for Range, Repeat, and Empty. | `OK_FOR_STUDY` | NO | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 191 | `equality.svg` | YES | YES | `equality` | NOT READY | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 192 | `event source browser.svg` | YES | YES | `event source browser` | USABLE, but semantic | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 193 | `events,delegaates,action.svg` | YES | YES | `events,delegaates,action` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 194 | `expandoobject.svg` | YES | YES | `expandoobject` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 195 | `FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison.svg` | YES | YES | `FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 196 | `FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED.svg` | YES | YES | `FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED` | CHECKED - useful compact transcript, but exact middleware/filter code punctuation remains in source images. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 197 | `filters.svg` | YES | YES | `filters` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 198 | `flex item ,flex shrinking.svg` | YES | YES | `flex item ,flex shrinking` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 199 | `fluent validation.svg` | YES | YES | `fluent-validation` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 200 | `formatting, numeric formatting, what can be formatted.svg` | YES | YES | `formatting, numeric formatting, what can be formatted` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 201 | `hashing.svg` | YES | YES | `hashing` | PARTIAL / needs cleanup | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 202 | `headers.svg` | YES | YES | `headers` | READY for repeat | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 203 | `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers.svg` | YES | YES | `httpclient,summary,theory,base usage,jsonoptions wrapper,handlers` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 204 | `httpcontent,custom one, readasstream buffering, compression directly to network.svg` | YES | YES | `httpcontent,custom one, readasstream buffering, compression directly to network` | READY for repeat | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 205 | `httpcontext items and features.svg` | YES | YES | `httpcontext items and features` | READY for repeat | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 206 | `index sign, keyof, type assertions, records to solve index sign issues.svg` | YES | YES | `index sign, keyof, type assertions, records to solve index sign issues` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 207 | `indexes, onmodel indexes.svg` | YES | YES | `indexes, onmodel indexes` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 208 | `injecting into razor.svg` | YES | YES | `injecting into razor` | READY for repeat | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_SELECTED_191_208.md` |
| 209 | `inline flags sharp.svg` | YES | YES | `inline flags sharp` | USABLE | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 210 | `interseption observer.svg` | YES | YES | `interseption observer` | GOOD | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_REMAINING_106_210.md` |
| 211 | `IVALIDATABLE OBJECT, VALIDATION ATTRIBUTES.svg` | YES | YES | `IVALIDATABLE OBJECT, VALIDATION ATTRIBUTES` | OK with minor exactness gaps | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 212 | `jagged arr,multidim arr,cast boxing unboxing enumerable vs generic.svg` | YES | YES | `jagged arr,multidim arr,cast boxing unboxing enumerable vs generic` | PARTIAL | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 213 | `jquery dynamic form validation.svg` | YES | YES | `jquery dynamic form validation` | PARTIAL / needs code appendix | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 214 | `js iterate, index.svg` | YES | YES | `js iterate, index` | GOOD - New source-reconstructed transcript added at `js iterate, index\regions\R01-array-index-iteration-final-transcript-v001.md`; readable source images transcribed for entries(), keys(), and for...in index behavior. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_2.md` |
| 215 | `js regex.svg` | YES | YES | `js regex` | PARTIAL | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 216 | `js sorting.svg` | YES | YES | `js sorting` | OK with minor exactness gaps | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 217 | `jsonconverter.svg` | YES | YES | `jsonconverter` | CHECKED - strong Optional<T>/JsonConverterFactory transcript, but exact generic/ref converter code needs source-code appendix. | `NEEDS_EXACT_PASS` | YES | `SOURCE_EXACT_FIX_PASS_2026_07_07_BATCH_001.md` |
| 218 | `jsondocument, jsonnode, jsonelement, utf8jsonwriter.svg` | YES | YES | `jsondocument, jsonnode, jsonelement, utf8jsonwriter` | OK with caveat | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 219 | `keyless entity type.svg` | YES | YES | `keyless entity type` | OK with minor exactness gaps | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 220 | `last element.svg` | YES | YES | `last element` | OK | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 221 | `link generator.svg` | YES | YES | `link generator` | PARTIAL / needs code appendix | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 222 | `linq join groupjoin groupby selectmany,selectmany second callback.svg` | YES | YES | `linq-join-groupjoin-groupby-selectmany-selectmany-second-callback` | FAIL | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 223 | `linq query syntax.svg` | YES | YES | `linq-query-syntax` | PARTIAL | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 224 | `linq to sql.svg` | YES | YES | `linq to sql` | PARTIAL / high risk for code reproduction | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 225 | `manual account lockout,ratelimiter middleware, idatabase vs idist cache.svg` | YES | YES | `manual account lockout,ratelimiter middleware, idatabase vs idist cache` | PARTIAL | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 226 | `MEDIA TYPES OF REQUESTS.svg` | YES | YES | `MEDIA TYPES OF REQUESTS` | PARTIAL | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 227 | `never type, exhaustion check with discriminated union.svg` | YES | YES | `never type, exhaustion check with discriminated union` | PARTIAL / mostly usable | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 228 | `not.svg` | YES | YES | `not` | GOOD - New source-reconstructed transcript added at `not\regions\R01R02-css-not-final-transcript-v001.md`; two screenshots and all SVG labels transcribed. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_1.md` |
| 229 | `OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg` | YES | YES | `OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties` | PARTIAL / high risk for code reproduction | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| 230 | `onmodelcreating.svg` | NO | YES | `onmodelcreating` | PARTIAL / high risk for code reproduction | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_211_230.md` |
| extra-001 | `openjson.svg` | NO | YES | `openjson` | GOOD - Substantial final semantic transcript with many code fences; minor mojibake only in generated headings, usable for OPENJSON repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-002 | `outputcache layers, to use or not,locking, outputcache vs cdn.svg` | NO | YES | `outputcache-layers-to-use-or-not-locking-outputcache-vs-cdn` | GOOD - Large source-preserving OutputCache/CDN transcript; enough API and sequence detail for study, with minor OCR/header residue. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-003 | `outputcache, response cache comparison.svg` | NO | YES | `outputcache, response cache comparison` | USABLE - Useful comparison transcript, but only a focused region candidate; exact policy/code coverage should be checked against SVG. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-004 | `pagination offset take.svg` | NO | YES | `pagination offset take` | GOOD - Compact pagination transcript with code blocks and clear offset/take sequence; adequate for questions. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-005 | `parse string to int,float,double.svg` | NO | YES | `parse string to int,float,double` | GOOD - Parse int/float/double transcript has enough examples/API names; minor generated-heading mojibake does not affect content. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-006 | `persistance, zustand,rquery,redux.svg` | NO | YES | `persistance, zustand,rquery,redux` | GOOD - Long persistence/Zustand/RQuery/Redux transcript; broad enough for repeating concepts and API contrasts, though small caveats remain. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-007 | `pipethrough,transformstream,pipeto,writablestream, readablestream.svg` | NO | YES | `pipethrough,transformstream,pipeto,writablestream, readablestream` | USABLE - Combined streams transcript is useful, but has caveats and some generated/OCR residue; exact stream method names and code should be rechecked. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-008 | `primary httphandler optoins, socket.svg` | NO | YES | `primary httphandler optoins, socket` | GOOD - Primary HttpHandler/Sockets transcript is detailed and source-preserving; usable for API-level review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-009 | `problem2.svg` | NO | YES | `problem2` | USABLE - Problem2 transcript is present but has several caveats and semantic summarization; verify exact code/steps before trusting fully. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-010 | `processing data as stream in dif situations, httpclient,endpoint,browser,websockets.svg` | NO | YES | `processing data as stream in dif situations, httpclient,endpoint,browser,websockets` | USABLE - Processing data as stream reconciliation exists, but is short/focused; needs exact coverage pass for completeness. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-011 | `produces, consumes, input output formatters 406 415, vary accept.svg` | NO | YES | `produces-consumes-input-output-formatters-406-415-vary-accept` | USABLE - Produces/Consumes region transcript is clean but narrow; verify all SVG regions and Accept/Vary examples. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-012 | `prog inline styles css.svg` | NO | YES | `prog inline styles css` | USABLE - Inline CSS transcript is compact and semantic; okay for basics, but too short for near-literal trust. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-013 | `promise.all.svg` | NO | YES | `promise.all` | GOOD - Promise.all transcript includes useful examples and sequencing; suitable for repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-014 | `QS PREFERENCE WITH MULTIPLE ACCEPT HEADER VALUES HELPER.svg` | NO | YES | `qs-preference-with-multiple-accept-header-values-helper` | USABLE - Query-string preference transcript is clean but region-specific; check winner ordering/build-result/HATEOAS details against SVG. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-015 | `randomnumbergenerator.svg` | NO | YES | `randomnumbergenerator` | GOOD - RandomNumberGenerator transcript has enough crypto/API detail and code blocks; usable with minor exactness check only. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-016 | `range operations on list.svg` | NO | YES | `range operations on list` | GOOD - Range operations on List transcript has clear examples and API names; good for questions. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-017 | `RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX.svg` | NO | YES | `RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX` | USABLE - Razor partial updates coverage exists but looks coverage-oriented; verify exact Razor/JS names and missing surrounding regions. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-018 | `react router.svg` | NO | YES | `react router` | GOOD - React Router transcript is large and code-rich; minor generated-heading artifacts do not block study use. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-019 | `react state and rerenders, store subscriptions.svg` | NO | YES | `react state and rerenders, store subscriptions` | USABLE - React state/rerenders combined transcript is useful but has caveats/semantic compression; exact hook behavior/examples need checking. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-020 | `react strict mode.svg` | NO | YES | `react strict mode` | GOOD - New source-reconstructed transcript added at `react strict mode\regions\R01-strict-mode-effect-cleanup-final-transcript-v001.md`; readable source screenshots transcribed for Strict Mode and effect cleanup. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_7.md` |
| extra-021 | `records.svg` | NO | YES | `records` | GOOD - Records transcript is screenshot-backed and substantial; usable for C# records review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-022 | `redis,multiplexer,redis lock.svg` | NO | YES | `redis-multiplexer-redis-lock` | USABLE - Redis lock transcript is clean but appears to cover one focused region; verify multiplexer/Redlock coverage across SVG. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-023 | `redux basics.svg` | NO | YES | `redux basics` | USABLE - Redux basics combined transcript is substantial, but caveats and semantic layer mean exact API/code pass is needed. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-024 | `ref in out.svg` | NO | YES | `ref in out` | GOOD - ref/in/out transcript is concise with API/code examples; suitable for repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-025 | `return url implementation razor.svg` | NO | YES | `return url implementation razor` | USABLE - ReturnUrl Razor transcript is very short; concepts present but exact coverage likely incomplete. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-026 | `returning most specific passing most generic.svg` | NO | YES | `returning-most-specific-passing-most-generic` | GOOD - Generic parameter/return specificity transcript is clear and code-supported; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-027 | `routing,route params tech info, custom constraints,router matching.svg` | NO | YES | `routing-route-params-tech-info-custom-constraints-router-matching` | BAD - Only planning/source-boundary/README style files found; no substantive regional transcript for routing/custom constraints. | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-028 | `scroll block.svg` | NO | YES | `scroll block` | USABLE - Scroll block transcript exists but has caveats and summary style; CSS exactness needs checking. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-029 | `semaphoreslim for ts js, pending promise without resolve.svg` | NO | YES | `semaphoreslim for ts js, pending promise without resolve` | USABLE - SemaphoreSlim/TS pending promise transcript is useful but caveated; verify exact async code and unresolved promise details. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-030 | `semaphoreslim vs channel.svg` | NO | YES | `semaphoreslim vs channel` | USABLE - SemaphoreSlim vs Channel transcript is clean but short; sufficient for overview, not near-literal. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-031 | `server browser threads,memory, webworkers , runtime vs compiler , es.svg` | NO | YES | `server browser threads,memory, webworkers , runtime vs compiler , es` | USABLE - Browser/server threads transcript is clean but short/focused; check worker lifecycle/error details against SVG. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-032 | `shared polly,cheat sheet,production ready verions, exceptions from pipeline and handling.svg` | NO | YES | `shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling` | USABLE - Very large Polly region transcript exists, but many caveat markers/generated artifacts; exact code/API pass required. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-033 | `sharp regex options  + COND REPLACE.svg` | NO | YES | `sharp regex options  + COND REPLACE` | GOOD - Sharp regex/options/conditional replace transcript has many code fences and regex detail; usable with minor exactness review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-034 | `sheet get last.svg` | NO | YES | `sheet get last` | USABLE - Sheet get last transcript exists but has caveats and semantic compression; check examples. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-035 | `sheet hashset.svg` | NO | YES | `sheet hashset` | USABLE - Sheet HashSet transcript exists but has caveats/summary layer; verify exact code and operations. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-036 | `sheet regex sharp.svg` | NO | YES | `sheet regex sharp` | GOOD - Sheet regex sharp transcript is compact but code-rich enough for repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-037 | `sql syntax. sql server.svg` | NO | YES | `sql-syntax-sql-server` | GOOD - SQL syntax/SQL Server region transcript is substantial and clean, with many SQL examples. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-038 | `sqlserver,efcore, bulk,sqlbulkcopy.svg` | NO | YES | `sqlserver-efcore-bulk-sqlbulkcopy` | GOOD - EFCore bulk/SqlBulkCopy transcript is clean and detailed enough for API/sequence review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-039 | `stored procedures.svg` | NO | YES | `stored procedures` | GOOD - Stored procedures transcript is long and corrected, with enough SQL/API detail for study. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-040 | `streaming.svg` | NO | YES | `streaming` | GOOD - Initial candidate was a short correction file, but folder contains large source-preserving streaming region transcripts; usable overall. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-041 | `STRING  TRIM.svg` | NO | YES | `STRING  TRIM` | GOOD - String Trim transcript is compact and example-focused; usable for repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-042 | `STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT.svg` | NO | YES | `STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT` | GOOD - New source-reconstructed transcript added at `STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT\regions\R01-string-case-conversion-final-transcript-v001.md`; readable source screenshots transcribed for ToLower/ToUpper/invariant and comparison guidance. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_4.md` |
| extra-043 | `STRING FORMAT,INTERPOLATION.svg` | NO | YES | `STRING FORMAT,INTERPOLATION` | GOOD - New source-reconstructed transcript added at `STRING FORMAT,INTERPOLATION\regions\R01-string-format-interpolation-final-transcript-v001.md`; all 3 readable source screenshots and FORMAT label transcribed. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_3.md` |
| extra-044 | `STRING INDEX.svg` | NO | YES | `STRING INDEX` | GOOD - String Index transcript is small but has examples/API details; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-045 | `string join.svg` | NO | YES | `string join` | GOOD - String.Join transcript is short but example-focused and sufficient for this narrow topic. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-046 | `STRING PADDING.svg` | NO | YES | `STRING PADDING` | GOOD - String padding transcript is narrow, with enough examples for review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-047 | `STRING REMOVE INSERT.svg` | NO | YES | `STRING REMOVE INSERT` | GOOD - String Remove/Insert transcript is concise and example-oriented; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-048 | `STRING SORT.svg` | NO | YES | `STRING SORT` | GOOD - String Sort transcript is compact with relevant examples; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-049 | `STRING SPLIT.svg` | NO | YES | `STRING SPLIT` | GOOD - String Split transcript is compact and API/example oriented; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-050 | `string to char list.svg` | NO | YES | `string to char list` | GOOD - String to char list transcript is concise with examples; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-051 | `STRINGBUILDER.svg` | NO | YES | `STRINGBUILDER` | USABLE - StringBuilder transcript exists but has caveats/combined summary style; exact examples should be checked. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-052 | `STRINGCOMPARER,compare strings case insens.svg` | NO | YES | `STRINGCOMPARER,compare strings case insens` | GOOD - StringComparer/case-insensitive comparison transcript is code-rich and suitable for review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-053 | `STRINGREADER.svg` | NO | YES | `STRINGREADER` | GOOD - StringReader transcript has region coverage and code; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-054 | `struct span.svg` | NO | YES | `struct span` | GOOD - Struct/span transcript is substantial and code-rich; good study source. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-055 | `svg react.svg` | NO | YES | `svg react` | GOOD - SVG React transcript includes enough JSX/SVG detail for repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-056 | `SVH DVH LVH.svg` | NO | YES | `SVH DVH LVH` | USABLE - SVH/DVH/LVH transcript exists but has caveats and summary style; verify CSS unit examples. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-057 | `symbol.svg` | NO | YES | `symbol` | USABLE - Symbol transcript is usable but caveated; exact JS code/identity examples need pass. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-058 | `tag helpers razor,partial.svg` | NO | YES | `tag helpers razor,partial` | USABLE - Tag helpers/partial transcript is compact; verify exact Razor names and examples. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-059 | `time.svg` | NO | YES | `time` | GOOD - Time transcript is large, clean, and API-heavy; good for review. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-060 | `transaction, isolation.svg` | NO | YES | `transaction, isolation` | GOOD - Transaction/isolation transcript is substantial with SQL concepts and examples; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-061 | `typescript any unknown.svg` | NO | YES | `typescript any unknown` | GOOD - New source-reconstructed transcript added at `typescript any unknown\regions\R01-any-vs-unknown-final-transcript-v001.md`; readable source screenshots transcribed for response.json(), any, unknown and narrowing. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_5.md` |
| extra-062 | `typescript generics default type arguments.svg` | NO | YES | `typescript generics default type arguments` | GOOD - New source-reconstructed transcript added at `typescript generics default type arguments\regions\R01-generic-default-type-arguments-final-transcript-v001.md`; readable source screenshots transcribed for ApiResponse default type arguments. | `OK_FOR_STUDY` | NO | `SOURCE_FIX_PASS_2026_07_07_BATCH_6.md` |
| extra-063 | `usecontext.svg` | NO | YES | `usecontext` | USABLE - useContext transcript exists but caveated and condensed; exact hook/provider examples need checking. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-064 | `usecookiepolicy.svg` | NO | YES | `usecookiepolicy` | USABLE - useCookiePolicy transcript is present but very low code-fence count and compact; verify middleware/API exactness. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-065 | `useReducer.svg` | NO | YES | `useReducer` | GOOD - useReducer transcript is substantial with many code examples; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-066 | `useRef to avoid including into deps array, to avoid rerenders or bad recreations.svg` | NO | YES | `useRef to avoid including into deps array, to avoid rerenders or bad recreations` | USABLE - useRef avoid rerenders transcript is present but caveated/semantic; exact examples need pass. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-067 | `useref, when need to have ref from obj created in useeffect + when need to access someting inside effect without incl into dep array.svg` | NO | YES | `useref, when need to have ref from obj created in useeffect + when need to access someting inside effect without incl into dep array` | GOOD - useRef/useEffect transcript is compact but includes relevant examples and distinctions; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-068 | `usesyncexternalstore.svg` | NO | YES | `usesyncexternalstore` | USABLE - useSyncExternalStore transcript is useful but caveated and summary-like; exact hook contract needs checking. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-069 | `utility types.svg` | NO | YES | `utility types` | GOOD - Utility types transcript is long and code-rich; suitable for questions and repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-070 | `viewcomponent.svg` | NO | YES | `viewcomponent` | USABLE - ViewComponent coverage exists but is compact; verify Razor/view lookup/class names. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-071 | `views, idexed views.svg` | NO | YES | `views-idexed-views` | GOOD - Views/indexed views transcript is long, clean, and SQL-detail rich; usable. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-072 | `websockets.svg` | NO | YES | `websockets` | GOOD - WebSockets transcript is long/corrected and detailed; usable, with minor exactness cleanup only. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-073 | `windows auth.svg` | NO | YES | `windows-auth` | USABLE - Windows Auth transcript is clean but focused on one deployment/SPN region; verify full SVG coverage. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-074 | `xhr.svg` | NO | YES | `xhr` | GOOD - XHR transcript is code/API-rich and suitable for repetition. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-075 | `xss, csp.svg` | NO | YES | `xss, csp` | USABLE - XSS/CSP transcript exists but caveated and summary-like; verify exact CSP headers/directives and code. | `NEEDS_EXACT_PASS` | YES | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
| extra-076 | `zod.svg` | NO | YES | `zod` | GOOD - Zod transcript is substantial and code-rich; usable for study/questions. | `OK_FOR_STUDY` | NO | `INDEPENDENT_TRANSCRIPT_AUDIT_EXTRA_231_306.md` |
