# PUT, PATCH, representations, and update preconditions

Knowledge ID: `http.put-patch-and-update-preconditions`

Topic: `http`

## Update semantics

`PUT` normally sends the complete desired representation to a known resource URI. Fields omitted from that representation are overwritten or reset according to the server model. Repeating the same PUT converges on the same representation, so the method is idempotent.

`PATCH` sends a partial change document. Its idempotency depends on the operations: replacing a value or setting it to a constant can be idempotent; increment-like changes are not inherently idempotent.

Successful updates commonly return `200 OK` with a representation or `204 No Content`. Creating through PUT or PATCH is an explicit upsert policy and is most natural when the client owns the identifier. When the server creates the identifier, `POST` is normally the clearer creation contract.

Conditional headers protect update intent:

```text
If-Match: <validator>  -> update only the expected current representation
If-None-Match: *      -> create only if the known URI does not exist
```

When the server requires a write precondition, a missing `If-Match` can produce `428 Precondition Required`; a supplied validator that does not match produces `412 Precondition Failed`. `409 Conflict` remains a domain or business conflict rather than a substitute for a failed HTTP validator.

## PATCH document models

PATCH is a method, not one universal body format:

- JSON Patch (`application/json-patch+json`) is an ordered array of `add`, `remove`, `replace`, `move`, `copy`, and `test` operations using JSON Pointer paths. It is precise, and `test` can express an optimistic precondition inside the document.
- JSON Merge Patch (`application/merge-patch+json`) is object-shaped. Absent properties remain unchanged, present properties replace values, and `null` generally means remove or set null according to the target model.
- A manual DTO with `application/json` is often clearer when a stable business contract and domain validation matter more than RFC operation expressiveness.

JSON Patch is more expressive and more complex to validate. Merge Patch is simpler for ordinary field replacement. Select the representation explicitly rather than treating every partial JSON object as equivalent.

## What should be recallable

- How do omission and idempotency differ between PUT and PATCH?
- When is update upsert natural, and when is POST a better creation method?
- What lost-update and create-only intentions do `If-Match` and `If-None-Match: *` express?
- How do JSON Patch, JSON Merge Patch, and a manual DTO represent change?
- Why can one PATCH document be idempotent while another is not?

## Sources

- Workspace: `_ai-conspects/PUT,PATCH/`
- Authoritative processed source: `regions/R01R07-put-patch-full-coverage-v001.md`, R01–R02 and practical synthesis
- Original SVG: `source/source-complete-v001.svg`
- Workspace: `_ai-conspects/ETAG, e tag/`
- Authoritative processed source: `01-final-transcript.md`, R02 and R04
- Original SVG: `source/ETAG, e tag.svg`
