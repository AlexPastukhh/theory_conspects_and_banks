# Карта покрытия и приоритетов knowledge layer

Status: planning and audit artifact; not authority over knowledge-unit content

Snapshot date: 2026-09-03

Scope: `_ai-conspects/_knowledge/` for an ASP.NET Core + React + TypeScript + EF Core + SQL Server web-development track.

## 1. Назначение и границы достоверности

Эта карта отвечает на два разных вопроса:

1. какие области уже представлены самостоятельными knowledge units;
2. какие отсутствующие или фрагментарные области разумно закрывать следующими.

Она не заменяет аудит содержимого units. Название файла или количество файлов подтверждает наличие материала, но само по себе не доказывает полноту, техническую глубину или готовность разработчика определённого уровня.

Поэтому в документе не используются проценты покрытия без явного конечного checklist и знаменателя. Формулировки `100%`, `95%` и подобные считаются недоказуемыми, пока каждый пункт выбранного checklist не сопоставлен с конкретным evidence.

### Статусы покрытия

| Статус | Что он означает |
|---|---|
| **EVIDENCED** | Есть один или несколько units, центральная тема которых непосредственно покрывает область. |
| **PARTIAL** | Составные части встречаются в units, но нет цельной модели, обзорного guide или важной части lifecycle/trade-offs. |
| **NO DEDICATED UNIT** | В topic indexes нет unit с этой центральной темой. Это не означает, что термин нигде не упоминается. |
| **NOT AUDITED** | По metadata нельзя сделать надёжный вывод; требуется чтение bodies и provenance. |

### Глубина D1-D4

Это целевая редакторская шкала, а не автоматически вычисляемое свойство файла:

| Уровень | Требуемый результат |
|---|---|
| D1 | Объяснить модель, назначение и основные термины. |
| D2 | Самостоятельно применить модель в типовом сценарии и распознать обычные ошибки. |
| D3 | Объяснить lifecycle, failure modes, edge cases, производительность и trade-offs. |
| D4 | Проектировать решения, сравнивать альтернативы и защищать системные инварианты. |

Текущую глубину конкретного unit можно присвоить только после body-аудита по этому rubric. Количество units не является показателем глубины.

## 2. Источники baseline

Primary references:

- [Microsoft Learn: ASP.NET Core fundamentals](https://learn.microsoft.com/en-us/training/paths/aspnet-core-fundamentals/)
- [Microsoft Learn: ASP.NET Core documentation](https://learn.microsoft.com/en-us/aspnet/core/)
- [Microsoft Learn: EF Core documentation](https://learn.microsoft.com/en-us/ef/core/)
- [Microsoft Learn: SQL documentation](https://learn.microsoft.com/en-us/sql/)
- [MDN Curriculum](https://developer.mozilla.org/en-US/curriculum/)
- [MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web)
- [React documentation](https://react.dev/learn)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
- [OWASP ASVS](https://owasp.org/www-project-application-security-verification-standard/)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)

Supplementary discovery references:

- [roadmap.sh](https://roadmap.sh/) — community-maintained navigation aid, not normative authority.

Эти источники задают темы и требования, но не единую лестницу Trainee/Junior/Mid/Senior/Lead. Привязка к ролям и P0-P3 ниже является локальным planning decision и должна корректироваться под реальные задачи, риски и стек проекта.

## 3. Проверяемый inventory

На snapshot date:

- topic indexes: **19**;
- knowledge units / Knowledge IDs: **576**;
- уникальных Knowledge IDs: **576**;
- duplicate Knowledge IDs: **0**.

| Topic | Units |
|---|---:|
| algorithms | 2 |
| architecture | 14 |
| aspnet-core | 98 |
| axios | 6 |
| css | 13 |
| dotnet | 157 |
| ef-core | 61 |
| http | 30 |
| javascript | 52 |
| react | 25 |
| react-hook-form | 8 |
| react-query | 27 |
| redis | 5 |
| redux | 5 |
| security | 15 |
| sql | 1 |
| sql-server | 31 |
| testing | 4 |
| typescript | 22 |
| **Total** | **576** |

Recalculation rule:

```powershell
$ids = Get-ChildItem -LiteralPath '_ai-conspects/_knowledge' -Recurse -File -Filter '*.md' |
  Select-String -Pattern '^Knowledge ID: `([^`]+)`' -Encoding utf8 |
  ForEach-Object { $_.Matches[0].Groups[1].Value }

$ids.Count
($ids | Sort-Object -Unique).Count
$ids | Group-Object | Where-Object Count -gt 1
```

## 4. Coverage map

### 4.1 Backend, HTTP and architecture

| Area | Status | Repository evidence and boundary |
|---|---|---|
| Routing, endpoint matching and route design | EVIDENCED | Несколько `aspnet-core` units покрывают matching phases, precedence, constraints, parameters and nested routes. |
| Middleware and request pipeline | EVIDENCED | Есть ordering, short-circuiting, cancellation, exception handling and request/response lifecycle units. Единого beginner overview нет. |
| MVC filters and application model | EVIDENCED | Есть отдельные units по stages, order, activation, factories, exceptions, constraints and application models. |
| Model binding and validation | EVIDENCED | Представлены binding sources, ModelState, cross-property validation, JSON DOM, raw body and multipart boundaries. |
| DI and options | EVIDENCED | Есть DI scope/disposal и серия units по options binding, validation, monitoring and reload. Captive-dependency decision guide требует отдельной проверки/дополнения. |
| Error responses and Problem Details | EVIDENCED | Есть middleware lifecycle, status-code pages, writers, metadata and public error-contract units. |
| HTTP semantics | EVIDENCED | Представлены methods, conditional requests, caching headers, content negotiation, media types, HATEOAS, versioning, Problem Details, SSE and WebSocket. Richardson maturity model уже содержится в `http.rest-constraints-resource-and-method-semantics`. |
| Caching | EVIDENCED | Есть response/output cache, `IMemoryCache`, distributed cache and HybridCache mechanics. Не подтверждён единый cross-cache selection guide. |
| Rate limiting | PARTIAL | Есть ASP.NET middleware policy unit и Polly limiter unit; comprehensive strategy/operations guide не подтверждён. |
| Background services | PARTIAL | `aspnet-core.options-monitor-reload-and-background-services` содержит `AddHostedService`/`BackgroundService`; `dotnet.server-threadpool-async-io-and-background-work` покрывает ownership. Нет цельного guide по queues, retries, durability и Quartz/Hangfire selection. |
| OpenAPI | PARTIAL | OpenAPI/API Explorer concerns встречаются в нескольких ASP.NET units; dedicated generation, schema customization and versioning workflow не подтверждён. |
| Reverse proxy and edge TLS | EVIDENCED | Есть forward/reverse proxy roles, YARP routing, forwarded headers, TLS termination/isolation/offload. |
| Horizontal scaling and microservices | EVIDENCED | Есть resource saturation, shared-state scaling and microservice boundary/cost units. Это не заменяет DDD/CQRS/modular-monolith guidance. |
| Structured logging and observability | NO DEDICATED UNIT | Нужен самостоятельный logging + metrics + traces + correlation guide. |
| Health checks | NO DEDICATED UNIT | Нужны readiness/liveness/dependency checks and orchestration semantics. |
| gRPC | NO DEDICATED UNIT | Нужны protocol, streaming, deadlines and REST-selection boundaries. |
| SignalR | NO DEDICATED UNIT | Термин встречается, но центральный connection/hub/scale-out unit не подтверждён. |
| Native AOT and trimming | NO DEDICATED UNIT | Нужны compatibility, reflection and deployment boundaries. |
| DDD/Clean/Hexagonal/CQRS/Vertical Slices | PARTIAL | Есть отдельные architecture models, но систематический application-architecture track не подтверждён. |

### 4.2 Frontend

| Area | Status | Repository evidence and boundary |
|---|---|---|
| CSS positioning, flex, stacking, scroll and viewport | EVIDENCED | 13 CSS units покрывают несколько самостоятельных layout/lifecycle mechanics. |
| CSS Grid and responsive-system design | NO DEDICATED UNIT | Есть mobile viewport and responsive mentions, но нет центрального Grid/breakpoint/container-query guide. |
| Accessibility | PARTIAL | Accessibility реально присутствует в modal and SVG units; нет систематического track по semantic HTML, keyboard navigation, focus, forms and ARIA. |
| JavaScript async and browser runtime | EVIDENCED | Есть promises, tasks/microtasks/event loop, timers, generators, cancellation, workers and streams. |
| JavaScript language fundamentals | PARTIAL | Есть отдельные APIs и async mechanics; не подтверждён цельный track по scope/closures, `this`, prototypes, modules and iteration protocols. |
| TypeScript type system | EVIDENCED | 22 units дают существенное покрытие types, narrowing, generics, utilities and related models. |
| TypeScript/build configuration | PARTIAL | Module-resolution material существует фрагментарно; нет цельного `tsconfig`/declarations/build pipeline guide. |
| React rendering and effects | EVIDENCED | Есть render snapshots, effects, refs, context, reducers, transitions, Strict Mode and external stores. |
| React Router data router | EVIDENCED | Семь центральных units покрывают route tree, loaders/actions, revalidation, errors, fetchers, shared data and forms/history. Статус не означает покрытие каждой версии API. |
| React Query | EVIDENCED | 27 registered units покрывают cache/query/mutation/observer/network/persistence/testing mechanics. `100%` не заявляется без versioned checklist. |
| React Hook Form and Zod | EVIDENCED | Восемь RHF units плюс TypeScript/Zod units. End-to-end beginner progression отдельно не проверен. |
| Axios | EVIDENCED | Шесть units покрывают core request/config/interceptor/cancellation/type patterns. |
| State-management selection | PARTIAL | React Query, Zustand and Redux представлены; cross-library decision guide не подтверждён. |
| Browser APIs | PARTIAL | Есть Fetch, XHR, storage, postMessage, workers, files, streams, EventSource and WebSocket. PWA/Service Worker, WebRTC and graphics tracks не подтверждены. |
| Frontend testing | PARTIAL | Есть Vitest, Testing Library and router/query testing; dedicated E2E and visual-regression units отсутствуют. |
| React Server Components and React 19 actions | NO DEDICATED UNIT | Нужны versioned framework units, если они входят в целевой стек. |
| Build and delivery tooling | NO DEDICATED UNIT | Vite представлен только dev-proxy boundary; нет цельного bundling, code-splitting and bundle-analysis track. |

### 4.3 Data and persistence

| Area | Status | Repository evidence and boundary |
|---|---|---|
| EF Core querying, change tracking, transactions and modeling | EVIDENCED | 61 units дают широкое предметное покрытие; beginner mental model и production profiling должны оцениваться отдельно. |
| SQL Server indexes, query semantics and DML | EVIDENCED | 31 units включают indexes, SARGability, logical processing, windows, DML, transactions and concurrency. |
| SQL fundamentals | PARTIAL | Есть `sql.subquery-membership-and-existence` и advanced SQL Server units, но нет цельного beginner guide по joins, grouping, aggregates and null semantics. |
| Query-plan reading and optimization workflow | PARTIAL | Execution plans упоминаются в существующих units, но самостоятельный operator/cardinality/diagnostic workflow не подтверждён. |
| Database design | PARTIAL | Constraints, schemas and views представлены; normalization, ER modeling, temporal/soft-delete decision models не собраны в track. |
| Transaction and concurrency mechanics | EVIDENCED | Есть SQL/EF transactions, savepoints, retries, rowversion and MERGE boundaries. Distributed workflow не покрыт этим статусом. |
| Redis basics and stampede control | EVIDENCED | Пять Redis units плюс HybridCache/single-flight material. |
| Redis operations and distributed features | NO DEDICATED UNIT | Нет центральных units по persistence, Sentinel, Cluster, Streams and Pub/Sub. |
| Database security | PARTIAL | Logins/users/roles/permissions представлены; RLS, Always Encrypted and TDE units не подтверждены. |
| Multi-tenancy | NO DEDICATED UNIT | Нужен comparison shared-schema/schema-per-tenant/database-per-tenant. |
| Other database families | NO DEDICATED UNIT | Добавлять только при реальной необходимости стека; это не автоматический defect текущей SQL-oriented базы. |

### 4.4 Security

| Area | Status | Repository evidence and boundary |
|---|---|---|
| Authentication, authorization and token lifecycle | EVIDENCED | Cookie/JWT/OIDC, Identity, refresh rotation, signing-key rotation and authorization lifecycle представлены в нескольких topics. |
| XSS, sanitization, CSP and Trusted Types | EVIDENCED | Есть dedicated security units и browser-boundary material. |
| CORS and antiforgery | EVIDENCED | Есть отдельные ASP.NET and security units; это не доказательство полного ASVS coverage. |
| MFA/TOTP/recovery | EVIDENCED | Factor selection, trusted devices, recovery and TOTP enrollment/verification представлены. |
| Passkeys/WebAuthn | PARTIAL | Упомянуты как factor model, но registration/authentication/attestation lifecycle не раскрыт отдельным unit. |
| Browser isolation and cross-origin embedding | EVIDENCED | CORS, CSP, postMessage and embedding/side-channel boundaries представлены. |
| OWASP Top 10 / ASVS overview | NO DEDICATED UNIT | Отдельные risks покрыты, но нет единой versioned mapping table по OWASP categories/requirements. |
| Threat modeling | NO DEDICATED UNIT | Нужен asset/trust-boundary/threat/mitigation workflow; STRIDE может быть одной из моделей. |
| Cryptography for application developers | PARTIAL | Password hashing, randomness, JWT signing and TLS pieces существуют; нет цельной модели encryption/signatures/HMAC/KDF/key management. |
| Security headers | PARTIAL | Некоторые headers и CSP представлены; нет систематического COOP/COEP/CORP/Permissions-Policy/SRI guide. |
| Security logging and audit | NO DEDICATED UNIT | Нужны event taxonomy, sensitive-data boundaries, correlation and retention. |
| Secrets management | NO DEDICATED UNIT | Нужен lifecycle для local secrets, CI/CD and managed vaults. |
| Supply-chain security | NO DEDICATED UNIT | Нужны dependency scanning, lockfiles, SBOM, signing and provenance. |
| Privacy/compliance | NO DEDICATED UNIT | Приоритет зависит от продукта и юрисдикции; нельзя считать универсально низким. |

### 4.5 Language, runtime and engineering practice

| Area | Status | Repository evidence and boundary |
|---|---|---|
| .NET async, cancellation, synchronization and channels | EVIDENCED | Есть самостоятельные lifecycle/failure/ownership units. |
| .NET memory, disposal, spans and unmanaged boundaries | EVIDENCED | Есть GC roots, disposal/finalization, pooling, Span/Memory, stackalloc and layout units. |
| Streams, encoding and binary data | EVIDENCED | .NET and JavaScript tracks содержат detailed stream/framing/encoding units. |
| LINQ | EVIDENCED | Есть aggregation, element, grouping/join, projection, partitioning, materialization and provider-boundary units. |
| C# language fundamentals | PARTIAL | Многие отдельные language mechanics представлены, но нет последовательного beginner track по types, classes, interfaces, generics, nullability and control flow. |
| JavaScript fundamentals | PARTIAL | Async/runtime и многие APIs представлены; unified foundational sequence отсутствует. |
| Testing strategy | PARTIAL | Framework-level mechanics есть; test pyramid, doubles, integration boundaries, property and mutation testing не собраны системно. |
| Performance measurement | PARTIAL | Allocation/cost mechanics присутствуют; BenchmarkDotNet/profiling methodology не имеет dedicated unit. |
| Source generators, Native AOT and GC tuning | NO DEDICATED UNIT | Отдельные mentions не равны самостоятельному operational guide. |
| Scheduling and advanced time modeling | PARTIAL | Date/time and DST units сильные; Cron/NodaTime-specific units отсутствуют. |
| Algorithms and data structures | PARTIAL | Два algorithm units не образуют общего track по complexity, searching, sorting, trees, graphs and dynamic programming. |

## 5. Приоритеты следующего покрытия

Приоритет — planning recommendation, а не свойство roadmap. Он учитывает:

1. prerequisite value для существующих units;
2. частоту применения в целевом стеке;
3. риск production failure или security defect;
4. отсутствие цельной модели, даже когда отдельные fragments уже есть.

Этот backlog управляет прежде всего **добавлением нового знания**. Он не задаёт интервалы уже существующим units: их review priority и следующий интервал определяются фактическим recall по `_ai-conspects/_repetition/REPETITION_POLICY.md`.

Внутри каждого уровня порядок предварительный. Всего ниже **40 уникальных backlog groups**: P0 = 9, P1 = 12, P2 = 11, P3 = 8.

### P0 — фундаментальные prerequisite gaps (9)

1. C# fundamentals learning path.
2. JavaScript fundamentals learning path, включая scope/closures, `this`, prototypes and modules.
3. SQL fundamentals: joins, grouping, aggregates, null semantics and query order.
4. ASP.NET Core request-pipeline overview, связывающий routing, middleware, binding, filters and results.
5. EF Core mental model: unit of work, tracking, query translation and SaveChanges lifecycle.
6. HTTP + HTTPS/TLS beginner model.
7. Semantic HTML and accessibility fundamentals.
8. CSS Grid and responsive-layout fundamentals.
9. Testing fundamentals: levels, isolation, doubles and deterministic assertions.

### P1 — частые production and security gaps (12)

10. Structured logging, correlation and OpenTelemetry signals.
11. Health checks: liveness, readiness and dependency health.
12. Background work decision guide: hosted service, queue, scheduler and durable job.
13. OpenAPI generation, schema customization and versioning workflow.
14. Query-plan reading, cardinality and repeatable SQL diagnosis.
15. State-management selection across local state, context, Redux/Zustand and server-state cache.
16. TypeScript project configuration, declarations and build pipeline.
17. Frontend E2E testing and browser-test boundaries.
18. OWASP Top 10 + ASVS mapping overview.
19. Threat modeling and trust-boundary analysis.
20. Application cryptography and key-management model.
21. Security logging, audit events and sensitive-data boundaries.

### P2 — advanced design and scale gaps (11)

22. DDD/Clean/Hexagonal boundaries in ASP.NET applications.
23. CQRS, Vertical Slices and mediator trade-offs.
24. Multi-tenancy data and isolation strategies.
25. Distributed transactions, outbox/inbox and Saga trade-offs.
26. gRPC, REST, SignalR, WebSocket and SSE selection guide.
27. Redis persistence, Sentinel, Cluster, Streams and Pub/Sub.
28. Database design patterns, normalization and temporal/soft-delete models.
29. Database security: RLS, encryption and key ownership.
30. Passkeys/WebAuthn registration and authentication lifecycle.
31. Modern browser isolation/security headers.
32. Supply-chain security: dependency scanning, SBOM and artifact provenance.

### P3 — stack- or product-dependent gaps (8)

33. React Server Components and React 19 actions.
34. Frontend bundling, code splitting and bundle analysis.
35. PWA/Service Worker and offline-first architecture.
36. Native AOT, trimming, source generators and advanced GC tuning.
37. Cron and NodaTime-specific scheduling models.
38. JSON Schema and cross-runtime schema governance.
39. Additional database families selected by a concrete workload.
40. Privacy/compliance implementation selected by product and jurisdiction.

`P3` означает conditional fit, а не низкую важность вообще. Например compliance становится P0/P1 для продукта с соответствующими юридическими обязанностями.

## 6. Как превратить карту в количественную

Процент можно публиковать только после появления versioned checklist:

| Requirement ID | Source/version | Target depth | Evidence IDs | Coverage | Audited depth | Notes |
|---|---|---:|---|---|---:|---|
| example | exact URL/version | D2 | `topic.unit-id` | PARTIAL | D1 | Missing failure mode |

Правила расчёта:

```text
NONE = 0
PARTIAL = 0.5
EVIDENCED/FULL = 1

width = sum(coverage weight) / number of checklist requirements
depth = assigned only after body + recall-contract + provenance audit
```

Если requirements имеют разную важность, weights должны быть записаны до подсчёта, а weighted и unweighted results должны публиковаться отдельно.

## 7. Проверки этой версии

- Все 19 topic indexes учтены.
- Inventory пересчитан из `Knowledge ID`, а не оценён по памяти.
- Duplicate Knowledge IDs отсутствуют.
- Richardson maturity model, BackgroundService, event-loop and accessibility evidence больше не объявлены отсутствующими.
- `NO DEDICATED UNIT` отделён от отсутствия любых mentions.
- Удалены недоказуемые проценты покрытия и псевдоточные role-level counts.
- P0-P3 содержат 40 уникальных backlog groups; заявленные размеры групп арифметически совпадают со списками.
- Текущая глубина D1-D4 не присваивается без body-аудита.

## 8. Operational workflow

- Repetition rules: `../_repetition/REPETITION_POLICY.md`
- Daily rolling plan: `../_repetition/DAILY_STUDY_PLAN.md`
- Full baseline state: `../_repetition/REPETITION_STATE.csv`
- Balanced initial wave: `../_repetition/INITIAL_WAVE_QUEUE.csv`
- New-knowledge lifecycle: `../_repetition/LEARNING_INBOX.md`
- Deferred questions and clarifications: `../_repetition/QUESTIONS_BACKLOG.md`
