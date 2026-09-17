# FluentValidation custom rules, domain errors, and validator dependencies

Knowledge ID: `dotnet.fluentvalidation-custom-rules-domain-errors-and-dependencies`

Topic: `dotnet`

Custom FluentValidation rules can adapt domain/value-object validation into field-addressed request failures. Keep the dependencies and the error-to-field mapping explicit so the validator remains testable and clients receive errors on the correct properties.

## Inject validator dependencies explicitly

When a validator needs a repository, `DbContext`, or an abstraction over one, the source recommends constructor injection. Injecting `IServiceProvider` and locating dependencies inside the validator hides requirements, makes tests harder, and can create lifetime mistakes. Constructor DI exposes the dependency in the type's construction contract.

## Translate domain failures with `Custom`

`Custom((value, context) => ...)` can add one or several FluentValidation failures. A null parent value can be attached to a known request field:

```csharp
RuleFor(dto => dto.Address)
    .Custom((address, context) =>
    {
        if (address is null)
        {
            context.AddFailure(
                SharedConst.IndividualRequestCnsts.AddressFieldName,
                Errors.AddressErrors.AddressIsRequired.Code);
        }
    });
```

For a non-null DTO, create the domain value and project every returned domain error into the validation result:

```csharp
if (address != null)
{
    var createAddress = Address.Create(
        address.PostalCode,
        address.Region,
        address.City,
        address.Street,
        address.House,
        address.Building,
        address.Apartment);

    if (createAddress.IsFailure)
    {
        foreach (var error in createAddress.Error)
        {
            context.AddFailure(
                MapAddressErrorToName(error.Code),
                error.Code);
        }
    }
}
```

The field-mapping helper converts domain error codes such as missing postal code, region, or city into the request field names expected by the API contract. The domain error identifies what failed; the mapping identifies where the client should see it.

## Reusable rule-builder extensions

A reusable extension can encapsulate the domain factory and failure projection:

```csharp
public static IRuleBuilder<TDto, string>
    MustBeValueObject<TDto, TValueObject>(
        this IRuleBuilder<TDto, string> builder,
        Func<string, Result<TValueObject,
            IReadOnlyList<Error>>> factory,
        string mapErrorToName)
    where TDto : class
{
    return builder.Custom((value, context) =>
    {
        var result = factory.Invoke(value);

        if (result.IsFailure)
        {
            foreach (var error in result.Error)
            {
                context.AddFailure(
                    mapErrorToName,
                    error.Code);
            }
        }
    });
}
```

The validator can then declare domain-backed rules without reproducing the translation loop:

```csharp
RuleFor(dto => dto.PhoneNumber)
    .MustBeValueObject(
        PhoneNumber.Create,
        SharedConst.ProvideIndividualClientsData.PhoneFieldName);
```

The source also uses a typed `MustBeFullName<TDto>` extension for `FullNameDto`. It calls `FullName.Create(first, middle, last)` and adds every returned error against the supplied full-name field:

```csharp
public static IRuleBuilder<TDto, FullNameDto>
    MustBeFullName<TDto>(
        this IRuleBuilder<TDto, FullNameDto> builder,
        string mapErrorToName)
    where TDto : class
{
    return builder.Custom((dto, context) =>
    {
        var result = FullName.Create(
            dto.FirstName,
            dto.MiddleName,
            dto.LastName);

        if (result.IsFailure)
        {
            foreach (var error in result.Error)
            {
                context.AddFailure(
                    mapErrorToName,
                    error.Code);
            }
        }
    });
}
```

This keeps the request validator fluent while retaining the domain factory as the authority for value-object invariants.

## What should be recallable

- Why constructor DI is preferable to locating services through `IServiceProvider` inside a validator.
- How `Custom` converts one domain result into multiple validation failures.
- Why domain error codes may need a separate mapping to request field names.
- What a reusable `IRuleBuilder` extension owns and what remains owned by the domain factory.

## Sources

- Workspace: `_ai-conspects/fluent-validation/`
- Authoritative processed source: `regions/FV04-custom-validators-reusable-logic.md`
- Closure transcript: `02-stage2-next01-full-transcript.md`
- Original SVG: `assets/raw/full.svg`

