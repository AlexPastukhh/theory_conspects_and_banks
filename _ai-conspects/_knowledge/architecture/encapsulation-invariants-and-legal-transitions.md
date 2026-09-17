# Encapsulation, invariants, and legal state transitions

Knowledge ID: `architecture.encapsulation-invariants-and-legal-transitions`

Topic: `architecture`

Encapsulation protects data integrity by hiding mutable state and bundling state changes with the operations that validate them. Public setters make every caller responsible for remembering all invariants; controlled behavior moves that responsibility into the object.

Suppose an inactive course must contain no students. Independent public setters permit invalid combinations:

```csharp
public class Course
{
    public bool IsActive { get; set; }
    public int NumberOfStudents { get; set; }
}
```

Private setters plus a legal transition preserve the rule:

```csharp
public class Course
{
    public bool IsActive { get; private set; }
    public int NumberOfStudents { get; private set; }

    public void Disable()
    {
        IsActive = false;
        NumberOfStudents = 0;
    }
}
```

Callers no longer need to coordinate the two assignments. `Disable` is also an abstraction: it names intent and hides how the transition is implemented.

## Construction invariants

A constructor guard can prevent invalid objects from existing:

```csharp
public class Triangle
{
    public IEnumerable<Edge> Edges { get; }

    public Triangle(IEnumerable<Edge> edges)
    {
        if (edges.Count() != 3)
            throw new Exception("Triangles must have 3 edges");

        Edges = edges;
    }
}
```

The guard makes construction own the exactly-three-edges invariant instead of asking every later consumer to check it.

## Encapsulation versus abstraction

```text
encapsulation -> maintain legal state and control operations
abstraction   -> foreground essential intent and hide irrelevant mechanics
```

They often overlap but are not identical. A constructor integrity check is primarily encapsulation. `NormalizeCustomerName` is primarily abstraction. A domain value object such as `EmailAddress` commonly does both: it validates/owns legal state and exposes a meaningful concept instead of raw string operations.

## What should be recallable

- Why information hiding alone is not the complete encapsulation model.
- Public-setter invariant risk and behavior-method repair.
- Constructor guards as prevention of invalid instances.
- The distinction and overlap between encapsulation and abstraction.

## Related knowledge

- `architecture.abstraction-hierarchy-and-intent`

## Sources

- Workspace: `_ai-conspects/abstraction-and-encapsulation/`
- Authoritative processed sources: `regions/AE03-encapsulation-data-integrity-invariants.md` and `regions/AE04-abstraction-encapsulation-difference-overlap.md`
- Materialized original SVG: `assets/raw/full.svg`
