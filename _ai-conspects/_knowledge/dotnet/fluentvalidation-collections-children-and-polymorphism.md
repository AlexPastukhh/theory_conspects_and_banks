# FluentValidation collections, child validators, and polymorphic properties

Knowledge ID: `dotnet.fluentvalidation-collections-children-and-polymorphism`

Topic: `dotnet`

Validation of an object graph has two different responsibilities: validate whether a collection or child slot is usable, then validate each value reached through it. Per-item validation does not replace parent-container validation.

## Validate the collection and its items

The source's representative rule checks all three layers:

```csharp
RuleFor(x => x.Addresses)
    .Cascade(CascadeMode.Stop)
    .NotNull()
        .WithMessage("Addresses required")
    .Must(a => a.Length >= 1 && a.Length <= 3)
        .WithMessage(
            "The number of addresses must be between 1 and 3")
    .ForEach(item =>
    {
        item.NotNull();
        item.SetValidator(new AddressValidator());
    });
```

`ForEach` cannot validate a `null` collection because there are no elements to iterate. A request with `"addresses": null` can therefore slip through when only element validators exist. `NotNull` or the appropriate collection rule owns the container contract; `ForEach` and `SetValidator` own the element contract.

## Prevent null-dependent validators from running

The source shows three alternatives for ordering follow-up work after the container check:

1. `Cascade(CascadeMode.Stop)` stops the chain after `NotNull` fails.
2. A `When(..., ApplyConditionTo.CurrentValidator)` can guard only the length predicate while leaving `NotNull` active.
3. `DependentRules` can run length and item rules only after the preceding `NotNull` rule succeeds.

The targeted-condition form is:

```csharp
RuleFor(x => x.Addresses)
    .NotNull()
        .WithMessage("Addresses required")
    .Must(a => a.Length >= 1 && a.Length <= 3)
        .When(
            x => x.Addresses != null,
            ApplyConditionTo.CurrentValidator)
        .WithMessage(
            "The number of addresses must be between 1 and 3")
    .ForEach(item =>
    {
        item.NotNull();
        item.SetValidator(new AddressValidator());
    });
```

The dependent-rule form makes the successful parent rule an explicit prerequisite:

```csharp
RuleFor(x => x.Addresses)
    .NotNull()
    .WithMessage("Addresses required")
    .DependentRules(() =>
    {
        RuleFor(x => x.Addresses)
            .Must(a => a.Length >= 1 && a.Length <= 3)
            .WithMessage(
                "The number of addresses must be between 1 and 3")
            .ForEach(item =>
            {
                item.NotNull();
                item.SetValidator(new AddressValidator());
            });
    });
```

These alternatives express different control-flow shapes, but each preserves the same key invariant: no length or element work runs against a missing collection while the missing collection still produces its own failure.

## Polymorphic child validation

A base-typed property can hold several derived request types:

```csharp
public class RegisterRequest
{
    public string Name { get; set; }
    public string Email { get; set; }
    public PhoneNumberDto Phone { get; set; }
    public AddressDto[] Addresses { get; set; }
}

public abstract class PhoneNumberDto
{
    public string Number { get; set; }
}

public class USPhoneNumberDto : PhoneNumberDto { }

public class InternationalPhoneNumberDto : PhoneNumberDto { }
```

`SetInheritanceValidator` dispatches by the runtime derived type:

This facility applies to class/domain-class inheritance hierarchies; it is not a general discriminator mechanism for arbitrary non-class shapes.

```csharp
RuleFor(x => x.Phone)
    .SetInheritanceValidator(config =>
    {
        config.Add<USPhoneNumberDto>(
            new USPhoneNumberValidator());

        config.Add<InternationalPhoneNumberDto>(
            new InternationalPhoneNumberValidator());
    });
```

This is the source's polymorphic-validation pattern: the parent property retains its base type, while each concrete class has its own validator.

## What should be recallable

- Why collection existence and collection elements require separate rules.
- Why `ForEach` cannot make a `null` collection fail by itself.
- How cascade stop, a current-validator condition, and `DependentRules` prevent null-dependent work.
- What `SetValidator` contributes for ordinary child items.
- How `SetInheritanceValidator` chooses validators for derived runtime types.

## Sources

- Workspace: `_ai-conspects/fluent-validation/`
- Authoritative processed sources: `regions/FV02-collections-complex-properties.md` and `regions/FV05-inheritance-validation.md`
- Closure transcript: `02-stage2-next01-full-transcript.md`
- Original SVG: `assets/raw/full.svg`
