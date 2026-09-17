# StringBuilder mutation and sizing

Knowledge ID: `dotnet.stringbuilder-mutation-and-sizing`

Topic: `dotnet`

`StringBuilder` maintains a mutable character buffer for many incremental edits. Capacity is allocated storage; `Length` is current characters; `MaxCapacity` is an upper policy limit, subject to documented implementation-specific growth behavior. Estimate initial capacity when useful and use `Clear` for owned reuse.

`ToString()` materializes an immutable snapshot, while `ToString(startIndex, length)` materializes a range. Further builder mutations do not change strings already produced.

`Append`, `AppendLine`, `AppendJoin`, and `AppendFormat` build content; interpolation handlers may be clearer for modern formatting. `Insert` shifts characters, `Remove` deletes a range, and `Replace` can be range-limited. Front insertion remains expensive. Indexes and lengths must stay within current contents; the indexer only reads/replaces an existing character and does not resize. Most mutators return the same builder for fluent use.

Use it for loops, unknown fragment counts, serializers, code/report/protocol generation. For a few fixed operands, interpolation/`+` is clearer and often compiler-optimized. Avoid shared concurrent mutation, excessive over-allocation, and builders used for only two appends. Formatting remains culture-dependent unless given an explicit provider; profile allocation assumptions.

## Sources
- Workspace: `_ai-conspects/STRINGBUILDER/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
