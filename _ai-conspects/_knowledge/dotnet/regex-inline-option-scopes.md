# .NET Regex inline option scopes

Knowledge ID: `dotnet.regex-inline-option-scopes`

Topic: `dotnet`

Singleline makes dot include newlines; Multiline changes anchors. Enable dot-all globally with `RegexOptions.Singleline`/`(?s)`, or scope it with `(?s:...)`:

```csharp
var pattern = @"header:(?s:.*?)footer";
```

Inline groups combine options (`(?im)`), disable them (`(?-s)`), or scope combinations (`(?s-m:...)`). Prefer nearby scopes over distant toggles. `[\s\S]` is a cross-platform any-character alternative but less direct.

Greedy `.*` may overconsume; use lazy/specific patterns. Test LF/CRLF and newline boundaries, and document complex toggles.

## What should be recallable

- Explain the core model of **.NET Regex inline option scopes** without opening the Unit.
- Reconstruct this Unit-grounded rule: Singleline makes dot include newlines; Multiline changes anchors.
- Reconstruct this Unit-grounded rule: Inline groups combine options (`(?im)`), disable them (`(?-s)`), or scope combinations (`(?s-m:...)`).
- Reconstruct this Unit-grounded rule: Greedy `.*` may overconsume; use lazy/specific patterns.
- Recall the Unit's stated boundaries, failure modes, and trade-offs; source/provenance details themselves are outside the scheduled scope.

## Sources
- Workspace: `_ai-conspects/inline flags sharp/`
- Processed source: `04-full-combined-final-transcript.md`, complete transcript
