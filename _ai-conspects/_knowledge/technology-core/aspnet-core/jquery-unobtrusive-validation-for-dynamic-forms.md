# jQuery unobtrusive validation for dynamic ASP.NET Core forms

Knowledge ID: `aspnet-core.jquery-unobtrusive-validation-for-dynamic-forms`

Topic: `aspnet-core`

## From server metadata to browser rules

The usual client stack is jQuery, `jquery.validate`, and `jquery.validate.unobtrusive`. Razor tag helpers translate model attributes such as `[Required]`, `[EmailAddress]`, `[StringLength]`, and `[Range]` into input metadata:

```html
data-val="true"
data-val-required="..."
data-val-email="..."
data-val-length="..."
data-val-range="..."
```

`asp-for`, `asp-validation-for`, and `asp-validation-summary` create names, inputs, and validation placeholders. The unobtrusive adapter converts `data-val-*` metadata into jQuery Validate rules and messages; jQuery Validate executes checks, updates classes/messages, and controls client submission.

Client validation improves feedback but does not replace model binding, data annotations, `ModelState`, business validation, or authorization. Rules such as uniqueness, existing-email checks, and edit permission often remain server-only.

## Partials and dynamic injection

A form can live in a markup-only partial while jQuery and validation scripts are loaded once by the page/layout. Server-rendered partial HTML keeps its `data-val-*` attributes.

HTML inserted after initial page load is not necessarily scanned automatically. Parse the new form or container after insertion:

```js
target.innerHTML = returnedHtml;
$.validator.unobtrusive.parse(target);
```

Without this step, the server still rejects invalid submissions, but the new form may display no immediate client validation. Manual `.validate({...})` rules are available, yet Razor-generated forms should normally reuse server-emitted unobtrusive metadata rather than duplicate the same definitions in JavaScript.

When server validation fails, add errors to `ModelState` and return the view/partial. Razor helpers render those messages. Business or authorization errors can use `ModelState.AddModelError(...)`. If the returned markup replaces the form again, parse that replacement again.

```text
server attributes -> Razor data-val metadata
-> dynamic DOM insertion -> unobtrusive.parse
-> immediate jQuery Validate UX
-> authoritative server binding/ModelState
-> returned partial renders server errors -> parse replacement
```

## What should be recallable

- Which library generates rules and which library executes them?
- Which Razor helpers and attributes become `data-val-*` metadata?
- Why must dynamically inserted forms be reparsed?
- Which validation responsibilities remain server-only?
- How do returned partials preserve and reactivate server errors and client behavior?

## Sources

- Workspace: `_ai-conspects/jquery dynamic form validation/`
- Authoritative processed source: `regions/jquery dynamic form validation-final.md`, sections 1–6
- Original SVG: `source/jquery dynamic form validation.svg`
