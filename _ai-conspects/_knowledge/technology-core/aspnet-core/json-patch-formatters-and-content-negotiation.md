# ASP.NET Core JSON Patch formatters and content negotiation

Knowledge ID: `aspnet-core.json-patch-formatters-and-content-negotiation`

Topic: `aspnet-core`

ASP.NET Core JSON Patch behavior depends on the selected package and serializer/input-formatter stack.

The established implementation uses `Microsoft.AspNetCore.JsonPatch`, Newtonsoft.Json, and an input formatter for `application/json-patch+json`. Newer prerelease support can instead use `Microsoft.AspNetCore.JsonPatch.SystemTextJson`.

Adding Newtonsoft input support or XML formatters alongside the normal System.Text.Json output formatter can change content negotiation. If a client does not send an explicit `Accept`, an object result may unexpectedly select XML depending on registered formatter order and supported types.

Configure only the formatters the application needs, retain the ordinary JSON output formatter, and verify:

```text
request Content-Type
-> selected JSON Patch input formatter and serializer

response Accept + formatter order/support
-> selected output representation
```

Package choice, input deserialization, and output negotiation are connected configuration decisions; “JSON Patch works” does not prove that ordinary object responses still default to the intended JSON format.

## What should be recallable

- Which serializer stack does the established JSON Patch package use?
- What media type selects JSON Patch input?
- How can adding Newtonsoft or XML support alter output negotiation?
- Which formatter order and supported-type checks should be verified?

## Sources

- Workspace: `_ai-conspects/PUT,PATCH/`
- Authoritative processed source: `regions/R01R07-put-patch-full-coverage-v001.md`, R05
- Original SVG: `source/source-complete-v001.svg`
