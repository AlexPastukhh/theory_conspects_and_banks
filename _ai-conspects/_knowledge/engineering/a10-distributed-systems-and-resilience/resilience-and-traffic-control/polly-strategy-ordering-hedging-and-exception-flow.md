# Polly strategy ordering, hedging, and exception flow

Knowledge ID: `dotnet.polly-strategy-ordering-hedging-and-exception-flow`

Topic: `dotnet`

## Composition is nesting

Strategy order determines which strategy is outer and which failures it can observe:

```text
outer retry
  -> inner timeout
      -> operation

outer timeout
  -> inner retry
      -> attempt 1
      -> delay
      -> attempt 2
```

These are not equivalent. In the first shape, each attempt can receive its own timeout. In the second, one timeout can bound the entire retry sequence. Circuit breaker, fallback, bulkhead/concurrency limiting, and rate limiting have the same nesting question.

Inner strategies cannot know what an outer retry or fallback will later handle. They emit a result/exception according to their own contract; outer strategies then classify it. Debugging therefore follows the exception/result from the operation outward.

## Hedging creates competing attempts

Hedging starts additional attempts when its trigger/delay rules allow. It can reduce tail latency but spends extra requests, connections, rate-limit capacity, and downstream work. Use it only when attempts are safe to duplicate or have idempotency protection.

The winning acceptable outcome cancels or abandons other attempts according to the strategy, but remote work may already have started. Hedging is not a free timeout substitute and must be placed relative to rate limits, timeouts, and breakers deliberately.

## What should be recallable

- Why strategy order is nested control flow rather than a flat list.
- How retry-outside-timeout differs from timeout-outside-retry.
- Why inner strategies cannot anticipate outer handling.
- What hedging trades for lower tail latency.
- Why idempotency and placement relative to limits/timeouts matter.

## Sources

- Workspace: `_ai-conspects/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling/`
- Authoritative processed source: `regions/R01R02R07-final-options-hedging-cheatsheet.md`, R01/R02 ordering and hedging; `regions/R04R05R06-manual-classic-exception-bubbling.md`, R04/R06 composition and exception bubbling
- Original SVG: `source/shared-polly-cheat-sheet-production-ready-verions-exceptions-from-pipeline-and-handling.svg`
