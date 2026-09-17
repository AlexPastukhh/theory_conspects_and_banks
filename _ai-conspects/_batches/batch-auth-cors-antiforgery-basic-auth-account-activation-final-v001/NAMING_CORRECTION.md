# Conspect naming correction

Conspect folders now match source SVG base names exactly:

```text
_ai-conspects/cors vs anti forgery/
_ai-conspects/basic auth/
_ai-conspects/account activation/
```

Rule:

- use the exact SVG base name as the conspect folder name;
- preserve spaces, casing, and punctuation;
- omit only the `.svg` extension;
- normalize suffixes such as `(1)` only when several uploaded files belong to one logical conspect.
