# Interlocked atomic transitions and flag operations

Knowledge ID: `dotnet.interlocked-atomic-transitions`

Topic: `dotnet`

`Interlocked` provides atomic `Read`, `Exchange`, `CompareExchange`, `Add`, `Increment`, and `Decrement`. For flags, `Or` adds without toggling, `And` with a complemented mask removes, and `Xor` toggles.

Use it for a small single-variable atomic transition. Use `lock` when several values or invariants must change together; individually atomic operations do not make a compound transition atomic.

## Sources

- Workspace: `_ai-conspects/interlocked,interlocked.read/`
- Processed source: `regions/final-transcript.md`, complete semantic transcript
- Preserved evidence remains authoritative for exact API spelling.
