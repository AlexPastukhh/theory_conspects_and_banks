# Cryptographic randomness and unbiased ranges

Knowledge ID: `dotnet.cryptographic-randomness-and-unbiased-ranges`

Topic: `dotnet`

Use `RandomNumberGenerator` whenever unpredictability protects security: session/reset/activation tokens, API keys, salts, nonces, MFA/recovery codes, and secrets. `System.Random` is for simulation/games/sampling, not adversarial prediction.

`GetBytes` returns raw entropy; `Fill(Span<byte>)` uses existing storage. Sixteen bytes provide 128 bits and 32 bytes 256 bits. Encoding changes representation length, not entropy; use Base64URL for URL transport. Alphabet characters contribute about `log2(size)` bits only under unbiased selection: 20 Base32 characters represent about 100 bits and 32 represent about 160 bits.

```csharp
byte[] bytes = RandomNumberGenerator.GetBytes(32);
string token = Convert.ToBase64String(bytes);

int code = RandomNumberGenerator.GetInt32(100_000, 1_000_000);
string codeText = code.ToString("D6");
```

`GetInt32(min, max)` uses an exclusive upper bound and unbiased range reduction. A raw value modulo `alphabet.Length` is biased whenever the source range is not evenly divisible by the alphabet size: some remainders receive one more source value than others. `GetInt32` rejects the uneven top portion rather than favoring those outcomes. Short numeric codes still need expiry, rate/attempt limits, and one-time use. Secure Fisher–Yates chooses `j = GetInt32(i + 1)` for each descending position so every index `0…i` is reachable without biased `%` reduction.

Prefer static APIs. Use `RandomNumberGenerator.Create()` only when an instance/abstraction is required; legacy `RNGCryptoServiceProvider` is obsolete for new code.

## Direct alphabet selection with BitConverter

An alternative to `GetBytes`-then-encode is to generate the secret string by picking characters from the Base32 alphabet directly. Four random bytes per output character are read as a `uint` via `BitConverter.ToUInt32`, then reduced to an alphabet index:

```csharp
byte[] random = RandomNumberGenerator.GetBytes(length * 4);
for (int i = 0; i < length; i++)
{
    uint val = BitConverter.ToUInt32(random, i * 4);
    sb.Append(Alphabet[val % (uint)Alphabet.Length]);
}
```

`BitConverter` interprets bytes as a number; it does not encrypt or decode. Machine endianness changes the numeric value but the selection remains derived from uniform random bytes.

For a 32-symbol alphabet: 32 divides `2^32` exactly, so `% 32` is uniformly distributed. If a different alphabet size is used, use rejection sampling or another unbiased mapping when exact uniformity matters.

Entropy of direct selection: each character from a 32-symbol alphabet contributes 5 bits, so 16 characters give 80 bits and 32 characters give 160 bits. A 16-character direct-selection key is much weaker than a 20-byte (160-bit) byte-first key even when both look like Base32 text.

The byte-first approach (`RandomNumberGenerator.GetBytes` + `Base32Encoding.ToString`) is preferred because its entropy is controlled by byte count, not output length, and it is conventional for TOTP libraries.

## Sources
- Workspace: `_ai-conspects/randomnumbergenerator/`
- Processed source: `regions/R01R02R03-final-coverage-transcript.md`, complete transcript
- Additional provenance: `_ai-conspects/creating base32 secret/`, `regions/full-semantic-transcript-v001.md`, sections 4-5
