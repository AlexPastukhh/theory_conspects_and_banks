# ASP.NET Core antiforgery token lifecycle

Knowledge ID: `aspnet-core.antiforgery-token-lifecycle`

Topic: `aspnet-core`

CSRF exploits automatic auth-cookie attachment. ASP.NET Core validates linked cookie/request tokens plus user/context data; failure is normally 400. Razor emits `__RequestVerificationToken`; `[ValidateAntiForgeryToken]` validates actions, and global `AutoValidateAntiforgeryToken` covers unsafe methods while skipping safe methods.

SPAs can obtain a same-origin request token through `IAntiforgery.GetAndStoreTokens`, expose it through an application-defined readable cookie or JSON response, and send it using the configured header:

```csharp
var tokens = antiforgery.GetAndStoreTokens(context);
context.Response.Cookies.Append(
    "XSRF-TOKEN",
    tokens.RequestToken!,
    new CookieOptions {
        HttpOnly = false,
        Secure = true,
        SameSite = SameSiteMode.Strict
    });
```

```js
await fetch("/Products/EditAjax", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
    "RequestVerificationToken": token
  },
  body: JSON.stringify(model)
});
```

Refresh after login/logout/session changes. Cross-tab failure has a concrete sequence:

```text
Tab A renders cookie C1 + request token R1
Tab B changes authentication/session state
the shared browser cookie becomes C2
Tab A submits stale R1 with C2
C2 + R1 fail pair validation
```

The cookie token and request token are related but not interchangeable. Sending the cookie token itself as the header value is not the intended protocol. The header alone also does not prove a trusted origin: the defense relies on an attacker being unable to read the trusted origin's request token while the browser supplies the paired cookie automatically.

For an SPA, cache the returned request token in process memory or a non-persisted query store and fetch it with `credentials: "include"`. Persistent `localStorage`/`sessionStorage` increases its exposure under XSS. Unsafe requests send the configured header while the browser sends both auth and antiforgery cookies.

Recognize the antiforgery response, refetch once, and retry at most once; never create an implicit endless retry loop.

Do not expose token endpoints through broad credentialed CORS. SameSite and Origin/Referer are defense in depth. Manual resource-filter validation can return stable Problem Details; result filters can mark built-in failures. Exception filters do not normally catch earlier authorization-filter failures. Use `[IgnoreAntiforgeryToken]` deliberately and avoid duplicate global validation.

## Global validation and always-run result rewriting

`AutoValidateAntiforgeryTokenAttribute` is suitable for global MVC registration and skips safe methods such as GET, HEAD, OPTIONS, and TRACE. A selected action can opt out with `[IgnoreAntiforgeryToken]`.

Built-in validation can short-circuit to `AntiforgeryValidationFailedResult`. An `IAsyncAlwaysRunResultFilter` can replace that result with an SPA-friendly Problem Details response even though an earlier stage produced it:

```csharp
public async Task OnResultExecutionAsync(
    ResultExecutingContext context,
    ResultExecutionDelegate next)
{
    if (context.Result is AntiforgeryValidationFailedResult)
    {
        context.Result = new ObjectResult(new ProblemDetails
        {
            Title = "Antiforgery validation failed",
            Detail = "The CSRF token is missing, expired, or invalid.",
            Status = StatusCodes.Status400BadRequest,
            Type = "https://example.com/problems/antiforgery-failed"
        }) { StatusCode = StatusCodes.Status400BadRequest };
    }

    await next();
}
```

Always-run variants exist only for result filters (`IAlwaysRunResultFilter` and `IAsyncAlwaysRunResultFilter`), not for arbitrary authorization or action filters.

## Sources
- Workspace: `_ai-conspects/antiforgerytoken/`
- Processed source: `02-corrected-semantic-transcript-v002.md`, complete corrected transcript
- Workspace: `_ai-conspects/cookie auth, antiforgery/`
- Authoritative processed source: `regions/R03-spa-antiforgery-and-cookie-policy.md`
- Original SVG: `source/cookie auth, antiforgery.svg`
- Workspace: `_ai-conspects/filters/`
- Authoritative processed sources: `regions/R02R03-concrete-examples-lower-addendum-final.md`, S-097, S-099-S-100, S-102, S-105, S-107; `FINAL_TRANSCRIPT.md`, section 11; and matching native text in `NATIVE_CANVAS_TEXT.md`
- Original SVG: `source/filters.svg`
