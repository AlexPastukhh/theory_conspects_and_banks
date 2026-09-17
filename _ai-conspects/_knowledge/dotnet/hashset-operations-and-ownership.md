# HashSet operations and ownership

Knowledge ID: `dotnet.hashset-operations-and-ownership`

Topic: `dotnet`

`HashSet<T>` stores unique values under an equality comparer supplied at construction or taken from the type default. Constructing from a sequence removes duplicates. `Add`/`Remove` report whether membership changed, `Contains` tests membership, `Clear` removes all members, and `Count` reports unique cardinality; `TryGetValue` retrieves the stored equal instance. `RemoveWhere`, `CopyTo`, `EnsureCapacity`, and `TrimExcess` support bulk removal, copying, and capacity management. Capacity differs from `Count`; enumeration order is not a sorting contract, and mutation invalidates an active enumerator. Hash-relevant fields must not change after insertion, and `Equals`/`GetHashCode` must agree.

Its algebra methods mutate the receiver:

- `UnionWith`, `IntersectWith`, `ExceptWith`, `SymmetricExceptWith`;
- subset/superset and proper variants;
- `Overlaps` and order-independent `SetEquals`.

The receiver's comparer defines membership. Clone before mutation when the original is still needed, and normalize comparer choice at aggregate boundaries.

LINQ `Distinct`, `Union`, `Intersect`, and `Except` return deferred enumerable pipelines and leave inputs unchanged; their comparer overloads make equality explicit, while key-based `*By` variants compare selected keys. Re-enumeration may rebuild lookup state. Use `ToHashSet` when the result needs repeated fast membership checks or mutation. LINQ is convenient for one transformation; an owned `HashSet<T>` fits incremental state. Neither model should be used when duplicate counts or ordering are meaningful. Translation of set operators on `IQueryable` is provider-dependent and is not identical to LINQ-to-Objects.

## Sources
- Workspace: `_ai-conspects/sheet hashset/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
