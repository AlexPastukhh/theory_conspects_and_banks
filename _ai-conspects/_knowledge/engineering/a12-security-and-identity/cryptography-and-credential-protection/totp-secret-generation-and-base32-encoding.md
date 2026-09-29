# TOTP secret generation and Base32 encoding

Knowledge ID: `dotnet.totp-secret-generation-and-base32-encoding`

Topic: `dotnet`

A TOTP secret is shared key material known to the server and the authenticator. TOTP security depends on the unpredictability of this secret. Base32 is an encoding that represents the secret as text; it does not create entropy and does not strengthen weak random input.

The classic Base32 alphabet is the 32-character set `ABCDEFGHIJKLMNOPQRSTUVWXYZ234567`.

## Byte-first approach (recommended)

Generate cryptographically secure random bytes, keep those bytes as the real secret, and encode to Base32 only where a text representation is required.

```csharp
using System.Security.Cryptography;
using OtpNet;

public static class TotpSecret
{
    // 20 bytes = 160 bits
    public static string CreateBase32Secret(int byteLength = 20)
    {
        byte[] secretBytes =
            RandomNumberGenerator.GetBytes(byteLength);

        return Base32Encoding.ToString(secretBytes);
    }
}
```

`RandomNumberGenerator.GetBytes` is a cryptographically secure source. `System.Random` is not a suitable replacement for security-sensitive secret generation.

The entropy math is direct:

```text
20 bytes * 8 bits/byte = 160 bits

Base32 carries 5 bits per character because 2^5 = 32.
160 bits / 5 bits per character = 32 characters (no padding needed).
```

A clean design separates byte storage from text presentation:

```csharp
public static class TotpSecretBytes
{
    public static byte[] CreateSecretBytes(int byteLength = 20) =>
        RandomNumberGenerator.GetBytes(byteLength);

    public static string ToBase32(byte[] secretBytes) =>
        Base32Encoding.ToString(secretBytes);
}
```

The binary bytes are the true secret. Entropy is exactly controlled by byte count. Base32 is only a presentation format. There is no custom character-selection algorithm to audit.

Whether the database stores protected bytes or a protected Base32 string is an application storage decision. In either form the secret is a credential.

## Direct alphabet selection approach

An alternative generates the textual key directly by picking characters from the Base32 alphabet using random integers:

```csharp
using System.Security.Cryptography;
using System.Text;

public static class TotpSecretCourseStyle
{
    // Base32 alphabet (classic): A-Z and 2-7
    private static readonly char[] Alphabet =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567".ToCharArray();

    public static string CreateSecret(int length = 16)
    {
        // Generate plenty of random bytes so every character pick is random
        byte[] random = RandomNumberGenerator.GetBytes(length * 4);
        var sb = new StringBuilder(length);

        for (int i = 0; i < length; i++)
        {
            // Read 4 bytes as an unsigned int (0..2^32-1)
            uint val = BitConverter.ToUInt32(random, i * 4);
            // Convert to an index inside Alphabet
            sb.Append(Alphabet[val % (uint)Alphabet.Length]);
        }

        return sb.ToString();
    }
}
```

Four bytes are consumed per output character because `BitConverter.ToUInt32` reads 4 bytes. For 16 characters this requests 64 bytes.

`BitConverter` does not encrypt or decode. It interprets 4 bytes as an unsigned 32-bit number. Machine endianness changes the numeric interpretation but the result is still derived from uniform random bytes; endianness does not make the selection predictable.

### Entropy of direct selection

Each character selected uniformly from 32 symbols contributes 5 bits:

```text
16 characters = 80 bits
32 characters = 160 bits
```

A 16-character direct-selection key is much weaker than a 20-byte (160-bit) byte-first key even though both produce Base32-like text.

### Modulo bias with a 32-symbol alphabet

`value % alphabetLength` can be biased when the random integer range is not evenly divisible by the alphabet length. For a 32-symbol alphabet and a uniform 32-bit integer: 32 divides `2^32` exactly, so `% 32` is unbiased. If a different alphabet length is used, apply rejection sampling or another unbiased mapping when exact uniformity matters.

## Comparison

| Aspect | Byte-first | Direct selection |
|---|---|---|
| True secret | binary bytes | text characters |
| Entropy control | byte count | output length + selection uniformity |
| Interoperability | conventional for TOTP libs | requires verified selection logic |
| Base32 role | encoding only | generated directly |
| Preferred | yes | acceptable only with correct length |

## What should be recallable

- Why does Base32 encode but not create entropy?
- How many bits does a 20-byte secret carry, and how many Base32 characters result?
- Why does `BitConverter.ToUInt32` read 4 bytes per character in direct selection?
- Why is a 16-character direct-selection key weaker than a 20-byte byte-first key?
- When is `% alphabetLength` biased, and when is it safe for a 32-symbol alphabet?
- What is the byte-first design advantage for TOTP libraries?

## Related knowledge

- `aspnet-core.otpauth-uri-construction`
- `aspnet-core.totp-enrollment-and-verification`
- `dotnet.cryptographic-randomness-and-unbiased-ranges`

## Sources

- Workspace: `_ai-conspects/creating base32 secret/`
- Authoritative processed source: `regions/full-semantic-transcript-v001.md`, sections 1-6
- Region files: `regions/B32SEC-R01-random-secret-bytes-base32-encoding.md`, S-001..S-018
- Original SVG: SHA-256 `00b26f65fd54c455c8d09c1cad61b2023719537afad3c427ab3ddb80179fa2a6`, Git blob `d5aad6ee05f95c43d8650f1506140fa93deb8ab4`
- Workspace: `_ai-conspects/mfa/`
- Authoritative processed sources: `regions/MFA-R03-secret-generation-helpers.md`; `regions/MFA-R03-v002-secret-generation-tail.md`; `regions/MFA-R04-otpauth-uri-qr-manual-key.md`, secret-generation continuation
- Original source identity: `mfa.svg` (named by the workspace boundary review; not physically present in this workspace)
