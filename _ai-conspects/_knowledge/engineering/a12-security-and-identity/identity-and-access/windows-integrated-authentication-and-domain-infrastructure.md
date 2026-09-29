# Windows integrated authentication and domain infrastructure

Knowledge ID: `security.windows-integrated-authentication-and-domain-infrastructure`

Topic: `security`

Windows Authentication lets an internal application trust a Windows/domain identity already established through the OS, browser, server, and domain handshake instead of collecting an application-specific password.

```text
domain user signs into Windows
-> browser requests protected intranet resource
-> server challenges with WWW-Authenticate: Negotiate
-> browser sends a Windows authentication token
-> SSPI/domain infrastructure validates it
-> application receives an authenticated Windows principal
```

Active Directory owns domain users/computers, groups, Kerberos key distribution, and central identity policy. The application does not own the password database. This model naturally fits domain-managed intranet portals, admin tools, corporate dashboards, and line-of-business applications where AD groups map to authorization.

## Negotiate, Kerberos, and NTLM

```text
Windows Authentication -> application/server authentication mode
Negotiate              -> HTTP scheme that can choose a Windows protocol
Kerberos / NTLM         -> underlying authentication protocols
```

Kerberos is normally preferred in a domain because it is ticket-based and supports stronger delegation scenarios. NTLM is older and may appear as fallback when Kerberos cannot work because of SPN, identity, domain, or configuration constraints.

Authentication establishes who the caller is; authorization still decides what that identity may do. AD group data can support roles/policies, but group information may appear as SIDs or claims depending on hosting/platform configuration. Inspect identity name, authentication type, claim types, role-claim type, group membership, and policy requirements separately.

This is a poor default for a public internet application: external/non-domain users, mobile and non-domain clients, browser/platform variation, proxies/firewalls, and Kerberos assumptions make app login, cookies, OAuth/OIDC, or an external identity provider more suitable.

## Kerberos deployment and SPNs

Production behavior depends on domain membership, browser intranet/trusted settings, IIS authentication, app-pool/service identity, SPN registration, DNS names, proxy/load balancer behavior, and authorization policy. Local IIS Express success proves only basic app wiring.

Conceptually:

```text
client requests a ticket for HTTP/app.company.local
-> domain controller resolves that service principal name (SPN)
-> ticket is encrypted for the registered service account
-> server/app-pool identity must be able to validate it
```

Kerberos can fail or fall back to NTLM when an SPN is missing, duplicated, on the wrong account, absent for a DNS/load-balanced alias, or inconsistent with the app-pool identity. IIS may run as `ApplicationPoolIdentity`, `NetworkService`, a domain service account, or gMSA; real Kerberos deployments may need a managed domain identity so SPNs are registered and maintained correctly.

## Diagnose the actual identity path

Repeated `401` responses or credential prompts can originate in the browser, domain, IIS, SPN, proxy, or application policy. Check:

```text
Windows Authentication and Anonymous settings
client/server domain membership and browser intranet zone
automatic credential sending
hostname, DNS alias, and HTTP SPN
app-pool/service identity
Kerberos versus NTLM fallback
proxy/load-balancer auth-header behavior
endpoint policy/group requirements
```

A protected temporary `whoami` endpoint can report the identity name, authentication type, authenticated flag, selected scheme, and safe claim-type/count information. Do not expose raw tokens, sensitive headers, full group lists, service-account details, or internal topology in a public diagnostic response.

## What should be recallable

- Which systems participate between domain login and `HttpContext.User`?
- How do Windows Authentication, Negotiate, Kerberos, and NTLM relate?
- Why is this model natural for intranets but weak as a public-app default?
- What is an SPN's role in Kerberos ticket validation?
- Which SPN/service-identity mistakes cause fallback or prompts?
- What should a safe `whoami` diagnostic prove without leaking secrets?

## Related knowledge

- `aspnet-core.windows-authentication-negotiate-hosting` — application and IIS/Kestrel wiring.
- `aspnet-core.authentication-schemes-oidc-events-and-tickets` — deliberate selection when Windows and app-managed schemes coexist.

## Sources

- Workspace: `_ai-conspects/windows-auth/`
- Authoritative processed sources: `regions/R01-core-windows-auth-model-ad-kerberos-ntlm.md` and `regions/R04-company-domain-deployment-spn-troubleshooting.md`
- Original SVG: `source/windows-auth.svg`
