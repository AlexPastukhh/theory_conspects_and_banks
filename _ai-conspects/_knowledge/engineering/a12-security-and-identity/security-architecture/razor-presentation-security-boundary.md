# Presentation decisions versus security enforcement in Razor

Knowledge ID: `aspnet-core.razor-presentation-security-boundary`

Topic: `aspnet-core`

## Core model

A Razor view may make presentation decisions, such as showing login/logout links, displaying the user name, choosing a banner from path/query data, formatting values, or hiding presentation-only controls.

Those decisions are not security enforcement. Hiding an admin link does not prevent a request to the protected endpoint.

Authorization, permission checks, business rules, and other security decisions must be enforced in policies, controllers or endpoints, services, and `[Authorize]`-based infrastructure.

```text
view
  -> decides what the UI displays;

authorization infrastructure / endpoint / service
  -> decides whether the operation is permitted.
```

Complex business logic and data retrieval also belong outside the view. Supply prepared data through a view model or a view-oriented component/service.

## What should be recallable

- Which request/user-dependent decisions are acceptable presentation logic?
- Why is hiding a UI element insufficient authorization?
- Where must permission enforcement happen?
- Which kinds of business or data-access logic should leave the view?
- How does UI visibility differ from operation security?

## Related knowledge

- `aspnet-core.razor-service-injection` — view dependencies and available request context.

## Sources

- Workspace: `_ai-conspects/injecting into razor/`
- Processed source: `FINAL_TRANSCRIPT.md`, S-003 and relevant request/user context from S-002
- Original SVG: `source/injecting into razor.svg`
