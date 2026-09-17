# StringReader line processing and memory

Knowledge ID: `dotnet.stringreader-line-processing-and-memory`

Topic: `dotnet`

`StringReader` is a cursor-based `TextReader` over an already existing string and exposes sequential `Read()`, `ReadLine()`, and `ReadToEnd()` APIs. `ReadLine()` processes one line at a time without constructing a line array, but each returned line is still a new string. It does not undo the cost of first buffering an HTTP body as text; use `StreamReader` over a stream when the complete string need not exist.

`data.Split('\n')` normally creates an array, every segment string, and references retaining all segments. Sequential `StringReader` may allocate a similar number of line strings in total, yet only the original input and current line need remain reachable. The distinction is total allocation versus simultaneously live allocation: a smaller live set reduces peak memory, GC tracing, accidental promotion, fragmentation pressure, and concurrent-request amplification.

For ten 1 MB lines, `Split` can retain the original, array, and ten strings; incremental work can be closer to original plus current line. Benefits disappear if lines are queued/retained, and a huge individual line can itself be a large-object allocation. Read one item, finish, and release it before the next; measure peak live memory and GC behavior, not only allocated bytes.

Choose `Split` for small input when clarity outweighs peak-memory concerns, `StringReader` when the complete string already exists and work can be sequential, and `StreamReader` for genuine file/HTTP streaming.

## Sources
- Workspace: `_ai-conspects/STRINGREADER/`
- Processed source: `regions/R01R02R03-final-coverage-transcript.md`, complete transcript
