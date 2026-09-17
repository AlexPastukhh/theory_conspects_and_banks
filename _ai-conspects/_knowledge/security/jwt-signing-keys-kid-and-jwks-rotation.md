# JWT signing keys, KID, and JWKS rotation

Knowledge ID: `security.jwt-signing-keys-kid-and-jwks-rotation`

Topic: `security`

A compact JWT contains three Base64URL-encoded parts:

```text
header.payload.signature
```

The header carries cryptographic metadata such as `alg`, `typ`, and `kid`; the payload carries issuer, subject, audience, expiration, and application claims. Encoding does not hide either part. The signature protects integrity and authenticity, not confidentiality, unless a separate encryption format such as JWE is used.

## Symmetric versus asymmetric signing

```text
HS256 / HS512
    one secret signs and validates
    simple and fast
    every validator holding the secret can also mint tokens
    secret distribution becomes harder across services

RS256 / ES256
    private key signs
    public key validates
    validators cannot mint tokens with the public key
    public validation keys can be published through JWKS
```

HMAC APIs require key bytes:

```csharp
var keyBytes = Encoding.UTF8.GetBytes(secret);
var key = new SymmetricSecurityKey(keyBytes);
```

Production key material belongs in protected configuration or a secret manager rather than source code.

## `kid` selects a candidate; validation establishes trust

`kid` identifies the verification key intended for a token. A verifier may read this untrusted header value to select a candidate key, but must then perform full signature, issuer, audience, lifetime, and algorithm validation. Never trust an arbitrary algorithm or key source selected only because the token header names it.

## Rotation overlap

A safe asymmetric rotation keeps old and new verification material available for an overlap period:

```text
publish the new public key in JWKS
-> continue signing with the old key briefly
-> start signing new tokens with the new key and kid
-> retain the old public key through maximum token lifetime + clock skew
-> remove the old public key after that grace period
```

With symmetric keys, `kid` can select among a locally trusted secret ring, but every validator must receive each secret, making rotation and distribution more operationally difficult.

Trusted issuers, allowed algorithms, and trusted key/JWKS sources remain explicit validation policy throughout rotation.

## Related knowledge

- `security.token-validation-signing-and-identity-deployment`
- `dotnet.jwt-descriptors-handlers-and-validation`

## What should be recallable

- Which JWT parts are encoded, and which security property does the signature provide?
- Why can every HMAC validator also mint tokens?
- Why is asymmetric validation useful across many services?
- What can an untrusted `kid` safely be used for?
- Why must the old public key remain available after signing switches?
- Why is symmetric-key distribution harder to scale?

## Sources

- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `regions/R01R02R03R04-jwt-auth-corrected-final-v002.md`, R04 JWT structure, signing, KID, JWKS, rotation, and trusted-key boundaries
- Original SVG: `source/jwt auth.svg`

