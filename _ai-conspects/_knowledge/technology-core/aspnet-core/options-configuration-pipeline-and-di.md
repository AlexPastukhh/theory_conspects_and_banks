# ASP.NET Core options configuration pipeline and dependency injection

Knowledge ID: `aspnet-core.options-configuration-pipeline-and-di`

Topic: `aspnet-core`

For one options type and name, `IOptionsFactory<TOptions>` builds one composed instance:

```text
create TOptions
-> run matching IConfigureOptions / IConfigureNamedOptions actions
-> run every IPostConfigureOptions action
-> validate
-> return/cache the final instance
```

Registrations do not create unrelated replacement objects. Actions setting different properties combine; when actions set the same property, the later action wins.

## Normal, named, and final configuration

- `IConfigureOptions<T>` applies ordinary/default configuration.
- `IConfigureNamedOptions<T>` can branch by options name and also handle the unnamed instance.
- `IPostConfigureOptions<T>` runs after normal configuration to finalize defaults, normalize values, enforce final invariants, or apply compatibility patches.

```csharp
public sealed class ConfigureMyOptions : IConfigureOptions<MyOptions>
{
    public void Configure(MyOptions options) =>
        options.TimeoutSeconds = 30;
}

public sealed class PostConfigureMyOptions
    : IPostConfigureOptions<MyOptions>
{
    public void PostConfigure(string? name, MyOptions options)
    {
        if (options.TimeoutSeconds < 1)
            options.TimeoutSeconds = 1;
    }
}
```

`PostConfigure<T>(name, ...)` patches one named instance. `PostConfigureAll<T>` runs for the default instance and every name:

```csharp
builder.Services.PostConfigureAll<FeatureOptions>(options =>
{
    options.Tags ??= Array.Empty<string>();
});
```

## Resolve dependencies from the real container

Use `OptionsBuilder.Configure<TDependency>`/DI-aware `PostConfigure`, or inject dependencies into a configurer class. Do not call `BuildServiceProvider()` during registration: a second container splits singleton identity, caches, ownership, and disposal.

```csharp
builder.Services.AddSingleton<ITicketStore,
    DistributedCacheTicketStore>();

builder.Services
    .AddOptions<CookieAuthenticationOptions>("Cookies")
    .Configure<ITicketStore>((options, ticketStore) =>
    {
        options.SessionStore = ticketStore;
    });
```

A class-based post-configurer is useful when final ordering is the intent:

```csharp
public sealed class PostConfigureCookieTicketStore
    : IPostConfigureOptions<CookieAuthenticationOptions>
{
    private readonly ITicketStore _store;

    public PostConfigureCookieTicketStore(ITicketStore store) =>
        _store = store;

    public void PostConfigure(
        string? name,
        CookieAuthenticationOptions options)
    {
        if (string.Equals(name, "Cookies", StringComparison.Ordinal))
            options.SessionStore = _store;
    }
}
```

`AddOptions` makes type, name, stage, and DI-aware generic overloads explicit in one fluent chain. Named `services.Configure<T>(name, ...)` and post-configure overloads remain valid alternatives.

## Authentication schemes are named options

For cookie authentication, scheme name is options name. `AddCookie("Cookies", ...)` and later `AddOptions<CookieAuthenticationOptions>("Cookies")...` contribute to the same named pipeline. The handler reads it through:

```csharp
IOptionsMonitor<CookieAuthenticationOptions>.Get("Cookies")
```

The same options infrastructure also configures JWT bearer, authorization, CORS, MVC, Kestrel, forwarded headers, HTTP, antiforgery, session, JSON, and application-defined options.

A server-side cookie `ITicketStore` still requires stored-ticket expiry to align with cookie/sliding-expiration behavior and requires a persistent Data Protection key ring across restarts and instances.

## What should be recallable

- In which order does `IOptionsFactory` configure, post-configure, and validate?
- Why do several registrations mutate one named instance rather than replace it?
- When should normal, named, and post configuration be used?
- Which two patterns support dependency injection during configuration?
- Why is building a second service provider unsafe?
- Why does the cookie scheme name also select its options instance?
- Which cookie-ticket concerns remain after assigning `SessionStore`?

## Sources

- Workspace: `_ai-conspects/options pattern/`
- Authoritative processed sources: configuration-order claims from `regions/OPT03-named-options-snapshot-configure-postconfigure.md`; complete `regions/OPT05-di-aware-options-postconfigure-cookie-auth.md`; and complete `regions/OPT06-options-configuration-interfaces-and-names.md`
- Original SVG: `source/options pattern.svg`

