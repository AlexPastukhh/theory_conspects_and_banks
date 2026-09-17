# Independent transcript audit - selected entries 191-208 and 201-208

Date: 2026-07-04

Scope source: `C:\Users\alexa\Downloads\svg-conspects-checked-scope-register-1-229-corrected.md`, used only as list of SVG entries. Old status values were ignored.

User goal for this pass: transcript must be good enough to repeat the conspect, create repetition questions, and recover code/API names/parameters without constantly reopening SVG.

## Worklist

```text
registry rows checked: 9
unique SVG entries: 9
duplicate registry rows in this worklist: 0
matching repo folders: 9
entries without matching folder: 0
download SVGs supplied by user: 9
download SVGs matching repo source SVG hash: 9 / 9
```

Checked entries:

```text
191 equality.svg
192 event source browser.svg
193 events,delegaates,action.svg
196 FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED.svg
201 hashing.svg
202 headers.svg
204 httpcontent,custom one, readasstream buffering, compression directly to network.svg
205 httpcontext items and features.svg
208 injecting into razor.svg
```

Important registry drift:

- The corrected register is still stale for some changed SVG files. For example `hashing.svg`, `headers.svg`, and `events,delegaates,action.svg` in the repo/Downloads are larger and have different SHA-256 than the register rows shown in the corrected register.
- For this audit, the actual repo `source/*.svg` files were checked against the user-supplied Downloads SVGs; all 9 matched exactly.

## Summary Verdict

| Entry | Transcript checked | Verdict for repeat/questions | Main reason |
|---:|---|---|---|
| 191 | `equality/10-full-source-preserving-transcript-v003.md` | **NOT READY** | Residual broken C# and broken generated recall questions remain. |
| 192 | `event source browser/regions/final-coverage-transcript.md` | **USABLE, but semantic** | Good compact explanation; not source-by-source enough for exact code recovery. |
| 193 | `events,delegaates,action/01-final-transcript.md` | **USABLE** | Good conceptual transcript for repeating; code is summarized, not fully source-literal. |
| 196 | `FILTER.../regions/R01-final-transcript.md` | **PARTIAL** | Good summary, but too condensed and no real code reconstruction from screenshots. |
| 201 | `hashing/10-full-source-preserving-transcript-v001.md` | **PARTIAL / needs cleanup** | Strong source coverage, but OCR-normalized text and recall questions contain mojibake and some suspicious visible-text artifacts. |
| 202 | `headers/FINAL_TRANSCRIPT.md` | **READY for repeat** | Clear integrated transcript; API/header examples are usable. |
| 204 | `httpcontent.../FINAL_TRANSCRIPT.md` | **READY for repeat** | Source-preserving and code-heavy enough for study/questions. |
| 205 | `httpcontext items and features/FINAL_TRANSCRIPT.md` | **READY for repeat** | Source-preserving, practical examples, good distinction between Items and Features. |
| 208 | `injecting into razor/FINAL_TRANSCRIPT.md` | **READY for repeat** | Small, focused, source-preserving transcript with enough code/examples. |

## Findings

### 191 - `equality.svg`

Verdict: **NOT READY_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied `equality.svg`.
- v003 is better than older versions and preserves 18 source blocks.
- Main concepts are present: `IEquatable<T>`, `Equals(object?)`, `GetHashCode()`, value-object components, `HashCode.Combine`, `SequenceEqual`.

Blocking issues:

- Broken source text remains despite `READY_NEAR_LITERAL_NORMALIZED`.
- Examples found in current v003:
  - `<a> C# Q`
  - `GetEqualityComponents() .SequenceEqual (other.GetEqual ityComponents())`
  - `return other is not null & FirstName == other.FirstName && ...` uses single `&` in a code block where the intended teaching code should be `&&`.
  - `protected override IEnumerable<object> GetEqualityComponents({)` is syntactically broken.
  - `(GetHashCode()` appears with a stray opening parenthesis.
- Generated recall questions are mojibake/broken Russian and not usable as question bank.
- Mechanical scan of selected transcript found no odd code fences, but that does not save the semantic/code corruption.

Required fix:

- Rebuild/patch v003 source blocks S-004, S-007, S-014, S-015, S-016, S-018 at minimum.
- Replace broken recall questions with clean questions or remove them from the source-preserving transcript and keep them in a separate clean question bank.

### 192 - `event source browser.svg`

Verdict: **USABLE_FOR_REPEAT, not near-literal**

Positive:

- Current source SVG matches user-supplied SVG.
- Real content exists in `regions/final-coverage-transcript.md`; the root `01-stage1-final-coverage-transcript.md` is only a closure/count summary.
- Old reported artifacts like `modem browsers`, `vent:`, `Plain text oO`, `50@0`, `Rerawicnar` were not found in the selected authoritative region transcript.
- The transcript cleanly covers `new EventSource(url)`, `onopen`, `onmessage`, `onerror`, `readyState`, named events, `event:`, `id:`, `data:`, `retry:`, `Last-Event-ID`, reconnect, and `close()`.

Limitations:

- It is a compact semantic transcript, not source-by-source.
- Good for repetition questions and conceptual review.
- If source screenshots contained exact JS/server code, this transcript is not enough to reconstruct every original snippet exactly.

Required fix:

- Promote `regions/final-coverage-transcript.md` or create a root `FINAL_TRANSCRIPT.md`; current root `01-stage...` is misleading for readers.

### 193 - `events,delegaates,action.svg`

Verdict: **USABLE_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied SVG.
- Old reported artifacts like `OnSaved({EventArgs e)`, `LU`, `Ca ehcrmhn` were not found in the selected final transcript.
- Transcript is coherent for C# events, `EventHandler`, `EventHandler<TEventArgs>`, `Action`, `Func`, `Predicate`, subscription lifetime, exceptions, `async void` event-handler hazard, and ASP.NET Core callback `Events`.

Limitations:

- The final transcript is semantic and region-level, not source-by-source code reconstruction.
- For exact screenshot code, region files/source images remain more authoritative.

Required fix:

- Optional: add a clean question bank. The transcript itself is good enough to generate questions.

### 196 - `FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED.svg`

Verdict: **PARTIAL_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied SVG.
- Old reported artifacts like `Middlewaree`, line-number junk, `2e if`, and `AuthClient` were not found in the selected authoritative region transcript.
- Core concepts are captured: `HttpContext.RequestAborted`, cooperative cancellation, middleware short-circuiting, async filter behavior, narrow `OperationCanceledException` handling, and avoiding late response writes.

Limitations:

- The root `01-final-coverage-transcript.md` is only a closure summary.
- Real content in `regions/R01-final-transcript.md` is a short semantic summary.
- It does not preserve screenshot code in enough detail to reconstruct middleware/filter examples.

Required fix:

- Add a source-preserving transcript with actual code blocks from all 10 screenshots.
- Promote the content file to `FINAL_TRANSCRIPT.md` after rebuild.

### 201 - `hashing.svg`

Verdict: **PARTIAL / NEEDS_CLEANUP**

Positive:

- Current source SVG matches user-supplied `hashing.svg`.
- `10-full-source-preserving-transcript-v001.md` is large and source-by-source: 104 source blocks / 104 screenshots.
- Integrated top section is useful for study: salt, pepper, password KDFs, PBKDF2, `PasswordHasher<TUser>`, `VerifyHashedPassword`, `SuccessRehashNeeded`, `CryptographicOperations.FixedTimeEquals`, bcrypt/Argon2id, versioning and migration.
- Code fences are structurally balanced.

Problems:

- Many generated recall questions are mojibake/broken Russian and not usable for repetition.
- Several source blocks are OCR-assisted normalized text, not exact source text.
- Suspicious visible-text artifacts remain in source blocks, for example odd quote/punctuation normalization around salt explanations and legacy OCR phrasing.
- The top integrated transcript is good, but the source-by-source layer is not clean enough to be treated as final question material without a cleanup pass.

Required fix:

- Keep the integrated study section.
- Clean or regenerate all recall questions in readable Russian/English.
- Patch obvious OCR artifacts in source blocks before marking as ready for question generation.

### 202 - `headers.svg`

Verdict: **READY_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied SVG.
- `FINAL_TRANSCRIPT.md` reads cleanly.
- Covers header categories, `Expect: 100-continue`, `Referer`, `Authorization`, `WWW-Authenticate`, `Origin`, `Access-Control-Expose-Headers`, `Location`, caching headers, typed/raw .NET header APIs, `IHeaderDictionary`, `StringValues`, typed ASP.NET Core header models, `Cookie` and `Set-Cookie`.
- Good enough for detailed repeat and question generation.

Limitations:

- It says regional files/source PNGs remain authoritative for exact screenshot wording/code, but the final transcript is strong enough for normal study use.

### 204 - `httpcontent,custom one, readasstream buffering, compression directly to network.svg`

Verdict: **READY_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied SVG.
- `FINAL_TRANSCRIPT.md` is source-preserving and code-heavy.
- Preserves important examples: custom `HttpContent`, `SerializeToStreamAsync`, `GZipStream`, `TryComputeLength`, `HttpCompletionOption.ResponseHeadersRead`, `LoadIntoBufferAsync`, `CreateContentReadStreamAsync`, `MyBufferedContent`, `MyDirectStreamContent`.
- Good enough for repetition questions and code/API reconstruction.

Minor limitation:

- Some typography uses smart punctuation, but not OCR garbage or broken code.

### 205 - `httpcontext items and features.svg`

Verdict: **READY_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied SVG.
- The registry-name folder with spaces (`httpcontext items and features`) is current; the hyphenated folder is older and should not be used as authoritative for this audit.
- `FINAL_TRANSCRIPT.md` is source-preserving and practical.
- Covers `HttpContext.Items`, object keys, `HttpContext.Features`, `IFeatureCollection`, `IExceptionHandlerFeature`, `IExceptionHandlerPathFeature`, `IEndpointFeature`, `GetEndpoint()`, custom features, tenant/correlation/profile examples.
- Good enough for repeat and question generation.

Risk:

- Duplicate older folder `httpcontext-items-and-features` can confuse future audits.

### 208 - `injecting into razor.svg`

Verdict: **READY_FOR_REPEAT**

Positive:

- Current source SVG matches user-supplied SVG.
- Small source: 3 screenshots / 3.
- `FINAL_TRANSCRIPT.md` is clean and enough for repetition.
- Covers `@inject`, `IAntiforgery`, `ILogger<MyView>`, `IHttpContextAccessor`, `IUrlHelper`, localization services, `Context`, `User`, `Context.Request.Path`, and keeping business/security logic out of views.

Limitation:

- Compact topic; enough for questions, but not a broad Razor guide.

## Immediate Priority

1. Fix `equality` first. It is marked ready by old files but is not actually safe for repetition or questions.
2. Rebuild `FILTER...` into a real source-preserving transcript with code snippets.
3. Clean `hashing` recall questions and obvious OCR artifacts.
4. Promote/standardize final transcript entrypoints for `event source browser` and `FILTER...`, because current root files are closure summaries rather than useful study transcripts.

