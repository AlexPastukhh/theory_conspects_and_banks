# Exact Pass Source Availability - 122 NEEDS_EXACT_PASS conspects

Date: 2026-07-07

Purpose: check whether each `NEEDS_EXACT_PASS` conspect has enough local source material to do the exact source-vs-transcript pass without asking for external SVGs again.

This is a source-availability inventory, not the exact correction pass itself.

## Summary

```text
NEEDS_EXACT_PASS rows checked: 122
READY_LOCAL_SOURCE: 118
SOURCE_EXISTS_TRANSCRIPT_CANDIDATE_UNCLEAR: 1
SOURCE_SVG_MISSING_BUT_IMAGES_EXIST: 3
```

## Rows Needing Source Attention Before Exact Pass

- `19` `mfa.svg`: SOURCE_SVG_MISSING_BUT_IMAGES_EXIST; sourceSvg=0, images=253, transcriptCandidates=2, mainCandidate=`03-stage2-remaining-transcripts.md`
- `87` `working with bytes, streams to bytes, to array readexactly,readatleast.svg`: SOURCE_SVG_MISSING_BUT_IMAGES_EXIST; sourceSvg=0, images=71, transcriptCandidates=2, mainCandidate=`02-stage1-r01-r02-transcript.md`
- `226` `MEDIA TYPES OF REQUESTS.svg`: SOURCE_SVG_MISSING_BUT_IMAGES_EXIST; sourceSvg=0, images=88, transcriptCandidates=2, mainCandidate=`02-stage1-r01-r02-transcript.md`
- `extra-031` `server browser threads,memory, webworkers , runtime vs compiler , es.svg`: SOURCE_EXISTS_TRANSCRIPT_CANDIDATE_UNCLEAR; sourceSvg=1, images=126, transcriptCandidates=0, mainCandidate=`-`

## Full Register

| # | SVG | Folder | Source status | Source SVGs | Images | Transcript candidates | Main candidate |
|---|---|---|---|---:|---:|---:|---|
| 1 | `regex, reusing, compiled.svg` | `regex, reusing, compiled` | READY_LOCAL_SOURCE | 1 | 31 | 3 | `R01R02R03R04-regex-reuse-final-v001.md` |
| 2 | `hateoas.svg` | `hateoas` | READY_LOCAL_SOURCE | 1 | 109 | 2 | `R01R06-hateoas-full-coverage-v001.md` |
| 3 | `modelstate.svg` | `modelstate` | READY_LOCAL_SOURCE | 1 | 58 | 2 | `modelstate-final.md` |
| 4 | `return new ().svg` | `return new ()` | READY_LOCAL_SOURCE | 1 | 33 | 5 | `01-transcript-R01-target-typed-new-expressions.md` |
| 6 | `totp, summary,theory.svg` | `totp, summary,theory` | READY_LOCAL_SOURCE | 1 | 49 | 2 | `R01-totp-theory-enrollment-verification-final.md` |
| 9 | `interlocked,interlocked.read.svg` | `interlocked,interlocked.read` | READY_LOCAL_SOURCE | 2 | 84 | 3 | `04-full-svg-semantic-transcript-v002.md` |
| 10 | `pointers.svg` | `pointers` | READY_LOCAL_SOURCE | 1 | 51 | 2 | `R01-csharp-pointers-unsafe-fixed-interop-final.md` |
| 11 | `span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types.svg` | `span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types` | READY_LOCAL_SOURCE | 1 | 150 | 5 | `06-full-combined-final-transcript.md` |
| 12 | `REST API BASICS.svg` | `REST API BASICS` | READY_LOCAL_SOURCE | 1 | 253 | 2 | `01-final-transcript.md` |
| 13 | `pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el.svg` | `pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el` | READY_LOCAL_SOURCE | 1 | 38 | 5 | `04-full-combined-final-transcript.md` |
| 16 | `url save base 64 for db, hex string.svg` | `url save base 64 for db, hex string` | READY_LOCAL_SOURCE | 1 | 33 | 2 | `R01R02-final-coverage.md` |
| 18 | `dbcontextpool, queryfilter.svg` | `dbcontextpool, queryfilter` | READY_LOCAL_SOURCE | 1 | 84 | 5 | `01-final-transcript.md` |
| 19 | `mfa.svg` | `mfa` | SOURCE_SVG_MISSING_BUT_IMAGES_EXIST | 0 | 253 | 2 | `03-stage2-remaining-transcripts.md` |
| 27 | `ef core performance, diagnostics , compiled linq, batching, n + 1.svg` | `ef-core-performance-diagnostics-compiled-linq-batching-n-1` | READY_LOCAL_SOURCE | 1 | 54 | 2 | `R01R02R03R04-efcore-performance-final-coverage.md` |
| 28 | `SUBSTRING.svg` | `SUBSTRING` | READY_LOCAL_SOURCE | 1 | 39 | 5 | `04-full-combined-final-transcript.md` |
| 34 | `adddataprotection, encryption, password recovery.svg` | `adddataprotection, encryption, password recovery` | READY_LOCAL_SOURCE | 1 | 108 | 2 | `final-transcript.md` |
| 36 | `scroll block css.svg` | `scroll block css` | READY_LOCAL_SOURCE | 1 | 41 | 5 | `04-full-combined-final-transcript.md` |
| 41 | `jwt auth.svg` | `jwt auth` | READY_LOCAL_SOURCE | 2 | 212 | 3 | `R01R02R03R04-jwt-auth-corrected-final-v002.md` |
| 43 | `PUT,PATCH.svg` | `PUT,PATCH` | READY_LOCAL_SOURCE | 1 | 118 | 2 | `R01R07-put-patch-full-coverage-v001.md` |
| 47 | `ef migrations, dotnet-counters.svg` | `ef migrations, dotnet-counters` | READY_LOCAL_SOURCE | 2 | 90 | 4 | `04-full-svg-semantic-transcript-v002.md` |
| 55 | `cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS.svg` | `cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS` | READY_LOCAL_SOURCE | 1 | 99 | 2 | `R01R07-cache-control-response-caching-etag-full-coverage-v001.md` |
| 60 | `membernotnull attribute,NULL.svg` | `membernotnull attribute,NULL` | READY_LOCAL_SOURCE | 1 | 22 | 4 | `final-transcript.md` |
| 65 | `redis, idatabase,iserver.svg` | `redis, idatabase,iserver` | READY_LOCAL_SOURCE | 1 | 107 | 5 | `08-full-combined-final-transcript.md` |
| 66 | `root document.svg` | `root document` | READY_LOCAL_SOURCE | 1 | 36 | 5 | `02-full-combined-final-transcript.md` |
| 68 | `svg.svg` | `svg` | READY_LOCAL_SOURCE | 1 | 28 | 4 | `02-full-combined-final-transcript.md` |
| 69 | `options pattern.svg` | `options pattern` | READY_LOCAL_SOURCE | 1 | 153 | 2 | `03-stage3-final-closure-audit.md` |
| 72 | `identity.svg` | `identity` | READY_LOCAL_SOURCE | 1 | 125 | 5 | `06-detailed-near-literal-full-transcript-v002.md` |
| 75 | `cookie auth, antiforgery.svg` | `cookie auth, antiforgery` | READY_LOCAL_SOURCE | 1 | 178 | 2 | `final-transcript.md` |
| 81 | `objectpool,arraypool,memorypool.svg` | `objectpool,arraypool,memorypool` | READY_LOCAL_SOURCE | 2 | 114 | 5 | `09-full-combined-final-transcript.md` |
| 83 | `istringlocalizer iviewlocalizer.svg` | `istringlocalizer iviewlocalizer` | READY_LOCAL_SOURCE | 1 | 28 | 2 | `R01-final-transcript.md` |
| 85 | `CASE INSENS,collate.svg` | `CASE INSENS,collate` | READY_LOCAL_SOURCE | 1 | 46 | 5 | `05-full-combined-final-transcript.md` |
| 87 | `working with bytes, streams to bytes, to array readexactly,readatleast.svg` | `working with bytes, streams to bytes, to array readexactly,readatleast` | SOURCE_SVG_MISSING_BUT_IMAGES_EXIST | 0 | 71 | 2 | `02-stage1-r01-r02-transcript.md` |
| 88 | `stacking contexts, zindex.svg` | `stacking contexts, zindex` | READY_LOCAL_SOURCE | 1 | 49 | 5 | `05-full-combined-final-transcript.md` |
| 91 | `remove from arr, copy.svg` | `remove from arr, copy` | READY_LOCAL_SOURCE | 1 | 44 | 5 | `05-full-combined-final-transcript.md` |
| 92 | `lazy loading.svg` | `lazy loading` | READY_LOCAL_SOURCE | 1 | 75 | 5 | `05-full-combined-final-transcript.md` |
| 94 | `pivot unpivot.svg` | `pivot unpivot` | READY_LOCAL_SOURCE | 1 | 42 | 5 | `04-full-combined-final-transcript.md` |
| 97 | `decoding, bytes memory, start of x byte character.svg` | `decoding, bytes memory, start of x byte character` | READY_LOCAL_SOURCE | 1 | 26 | 1 | `01-final-transcript.md` |
| 99 | `vitest test errors.svg` | `vitest test errors` | READY_LOCAL_SOURCE | 1 | 27 | 3 | `R01R02R03-vitest-errors-final-v001.md` |
| 100 | `principles,practises,patterns.svg` | `principles,practises,patterns` | READY_LOCAL_SOURCE | 1 | 39 | 2 | `R01-domain-modeling-many-to-many-ownership-final.md` |
| 101 | `partially initialized antipattern and possible partial inits inside repositories.svg` | `partially initialized antipattern and possible partial inits inside repositories` | READY_LOCAL_SOURCE | 1 | 25 | 1 | `01-final-transcript.md` |
| 103 | `viTst existance assert test.svg` | `viTst existance assert test` | READY_LOCAL_SOURCE | 1 | 37 | 5 | `04-full-combined-final-transcript.md` |
| 106 | `sheet exec order.svg` | `sheet exec order` | READY_LOCAL_SOURCE | 1 | 21 | 3 | `R01-semantic-transcript-final-v001.md` |
| 110 | `react root error, trigger useeffect on route change.svg` | `react root error, trigger useeffect on route change` | READY_LOCAL_SOURCE | 1 | 45 | 5 | `05-full-combined-final-transcript.md` |
| 114 | `Rhf react hook form.svg` | `Rhf react hook form` | READY_LOCAL_SOURCE | 1 | 194 | 5 | `10-full-combined-final-transcript.md` |
| 115 | `textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream.svg` | `textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream` | READY_LOCAL_SOURCE | 1 | 54 | 3 | `semantic-transcript-final-v001.md` |
| 119 | `ef has conversion, value converte,comparer.svg` | `ef has conversion, value converte,comparer` | READY_LOCAL_SOURCE | 1 | 96 | 5 | `06-full-combined-final-transcript.md` |
| 122 | `idistributedcache.svg` | `idistributedcache` | READY_LOCAL_SOURCE | 3 | 116 | 5 | `02-corrected-semantic-transcript-v002.md` |
| 123 | `useTransition full flow, usedebounce, useDefferedvalue.svg` | `useTransition full flow, usedebounce, useDefferedvalue` | READY_LOCAL_SOURCE | 1 | 71 | 5 | `07-full-combined-final-transcript.md` |
| 125 | `typescript explicit type annotations vs satisfies.svg` | `typescript explicit type annotations vs satisfies` | READY_LOCAL_SOURCE | 1 | 46 | 5 | `05-full-combined-final-transcript.md` |
| 126 | `explicit interface inplementation.svg` | `explicit interface inplementation` | READY_LOCAL_SOURCE | 1 | 55 | 5 | `05-full-combined-final-transcript.md` |
| 127 | `uselocation.svg` | `uselocation` | READY_LOCAL_SOURCE | 1 | 40 | 5 | `04-full-combined-final-transcript.md` |
| 133 | `usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions.svg` | `usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions` | READY_LOCAL_SOURCE | 1 | 41 | 3 | `R01R02R03R04-transitions-query-final-v001.md` |
| 138 | `inset vs size,margins,formula.svg` | `inset vs size,margins,formula` | READY_LOCAL_SOURCE | 1 | 48 | 3 | `semantic-transcript-final-v001.md` |
| 143 | `FILTERING AND SEARCHING.svg` | `FILTERING AND SEARCHING` | READY_LOCAL_SOURCE | 1 | 32 | 3 | `R01-R04-semantic-transcript-final-v001.md` |
| 146 | `last modified header, implementation, expirational model.svg` | `last modified header, implementation, expirational model` | READY_LOCAL_SOURCE | 1 | 53 | 3 | `R01-R04-semantic-transcript-final-v001.md` |
| 147 | `owned entity.svg` | `owned entity` | READY_LOCAL_SOURCE | 1 | 77 | 5 | `06-full-combined-final-transcript.md` |
| 150 | `ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED.svg` | `ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED` | READY_LOCAL_SOURCE | 1 | 40 | 3 | `R01R02R03-routing-route-design-final-v001.md` |
| 151 | `vary header.svg` | `vary header` | READY_LOCAL_SOURCE | 1 | 35 | 5 | `02-full-combined-final-transcript.md` |
| 152 | `- EF CORE GENERAL  repo shit   entity shit   onmodelcreat shit  transactions shit  dbexceptions   db level invariants,protection, trigger.svg` | `ef-core-general-repo-shit-entity-shit-onmodelcreat-shit-transactions-shit-dbexceptions-db-level-invariants-protection-trigger` | READY_LOCAL_SOURCE | 2 | 666 | 5 | `17-full-svg-reconciliation-final-v002.md` |
| 157 | `antiforgerytoken.svg` | `antiforgerytoken` | READY_LOCAL_SOURCE | 3 | 92 | 4 | `R01R02R03-antiforgerytoken-corrected-final-v002.md` |
| 159 | `assplitquery.svg` | `assplitquery` | READY_LOCAL_SOURCE | 2 | 86 | 2 | `R01R02R03R04-assplitquery-final-v001.md` |
| 160 | `AUTH EVENTS.svg` | `AUTH EVENTS` | READY_LOCAL_SOURCE | 2 | 161 | 4 | `R01R02R03-auth-events-corrected-final-v002.md` |
| 162 | `authentication,, oidc, flows , handlers , forwarding auth events.svg` | `authentication-oidc-flows-handlers-forwarding-auth-events` | READY_LOCAL_SOURCE | 1 | 730 | 4 | `04-stage4-final-coverage-audit.md` |
| 163 | `authorization flow,autorization options, framework, authorizationmiddlewareresulthandler.svg` | `authorization-flow-autorization-options-framework-authorizationmiddlewareresulthandler` | READY_LOCAL_SOURCE | 1 | 149 | 3 | `R01R02R03R04-authorization-full-final-v002.md` |
| 166 | `BALANCING GROUPS .NET.svg` | `BALANCING GROUPS .NET` | READY_LOCAL_SOURCE | 1 | 35 | 3 | `R01R02R03R04-balancing-groups-final-v001.md` |
| 167 | `BINDING SOURCE ATTRIBUTES.svg` | `BINDING SOURCE ATTRIBUTES` | READY_LOCAL_SOURCE | 1 | 38 | 2 | `R01-final-coverage-transcript.md` |
| 168 | `Bitwise checking for all combinations.svg` | `Bitwise checking for all combinations` | READY_LOCAL_SOURCE | 1 | 35 | 3 | `R01R02R03R04-bitwise-combinations-final-v001.md` |
| 178 | `cookies vs tokens sheet jswt in cookies.svg` | `cookies vs tokens sheet jswt in cookies` | READY_LOCAL_SOURCE | 1 | 35 | 2 | `R01R02-final-coverage.md` |
| 181 | `create array, fixed length.svg` | `create array, fixed length` | READY_LOCAL_SOURCE | 1 | 40 | 3 | `R01R02R03R04-array-creation-final-v001.md` |
| 184 | `decorator.svg` | `decorator` | READY_LOCAL_SOURCE | 1 | 44 | 5 | `05-full-combined-final-transcript.md` |
| 190 | `Enumerable static methods.svg` | `Enumerable static methods` | READY_LOCAL_SOURCE | 1 | 21 | 3 | `R01-semantic-transcript-final-v001.md` |
| 192 | `event source browser.svg` | `event source browser` | READY_LOCAL_SOURCE | 1 | 68 | 2 | `final-coverage-transcript.md` |
| 193 | `events,delegaates,action.svg` | `events,delegaates,action` | READY_LOCAL_SOURCE | 1 | 80 | 5 | `01-final-transcript.md` |
| 194 | `expandoobject.svg` | `expandoobject` | READY_LOCAL_SOURCE | 1 | 51 | 5 | `05-full-combined-final-transcript.md` |
| 196 | `FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED.svg` | `FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED` | READY_LOCAL_SOURCE | 1 | 31 | 2 | `R01-final-transcript.md` |
| 198 | `flex item ,flex shrinking.svg` | `flex item ,flex shrinking` | READY_LOCAL_SOURCE | 1 | 40 | 5 | `04-full-combined-final-transcript.md` |
| 200 | `formatting, numeric formatting, what can be formatted.svg` | `formatting, numeric formatting, what can be formatted` | READY_LOCAL_SOURCE | 1 | 50 | 3 | `R01R02R03R04-dotnet-formatting-final-v001.md` |
| 201 | `hashing.svg` | `hashing` | READY_LOCAL_SOURCE | 1 | 428 | 5 | `10-full-source-preserving-transcript-v001.md` |
| 207 | `indexes, onmodel indexes.svg` | `indexes, onmodel indexes` | READY_LOCAL_SOURCE | 1 | 188 | 5 | `09-full-combined-final-transcript.md` |
| 209 | `inline flags sharp.svg` | `inline flags sharp` | READY_LOCAL_SOURCE | 1 | 40 | 5 | `04-full-combined-final-transcript.md` |
| 212 | `jagged arr,multidim arr,cast boxing unboxing enumerable vs generic.svg` | `jagged arr,multidim arr,cast boxing unboxing enumerable vs generic` | READY_LOCAL_SOURCE | 1 | 50 | 5 | `05-full-combined-final-transcript.md` |
| 213 | `jquery dynamic form validation.svg` | `jquery dynamic form validation` | READY_LOCAL_SOURCE | 1 | 46 | 2 | `jquery dynamic form validation-final.md` |
| 215 | `js regex.svg` | `js regex` | READY_LOCAL_SOURCE | 1 | 40 | 5 | `04-full-combined-final-transcript.md` |
| 217 | `jsonconverter.svg` | `jsonconverter` | READY_LOCAL_SOURCE | 1 | 70 | 2 | `R01R02-jsonconverter-optional-final.md` |
| 221 | `link generator.svg` | `link generator` | READY_LOCAL_SOURCE | 1 | 40 | 2 | `R01-final-coverage-transcript.md` |
| 223 | `linq query syntax.svg` | `linq-query-syntax` | READY_LOCAL_SOURCE | 1 | 107 | 2 | `R01R02R03-linq-query-syntax-final.md` |
| 224 | `linq to sql.svg` | `linq to sql` | READY_LOCAL_SOURCE | 2 | 159 | 3 | `R01-final-coverage-transcript.md` |
| 225 | `manual account lockout,ratelimiter middleware, idatabase vs idist cache.svg` | `manual account lockout,ratelimiter middleware, idatabase vs idist cache` | READY_LOCAL_SOURCE | 2 | 174 | 3 | `04-full-svg-semantic-transcript-v002.md` |
| 226 | `MEDIA TYPES OF REQUESTS.svg` | `MEDIA TYPES OF REQUESTS` | SOURCE_SVG_MISSING_BUT_IMAGES_EXIST | 0 | 88 | 2 | `02-stage1-r01-r02-transcript.md` |
| 227 | `never type, exhaustion check with discriminated union.svg` | `never type, exhaustion check with discriminated union` | READY_LOCAL_SOURCE | 1 | 52 | 5 | `05-full-combined-final-transcript.md` |
| 229 | `OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties.svg` | `OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties` | READY_LOCAL_SOURCE | 1 | 327 | 5 | `13-full-combined-final-transcript.md` |
| 230 | `onmodelcreating.svg` | `onmodelcreating` | READY_LOCAL_SOURCE | 1 | 283 | 5 | `13-full-combined-final-transcript.md` |
| extra-003 | `outputcache, response cache comparison.svg` | `outputcache, response cache comparison` | READY_LOCAL_SOURCE | 1 | 386 | 2 | `R01-outputcache-responsecache-policies-etags-final.md` |
| extra-007 | `pipethrough,transformstream,pipeto,writablestream, readablestream.svg` | `pipethrough,transformstream,pipeto,writablestream, readablestream` | READY_LOCAL_SOURCE | 1 | 171 | 5 | `07-full-combined-final-transcript.md` |
| extra-009 | `problem2.svg` | `problem2` | READY_LOCAL_SOURCE | 1 | 78 | 5 | `06-full-combined-final-transcript.md` |
| extra-010 | `processing data as stream in dif situations, httpclient,endpoint,browser,websockets.svg` | `processing data as stream in dif situations, httpclient,endpoint,browser,websockets` | READY_LOCAL_SOURCE | 1 | 51 | 1 | `04-full-svg-semantic-transcript-v002.md` |
| extra-011 | `produces, consumes, input output formatters 406 415, vary accept.svg` | `produces-consumes-input-output-formatters-406-415-vary-accept` | READY_LOCAL_SOURCE | 1 | 181 | 3 | `03-stage3-final-coverage-audit.md` |
| extra-012 | `prog inline styles css.svg` | `prog inline styles css` | READY_LOCAL_SOURCE | 1 | 23 | 3 | `R01-semantic-transcript-final-v001.md` |
| extra-014 | `QS PREFERENCE WITH MULTIPLE ACCEPT HEADER VALUES HELPER.svg` | `qs-preference-with-multiple-accept-header-values-helper` | READY_LOCAL_SOURCE | 1 | 143 | 3 | `03-stage3-final-coverage-audit.md` |
| extra-017 | `RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX.svg` | `RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX` | READY_LOCAL_SOURCE | 1 | 39 | 2 | `R01R02R03-final-coverage.md` |
| extra-019 | `react state and rerenders, store subscriptions.svg` | `react state and rerenders, store subscriptions` | READY_LOCAL_SOURCE | 1 | 74 | 5 | `05-full-combined-final-transcript.md` |
| extra-022 | `redis,multiplexer,redis lock.svg` | `redis-multiplexer-redis-lock` | READY_LOCAL_SOURCE | 1 | 125 | 3 | `03-stage3-final-coverage-audit.md` |
| extra-023 | `redux basics.svg` | `redux basics` | READY_LOCAL_SOURCE | 1 | 146 | 5 | `07-full-combined-final-transcript.md` |
| extra-025 | `return url implementation razor.svg` | `return url implementation razor` | READY_LOCAL_SOURCE | 1 | 19 | 2 | `final-transcript.md` |
| extra-028 | `scroll block.svg` | `scroll block` | READY_LOCAL_SOURCE | 1 | 41 | 5 | `04-full-combined-final-transcript.md` |
| extra-029 | `semaphoreslim for ts js, pending promise without resolve.svg` | `semaphoreslim for ts js, pending promise without resolve` | READY_LOCAL_SOURCE | 1 | 69 | 5 | `06-full-combined-final-transcript.md` |
| extra-030 | `semaphoreslim vs channel.svg` | `semaphoreslim vs channel` | READY_LOCAL_SOURCE | 1 | 30 | 2 | `R01-final-transcript.md` |
| extra-031 | `server browser threads,memory, webworkers , runtime vs compiler , es.svg` | `server browser threads,memory, webworkers , runtime vs compiler , es` | SOURCE_EXISTS_TRANSCRIPT_CANDIDATE_UNCLEAR | 1 | 126 | 0 | `-` |
| extra-032 | `shared polly,cheat sheet,production ready verions, exceptions from pipeline and handling.svg` | `shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling` | READY_LOCAL_SOURCE | 1 | 412 | 4 | `R01R02R07-final-options-hedging-cheatsheet.md` |
| extra-034 | `sheet get last.svg` | `sheet get last` | READY_LOCAL_SOURCE | 1 | 44 | 5 | `05-full-combined-final-transcript.md` |
| extra-035 | `sheet hashset.svg` | `sheet hashset` | READY_LOCAL_SOURCE | 1 | 84 | 5 | `05-full-combined-final-transcript.md` |
| extra-051 | `STRINGBUILDER.svg` | `STRINGBUILDER` | READY_LOCAL_SOURCE | 1 | 40 | 5 | `04-full-combined-final-transcript.md` |
| extra-056 | `SVH DVH LVH.svg` | `SVH DVH LVH` | READY_LOCAL_SOURCE | 1 | 48 | 5 | `05-full-combined-final-transcript.md` |
| extra-057 | `symbol.svg` | `symbol` | READY_LOCAL_SOURCE | 1 | 43 | 5 | `05-full-combined-final-transcript.md` |
| extra-058 | `tag helpers razor,partial.svg` | `tag helpers razor,partial` | READY_LOCAL_SOURCE | 1 | 38 | 2 | `R01-final-coverage-transcript.md` |
| extra-063 | `usecontext.svg` | `usecontext` | READY_LOCAL_SOURCE | 1 | 34 | 5 | `03-full-combined-final-transcript.md` |
| extra-064 | `usecookiepolicy.svg` | `usecookiepolicy` | READY_LOCAL_SOURCE | 1 | 101 | 5 | `08-full-combined-final-transcript.md` |
| extra-066 | `useRef to avoid including into deps array, to avoid rerenders or bad recreations.svg` | `useRef to avoid including into deps array, to avoid rerenders or bad recreations` | READY_LOCAL_SOURCE | 1 | 41 | 5 | `04-full-combined-final-transcript.md` |
| extra-068 | `usesyncexternalstore.svg` | `usesyncexternalstore` | READY_LOCAL_SOURCE | 1 | 74 | 5 | `05-full-combined-final-transcript.md` |
| extra-070 | `viewcomponent.svg` | `viewcomponent` | READY_LOCAL_SOURCE | 1 | 37 | 2 | `R01R02R03-final-coverage.md` |
| extra-073 | `windows auth.svg` | `windows-auth` | READY_LOCAL_SOURCE | 1 | 194 | 3 | `03-stage3-final-coverage-audit.md` |
| extra-075 | `xss, csp.svg` | `xss, csp` | READY_LOCAL_SOURCE | 1 | 66 | 5 | `06-full-combined-final-transcript.md` |
