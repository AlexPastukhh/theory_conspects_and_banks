# Async callback hooks versus classic C# events

Knowledge ID: `dotnet.async-callbacks-vs-events`

Topic: `dotnet`

## The async-void event hazard

Classic `EventHandler<T>` returns `void`. An async lambda attached to it therefore becomes `async void`:

```csharp
publisher.Changed += async (_, args) =>
{
    await SaveAsync(args);
};
```

The publisher cannot await the handler, cannot know when it completes, and cannot reliably catch exceptions thrown after an `await`. A `try/catch` around `Changed?.Invoke(...)` covers only synchronous execution before the handler yields.

## Awaitable callback injection

When sequencing and failure control matter, expose an awaitable callback shape:

```text
Func<Task>
Func<T, Task>
Func<TContext, Task>
```

```csharp
public async Task SaveAsync(
    Func<Task>? beforeSave = null,
    Func<Task>? afterSave = null)
{
    if (beforeSave is not null)
        await beforeSave();

    await PersistAsync();

    if (afterSave is not null)
        await afterSave();
}
```

This is controlled callback injection, not the C# event system. It fits customization of defined steps in one operation while the operation retains order and exception ownership.

## ASP.NET Core objects named `Events`

Authentication components often expose an `Events` property whose members are callback properties such as `Func<TokenValidatedContext, Task>`, not members declared with the `event` keyword. The pipeline invokes and awaits callbacks such as `OnTokenValidated`, `OnMessageReceived`, and `OnAuthenticationFailed`.

A token-validation callback can therefore resolve a database context, await a user lookup, and fail the authentication context if the user no longer exists; its completion and failure remain part of the authentication pipeline.

The essential distinction is:

```text
classic event -> multicast void notification, async handler becomes async void
awaitable hook -> Func<..., Task> callback controlled and awaited by the caller
```

## What should be recallable

- Why async handlers attached to classic events become `async void` and escape normal awaiting/error control.
- Why a raiser's surrounding `try/catch` cannot cover failures after the first await.
- How `Func<..., Task>` hooks preserve sequencing and exception ownership.
- Why ASP.NET Core authentication `Events` objects are awaitable callback collections rather than C# events.

## Sources

- Workspace: `_ai-conspects/events,delegaates,action/`
- Processed source: `01-final-transcript.md`, R04
- Original SVG: `source/events,delegaates,action.svg`
- Workspace: `_ai-conspects/events-delegaates-action/`
- Authoritative processed sources: `10-full-source-preserving-transcript-v003.md`, S-015, S-017–S-018, S-020, S-023, S-027–S-029, S-034, S-036–S-038, S-041–S-043; `11-technical-corrections-v002.md`, correction 6
- Original SVG: `source/events,delegaates,action.svg`, SHA-256 `58fe05fdd4d608c36102140c4a25a6f8975bc5d914825d20ebc1aea90364778e`
