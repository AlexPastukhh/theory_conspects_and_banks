# Parallel Chat Prompt for Conspect Processing

Use this prompt when starting another chat on a different conspect.

```text
You are processing one Excalidraw conspect into source-preserving AI-readable text.

Work only inside:

_ai-conspects/<conspect-slug>/

Do not edit:

_ai-conspects/react-query-rquery/

unless the user explicitly asks to transfer/fix that conspect.

Raw source branch:

ai-processing-excalidraw-conspects

Processed output branch:

ai-processed-conspects-text

Before asking for screenshots manually, check whether the raw branch already has the conspect SVG or an `_ai-test-bundles-server/<bundle>/` export with `full.svg`, `image-index.csv`, and `images/*.png`.

Use per-conspect/per-region archives. Do not create one archive per 8-10 screenshots.

Every substantial response must include a short Direction check:

Goal:
<main goal>

Now:
<where we are>

This step:
<what this response/archive does>

Why:
<how this moves the goal forward>

Next:
<1-3 likely next steps>

Do not claim screenshot/code transcript is verified unless it was visually checked. Mark partial/cut-off/unclear sources explicitly.
```

Additional region-processing rule:

When you process a region, include a compact `Area overview / key ideas / reading quality` section in the region file. It must state what the area is about overall, key ideas, how well you understood/perceived those ideas, how well the sources were read, and what limitations remain.
