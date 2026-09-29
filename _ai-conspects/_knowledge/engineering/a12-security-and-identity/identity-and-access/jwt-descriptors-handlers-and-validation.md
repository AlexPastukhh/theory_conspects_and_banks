# JWT descriptors, handlers, and validation in .NET

Knowledge ID: `dotnet.jwt-descriptors-handlers-and-validation`

Topic: `dotnet`

`SecurityTokenDescriptor` centralizes token-creation inputs:

```text
Issuer
Audience
Subject / claims
NotBefore
Expires
IssuedAt
SigningCredentials
EncryptingCredentials
AdditionalHeaderClaims
```

It is useful when token creation is dynamic, encryption/JWE is required, or several handlers/token types share a descriptor-based flow. Appropriate custom header fields, including a `kid` where the creation policy calls for it, can be supplied through `AdditionalHeaderClaims`.

Representative access-token issuance:

```csharp
var descriptor = new SecurityTokenDescriptor
{
    Issuer = issuer,
    Audience = audience,
    Subject = new ClaimsIdentity(claims),
    NotBefore = DateTime.UtcNow,
    Expires = DateTime.UtcNow.AddMinutes(15),
    SigningCredentials = signingCredentials,
};

var handler = new JwtSecurityTokenHandler();
var accessToken = handler.CreateEncodedJwt(descriptor);
```

## Handler operations have different trust contracts

```text
ReadJwtToken
    parse a compact JWT; establish no trust

ValidateToken
    validate under TokenValidationParameters and return ClaimsPrincipal

ValidateTokenAsync
    asynchronous validation with a structured result

CreateJwtSecurityToken / CreateToken
    create token objects

CreateEncodedJwt
    create the final compact string

WriteToken
    serialize a token object to compact form
```

Reading `Header`, `Payload`, `Claims`, `Issuer`, `Audiences`, `ValidFrom`, `ValidTo`, or raw encoded segments does not authenticate the token.

## Explicit validation contract

ASP.NET Core bearer validation should explicitly define issuer, audience, lifetime, and signing-key checks:

```csharp
builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = issuer,
            ValidateAudience = true,
            ValidAudience = audience,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = signingKey,
            ClockSkew = TimeSpan.FromSeconds(30),
        };
    });
```

Validation policy also owns trusted key resolution/key sets, allowed algorithms, lifetime rules, and clock skew. Authentication and authorization middleware must execute before protected endpoints.

Successful validation establishes the principal used for application authorization:

```csharp
ClaimsPrincipal principal = handler.ValidateToken(
    token,
    validationParameters,
    out SecurityToken validatedToken);
```

Authorization must use that validated principal rather than claims read from an untrusted parse.

## Related knowledge

- `security.jwt-signing-keys-kid-and-jwks-rotation`
- `security.browser-access-and-refresh-token-lifecycle`
- `aspnet-core.jwt-bearer-event-lifecycle`

## What should be recallable

- Which creation inputs does `SecurityTokenDescriptor` group?
- How do parse, validate, create, encode, and serialize handler operations differ?
- Why does reading a JWT's claims not establish trust?
- Which issuer/audience/lifetime/signing controls should validation define?
- What object should downstream authorization inspect?

## Sources

- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `regions/R01R02R03R04-jwt-auth-corrected-final-v002.md`, R03 bearer validation/token issuance and R04 descriptor/handler/claims-validation sections
- Original SVG: `source/jwt auth.svg`
