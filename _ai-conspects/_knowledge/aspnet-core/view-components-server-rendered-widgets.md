# View Components as server-rendered widgets

Knowledge ID: `aspnet-core.view-components-server-rendered-widgets`

Topic: `aspnet-core`

A View Component is reusable server-side UI with its own service/data orchestration. MVC locates the class, invokes `Invoke`/`InvokeAsync`, receives an `IViewComponentResult`, renders a component view such as `Views/Shared/Components/<Name>/Default.cshtml`, and inserts the HTML into the parent response.

```cshtml
@await Component.InvokeAsync("FeaturedProducts", new { count = 2 })
```

Use a partial when the parent already owns the data and only markup is reused. Use a View Component when a widget independently queries a service, chooses its model, uses DI, or appears across views/layouts. Keep ordinary Razor logic presentational; business rules stay in model/services.

Unlike a React component, a View Component has no client state or automatic subtree rerender. It runs during a server request. Later updates require navigation/refresh or a client mechanism such as fetch/AJAX, HTMX, or SignalR to request fresh HTML. React fits interactive client state; Razor/View Components fit server-rendered request-response flow.

Choose an ordinary Razor view for server-rendered pages where SEO/fast first render, forms/CRUD, and minimal JavaScript dominate. Choose a View Component for an independently reusable server widget with its own DI/data work. Choose React when the boundary needs interactive client state, effects, and local rerendering.

## Sources
- Workspace: `_ai-conspects/viewcomponent/`
- Processed source: `regions/R01R02R03-final-coverage.md`, complete transcript
