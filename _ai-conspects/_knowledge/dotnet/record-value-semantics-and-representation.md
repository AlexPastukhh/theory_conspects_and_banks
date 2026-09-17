# C# record value semantics and representation

Knowledge ID: `dotnet.record-value-semantics-and-representation`

Topic: `dotnet`

`record` means reference-type `record class`; `record struct` and `readonly record struct` are value types. Records generate value equality, hashing, `==`/`!=`, useful `ToString`, and `with` support. An ordinary class has reference equality by default unless equality is implemented explicitly. Positional record classes also generate constructor, public init properties, and deconstruction; non-positional records keep record semantics while allowing explicit validation and members.

```csharp
public record Person(string FirstName, string LastName);
var changed = original with { FirstName = "Eva" };
```

`with` is nondestructive but shallow: referenced nested objects remain shared. Mutable equality-participating members are dangerous after insertion into dictionaries/sets. Customize equality and hashing as one coherent contract. Prefer an ordinary class for identity-oriented entities with mutable lifecycle, ORM/proxy needs, or reference semantics.

Structs copy by value in assignment and ordinary calls; `ref` passes by reference with read/write access, `in` passes by reference with read-only intent, and `out` passes by reference for assignment by the callee. Avoid the “struct equals stack” myth: value types live inline in their containing location, including object fields and arrays; boxing creates a heap-wrapped copy. Small immutable values suit record structs, while larger/richer/shared value objects can use record classes to get value equality without whole-value copying.

An immutable `Address`-style record class can model an EF owned/complex value object when it lacks independent identity; actual mapping support is EF-version-specific.

## Sources
- Workspace: `_ai-conspects/records/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/hashcode/`
- Processed source: `02-source-preserving-transcript-v002.md`, section S-001 (records generate equality and hash code)
- Workspace: `_ai-conspects/equality/`
- Processed source: `10-full-source-preserving-transcript-v003.md`, section S-001; `11-technical-corrections-v002.md`, item 7
