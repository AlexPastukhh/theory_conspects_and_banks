# JavaScript splice mutation and iteration

Knowledge ID: `javascript.splice-mutation-and-iteration`

Topic: `javascript`

`array.splice(start, deleteCount, ...items)` mutates its receiver and returns a new array of removed elements; insertion-only calls return `[]`. Omitted `deleteCount` removes to the end; `undefined` converts to zero and differs from omission. Negative/zero counts remove nothing, oversized counts clamp, negative starts count from the end, starts below `-length` clamp to the beginning, and starts beyond length use the append position. Inserted array contents require spread; otherwise the array becomes one nested element. Indices after replacement shift by the net difference between inserted and removed counts.

```js
array.splice(index, 0, ...items);          // insert
array.splice(index, count, ...items);      // replace
array.splice(0, array.length, ...next);    // preserve identity
```

Replacing all contents preserves references held by observers; assigning a new array is clearer under simple ownership. `length = 0` followed by `push(...next)` is another two-step identity-preserving mutation. Very large spreads can exceed argument limits.

`slice(start,end)` is non-mutating with exclusive end; `splice` uses a count and mutates. `toSpliced` provides immutable splice-like editing where supported. Shallow results still share nested objects. Mutation can invalidate assumptions in concurrent iteration and memoization. Prefer copied state in React/Redux and document in-place utilities. Sparse arrays and holes need explicit tests when relevant.

Forward removal can skip adjacent matches because the next element shifts into the current index before `i++`. Iterate backward, decrement after removal, filter immutably, or compact with read/write indices and truncate once. Front removals are O(n); repeated front splices can become O(n²), so queues should use a deque/ring buffer/logical head and bulk deletions should filter/compact once.

## Sources
- Workspace: `_ai-conspects/splice/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
