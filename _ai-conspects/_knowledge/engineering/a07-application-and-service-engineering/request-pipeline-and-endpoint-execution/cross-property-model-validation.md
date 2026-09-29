# Cross-property validation with IValidatableObject and ValidationAttribute

Knowledge ID: `aspnet-core.cross-property-model-validation`

Topic: `aspnet-core`

Cross-property rules need the complete model rather than one isolated property. DataAnnotations provides two class-level approaches: implement `IValidatableObject` on a model-specific type, or declare a reusable class-level `ValidationAttribute`. Both return `ValidationResult` objects to the ASP.NET Core `ModelState` pipeline.

## Model-owned rule with IValidatableObject

Use `IValidatableObject` when the model naturally owns the rule and several of its properties must be inspected together:

```csharp
public abstract class CourseFormManipulationDto : IValidatableObject
{
    [Required(ErrorMessage = "You should fill out a title.")]
    [MaxLength(100)]
    public string? Title { get; set; }

    [MaxLength(1500)]
    public string? Description { get; set; }

    public IEnumerable<ValidationResult> Validate(
        ValidationContext validationContext)
    {
        if (!string.IsNullOrWhiteSpace(Title)
            && !string.IsNullOrWhiteSpace(Description)
            && string.Equals(
                Title,
                Description,
                StringComparison.OrdinalIgnoreCase))
        {
            yield return new ValidationResult(
                "The provided description should be different from the title.",
                new[] { nameof(Description) });
        }
    }
}
```

ASP.NET Core adds each returned result to `ModelState`. `MemberNames` selects the field that receives the error; omitting names creates a model-level error.

Property attributes are evaluated before `IValidatableObject.Validate`. The class-level callback is intended for a model whose property-level validation succeeded, so it should not repair or duplicate `[Required]`, `[StringLength]`, or similar property failures.

This option fits a model-specific rule, keeps it beside the properties, compares multiple values directly, and requires no reusable attribute type.

## Reusable class-level ValidationAttribute

Use a custom class-level attribute when the same declarative rule should apply to multiple models or attribute-based configuration is preferred:

```csharp
[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
public sealed class TitleMustBeDifferentFromDescriptionAttribute
    : ValidationAttribute
{
    protected override ValidationResult? IsValid(
        object? value,
        ValidationContext validationContext)
    {
        if (validationContext.ObjectInstance
            is not CourseFormManipulationDto dto)
        {
            throw new InvalidOperationException(
                $"{nameof(TitleMustBeDifferentFromDescriptionAttribute)} " +
                $"must be applied to {nameof(CourseFormManipulationDto)}.");
        }

        if (!string.IsNullOrWhiteSpace(dto.Title)
            && !string.IsNullOrWhiteSpace(dto.Description)
            && string.Equals(
                dto.Title,
                dto.Description,
                StringComparison.OrdinalIgnoreCase))
        {
            return new ValidationResult(
                "The provided description should be different from the title.",
                new[] { nameof(CourseFormManipulationDto.Description) });
        }

        return ValidationResult.Success;
    }
}
```

Apply it to the class:

```csharp
[TitleMustBeDifferentFromDescription]
public abstract class CourseFormManipulationDto
{
    // properties
}
```

`ValidationContext.ObjectInstance` exposes the complete model. The `value` argument is also the class-level value, but the context makes intended model access explicit.

A reusable attribute should be generic enough for its supported targets or clearly reject an incompatible type. Do not put database calls, network calls, or expensive workflows inside validation attributes. Those rules belong in application/domain services where dependencies, cancellation, and error handling are explicit.

## Choosing the boundary

```text
IValidatableObject
  -> fastest for one model
  -> rule stays beside its properties
  -> no custom attribute type

class-level ValidationAttribute
  -> reusable and declarative
  -> applicable to multiple model classes
  -> separates validation behavior from the DTO
```

Both mechanisms feed `ValidationResult` into the same `ModelState` pipeline. Neither replaces authorization or deeper domain invariants.

## What should be recallable

- How both mechanisms perform class-level, cross-property validation and feed `ModelState`.
- Full `IValidatableObject.Validate` flow, property-first ordering, and field-level versus model-level `MemberNames`.
- Full class-level attribute flow, `ObjectInstance`, target rejection, successful result, and class application.
- Reuse/ownership tradeoff and why dependency-heavy business validation belongs outside attributes.
- Why DataAnnotations validation does not replace authorization or domain invariants.

## Sources

- Workspace: `_ai-conspects/IVALIDATABLE OBJECT, VALIDATION ATTRIBUTES/`
- Processed source: `regions/R01R02-final-coverage-transcript.md`, R01–R02
- Original SVG: `source/IVALIDATABLE OBJECT, VALIDATION ATTRIBUTES.svg`
