# ASP.NET Core options binding, names, and access lifetimes

Knowledge ID: `aspnet-core.options-binding-names-and-access-lifetimes`

Topic: `aspnet-core`

The options pattern maps configuration into explicit CLR shapes instead of scattering string keys and conversions across consumers. A section-name constant keeps binding call sites aligned:

```csharp
public sealed class LoggingOptions
{
    public const string SectionName = "Logging";
    public LogLevelOptions? LogLevel { get; set; }
}

public sealed class LogLevelOptions : Dictionary<string, LogLevel>
{
    public LogLevelOptions()
        : base(StringComparer.OrdinalIgnoreCase) { }
}

builder.Services.AddOptions<LoggingOptions>()
    .Bind(builder.Configuration.GetSection(LoggingOptions.SectionName));
```

The options class expresses the expected shape; the binder maps section values into it. Dictionary-like options can choose their own comparer and behavior just like other CLR types.

## Several instances of one type

Named options let one type represent sibling configuration contracts:

```csharp
public sealed class FeatureOptions
{
    public bool Enabled { get; set; }
    public string? Name { get; set; }
    public Version? Version { get; set; }
    public Uri? Endpoint { get; set; }
    public string? ApiKey { get; set; }
    public string[] Tags { get; set; } = Array.Empty<string>();
}
```

```csharp
builder.Services.AddOptions<FeatureOptions>("TodoApi")
    .Bind(builder.Configuration.GetSection("Features:TodoApi"));

builder.Services.AddOptions<FeatureOptions>("WeatherStation")
    .Bind(builder.Configuration.GetSection("Features:WeatherStation"));
```

```json
{
  "Features": {
    "TodoApi": {
      "Enabled": true,
      "Name": "TODOS API",
      "Version": "0.4.20",
      "Endpoint": "https://jsonplaceholder.typicode.com/todos",
      "ApiKey": "...",
      "Tags": ["self-improvement", "organization"]
    },
    "WeatherStation": { }
  }
}
```

`IOptionsSnapshot<T>` and `IOptionsMonitor<T>` retrieve a named instance through `Get(name)`. Plain `IOptions<T>.Value` exposes the default unnamed instance.

```csharp
app.MapGet("/features",
    (IOptionsSnapshot<FeatureOptions> options) => Results.Json(new
    {
        TodoApi = options.Get("TodoApi"),
        WeatherStation = options.Get("WeatherStation"),
    }));
```

## Choose the access model by lifetime

The underlying DI reminder is: transient services are created for each resolution, scoped services once per scope as needed, and singleton services once for the application lifetime. Options access interfaces deliberately align with different parts of that lifetime model:

```text
IOptions<T>
    singleton/static view
    value created lazily and then reused
    runtime configuration reload does not replace Value

IOptionsSnapshot<T>
    scoped view
    recomputed for each new scope/request
    stable within that request
    next request can observe a reload

IOptionsMonitor<T>
    singleton/live view
    CurrentValue can change
    supports named Get(name) and OnChange notification
```

Use a snapshot when transient/scoped request work needs refreshed values between requests without mid-request changes. Use a monitor when singleton/background work must see live values or react immediately. Use plain options when configuration is effectively static for the process lifetime.

## Strict binder behavior

Binder options can turn a typo into an early failure instead of silently leaving a property null:

```csharp
builder.Services.Configure<FeatureOptions>(
    name: "WeatherStation",
    config: builder.Configuration.GetSection("Features:WeatherStation"),
    configureBinder: binder =>
    {
        binder.BindNonPublicProperties = false;
        binder.ErrorOnUnknownConfiguration = true;
    });
```

`ErrorOnUnknownConfiguration` catches an unknown key such as `Endpont`. Keeping `BindNonPublicProperties` false preserves non-public setter/property encapsulation.

## Related knowledge

- `aspnet-core.options-validation-and-startup-failure`
- `aspnet-core.options-configuration-pipeline-and-di`
- `aspnet-core.options-monitor-reload-and-background-services`

## What should be recallable

- Why put the section name beside the options class?
- How can one options type represent `TodoApi` and `WeatherStation` separately?
- Which interfaces can retrieve a named instance?
- Which values are static, per-scope, or live?
- Why is a snapshot stable within one request?
- Which binder setting exposes misspelled configuration keys?

## Sources

- Workspace: `_ai-conspects/options pattern/`
- Authoritative processed sources: `regions/OPT02-options-pattern-basics-binding.md`, complete region; `regions/OPT03-named-options-snapshot-configure-postconfigure.md`, access-lifetime, named and binder sections; and named-access boundaries from `regions/OPT06-options-configuration-interfaces-and-names.md`
- Original SVG: `source/options pattern.svg`
