# Authorization middleware, policy evaluator, and result-handler flow

Knowledge ID: `aspnet-core.authorization-middleware-policy-evaluator-and-result-handler`

Topic: `aspnet-core`

ASP.NET Core authorization is a framework pipeline: routing selects the endpoint, authentication prepares the principal, and authorization evaluates whether that principal satisfies the endpoint policy. The key runtime pieces are not just attributes and handlers; they are the middleware, the policy provider, the evaluator, and the final result handler that decides how challenge and forbid states become HTTP responses.

```csharp
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.MapControllers();
```

The `UseAuthorization()` call installs `AuthorizationMiddleware`, which reads endpoint metadata, resolves the effective policy, authenticates the required schemes, and then asks the evaluator to decide whether the current user is allowed through.

## `AuthorizationOptions` and policy lookup

`AuthorizationOptions` is the central configuration object for default behavior and named policies:

```csharp
builder.Services.AddAuthorization(options =>
{
    options.DefaultPolicy = new AuthorizationPolicyBuilder()
        .RequireAuthenticatedUser()
        .Build();

    options.FallbackPolicy = new AuthorizationPolicyBuilder()
        .RequireAuthenticatedUser()
        .Build();

    options.InvokeHandlersAfterFailure = true;

    options.AddPolicy("AdminOnly", policy =>
    {
        policy.RequireRole("Admin");
    });
});
```

Important distinctions:

```text
DefaultPolicy
    used when authorization is explicitly requested but no policy name is given

FallbackPolicy
    applies when an endpoint has no authorization requirement at all

InvokeHandlersAfterFailure
    controls whether later handlers still run after Fail()
```

`DefaultPolicy` and `FallbackPolicy` are not the same thing. One is the normal default for explicit authorization checks; the other is a safety net for otherwise unprotected endpoints.

## Endpoint metadata and effective policy

The middleware combines several pieces of endpoint metadata into one policy:

```csharp
[Authorize]
[Authorize(Roles = "Admin")]
[Authorize(Policy = "CanEditOrders")]
```

It also reads direct policy metadata and custom requirement metadata:

```csharp
var policy = new AuthorizationPolicyBuilder()
    .RequireAuthenticatedUser()
    .RequireRole("Admin")
    .Build();

app.MapGet("/admin", () => "admin")
   .RequireAuthorization(policy);
```

Custom requirement metadata participates in the same pipeline through `IAuthorizationRequirementData`:

```csharp
public sealed class MinimumAgeAttribute(int age)
    : Attribute, IAuthorizationRequirementData
{
    public IEnumerable<IAuthorizationRequirement>
        GetRequirements()
    {
        yield return new MinimumAgeRequirement(age);
    }
}
```

The framework treats all of these as inputs that are merged into the effective authorization policy. This is why endpoint conventions, attributes, and custom metadata all feed the same authorization engine.

## `AuthorizationMiddleware` and `PolicyEvaluator`

The middleware follows a fixed sequence:

```text
1. identify the selected endpoint
2. build or retrieve the effective policy
3. if no policy applies, continue without blocking
4. authenticate required schemes
5. choose the authorization resource
6. ask the policy evaluator to authorize
```

Conceptually:

```csharp
var endpoint = context.GetEndpoint();
var policy = await policyProvider.GetPolicyAsync("...");

var authenticateResult =
    await policyEvaluator.AuthenticateAsync(policy, context);

var authorizeResult =
    await policyEvaluator.AuthorizeAsync(
        policy,
        authenticateResult,
        context,
        resource);
```

The middleware passes the selected resource, commonly the `HttpContext` itself, into the authorization decision. Custom handlers often need to inspect the exact resource or entity being accessed.

`AllowAnonymous` is an important exception: it does not mean "skip authentication forever." It means "skip the authorization block for this endpoint" and continue to the next middleware. The endpoint can still benefit from authentication if it wants to or if other middleware requires it.

## `AuthorizationHandlerContext` and requirement lifecycle

The default `AuthorizationService` creates an `AuthorizationHandlerContext`, resolves registered `IAuthorizationHandler` services, and runs them against the current requirements.

```csharp
var authContext =
    contextFactory.CreateContext(
        requirements,
        user,
        resource);

foreach (var handler in handlers)
{
    await handler.HandleAsync(authContext);

    if (!options.InvokeHandlersAfterFailure &&
        authContext.HasFailed)
    {
        break;
    }
}
```

Handlers succeed requirements with `context.Succeed(requirement)` and can explicitly veto with `context.Fail()`. A policy is only successful when no explicit failure remains and all requirements have been satisfied.

One subtle but important detail is that different requirements can be satisfied by different handlers, while the overall policy is still AND across requirements. A single requirement may be satisfied by multiple handlers as alternatives, but the policy still demands an overall success for each requirement.

`PendingRequirements` is the live set of unresolved requirements. If code iterates it, the collection may change during the loop as handlers call `Succeed(requirement)`, so `.ToList()` is a common and correct snapshot.

## `PolicyAuthorizationResult` and challenge vs forbid

The evaluator converts authorization into a result state:

```text
Succeeded
Challenged
Forbidden
```

This distinction matters:

```text
challenge
    client is not authenticated enough yet

forbid
    client is authenticated but not permitted
```

That is why a policy may reach different HTTP outcomes depending on whether the principal was authenticated at all. `Challenge` usually triggers a login or 401-style response, while `Forbid` usually yields 403 semantics.

The default `AuthorizationMiddlewareResultHandler` maps these states to authentication schemes and their behavior:

```csharp
if (authorizeResult.Succeeded)
{
    await next(context);
    return;
}

if (authorizeResult.Challenged)
{
    await context.ChallengeAsync();
    return;
}

if (authorizeResult.Forbidden)
{
    await context.ForbidAsync();
    return;
}
```

## Custom result handlers and safe override logic

Custom `IAuthorizationMiddlewareResultHandler` implementations exist because an application often needs different behavior for API requests versus browser requests, or a custom JSON error contract instead of the default challenge/forbid pipeline.

```csharp
public interface IAuthorizationMiddlewareResultHandler
{
    Task HandleAsync(
        RequestDelegate next,
        HttpContext context,
        AuthorizationPolicy policy,
        PolicyAuthorizationResult authorizeResult);
}
```

The key rule is: override only the cases your app owns, and delegate everything else to the default handler. Otherwise you can bypass scheme-specific `WWW-Authenticate` headers, cookie redirects, or OIDC flows and produce the wrong semantics.

Example behavior:

```csharp
if (authorizeResult.Forbidden && IsApiRequest(context))
{
    context.Response.StatusCode = StatusCodes.Status403Forbidden;
    context.Response.ContentType = "application/json";
    await context.Response.WriteAsJsonAsync(new
    {
        error = "forbidden",
        message = "You do not have permission to access this resource."
    });
    return;
}

await _defaultHandler.HandleAsync(
    next,
    context,
    policy,
    authorizeResult);
```

This keeps the custom API response while preserving default login and scheme behavior for browser flows.

## What should be recallable

- The role of `AuthorizationMiddleware` in reading endpoint metadata and selecting the effective policy.
- The difference between `DefaultPolicy`, `FallbackPolicy`, and `RequireAuthorization`.
- Why `AllowAnonymous` skips authorization, not necessarily authentication.
- How `PolicyEvaluator` authenticates policy schemes and then authorizes the selected resource.
- Why challenge and forbid are separate states and what each one implies.
- How `Fail()` and `Succeed(requirement)` interact with `PendingRequirements` and `InvokeHandlersAfterFailure`.
- Why custom `IAuthorizationMiddlewareResultHandler` implementations must delegate unknown cases to the default framework result handler.

## Related knowledge

- `aspnet-core.authorization-policy-requirements-and-pending-lifecycle`
- `aspnet-core.authentication-schemes-oidc-events-and-tickets`
- `aspnet-core.cookie-auth-api-challenge-responses`

## Sources

- Workspace: `_ai-conspects/authorization-flow-autorization-options-framework-authorizationmiddlewareresulthandler/`
- Authoritative processed source: `01-final-transcript.md`
- Current source-of-truth ledger: `CURRENT_SOURCE_OF_TRUTH.md`
- Original SVG: `source/authorization flow,autorization options, framework, authorizationmiddlewareresulthandler(2).svg`
