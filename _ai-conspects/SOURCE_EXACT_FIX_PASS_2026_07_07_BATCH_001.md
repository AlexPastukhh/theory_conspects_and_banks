# Source Exact Fix Pass 2026-07-07 - Batch 001

Scope: 10 locally checkable `NEEDS_EXACT_PASS` rows from `INDEPENDENT_TRANSCRIPT_AUDIT_MASTER_ALL_306.md`.

## Checked Rows

| # | SVG | Result | Decision | Notes |
|---:|---|---|---|---|
| 83 | `istringlocalizer iviewlocalizer.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Transcript is useful and closes 7 images, but explicitly leaves exact code punctuation in `source/images`; needs exact code appendix before source replacement. |
| 97 | `decoding, bytes memory, start of x byte character.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Good UTF-8 semantic transcript, but exact bit diagrams/examples remain image-authoritative. |
| 101 | `partially initialized antipattern and possible partial inits inside repositories.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Strong concept transcript, but exact screenshot wording/code remains outside transcript. |
| 106 | `sheet exec order.svg` | fixed and promoted | `OK_FOR_STUDY` | Corrected logical order to match source diagram: pagination is step 8; window-function area is a note after HAVING, not a separate numbered step. |
| 115 | `textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Code-rich and useful, but semantic rather than source-preserving over many chunks/streaming examples. |
| 127 | `uselocation.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Complete semantic coverage, but file explicitly says SVG/screenshots remain authoritative for exact source code/punctuation/version details. |
| 167 | `BINDING SOURCE ATTRIBUTES.svg` | fixed and promoted | `OK_FOR_STUDY` | Contact sheet and transcript align; cleaned mojibake arrows in ApiController inference list. |
| 190 | `Enumerable static methods.svg` | fixed and promoted | `OK_FOR_STUDY` | Updated examples to match source: `Enumerable.Range(1, 10)`, `Enumerable.Repeat("N/A", 5)`, `Enumerable.Empty<string>()`. |
| 196 | `FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Useful compact transcript, but exact middleware/filter code punctuation remains in source images. |
| 217 | `jsonconverter.svg` | checked, still partial | `NEEDS_EXACT_PASS` | Strong transcript for Optional<T>/JsonConverterFactory, but exact generic/ref syntax and converter code need source-code appendix. |

## Files Changed

- `sheet exec order/regions/R01-semantic-transcript-final-v001.md`
- `BINDING SOURCE ATTRIBUTES/regions/R01-final-coverage-transcript.md`
- `Enumerable static methods/regions/R01-semantic-transcript-final-v001.md`
- `INDEPENDENT_TRANSCRIPT_AUDIT_MASTER_ALL_306.md`

## Batch Outcome

```text
checked: 10
promoted to OK_FOR_STUDY: 3
remained NEEDS_EXACT_PASS: 7
```
