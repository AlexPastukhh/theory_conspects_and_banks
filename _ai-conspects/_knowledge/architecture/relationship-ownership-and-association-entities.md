# Relationship ownership and association entities

Knowledge ID: `architecture.relationship-ownership-and-association-entities`

Topic: `architecture`

For a bidirectional many-to-many relationship, choose one owner for public mutations rather than allowing both sides to create one-sided links. The owner creates the association and synchronizes the other navigation through an internal operation:

```csharp
public void AddStudent(Student student)
{
    var link = new StudentInstructor(student, this, clock.UtcNow);
    _studentInstructors.Add(link);
    student.AddInstructor(link); // internal
}
```

When the link carries date, role, order, status, provenance, or validity, model it as an explicit association entity rather than an invisible ORM join. Protect duplicates and required state inside model operations; use private/internal constructors or factories so application services orchestrate workflows without assembling invalid entities.

Expose stable read-only views without allocating/sorting on every property read. A supplied clock improves deterministic tests and UTC consistency, while the link's equality/key strategy must prevent duplicate relationships. Ownership is a domain decision, not merely an EF navigation preference.

## Sources
- Workspace: `_ai-conspects/principles,practises,patterns/`
- Processed source: `regions/R01-domain-modeling-many-to-many-ownership-final.md`, complete transcript
