# ASP.NET Core options validation and startup failure

Knowledge ID: `aspnet-core.options-validation-and-startup-failure`

Topic: `aspnet-core`

Binding establishes an options object's shape; validation establishes whether the resulting values form an acceptable application configuration.

## Attribute and predicate validation

```csharp
public sealed class WeatherOptions
{
    [Required]
    public Uri Endpoint { get; set; } = default!;

    [Range(1, 30)]
    public int TimeoutSeconds { get; set; } = 5;

    [Required]
    public string ApiKey { get; set; } = default!;
}

builder.Services.AddOptions<WeatherOptions>()
    .Bind(builder.Configuration.GetSection("Features:WeatherStation"))
    .ValidateDataAnnotations()
    .ValidateOnStart();
```

DataAnnotations fit required values and local range/format rules. Predicate validators express cross-field or application rules that do not fit an attribute:

```csharp
builder.Services.AddOptions<WeatherOptions>()
    .Bind(builder.Configuration.GetSection("Features:WeatherStation"))
    .Validate(o => o.Endpoint.Scheme == Uri.UriSchemeHttps,
        "Endpoint must be HTTPS")
    .Validate(o => !string.IsNullOrWhiteSpace(o.ApiKey),
        "ApiKey is required")
    .ValidateOnStart();
```

An `Enabled` feature requiring an API key is another predicate-style rule.

## First use versus startup

Without `ValidateOnStart`, validation occurs when code first requests `IOptions<T>.Value`, `IOptionsSnapshot<T>.Value`, or `IOptionsMonitor<T>.CurrentValue`. The host may start and fail only when the first request or service touches the invalid configuration.

`ValidateOnStart` moves failure to host startup. Use it for configuration whose absence makes the process unable to operate safely, such as database connections, required API endpoints, authentication keys, or a background service's thresholds.

Each named instance has its own binding and validation pipeline, so validate every required name:

```csharp
builder.Services.AddOptions<FeatureOptions>("WeatherStation")
    .Bind(builder.Configuration.GetSection("Features:WeatherStation"))
    .ValidateDataAnnotations()
    .ValidateOnStart();

builder.Services.AddOptions<FeatureOptions>("TodoApi")
    .Bind(builder.Configuration.GetSection("Features:TodoApi"))
    .Validate(o => o.Endpoint is not null, "Endpoint required")
    .ValidateOnStart();
```

## Source-generated validation

`[OptionsValidator]` on a partial validator type can generate an `IValidateOptions<T>` implementation at compile time rather than relying on reflection-heavy runtime validation:

```csharp
[OptionsValidator]
public sealed partial class ValidateWeatherOptions
    : IValidateOptions<WeatherOptions>
{
}
```

This is primarily useful when performance, trimming, or AOT requirements justify it.

The sensor-station example applies the same model to a required dictionary of named sensors, a `PollingInterval` constrained by a `TimeSpan` range and `HH:mm:ss` regular-expression/format rule, and required low/high thresholds with allowed ranges. That prevents the long-running loop from starting with unusable timing or alert bounds.

## What should be recallable

- What does binding guarantee, and what does validation add?
- When are options validated without `ValidateOnStart`?
- Why can delayed validation fail far after a successful startup?
- Which rules fit attributes and which fit predicates?
- Why must named instances be validated independently?
- When is source-generated validation worth its extra setup?
- Why validate a hosted service's polling interval and thresholds before its loop starts?

## Sources

- Workspace: `_ai-conspects/options pattern/`
- Authoritative processed sources: `regions/OPT01-options-validation.md`, complete region, plus validation and sensor-model claims from `regions/OPT04-optionsmonitor-onchange-background-service.md` and `regions/OPT07-optionsmonitor-sensor-station-validation-reload.md`
- Original SVG: `source/options pattern.svg`
