# Independent Transcript Audit - extra 231-306

Date: 2026-07-05

Scope: the 76 zip/workspace SVG entries that were still `NOT_AUDITED_YET` in `INDEPENDENT_TRANSCRIPT_AUDIT_MASTER_ALL_306.md`.

Method: independent transcript quality pass using the workspace folder contents, transcript candidates, file lengths, code-fence density, caveat markers, and targeted inspection of suspicious folders. Existing old statuses were treated only as evidence of whether a transcript exists, not as trust decisions.

## Summary

```text
checked rows: 76
GOOD / OK_FOR_STUDY: 40
USABLE / NEEDS_EXACT_PASS: 30
BAD / NEEDS_REBUILD_OR_TRANSCRIPT: 6
```

## High Priority Rebuilds

- `extra-020`: No real regional transcript found; folder shows only source check/manifest/policy/status and `regional transcripts: not started`.
- `extra-027`: Only planning/source-boundary/README style files found; no substantive regional transcript for routing/custom constraints.
- `extra-042`: No real transcript found; only source check/manifest/policy/status and status says regional transcripts not started.
- `extra-043`: No real transcript found; only source check/manifest/policy/status and status says regional transcripts not started.
- `extra-061`: No real transcript found; only setup files and status says regional transcripts not started.
- `extra-062`: No real transcript found; only setup files and status says regional transcripts not started.

## Register

| # | Verdict | Decision | Needs work | Finding |
|---|---|---|---|---|
| extra-001 | GOOD | `OK_FOR_STUDY` | NO | Substantial final semantic transcript with many code fences; minor mojibake only in generated headings, usable for OPENJSON repetition. |
| extra-002 | GOOD | `OK_FOR_STUDY` | NO | Large source-preserving OutputCache/CDN transcript; enough API and sequence detail for study, with minor OCR/header residue. |
| extra-003 | USABLE | `NEEDS_EXACT_PASS` | YES | Useful comparison transcript, but only a focused region candidate; exact policy/code coverage should be checked against SVG. |
| extra-004 | GOOD | `OK_FOR_STUDY` | NO | Compact pagination transcript with code blocks and clear offset/take sequence; adequate for questions. |
| extra-005 | GOOD | `OK_FOR_STUDY` | NO | Parse int/float/double transcript has enough examples/API names; minor generated-heading mojibake does not affect content. |
| extra-006 | GOOD | `OK_FOR_STUDY` | NO | Long persistence/Zustand/RQuery/Redux transcript; broad enough for repeating concepts and API contrasts, though small caveats remain. |
| extra-007 | USABLE | `NEEDS_EXACT_PASS` | YES | Combined streams transcript is useful, but has caveats and some generated/OCR residue; exact stream method names and code should be rechecked. |
| extra-008 | GOOD | `OK_FOR_STUDY` | NO | Primary HttpHandler/Sockets transcript is detailed and source-preserving; usable for API-level review. |
| extra-009 | USABLE | `NEEDS_EXACT_PASS` | YES | Problem2 transcript is present but has several caveats and semantic summarization; verify exact code/steps before trusting fully. |
| extra-010 | USABLE | `NEEDS_EXACT_PASS` | YES | Processing data as stream reconciliation exists, but is short/focused; needs exact coverage pass for completeness. |
| extra-011 | USABLE | `NEEDS_EXACT_PASS` | YES | Produces/Consumes region transcript is clean but narrow; verify all SVG regions and Accept/Vary examples. |
| extra-012 | USABLE | `NEEDS_EXACT_PASS` | YES | Inline CSS transcript is compact and semantic; okay for basics, but too short for near-literal trust. |
| extra-013 | GOOD | `OK_FOR_STUDY` | NO | Promise.all transcript includes useful examples and sequencing; suitable for repetition. |
| extra-014 | USABLE | `NEEDS_EXACT_PASS` | YES | Query-string preference transcript is clean but region-specific; check winner ordering/build-result/HATEOAS details against SVG. |
| extra-015 | GOOD | `OK_FOR_STUDY` | NO | RandomNumberGenerator transcript has enough crypto/API detail and code blocks; usable with minor exactness check only. |
| extra-016 | GOOD | `OK_FOR_STUDY` | NO | Range operations on List transcript has clear examples and API names; good for questions. |
| extra-017 | USABLE | `NEEDS_EXACT_PASS` | YES | Razor partial updates coverage exists but looks coverage-oriented; verify exact Razor/JS names and missing surrounding regions. |
| extra-018 | GOOD | `OK_FOR_STUDY` | NO | React Router transcript is large and code-rich; minor generated-heading artifacts do not block study use. |
| extra-019 | USABLE | `NEEDS_EXACT_PASS` | YES | React state/rerenders combined transcript is useful but has caveats/semantic compression; exact hook behavior/examples need checking. |
| extra-020 | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | No real regional transcript found; folder shows only source check/manifest/policy/status and `regional transcripts: not started`. |
| extra-021 | GOOD | `OK_FOR_STUDY` | NO | Records transcript is screenshot-backed and substantial; usable for C# records review. |
| extra-022 | USABLE | `NEEDS_EXACT_PASS` | YES | Redis lock transcript is clean but appears to cover one focused region; verify multiplexer/Redlock coverage across SVG. |
| extra-023 | USABLE | `NEEDS_EXACT_PASS` | YES | Redux basics combined transcript is substantial, but caveats and semantic layer mean exact API/code pass is needed. |
| extra-024 | GOOD | `OK_FOR_STUDY` | NO | ref/in/out transcript is concise with API/code examples; suitable for repetition. |
| extra-025 | USABLE | `NEEDS_EXACT_PASS` | YES | ReturnUrl Razor transcript is very short; concepts present but exact coverage likely incomplete. |
| extra-026 | GOOD | `OK_FOR_STUDY` | NO | Generic parameter/return specificity transcript is clear and code-supported; usable. |
| extra-027 | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | Only planning/source-boundary/README style files found; no substantive regional transcript for routing/custom constraints. |
| extra-028 | USABLE | `NEEDS_EXACT_PASS` | YES | Scroll block transcript exists but has caveats and summary style; CSS exactness needs checking. |
| extra-029 | USABLE | `NEEDS_EXACT_PASS` | YES | SemaphoreSlim/TS pending promise transcript is useful but caveated; verify exact async code and unresolved promise details. |
| extra-030 | USABLE | `NEEDS_EXACT_PASS` | YES | SemaphoreSlim vs Channel transcript is clean but short; sufficient for overview, not near-literal. |
| extra-031 | USABLE | `NEEDS_EXACT_PASS` | YES | Browser/server threads transcript is clean but short/focused; check worker lifecycle/error details against SVG. |
| extra-032 | USABLE | `NEEDS_EXACT_PASS` | YES | Very large Polly region transcript exists, but many caveat markers/generated artifacts; exact code/API pass required. |
| extra-033 | GOOD | `OK_FOR_STUDY` | NO | Sharp regex/options/conditional replace transcript has many code fences and regex detail; usable with minor exactness review. |
| extra-034 | USABLE | `NEEDS_EXACT_PASS` | YES | Sheet get last transcript exists but has caveats and semantic compression; check examples. |
| extra-035 | USABLE | `NEEDS_EXACT_PASS` | YES | Sheet HashSet transcript exists but has caveats/summary layer; verify exact code and operations. |
| extra-036 | GOOD | `OK_FOR_STUDY` | NO | Sheet regex sharp transcript is compact but code-rich enough for repetition. |
| extra-037 | GOOD | `OK_FOR_STUDY` | NO | SQL syntax/SQL Server region transcript is substantial and clean, with many SQL examples. |
| extra-038 | GOOD | `OK_FOR_STUDY` | NO | EFCore bulk/SqlBulkCopy transcript is clean and detailed enough for API/sequence review. |
| extra-039 | GOOD | `OK_FOR_STUDY` | NO | Stored procedures transcript is long and corrected, with enough SQL/API detail for study. |
| extra-040 | GOOD | `OK_FOR_STUDY` | NO | Initial candidate was a short correction file, but folder contains large source-preserving streaming region transcripts; usable overall. |
| extra-041 | GOOD | `OK_FOR_STUDY` | NO | String Trim transcript is compact and example-focused; usable for repetition. |
| extra-042 | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | No real transcript found; only source check/manifest/policy/status and status says regional transcripts not started. |
| extra-043 | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | No real transcript found; only source check/manifest/policy/status and status says regional transcripts not started. |
| extra-044 | GOOD | `OK_FOR_STUDY` | NO | String Index transcript is small but has examples/API details; usable. |
| extra-045 | GOOD | `OK_FOR_STUDY` | NO | String.Join transcript is short but example-focused and sufficient for this narrow topic. |
| extra-046 | GOOD | `OK_FOR_STUDY` | NO | String padding transcript is narrow, with enough examples for review. |
| extra-047 | GOOD | `OK_FOR_STUDY` | NO | String Remove/Insert transcript is concise and example-oriented; usable. |
| extra-048 | GOOD | `OK_FOR_STUDY` | NO | String Sort transcript is compact with relevant examples; usable. |
| extra-049 | GOOD | `OK_FOR_STUDY` | NO | String Split transcript is compact and API/example oriented; usable. |
| extra-050 | GOOD | `OK_FOR_STUDY` | NO | String to char list transcript is concise with examples; usable. |
| extra-051 | USABLE | `NEEDS_EXACT_PASS` | YES | StringBuilder transcript exists but has caveats/combined summary style; exact examples should be checked. |
| extra-052 | GOOD | `OK_FOR_STUDY` | NO | StringComparer/case-insensitive comparison transcript is code-rich and suitable for review. |
| extra-053 | GOOD | `OK_FOR_STUDY` | NO | StringReader transcript has region coverage and code; usable. |
| extra-054 | GOOD | `OK_FOR_STUDY` | NO | Struct/span transcript is substantial and code-rich; good study source. |
| extra-055 | GOOD | `OK_FOR_STUDY` | NO | SVG React transcript includes enough JSX/SVG detail for repetition. |
| extra-056 | USABLE | `NEEDS_EXACT_PASS` | YES | SVH/DVH/LVH transcript exists but has caveats and summary style; verify CSS unit examples. |
| extra-057 | USABLE | `NEEDS_EXACT_PASS` | YES | Symbol transcript is usable but caveated; exact JS code/identity examples need pass. |
| extra-058 | USABLE | `NEEDS_EXACT_PASS` | YES | Tag helpers/partial transcript is compact; verify exact Razor names and examples. |
| extra-059 | GOOD | `OK_FOR_STUDY` | NO | Time transcript is large, clean, and API-heavy; good for review. |
| extra-060 | GOOD | `OK_FOR_STUDY` | NO | Transaction/isolation transcript is substantial with SQL concepts and examples; usable. |
| extra-061 | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | No real transcript found; only setup files and status says regional transcripts not started. |
| extra-062 | BAD | `NEEDS_REBUILD_OR_TRANSCRIPT` | YES | No real transcript found; only setup files and status says regional transcripts not started. |
| extra-063 | USABLE | `NEEDS_EXACT_PASS` | YES | useContext transcript exists but caveated and condensed; exact hook/provider examples need checking. |
| extra-064 | USABLE | `NEEDS_EXACT_PASS` | YES | useCookiePolicy transcript is present but very low code-fence count and compact; verify middleware/API exactness. |
| extra-065 | GOOD | `OK_FOR_STUDY` | NO | useReducer transcript is substantial with many code examples; usable. |
| extra-066 | USABLE | `NEEDS_EXACT_PASS` | YES | useRef avoid rerenders transcript is present but caveated/semantic; exact examples need pass. |
| extra-067 | GOOD | `OK_FOR_STUDY` | NO | useRef/useEffect transcript is compact but includes relevant examples and distinctions; usable. |
| extra-068 | USABLE | `NEEDS_EXACT_PASS` | YES | useSyncExternalStore transcript is useful but caveated and summary-like; exact hook contract needs checking. |
| extra-069 | GOOD | `OK_FOR_STUDY` | NO | Utility types transcript is long and code-rich; suitable for questions and repetition. |
| extra-070 | USABLE | `NEEDS_EXACT_PASS` | YES | ViewComponent coverage exists but is compact; verify Razor/view lookup/class names. |
| extra-071 | GOOD | `OK_FOR_STUDY` | NO | Views/indexed views transcript is long, clean, and SQL-detail rich; usable. |
| extra-072 | GOOD | `OK_FOR_STUDY` | NO | WebSockets transcript is long/corrected and detailed; usable, with minor exactness cleanup only. |
| extra-073 | USABLE | `NEEDS_EXACT_PASS` | YES | Windows Auth transcript is clean but focused on one deployment/SPN region; verify full SVG coverage. |
| extra-074 | GOOD | `OK_FOR_STUDY` | NO | XHR transcript is code/API-rich and suitable for repetition. |
| extra-075 | USABLE | `NEEDS_EXACT_PASS` | YES | XSS/CSP transcript exists but caveated and summary-like; verify exact CSP headers/directives and code. |
| extra-076 | GOOD | `OK_FOR_STUDY` | NO | Zod transcript is substantial and code-rich; usable for study/questions. |
