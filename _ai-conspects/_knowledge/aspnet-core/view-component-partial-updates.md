# Partial updates for View Components

Knowledge ID: `aspnet-core.view-component-partial-updates`

Topic: `aspnet-core`

A View Component's delivered HTML is static until the browser requests or receives an update. Expose an endpoint returning freshly rendered component HTML, then replace only the target fragment.

With fetch, read `response.text()` and assign the target's `innerHTML`; the endpoint returns HTML, not necessarily JSON. HTMX expresses the same flow declaratively:

```html
<div id="cartSummary"
     hx-get="/widgets/cart-summary"
     hx-trigger="load, every 5s"
     hx-swap="innerHTML">
  @await Component.InvokeAsync("CartSummary")
</div>
```

`hx-get`/`hx-post` selects the endpoint, `hx-trigger` the event/polling schedule, `hx-target` the receiver, and `hx-swap` the replacement strategy. Fetch fits custom loading/error/client logic; HTMX fits “replace this fragment with server HTML” with minimal JavaScript.

The initial request therefore renders useful component HTML before HTMX runs; later triggers request the endpoint and swap in a fresh server-rendered fragment. The equivalent imperative flow is `fetch(url) → response.text() → target.innerHTML = html`.

SignalR fits server-triggered change signals. Usually push a small “refresh now” event and fetch the new HTML rather than maintaining a second client rendering model or pushing full markup. These are partial page updates, not client routing/state management.

## Sources
- Workspace: `_ai-conspects/RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX/`
- Processed source: `regions/R01R02R03-final-coverage.md`, complete transcript
