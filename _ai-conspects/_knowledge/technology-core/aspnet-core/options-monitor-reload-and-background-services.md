# ASP.NET Core options monitoring, reload, and background services

Knowledge ID: `aspnet-core.options-monitor-reload-and-background-services`

Topic: `aspnet-core`

`IOptionsMonitor<T>` is the live singleton options view for long-running singleton or `BackgroundService` code. A worker can read `CurrentValue` on every cycle or cache a local reference and replace it from `OnChange` when rebuilding dependent state.

`OnChange` returns an `IDisposable`. Store and dispose that subscription when the service stops.

## Integrated sensor-monitor example

The source example registers a case-insensitive `SensorFactory`, a hosted monitor, and startup-validated station options. The factory reuses an `ISensorService` by station name; its fake implementation changes the current temperature by a small random amount on each read.

```csharp
builder.Services.AddSingleton<SensorFactory>();
builder.Services.AddHostedService<SensorMonitorService>();

builder.Services
    .AddOptionsWithValidateOnStart<SensorStationOptions>()
    .BindConfiguration(
        SensorStationOptions.SensorStationOptionsSectionName)
    .ValidateDataAnnotations();
```

The worker owns the monitor and subscription:

```csharp
internal sealed class SensorMonitorService : BackgroundService
{
    private readonly SensorFactory _sensorFactory;
    private readonly IOptionsMonitor<SensorStationOptions> _options;
    private readonly ILogger<SensorMonitorService> _logger;
    private readonly IDisposable? _onChangeSubscription;

    public SensorMonitorService(
        SensorFactory sensorFactory,
        IOptionsMonitor<SensorStationOptions> options,
        ILogger<SensorMonitorService> logger)
    {
        _sensorFactory = sensorFactory;
        _options = options;
        _logger = logger;
        _onChangeSubscription = options.OnChange(OnOptionsChanged);
    }

    public override void Dispose()
    {
        _onChangeSubscription?.Dispose();
        base.Dispose();
    }
}
```

Its loop reads one coherent current options reference for each cycle, checks each sensor against low/high thresholds, logs a normal reading or alert, and delays by the current polling interval:

```csharp
protected override async Task ExecuteAsync(
    CancellationToken stoppingToken)
{
    while (!stoppingToken.IsCancellationRequested)
    {
        var options = _options.CurrentValue;

        foreach (var (sensor, thresholds) in options.Sensors)
        {
            var service = _sensorFactory.Create(sensor);
            var temperature = service.ReadTemperature();
            AlertSensorReadings(sensor, temperature, thresholds);
        }

        await Task.Delay(options.PollingInterval, stoppingToken);
    }
}
```

Reading `CurrentValue` inside the loop lets changed thresholds and polling intervals apply between cycles. An immediate callback can log the new object or rebuild a cache/client. Copying the value into a field is optional and useful only when a stable local reference or rebuild step is desired.

## Reload is provider-dependent

The live sequence is:

```text
reload-capable configuration provider detects change
-> options section is rebound
-> CurrentValue is replaced
-> OnChange callbacks run
```

JSON, key-per-file, and other reload-capable providers can notify. File shares, containers, and some hosting environments may not deliver reliable file-system notifications. A polling watcher such as `DOTNET_USE_POLLING_FILE_WATCHER=true` may be required. `IOptionsMonitor` cannot create reload events that the underlying provider never reports.

## Related knowledge

- `aspnet-core.options-binding-names-and-access-lifetimes`
- `aspnet-core.options-validation-and-startup-failure`

## What should be recallable

- Why can a singleton worker use `IOptionsMonitor` but not a scoped snapshot as its live dependency?
- What two strategies consume changing monitor values?
- Why must the `OnChange` subscription be disposed?
- Why read one `CurrentValue` per work cycle?
- Which changes happen between provider notification and callback execution?
- Why can reload fail to appear on a file share or in a container?
- What does the polling-file-watcher setting address?

## Sources

- Workspace: `_ai-conspects/options pattern/`
- Authoritative processed sources: monitor/lifetime claims from `regions/OPT03-named-options-snapshot-configure-postconfigure.md`; complete `regions/OPT04-optionsmonitor-onchange-background-service.md`; and runtime/reload claims from `regions/OPT07-optionsmonitor-sensor-station-validation-reload.md`
- Original SVG: `source/options pattern.svg`
