# Next three CURRENT_SOURCE_OF_TRUTH correction v003

Purpose: replace three stale source-of-truth files after the full-SVG v002 artifacts and audits were already pushed.

```text
ef core retry, savepoints:
  embedded assets: 76
  image uses: 76
  restored uses: 70
  SVG text nodes: 56
  independent audit: PASS

linq to sql:
  embedded assets: 86
  image uses: 91
  restored uses: 89
  duplicate placements: 5
  SVG text nodes: 64
  independent audit: PASS

google recapcha and recapchas:
  embedded assets: 76
  image uses: 77
  restored uses: 0
  duplicate placements: 1
  SVG text nodes: 537
  independent audit: PASS
```

This correction changes status metadata only. Existing full-source SVGs, screenshots, transcripts, ledgers, and audits remain unchanged.
