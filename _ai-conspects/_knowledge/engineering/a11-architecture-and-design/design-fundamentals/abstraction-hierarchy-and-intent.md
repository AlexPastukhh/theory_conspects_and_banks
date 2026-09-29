# Abstraction hierarchy and intention-revealing code

Knowledge ID: `architecture.abstraction-hierarchy-and-intent`

Topic: `architecture`

Abstraction amplifies what is essential for the current task and removes irrelevant detail from the reader's immediate attention. It is not limited to `abstract` classes or interfaces: names, variables, methods, classes, language constructs, and library APIs all express ideas while hiding lower-level mechanics.

Good abstraction reduces the number of concerns a reader must hold at once. Bad abstraction mixes unrelated concerns and forces the reader to reconstruct several tasks simultaneously. Giant methods/classes illustrate the cognitive cost: the problem is not only line count, but the absence of named concepts and responsibility boundaries.

General-purpose languages permit many equivalent organizations of the same computation. The source contrasts that freedom with a human working-attention limit of roughly 5-9 simultaneous things: a 100,000-line method or class is possible, but it makes development slower and defects more likely because no usable conceptual hierarchy exists.

## Intention over implementation detail

The source's customer-name example extracts a detail-heavy transformation:

```csharp
private static string NormalizeCustomerName(string name)
{
    string normalized = name
        .Replace(" ", "-")
        .Trim();

    if (normalized.Length > 50)
        normalized = normalized.Substring(0, 50);

    return normalized;
}

string customerName = ReadCustomerName();
string normalizedName = NormalizeCustomerName(customerName);
SaveCustomerName(normalizedName);
```

The caller reads the workflow's WHAT; `Replace`, `Trim`, length checking, and `Substring` remain the HOW. The method is valuable even if called once: code simplification and naming intent are independent benefits from reuse.

## Hierarchy

Higher-order abstractions build on lower-order abstractions. `NormalizeCustomerName` depends on library abstractions such as `Replace`, `Trim`, `Length`, and `Substring`; a larger workflow then depends on `ReadCustomerName`, `NormalizeCustomerName`, and `SaveCustomerName`.

```text
character/string operations
-> normalization operation
-> customer-processing workflow
```

An appropriate hierarchy lets complex logic be discussed with a small vocabulary, keeps the reader at one level of concern, and emphasizes what should happen rather than forcing every implementation step into the calling code.

## What should be recallable

- Essential amplification and irrelevant-detail elimination.
- Why all code can participate in abstraction.
- Single-concern abstraction versus mixed-concern code.
- Why method extraction helps even without reuse.
- How higher abstractions build on lower ones.

## Related knowledge

- `architecture.encapsulation-invariants-and-legal-transitions`

## Sources

- Workspace: `_ai-conspects/abstraction-and-encapsulation/`
- Authoritative processed sources: `regions/AE01-abstraction-definition-purpose-hierarchy.md` and `regions/AE02-normalize-customer-name-abstraction.md`
- Materialized original SVG: `assets/raw/full.svg`
