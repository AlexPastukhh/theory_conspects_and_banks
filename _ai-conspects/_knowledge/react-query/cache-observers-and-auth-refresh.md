# React Query cache observers and auth refresh

Knowledge ID: `react-query.cache-observers-and-auth-refresh`

Topic: `react-query`

`QueryClient` owns the cache. `setQueryData` notifies observers of that query, but components that never observe its key do not rerender. `getQueryData` is an imperative snapshot read: it creates no subscription and cannot rerender ordinary TypeScript code.

Export exactly one client and key, and pass that same instance to `QueryClientProvider` and non-React helpers. A second client creates an independent cache.

```ts
export const queryClient = new QueryClient();
export const TOKEN_KEY = ["auth", "token"] as const;

export const getAccessToken = () =>
  queryClient.getQueryData<string | null>(TOKEN_KEY) ?? null;

export const setAccessToken = (token: string | null) =>
  queryClient.setQueryData(TOKEN_KEY, token);
```

A hook observing the same key rerenders when its selected result changes; a root observer can switch login/product branches. Hooks are not required for cache access in ordinary modules.

Deduplicate simultaneous refreshes with one module-level promise, store the fresh token, and reset the promise in `finally`:

```ts
let refreshPromise: Promise<string> | null = null;

async function refreshAccessToken() {
  if (refreshPromise) return refreshPromise;

  refreshPromise = fetch("/api/auth/refresh", {
    method: "POST",
    credentials: "include",
  })
    .then(async response => {
      if (!response.ok) throw new Error("Refresh failed");
      const { accessToken } = await response.json();
      setAccessToken(accessToken);
      return accessToken;
    })
    .catch(error => {
      setAccessToken(null);
      throw error;
    })
    .finally(() => {
      refreshPromise = null;
    });

  return refreshPromise;
}
```

The fetch wrapper snapshots the current token, sets `Authorization`, preserves credentials, and refreshes only after 401. It then replaces the header with the fresh token and retries the original request once. Persistent 401s must not loop. If refresh fails, clear the cached access token so observers/UI do not retain stale authenticated state. The captured `fetchWithAuth` contract returns the original `401` response after that cleanup; another wrapper may deliberately reject instead, but callers and UI must know which policy it implements.

On logout, clear token state and remove/invalidate identity-owned queries. `queryClient.clear()` is optional and may be too broad. React Query can technically store an access token but is primarily a server-state cache; HttpOnly secure cookies or a dedicated auth store may provide clearer boundaries. Do not persist sensitive tokens to local storage without security review.

## Sources
- Workspace: `_ai-conspects/react query rerenders + setting and getting data from cache outside of react/`
- Processed source: `01-final-transcript.md`, complete transcript
- Workspace: `_ai-conspects/jwt auth/`
- Authoritative processed source: `01-final-transcript.md`, R01 and R03 (singleton QueryClient, imperative token cache, single-flight refresh and one-retry fetch flow)
- Original SVG: `source/jwt auth.svg`
