# XOR semantics, cancellation, and equality alternatives

Knowledge ID: `dotnet.xor-semantics-and-collection-equality`

Topic: `dotnet`

Boolean XOR is true for exactly one true operand; integer XOR applies per bit (`0101 ^ 0011 = 0110`). `x ^= mask` toggles selected bits and twice restores the value. XOR is not exponentiation and does not short-circuit.

`x^x=0`, `x^0=x`, commutativity, and associativity make pairs cancel and support parity/unpaired-value puzzles. They also make XOR a weak collection hash: order disappears, even duplicate counts vanish, and collisions are easy. XOR checksums detect only some errors and are not cryptographic.

Use `HashSet.SetEquals` for sets, frequency maps for multisets, sorted comparison for equality, and canonical stable data plus an appropriate hash for cache/security. Framework hashes may be randomized across processes; hash equality never proves collection equality.

## Sources
- Workspace: `_ai-conspects/xor operator/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
