# Rectangular and jagged arrays, enumeration, and boxing

Knowledge ID: `dotnet.rectangular-jagged-arrays-and-enumeration`

Topic: `dotnet`

`T[,]` is one rectangular allocation with a fixed length per dimension. `Length` is the total element count, `Rank` is the number of dimensions, `GetLength(d)` reads one dimension, and access uses `[row, column]`. Its contiguous rectangular layout generally has better locality.

`T[][]` is an array of independently allocated arrays. Rows may differ in length or be `null`, and access uses `[row][column]`. Iterate each row using its own length.

Non-generic `IEnumerable` exposes `object`, so each value-type element may be boxed into an object representation. Repeated boxing creates allocations and GC pressure; reference-type elements do not pay that boxing cost. `IEnumerable<T>` keeps the element type. Rectangular arrays expose their elements through `System.Array` enumeration patterns; indexed nested loops avoid boxing overhead. Jagged arrays are generic arrays at each level.

```csharp
int value = 42;
object boxed = value;       // box: creates the object representation
int copy = (int)boxed;      // unbox: requires the exact value type
```

`Cast<T>()` is deferred and throws at the first incompatible element; enumerating again repeats the work. For boxed values it performs the runtime cast/unbox—it is not a numeric or general conversion API. `OfType<T>()` filters incompatible values and skips `null`. Unboxing requires the exact boxed value type: a boxed `int` cannot be unboxed directly as `long`; unbox to `int`, then convert.

## Sources
- Workspace: `_ai-conspects/jagged arr,multidim arr,cast boxing unboxing enumerable vs generic/`
- Processed source: `05-full-combined-final-transcript.md`, complete transcript
