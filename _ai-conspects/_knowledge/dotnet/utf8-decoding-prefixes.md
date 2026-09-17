# UTF-8 decoding prefixes and byte boundaries

Knowledge ID: `dotnet.utf8-decoding-prefixes`

Topic: `dotnet`

A mathematical value and its storage width are separate facts. UTF-8 uses one to four bytes, so a decoder reads structure from the first byte rather than guessing from numeric size.

```text
0xxxxxxx   one-byte ASCII character
110xxxxx   start of a two-byte sequence
1110xxxx   start of a three-byte sequence
11110xxx   start of a four-byte sequence
10xxxxxx   continuation byte
```

The leading prefix gives the total length. Each following byte must begin with `10`. The decoder removes the structural bits and combines the payload bits. For `A`, leading `0` identifies one byte; for `110xxxxx 10xxxxxx`, the decoder expects and validates two. Three- and four-byte forms work the same way.

Structural bits reduce payload capacity, but non-conflicting start and continuation patterns make UTF-8 self-synchronizing and enable reliable boundary detection without external length metadata.

## What should be recallable

- Numeric value versus storage-width distinction.
- All leading and continuation prefixes.
- Derive length, validate continuation bytes, remove markers, combine payload.
- Structural-bit cost and self-synchronization benefit.

## Sources

- Workspace: `_ai-conspects/decoding, bytes memory, start of x byte character/`
- Processed source: `01-final-transcript.md`, complete transcript
- Exact diagrams and evidence remain in the workspace.
