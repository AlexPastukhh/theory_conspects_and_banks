# FluentValidation rule sets, reuse boundaries, and failure results

Knowledge ID: `dotnet.fluentvalidation-rulesets-reuse-and-failure-results`

Topic: `dotnet`

Rule sets select groups of validation rules for a scenario. They are useful for deliberate composition, but using them to make one data contract and one validator stand in for unrelated endpoint tasks can hide a contract-design problem.

## Named and default rules

Rules inside `RuleSet` blocks are selected by name. Rules declared outside every block belong to the default rule set:

```csharp
public class StudentValidator : AbstractValidator<StudentDto>
{
    public StudentValidator()
    {
        RuleSet("Register", () =>
        {
            RuleFor(x => x.Email)
                .NotEmpty()
                .Length(0, 150)
                .EmailAddress();
        });

        RuleSet("EditPersonalInfo", () =>
        {
            // Scenario-specific rules.
        });

        // Default rules:
        RuleFor(x => x.Name)
            .NotEmpty()
            .Length(0, 200);

        RuleFor(x => x.Addresses)
            .NotNull()
            .SetValidator(new AddressesValidator());
    }
}
```

The selection forms captured by the source are:

```csharp
// Rules outside named sets.
ValidationResult result = validator.Validate(request);

// Only the named set.
ValidationResult result = validator.Validate(
    request,
    options => options.IncludeRuleSets("Register"));

// Named set plus default/outside rules.
ValidationResult result = validator.Validate(
    request,
    options => options
        .IncludeRuleSets("Register")
        .IncludeRulesNotInRuleSet());
```

The captured examples also use the name `"default"` with `IncludeRuleSets`; `IncludeRulesNotInRuleSet()` is the explicit operation for including rules outside named sets.

## Reuse is not automatically a good contract boundary

One validator can technically contain `Register`, `EditPersonalInfo`, and default rules. The source warns that reusing one validator and one data contract across different endpoints can be a strong sign of a CRUD-oriented interface rather than task-specific API contracts.

Rule-set composition should therefore be a deliberate validation concern, not a substitute for deciding whether the endpoints actually accept the same request shape and business task.

## Returning failures versus throwing

Normal `Validate` returns a `ValidationResult`. FluentValidation can instead throw:

```csharp
var validator = new RegisterRequestValidator();
validator.ValidateAndThrow(request);
```

The options form can combine rule-set selection and throwing:

```csharp
ValidationResult result = validator.Validate(
    request,
    options => options
        .IncludeRuleSets("Email")
        .IncludeRulesNotInRuleSet()
        .ThrowOnFailures());
```

`ValidateAndThrow` and `ThrowOnFailures` turn failed validation into an exception rather than an ordinary result. The source explicitly warns against using exceptions for routine validation failures: invalid input and expected business-rule failures are validation outcomes, not exceptional situations. Prefer result-style handling for that normal path.

## What should be recallable

- Which rules are in the default rule set.
- How `IncludeRuleSets` differs from `IncludeRulesNotInRuleSet`.
- Why technical validator reuse can still be a request-contract design smell.
- What `ValidateAndThrow` and `ThrowOnFailures` change.
- Why expected validation failures should normally remain results rather than exceptions.

## Sources

- Workspace: `_ai-conspects/fluent-validation/`
- Authoritative processed sources: `regions/FV06-rulesets-reuse-cautions.md` and `regions/FV07-throwing-exceptions-summary.md`
- Closure transcript: `02-stage2-next01-full-transcript.md`
- Original SVG: `assets/raw/full.svg`

