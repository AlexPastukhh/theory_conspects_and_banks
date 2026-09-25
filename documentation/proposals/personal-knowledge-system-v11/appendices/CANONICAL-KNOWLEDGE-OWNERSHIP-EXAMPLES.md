# Canonical Knowledge Ownership — examples

| Knowledge | Canonical home | Reason |
|---|---|---|
| C# generics | Technology / C# | Defining language/type-system model |
| Python decorators | Technology / Python | Defining language model |
| Node module system | Technology / Node.js | Defining runtime/ecosystem model |
| React render model | Technology / React | Defining framework model |
| EF Core change tracker | Technology / EF Core | Defining ORM model |
| General async model | Engineering / Concurrency & Asynchrony | Broader concept |
| .NET Task + async/await model | Technology / .NET | Core .NET runtime model; linked from Asynchrony |
| Node event loop + Promise model | Technology / Node.js | Core Node runtime model; linked from Asynchrony |
| Python asyncio model | Technology / Python | Core Python runtime model; linked from Asynchrony |
| Transaction isolation | Engineering / Data & Persistence / Transactions | Cross-technology concept |
| EF Core optimistic concurrency | Engineering / Data & Persistence / Concurrency | EF is an implementation/context of broader concurrency concept |
| SQL Server indexes | Engineering / Data & Persistence / Indexing | DB implementation of broader indexing/query-performance concept |
| XSS | Engineering / Security | Cross-stack security concept |
| HTTP caching | Engineering / Networking & Web / HTTP | Protocol concept |
| Polly retry API details | Technology/library-specific if API-focused; otherwise Engineering / Resilience | Depends on subject of unit |
| React Query cache/observer model | Technology / React Query | Defining library model |

## Decision heuristic

```text
Is the Unit mainly about a broader engineering concept?
  ├─ yes → engineering concept owns it
  │
  └─ no
      ↓
Is it part of the technology's own defining mental model?
  ├─ yes → technology owns it
  │          ↓
  │     broader concept also relevant?
  │          └─ link from engineering map
  │
  └─ ambiguous → choose the owner that best matches the semantic subject
                 and minimizes duplicated explanation
```
