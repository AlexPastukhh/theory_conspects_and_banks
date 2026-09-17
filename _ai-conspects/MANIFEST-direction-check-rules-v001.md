# MANIFEST - Direction Check Rules v001

Archive type: **workflow/protocol update**  
Generated: 2026-06-01 17:21:45 UTC

## Direction check

Goal:
Keep parallel conspect-processing chats aligned while preserving folder boundaries.

Now:
Processed work is already separated by `_ai-conspects/<conspect-slug>/`.

This step:
Add a compact Direction check rule and a reusable prompt for other chats.

Why:
This prevents drift, unnecessary archives, unsupported transcript claims, and cross-conspect edits.

Next:
1. apply this archive to `ai-processed-conspects-text`;
2. use the prompt when starting other chats;
3. continue each chat only inside its assigned conspect folder.

## Files included

```text
_ai-conspects/CONSPECT_PROCESSING_RULES.md
_ai-conspects/PARALLEL_CHAT_PROMPT.md
_ai-conspects/MANIFEST-direction-check-rules-v001.md
_ai-conspects/APPLY_DIRECTION_CHECK_RULES.md
```

## Scope

This archive updates shared workflow rules only.

It does not modify any conspect-specific folder such as:

```text
_ai-conspects/react-query-rquery/
```
