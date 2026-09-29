# C# String.Remove and String.Insert

Knowledge ID: `dotnet.string-remove-and-insert`

Topic: `dotnet`

Strings are immutable; both methods return a new string.

```csharp
string value = "HelloWorld";
string prefix = value.Remove(5);       // "Hello"
string removed = value.Remove(5, 5);   // "Hello"
string inserted = "Hello".Insert(5, " World");
```

`Remove(startIndex)` removes through the end; `Remove(startIndex, count)` removes a range. Indexes are zero-based and the range must fit. `Insert` does not overwrite—it shifts existing characters right.

Ranges can express prefix/removal:

```csharp
string prefix = value[..5];
string withoutMiddle = value[..start] + value[(start + count)..];
```

Repeated concatenation allocates repeatedly; use `StringBuilder` or a parser for many incremental edits.

Validate input-derived indexes: `start >= 0`, `count >= 0`, and `start + count <= value.Length`. Prefer domain-level contracts rather than exposing raw range failures unexpectedly.

## What should be recallable

- One- and two-argument Remove behavior and Insert's shifting semantics.
- Immutability and range alternatives.
- Bounds validation and allocation guidance for many edits.

## Sources

- Workspace: `_ai-conspects/STRING REMOVE INSERT/`
- Processed source: `regions/R01-semantic-transcript-final-v001.md`, complete transcript
- Original SVG: `source/STRING REMOVE INSERT.svg`
