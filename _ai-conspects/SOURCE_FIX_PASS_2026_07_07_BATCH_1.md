# Source Fix Pass 2026-07-07 - Batch 1

## What changed

- `not/regions/R01R02-css-not-final-transcript-v001.md` was created from local SVG text labels and the two readable source screenshots.
- The master audit was updated for rows where the previous BAD verdict was stale because real final regional transcripts already exist.

## Rows moved to OK_FOR_STUDY

- 39 `composite key.svg` -> existing `composite-key/regions/r01r02r03-final-coverage-transcript-v001.md` closes 25 images and 18 labels.
- 51 `basic auth.svg` -> existing `basic auth/regions/R01R02R03-basic-authentication-final.md` covers 24 image uses and 6 grouped text blocks.
- 73 `imemorycache.svg` -> existing `imemorycache/regions/R01R02R03-imemorycache-final.md` is a real combined transcript.
- 78 `alternate key.svg` -> existing `alternate-key/regions/R01R02R03-efcore-alternate-key-final.md` closes 24 images and 8 labels.
- 228 `not.svg` -> new source-reconstructed transcript added.

## Remaining limitation

Rows with source content mostly inside screenshots still require visual/OCR reconstruction. This pass did not pretend to solve those without readable source evidence.
