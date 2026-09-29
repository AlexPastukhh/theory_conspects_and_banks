# FluentValidation built-in rules, conditions, and cascade control

Knowledge ID: `dotnet.fluentvalidation-built-in-rules-conditions-and-cascade`

Topic: `dotnet`

FluentValidation rule chains describe both checks and the control flow between them. A validator is not just a list of predicates: the property type changes built-in semantics, a condition can cover one or several validators, and cascade policy determines what runs after a failure.

## `NotEmpty`, whitespace, and regex checks

`NotEmpty()` is type-sensitive:

- a string fails when it is `null` or empty, but whitespace-only text is not necessarily empty;
- a collection fails when it is `null` or has no items;
- a nullable value type fails when it is `null`;
- a non-nullable value type fails when it equals that type's default value.

When whitespace must also fail, make that requirement explicit:

```csharp
RuleFor(x => x.Email)
    .NotEmpty()
    .Must(value => !string.IsNullOrWhiteSpace(value))
    .WithMessage("Email is required");
```

The captured source also identifies `NotWhiteSpace()` in FluentValidation versions where that validator is available. For an ordinary regular-expression constraint, `Matches` expresses the intent more directly than a `Must(Regex.IsMatch(...))` predicate:

```csharp
RuleFor(x => x.Phone)
    .NotEmpty()
    .Matches("^[2-9][0-9]{9}$");
```

## Which validators a condition controls

By default, a chained `When(...)` can apply to all preceding validators in that rule chain. That can accidentally suppress `NotEmpty()` along with a later format check. Use `ApplyConditionTo.CurrentValidator` when only the immediately preceding validator is conditional:

```csharp
RuleFor(x => x.Phone)
    .NotEmpty()
    .Matches("^[2-9][0-9]{9}$")
    .When(
        x => x.Phone != null,
        ApplyConditionTo.CurrentValidator);
```

Here a missing phone can still fail `NotEmpty`; the condition only prevents the regex validator from running for `null`.

## Cross-property presence and format are separate rules

A naive pair of rules can say "validate email only when phone is absent" and "validate phone only when email is absent":

```csharp
RuleFor(x => x.Email)
    .NotEmpty()
    .Length(0, 150)
    .EmailAddress()
    .When(x => x.Phone == null);

RuleFor(x => x.Phone)
    .NotEmpty()
    .Matches("^[2-9][0-9]{9}$")
    .When(x => x.Email == null);
```

If both values are present, neither rule necessarily checks the other present value. An invalid phone can therefore pass merely because an email exists.

For an exclusive "email or phone, but not both" contract, the source uses `When(...).Otherwise(...)`: the selected branch validates one value and requires the other to be `Null()`.

For an "at least one, and every supplied value must be valid" contract, separate presence from format:

```csharp
When(x => x.Email == null, () =>
{
    RuleFor(x => x.Phone).NotEmpty();
});

When(x => x.Phone == null, () =>
{
    RuleFor(x => x.Email).NotEmpty();
});

RuleFor(x => x.Email)
    .NotEmpty()
    .Length(0, 150)
    .EmailAddress()
    .When(x => x.Email != null);

RuleFor(x => x.Phone)
    .NotEmpty()
    .Matches("^[2-9][0-9]{9}$")
    .When(x => x.Phone != null);
```

This composition answers two independent questions: whether enough contact data exists, and whether each supplied value is valid.

## Rule-level and class-level cascade

Rule-level stop prevents later validators in the same chain from running after an earlier failure:

```csharp
RuleFor(x => x.Email)
    .Cascade(CascadeMode.Stop)
    .NotEmpty()
    .Length(1, 150);
```

The captured class-level form sets `CascadeMode = CascadeMode.Stop` before multiple `RuleFor` chains. Its broader effect is to stop both within a chain and between rule chains. The placement of cascade policy therefore changes the validation surface, not merely performance.

## What should be recallable

- How `NotEmpty()` changes across strings, collections, nullable values, and non-nullable values.
- Why whitespace-only strings need an explicit rule.
- When `Matches` is clearer than `Must(Regex.IsMatch(...))`.
- Why `When` can accidentally suppress preceding validators and what `CurrentValidator` changes.
- Why presence rules and format rules must be separated for optional alternative fields.
- The difference between rule-level and class-level cascade stop.

## Sources

- Workspace: `_ai-conspects/fluent-validation/`
- Authoritative processed sources: `regions/FV01-regex-basic-validators.md` and `regions/FV03-conditional-validation-cascade-mode.md`
- Closure transcript: `02-stage2-next01-full-transcript.md`
- Original SVG: `assets/raw/full.svg`

