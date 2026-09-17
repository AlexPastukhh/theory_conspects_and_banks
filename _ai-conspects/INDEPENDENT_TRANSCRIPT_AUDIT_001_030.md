# Independent transcript audit 001-030

Date: 2026-07-04

Scope: registry entries 1-30 only. Existing READY/final/verified/source-preserving/coverage statuses were not accepted as proof. They were used only as navigation hints when locating candidate transcript/source files.

## Worklist

```text
registry rows: 30
unique SVG entries: 30
duplicate registry rows: 0
matching repo folders: 30
entries without matching folder: 0
```

Source caveat: entry 19 (`mfa.svg`) has a matching `mfa` folder, but no `.svg` file was found under that folder during this audit. The folder contains extracted source images/contact sheets and region transcripts, so it can still be reviewed, but strict SVG-to-transcript verification is weaker for that entry.

## Method

- Read the candidate final/integrated transcript for each of the 30 registry entries.
- For large conspects, sampled region/source-preserving files where the main file was only a summary.
- Checked source availability by folder and `.svg` presence.
- Ran a mechanical scan of the selected authoritative transcript files for odd Markdown code fences, placeholder/OCR-error signals, and common UTF-8 mojibake markers for broken dashes, quotes, bullets, and copyright-like symbols.
- Did not rely on old coverage/status wording as evidence of correctness.

## Global findings

Mechanical structure:

- No selected authoritative transcript had an odd number of Markdown code fences.
- No blocking placeholder file was found among the selected final files. `mfa` contains positive phrases such as "not an OCR-timeout/error placeholder", which are not bad placeholder signals.
- Mojibake is widespread in headings, dashes, quotes, and bullets. It usually does not damage code fences, but it does damage near-literal trust and some visible-text reproduction.

Main quality pattern:

- Many transcripts are good semantic study notes, not near-literal source reconstructions.
- For the user's target of recreating exact code/API names/parameters without SVG, source-by-source files are much safer than integrated semantic transcripts.
- Entries explicitly saying "SVG/screenshots remain authoritative for exact punctuation/code" should be treated as partial for exact code recovery, even when concept coverage is good.

## Audit register

| # | SVG name from registry | Folder checked | Primary transcript checked | Verdict | Source match / reliability assessment |
|---:|---|---|---|---|---|
| 1 | `regex, reusing, compiled.svg` | `regex, reusing, compiled` | `01-final-transcript.md` | **B / usable with exactness caveat** | Covers the topic and preserves key C# examples: `Regex`, `RegexOptions.Compiled`, `CultureInvariant`, timeout. It is semantic, not source-by-source. Good for study and most API recall; check SVG for exact original wording/punctuation. Mojibake in title punctuation. |
| 2 | `hateoas.svg` | `hateoas` | `regions/R01R06-hateoas-full-coverage-v001.md` | **B- / comprehensive semantic** | Strong source map by image IDs and text nodes, but much of the content is synthesized prose. Good for repeating concepts, HATEOAS flow, relation names, and ASP.NET Core link-building ideas. Not sufficient as near-literal code reconstruction for all 78 image uses. |
| 3 | `modelstate.svg` | `modelstate` | `regions/modelstate-final.md` | **C+ / too condensed for code recovery** | Good conceptual ModelState summary. It preserves important API names (`ModelState`, `TryValidateModel`, `AddModelError`, `InvalidModelStateResponseFactory`) but has no source-specific code blocks. Not enough for exact reproduction of source screenshots. |
| 4 | `return new ().svg` | `return new ()` | `03-full-combined-final-transcript.md` | **B / small and adequate** | The core `return new(...)` / `ValueTask<InterceptionResult<int>>` example is preserved. File explicitly says SVG/screenshots remain authoritative for exact source code and punctuation, but the conspect is tiny and the semantic risk is low. |
| 5 | `CUSTOM ROUTE CONSTRAINT.svg` | `CUSTOM ROUTE CONSTRAINT` | `regions/R01-final-coverage-transcript.md` | **B+ / mostly reconstructable** | Good C# example for `IRouteConstraint`, `RouteOptions.ConstraintMap`, and route usage. Looks sufficient for learning and reproducing the main code shape. Still normalized and not a per-screenshot literal transcript. |
| 6 | `totp, summary,theory.svg` | `totp, summary,theory` | `regions/R01-totp-theory-enrollment-verification-final.md` | **B / concept complete, code summarized** | Formula `C = floor((T - T0) / X)` and enrollment sequence are preserved. Backend code flow is summarized rather than transcribed. Good for review questions and architecture; partial for exact implementation. |
| 7 | `rawconnections,dbconnection,sqlconnection,commands.svg` | same | `04-detailed-near-literal-transcript-v002.md` | **A- / strong** | Detailed, source-faithful, with many C#/SQL code blocks and ADO.NET API names. Minor exactness caveat remains for punctuation/layout, but this is one of the safer transcripts for code/API reconstruction. |
| 8 | `any in exists.svg` | `any in exists` | `01-final-transcript.md` | **A- / small and clear** | SQL examples for `IN`, `EXISTS`, `ANY`, `NOT EXISTS` are preserved. Good enough for repeat/review/code recall. Minor semantic normalization only. |
| 9 | `interlocked,interlocked.read.svg` | `interlocked,interlocked.read` | `04-full-svg-semantic-transcript-v002.md` | **C+ / high-level only** | Covers regions and API names (`Interlocked.Read`, `CompareExchange`, `MemoryBarrier`, etc.) but almost no exact code. Good for concept review; weak for reproducing screenshots, code sequences, or precise examples. |
| 10 | `pointers.svg` | `pointers` | `regions/R01-csharp-pointers-unsafe-fixed-interop-final.md` | **B / adequate semantic with code** | Preserves key unsafe examples (`int*`, `&x`, `*p`, `fixed`). Good for study and core syntax. Not near-literal source-by-source. |
| 11 | `span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types.svg` | same | `06-full-combined-final-transcript.md` | **B / broad but semantic** | Large source condensed into integrated sections. Good API coverage (`Span<T>`, `Memory<T>`, `stackalloc`, `ArrayPool<T>`, `Unsafe.SizeOf<T>`, etc.) and some code. Exact original code/version details still require SVG/source images. |
| 12 | `REST API BASICS.svg` | `REST API BASICS` | `01-final-transcript.md` plus region sample | **C+ as main file / B with regions** | Main file is only an index-level summary and explicitly sends exact code/wording to source/regions. Region files are more useful, but the primary transcript alone is not enough for detailed repetition or code recovery. |
| 13 | `pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el.svg` | same | `04-full-combined-final-transcript.md` | **B- / concepts good, CSS exactness weak** | Explains pseudo-elements, stacking contexts, fixed overlays, and portal/backdrop guidance. Lacks exact CSS/source code; file says source remains authoritative for exact code/punctuation. |
| 14 | `SQL SERVER MARS.svg` | `sql-server-mars` | `04-source-preserving-transcript-v002.md` | **A / strong source-by-source** | Per-screenshot blocks with near-literal content and visible code. Good match to source intent and strong for code/API/sequence recall. Mojibake affects punctuation/dashes but not core code. |
| 15 | `async processing of multiple calls,parallelism.svg` | same | `09-full-combined-final-transcript.md` | **B+ / strong semantic with code** | Preserves many key C# examples and distinctions: `SemaphoreSlim`, `Task.WhenAll`, `Parallel.ForEachAsync`, cancellation, ordering. Not source-literal; exact punctuation/version details still require source. |
| 16 | `url save base 64 for db, hex string.svg` | same | `regions/R01R02-final-coverage.md` | **B / concept reliable** | Clear distinction between Data Protection/hash bytes and Base64/Base64Url/hex encoding. Good for review. Limited exact code/API reconstruction, but the topic is mostly conceptual. |
| 17 | `searching impl, ef core, full text search,sql server.svg` | same | `02-corrected-semantic-transcript-v002.md` | **B+ / good corrected semantic** | Includes important C#, SQL, EF Core and SQL Server full-text examples. Better than a generic summary and likely usable for most study/code recall, but still labeled semantic rather than near-literal. |
| 18 | `dbcontextpool, queryfilter.svg` | `dbcontextpool, queryfilter` | `regions/R01R02R03-final-coverage.md` | **C+ / label-derived semantic** | Useful explanation of pooling, tenant state, query filters, and ADO.NET cleanup. No exact code snippets; weak for implementation reconstruction. Suitable for conceptual review questions. |
| 19 | `mfa.svg` | `mfa` | `04-closure-audit.md`, sampled region files | **C / needs precision pass** | Region transcripts exist and include source IDs plus visible text/code, but the folder has no `.svg` found. `MFA-R02` contains visible mojibake/OCR artifacts in bullets and quotes. Backend region has useful code, yet the package is fragmented across stages. Needs a consolidated, cleaned, source-preserving final transcript. |
| 20 | `redux rtk.svg` | `redux rtk` | `01-final-transcript.md` | **B+ / useful with code** | Good RTK/Redux API coverage: `configureStore`, `createSlice`, `createAsyncThunk`, `extraReducers`, `builder.addCase`, action shapes. Semantic, but enough for most code/API recall. |
| 21 | `js yield, asyncenumerable, finally of generator.svg` | same | `01-final-transcript.md` | **A- / strong** | Good JS generator/async generator examples, including `iterator.return()`, `finally` yielding, and cancellation caveats. Reliable for study and code reconstruction. |
| 22 | `typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion.svg` | same | `01-final-transcript.md` | **A- / strong** | Preserves TypeScript class examples, constructor parameter properties, `implements`, `super`, getters/setters, and definite assignment assertion. Good for code/API recall. |
| 23 | `server resources,multipleinstances,microservices.svg` | same | `02-source-preserving-transcript-v002.md` | **A- / strong evidence layer** | Source-preserving per-screenshot blocks with numbers, terminology, analogies, and recall questions. Good for detailed repetition. Mojibake appears in arrows/dashes but does not block meaning. |
| 24 | `set js.svg` | `set js` | `01-final-transcript.md` | **A- / compact and usable** | Good JS/TS `Set` API examples (`add`, `has`, `delete`, `clear`, `size`, iteration, set operations). Semantic but sufficient for this compact topic. |
| 25 | `options requ.svg` | `options requ` | `01-final-transcript.md` | **B+ / useful with HTTP/C# code** | Preserves CORS preflight examples, headers, `Vary: Origin`, ASP.NET Core CORS middleware order and options. Mojibake in quotes only. Good for API/header recall. |
| 26 | `in any exist, some.svg` | `in any exist, some` | `regions/final-transcript.md` | **A- / good SQL transcript** | Preserves SQL examples and semantics for `EXISTS`, `IN`, `ANY`, `SOME`, null behavior, empty sets. Good for study and code recall. |
| 27 | `ef core performance, diagnostics , compiled linq, batching, n + 1.svg` | `ef-core-performance-diagnostics-compiled-linq-batching-n-1` | `regions/R01R02R03R04-efcore-performance-final-coverage.md` | **C / too semantic for code/API reproduction** | Captures themes but has no code blocks and explicitly says exact code punctuation should be checked against screenshots. Good high-level review only; insufficient for detailed reconstruction. |
| 28 | `SUBSTRING.svg` | `SUBSTRING` | `04-full-combined-final-transcript.md` | **B- / concept adequate, exact examples absent** | Explains `Substring`, ranges, spans, allocation and Unicode caveats. No concrete code fences beyond prose; file says source is authoritative for exact code/version details. |
| 29 | `FLAT FLATMAP.svg` | `FLAT FLATMAP` | `05-full-combined-final-transcript.md` | **B+ / good semantic with JS examples** | Good examples for `flat`, `flatMap`, reduce alternatives, one-level flattening, and depth. Exact original examples still source-authoritative, but transcript is usable for most review/code recall. |
| 30 | `memory vs localstorage vs sessionstorage, session storage and local storage api methods.svg` | same | `01-final-transcript.md` | **B+ / good API coverage** | Preserves Web Storage API methods, JSON serialization helpers, lifetime/security tradeoffs, storage event, and quota handling. Good for study and code recall; semantic normalization remains. |

## Priority fixes

1. **Create a consolidated cleaned transcript for `mfa`** from the existing region files and source images; fix mojibake/OCR bullets and preserve the backend/controller code blocks.
2. **Upgrade high-risk semantic-only entries** if exact code recovery matters: `interlocked`, `REST API BASICS`, `dbcontextpool/queryfilter`, `ef core performance`, `modelstate`.
3. **Normalize encoding** across transcripts so typographic quotes/dashes/bullets are not stored as mojibake.
4. **For every semantic transcript with an exactness note**, add source-by-source appendices for visible code/API snippets, especially where the source has screenshots rather than simple diagrams.
