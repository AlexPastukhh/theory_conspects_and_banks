# .NET Regex balancing groups

Knowledge ID: `dotnet.regex-balancing-groups`

Topic: `dotnet`

.NET balancing groups treat capture history as a stack. `(?<open>\()` pushes and `(?<-open>\))` requires/pops a capture. This supports arbitrary nesting depth within regex-engine limits, unlike a fixed number of manually nested groups. `(?(open)(?!))` fails if unmatched openings remain. Anchor the complete input with `\A ... \z`; otherwise a valid prefix may hide invalid trailing text. Group alternatives before applying repetition.

Multiple named stacks can track delimiter families. Corresponding tags additionally require the closing name to match the most recent opening name; depth alone is insufficient:

```text
<a><b></b></a>  valid LIFO nesting
<a><b></a></b>  invalid: closing name does not match the top opening
```

Capture history follows engine matching/backtracking semantics, not a general mutable collection API.

Use this for balanced delimiters or small constrained languages, not real HTML/XML with comments, scripts, quoted brackets, void elements, namespaces, and browser parsing rules. Complex/untrusted patterns need a timeout; balancing and nested alternatives can backtrack expensively.

## Sources

- Workspace: `_ai-conspects/BALANCING GROUPS .NET/`
- Processed source: `01-final-transcript.md`, complete transcript
