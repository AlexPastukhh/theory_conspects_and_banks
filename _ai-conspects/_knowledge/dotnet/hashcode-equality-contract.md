# GetHashCode contract, purpose, and mutable-key failure

Knowledge ID: `dotnet.hashcode-equality-contract`

Topic: `dotnet`

## Purpose of GetHashCode

`GetHashCode()` exists to support hash-based collections: `Dictionary<TKey, TValue>` and `HashSet<T>`.

When a key or item is inserted, the collection:

1. computes its hash code;
2. uses the hash to select a bucket;
3. uses `Equals` to resolve matches inside that bucket.

The hash code narrows down candidate buckets quickly. Equality then confirms identity. Hash codes support fast lookup; they are not proof of identity.

## Security boundary

`GetHashCode()` and `HashCode` are not cryptographic.

For:

- password hashing;
- signatures;
- secure digests;

use cryptographic APIs such as SHA-256, HMAC, bcrypt, Argon2, and similar tools chosen for the actual security purpose.

`HashCode` is only for collection hashing. It is optimized for in-memory lookup, not for collision resistance, secrecy, or long-term stability.

## Stability boundary

Do not persist or share hash codes as identifiers.

Do not assume:

- the same hash code across processes;
- the same hash code across runtime versions;
- uniqueness.

This is wrong as a durable key:

```csharp
var id = obj.GetHashCode();
```

A hash code may collide and may change between runs or runtime implementations. Durable identity needs an explicit stable identifier such as a database key or GUID chosen for that purpose.

## The mandatory equality contract

> If two objects are equal, they must return the same hash code.

Hashing and equality must match logically:

- equal objects may never be separated into different hash buckets by different hash codes;
- unequal objects may still share a hash code (collisions are allowed).

The direction is one-way: equal -> same hash. Identical hash codes do not imply equality.

A common violation: equality uses `FirstName` and `LastName`, but `GetHashCode()` additionally includes `BirthDate`. Two objects with the same first and last name but different birth dates could then be considered equal by `Equals` yet land in different buckets, making lookups unreliable.

## Mutable keys: why mutation breaks dictionary and HashSet lookup

Fields involved in equality and hashing should ideally be immutable while the object is stored in a hash-based collection.

```csharp
var person = new Person { FirstName = "A", LastName = "B" };

var set = new HashSet<Person> { person };

person.LastName = "C"; // dangerous
```

The object's hash code may change after insertion. The collection does not move the existing entry to a new bucket. Later lookup starts from the new hash and searches the wrong bucket.

Concrete bucket flow shows why:

Before mutation:

```text
key.Email = "a@test.com"
hash = 1234
bucket = 2
```

Stored:

```text
bucket 2 -> entry(key.Email = "a@test.com", value = "hello")
```

Lookup with unchanged key succeeds:

```text
1. compute hash -> 1234
2. go to bucket 2
3. compare equality
4. found
```

After mutation:

```text
key.Email = "b@test.com"
hash = 8888
bucket = 1
```

Storage is still:

```text
bucket 2 -> entry(the same object, but now mutated)
```

Lookup now fails:

```text
1. compute hash -> 8888
2. go to bucket 1
3. nothing there
4. not found
```

Mutation changes the key's current identity without reindexing the collection's internal storage. The entry remains in bucket 2 forever, physically present but unreachable through the normal hash path.

The same rule applies to `HashSet<T>`: each item acts as its own key. The same mutable-field danger and the same three-step lookup apply.

## What should be recallable

- Why is GetHashCode unsuitable for passwords or persistent IDs?
- What stability guarantees does a hash code carry across processes and runtime versions?
- State the mandatory direction of the equality contract.
- Are collisions between unequal objects allowed?
- What happens when a dictionary key is mutated after insertion?
- Which bucket does the collection search after mutation?
- Does the same mutable-key danger apply to HashSet?

## Related knowledge

- `dotnet.hashcode-api-and-implementation` - how to implement GetHashCode and IEquatable<T>
- `dotnet.value-object-equality-and-component-streams` - ValueObject base pattern and declarative component streams
- `dotnet.hashset-operations-and-ownership` - HashSet API: Add, Remove, Contains, set algebra

## Sources

- Workspace: `_ai-conspects/hashcode/`
- Authoritative processed source: `02-source-preserving-transcript-v002.md`, sections S-001, S-002, S-003, S-012, S-016, S-022, S-023, S-024
- Quality audit: `05-transcript-quality-correction-audit-v002.md`
- Original SVG: `source/hashcode.svg` (Git blob SHA: 0eaf471525a9cf3056a6815b07a7c1c266ed210c)
- Workspace: `_ai-conspects/equality/`
- Authoritative processed source: `10-full-source-preserving-transcript-v003.md`, section S-003
