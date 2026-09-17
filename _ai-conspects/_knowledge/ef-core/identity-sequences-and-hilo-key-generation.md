# EF Core identity, sequences, and HiLo key generation

Knowledge ID: `ef-core.identity-sequences-and-hilo-key-generation`

Topic: `ef-core`

Identity columns generate a value during insert. A database sequence is an independent counter that can serve multiple tables or defaults. HiLo reserves a high value from a sequence and generates a range of low values in the client, reducing database round trips and making keys available before insert.

```csharp
modelBuilder.HasSequence<long>("EntityHiLo");
builder.Property(x => x.Id).UseHiLo("EntityHiLo");
```

HiLo intentionally permits gaps, and values from entity types sharing a sequence can interleave. It fits large batches and graphs that need keys before insert while amortizing database round trips; it is not gap-free business numbering.

Identity normally receives its final value during insert; sequences allocate independently; HiLo provides early client-side keys from reserved ranges.

## Sources

- Workspace: `_ai-conspects/onmodelcreating/`
- Authoritative processed source: `13-full-combined-final-transcript.md`, sections 2 and 9
- Original SVG: `source/onmodelcreating.svg`
