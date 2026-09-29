# Account activation email confirmation flow

Knowledge ID: `aspnet-core.account-activation-email-confirmation-flow`

Topic: `aspnet-core`

Account activation is a pre-authentication gate: the user is created as inactive, a time-limited activation token is generated, the email contains the activation link, and the confirmation endpoint validates the token before the account is enabled. The source treats both the legacy `SecurityCode` approach and the later separate `Activation` aggregate as variants of the same design problem: make the code unpredictable, expire it, bind it to the right user, and avoid activating the account prematurely.

## Legacy flow: random code on the user record

The older registration design stores an activation/security code directly on the `User` record:

```csharp
userToAdd.SecurityCode = Convert.ToBase64String(
    RandomNumberGenerator.GetBytes(128));

userToAdd.SecurityCodeExpirationDate =
    DateTime.UtcNow.AddHours(1);
```

This is source-grounded because it shows the real concern: the code must be cryptographically random and expiration-based. The later design moves the same responsibility into a dedicated `Activation` entity so the account can keep multiple activation attempts, history, and stronger domain boundaries instead of mutating user fields directly.

The legacy activation service is also simple and instructive:

```csharp
public async Task<bool> ActivateUserAsync(string securityCode)
{
    if (string.IsNullOrWhiteSpace(securityCode))
    {
        throw new ArgumentNullException(nameof(securityCode));
    }

    var user = await _context.Users.FirstOrDefaultAsync(u =>
        u.SecurityCode == securityCode &&
        u.SecurityCodeExpirationDate >= DateTime.UtcNow);

    if (user == null)
    {
        return false;
    }

    user.Active = true;
    user.SecurityCode = null;
    return true;
}
```

This check still matters conceptually: activation is valid only for a nonblank code whose expiration has not passed; once valid, the account is activated and the code is cleared. The important operational requirement is persistence: the unit of work must save those changes.

## Separate Activation aggregate is a clearer domain boundary

The better design models activation as an aggregate owned by the user:

```csharp
public class User : Entity
{
    private readonly List<Activation> _accountActivations =
        new List<Activation>();

    public Activation LastAccountActivation =>
        _accountActivations.MaxBy(a => a.CodeExpirationTime);
}
```

The source calls out the reason clearly: a separate activation entity allows activation history, attempts, expiration tracking, row-versioning, and multiple reissue flows instead of mutating activation fields directly on `User`.

The activation record itself captures the main state:

```csharp
public class Activation : Entity
{
    public string SecurityCode { get; private set; }
    public DateTimeOffset CodeExpirationTime { get; private set; }
    public bool IsActivated { get; private set; }
    public Maybe<DateTimeOffset> ActivatedAt { get; private set; }
    public bool IsActivationAttempted { get; private set; }
    public User User { get; internal set; } = default!;
}
```

The constructor and domain method enforce the rules:

```csharp
internal UnitResult<Error> ActivateAccount(
    string inputCode,
    DateTimeOffset utcNow)
{
    Guard.IsNotNull(inputCode);

    if (inputCode != SecurityCode)
    {
        IsActivationAttempted = true;
        return Errors.Account.InValidActivationCode(
            SecurityCode,
            inputCode);
    }

    if (utcNow > CodeExpirationTime)
    {
        IsActivationAttempted = true;
        return Errors.Account.ActivationCodeHasExpired(
            inputCode,
            CodeExpirationTime);
    }

    IsActivationAttempted = true;
    IsActivated = true;
    return UnitResult.Success<Error>();
}
```

The important semantics are: wrong code fails, expired code fails, valid code activates the account, and the activation attempt is recorded. The source also notes a correction: a complete domain method should set `ActivatedAt`, reject already-activated replays, and persist the resulting state.

## Token generation must fit database and security constraints

The code generation factory creates a random activation code and expiry:

```csharp
internal static Activation StartAccountActivation(
    DateTimeOffset utcNow)
{
    var code = Convert.ToHexString(
        RandomNumberGenerator.GetBytes(128));

    var expirationDate = utcNow.AddHours(1);

    return new Activation(
        code!,
        expirationDate,
        false,
        Maybe.None,
        false);
}
```

This is the source's main warning: the hex-encoded 128-byte random value produces a very long token. If the database column is limited, token length and column size can conflict. The source explicitly points out a better choice: use fewer bytes, or store a hash of the raw code and send the raw code only in the email, never persist it in plain form. That is a real security and storage boundary, not a mere style preference.

## EF mapping, user ownership, and concurrency

The mapping shows the persistence contract:

```csharp
modelBuilder.Entity<Activation>(ab =>
{
    ab.ToTable("AccountActivations").HasKey(a => a.Id);
    ab.Property(a => a.Id).HasColumnName("ActivationsIds");
    ab.Property<long>("UserId");

    ab.Property(a => a.ActivatedAt)
        .HasConversion(
            maybe => maybe.GetValueOrDefault(),
            value => Maybe.From(value));

    ab.Property(a => a.SecurityCode)
        .HasMaxLength(100);

    ab.Property<byte[]>("Version")
        .IsRowVersion();
});
```

The source emphasizes the relationship:

```csharp
ub.HasMany<Activation>("_accountActivations")
    .WithOne(aa => aa.User)
    .HasForeignKey("UserId")
    .OnDelete(DeleteBehavior.Cascade);
```

This means the user owns multiple activation records, and the row-version field gives concurrency protection against double-activation races or concurrent reissue attempts. EF-level row-versioning matters here because activation is a transactional security decision.

## Email flow: generation, delivery, and confirmation endpoints

The registration flow sends an email with an activation link:

```csharp
var securityCode = user.LastAccountActivation.SecurityCode;

var link = _linkFactory.CreateLink(
    "ActivateAccount",
    "Account",
    securityCode);

var message =
    $"To activate your account click on " +
    $"<a href=\"{link}\">link</a>:";

var sendEmail = await _email.SendEmailAsync(
    user.Email,
    "Activate your account",
    message,
    cancellationToken);
```

The source is explicit: after registration, the user is redirected to a check-email page rather than signed in automatically. Email failure aborts the flow with an error. The link factory uses `LinkGenerator` and the current HTTP context to create an absolute URL:

```csharp
var link = _link.GetUriByAction(
    _contextAccessor.HttpContext!,
    action,
    controller,
    new { code },
    scheme);
```

This is a practical route-generation boundary: the link depends on request context and host/scheme data. The source also calls out an important production correction: for background jobs, a configured public base URL is preferable to an ambient request-scoped factory.

## GET activation is convenient but requires safety design

The email flow usually ends in a GET route:

```csharp
[HttpGet("activate/{code}")]
public async Task<IActionResult> ActivateAccountAsync(
    string code)
{
    // validate and confirm
}
```

The source notes the safety concern: GET is conventionally safe, but email verification mutates state. A robust design may make the GET route display a confirmation page and then require a POST mutation, or use an idempotent GET activation pattern that is resistant to link prefetchers and repeated clicks. The account should not be activated twice or left in a partially changed state.

## What should be recallable

- Why is account activation treated as a pre-authentication gate?
- What is the difference between the legacy `User.SecurityCode` design and the `Activation` aggregate design?
- What security properties matter for activation tokens: unpredictability, expiration, user binding, and one-time semantics?
- Why does the source warn about token size and `HasMaxLength` conflicts?
- What does the `Activation` domain method validate before success?
- Why do row-versioning and a user-owned activation list matter?
- What is the key difference between a link factory using `HttpContext` and a configured public URL?
- Why does the source stress GET/POST boundaries for email confirmation?
- What should happen when email sending fails or the activation code is missing/expired?

## Related knowledge

- `aspnet-core.data-protection-reset-tokens`
- `aspnet-core.totp-enrollment-and-verification`
- `aspnet-core.safe-return-url-login-flow`
- `aspnet-core.link-generator-and-public-origin`

## Sources

- Workspace: `_ai-conspects/account activation/`
- Authoritative processed source: `04-source-preserving-transcript-v002.md`, full source-preserving transcript and technical-correction section
- Authoritative processed source: `05-corrected-domain-code-reference-v002.md`, corrected token sizing, persistence, and flow safety
- Authoritative processed source: `08-technical-risk-corrections-v002.md`, GET/POST and activation-safety corrections
- Authority status: `CURRENT_SOURCE_OF_TRUTH.md`
- Original SVG identity: `source/Account activation.svg` (current repository source is established in the workspace owner metadata; no path invention beyond that verified source)
