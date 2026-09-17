# Password hashing, verification, and upgrades

Knowledge ID: `dotnet.password-hashing-verification-and-upgrades`

Topic: `dotnet`

Passwords need one-way verification, not reversible encryption. Derive a verifier with a password KDF, a fresh random per-password salt, and a deliberately expensive work factor. Equal passwords then do not share stored hashes.

Store a versioned envelope containing algorithm, parameters, salt, and derived key, for example `version:algorithm:iterations:salt:hash`. Verification must validate the format and bounded parameters, derive using the stored configuration, and compare with `CryptographicOperations.FixedTimeEquals`. After successful verification, rehash when the version or cost is obsolete; ASP.NET Core `PasswordHasher` reports `SuccessRehashNeeded` for this migration path.

```csharp
byte[] salt = RandomNumberGenerator.GetBytes(16);
byte[] key = Rfc2898DeriveBytes.Pbkdf2(
    password, salt, 210_000, HashAlgorithmName.SHA256, 32);
```

Tune cost using deployment measurements and prefer framework password hashing or a dedicated wrapper over ad hoc code. The `user` parameter in `IPasswordHasher<TUser>` permits implementations with user-specific context. Use encryption/Data Protection only for data that must later be recovered.

## Sources
- Workspace: `_ai-conspects/hashing/`
- Processed source: `01-final-transcript.md`, complete transcript

