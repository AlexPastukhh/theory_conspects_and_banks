# Repetition Plan Coverage And Load Review

Generated: 2026-07-23

## Scope

This compares the combined PDF repetition plan against local workspace conspects and the master audit table. Names are normalized for case, spacing and punctuation. Manual mappings from the conspect match audit are already reflected in the CSV input.

## Coverage Summary

```text
schedule rows: 122
planned conspect items: 265
unique planned matched folders: 244
unique local/master conspects: 308
local/master conspects not in current PDF plan: 64
days with schedule entries: 64
rows with details/block limiter: 28
rows with explicit block: 22
rows with details only: 6
```

## Meaning Of Details And Block

`Topic note` names the conspect or conspects to repeat. If several names are separated by semicolons, each is a separate conspect item for that day.

`details` narrows the repetition target inside the conspect: repeat the named subtopics, caveats, APIs, methods or concepts, not necessarily the whole transcript. Treat it as a study prompt and question-generation filter.

`block` is stronger than ordinary details: it points to a specific section/fragment inside the conspect. For these rows, the default should be a targeted pass over that block, plus only enough surrounding context to make it understandable.

If both `details` and `block` exist, use `block` as the anchor and `details` as the expected content to verify from that block.

## Load Notes

A fair daily load should count limited rows as lighter than full-conspect rows. A day with 5+ conspects is probably heavy unless many rows have narrow `details`/`block` constraints.

Recommended balancing rule: cap normal days at about 3 full conspects or 5 lightweight/partial items. Move overflow to nearest free/light day in the same week, keeping ASP and React/client/CSS mixed when possible.

## Redistribution Strategy

Do not blindly move every semicolon-separated item. First classify each row:

- `full`: no `details` and no `block`; repeat the whole transcript and generate broad questions.
- `partial`: has `details`; repeat only those subtopics, plus minimal context.
- `block`: has `block`; open the named section/visual block and repeat that fragment exactly.

Suggested capacity target:

```text
normal day: 2-3 full conspects, or 4-5 partial/block items
heavy day warning: 5+ conspects or load score >= 7
hard split required: load score >= 9
```

Best move candidates are broad semicolon bundles with no `details`/`block`, especially from the same day. Preserve rows with explicit `block` near their original date because those are already intentionally scoped.

## Days To Split First

| Date | Why split | Suggested action |
|---|---|---|
| 03-05 | 15 conspect items, load score 17 | Split into at least 3 sessions: MVC/Razor group, Razor helpers/components group, TypeScript basics group. |
| 03-07 | 10 conspect items, load score 12 | Keep the `filters` and `ef has conversion` block repeats, move the auth/CORS/React utility bundle to a light day. |
| 03-10 | 10 conspect items, load score 12 | Split backend security/file/download topics away from JS bytes/streams/concurrency topics. |
| 04-16 | 9 conspect items, load score 10 | Split EF/modeling items from events/conventions/claims; this is 9 full items in one row. |
| 03-06 | 8 conspect items, load score 10 | Keep EF CORE GENERAL partial block; split explicit interface/lazy loading from Redux/Zustand/React state. |
| 04-04 | 8 conspect items, load score 10 | Split JS array/not items from ASP headers/auth/server/ascii items. |
| 02-15 | 6 conspect items, load score 10 | Move one broad semicolon group to the nearest light day in the same month. |
| 02-19 | 7 conspect items, load score 9 | Move one broad semicolon group to the nearest light day in the same month. |
| 03-11 | 7 conspect items, load score 9 | Move one broad semicolon group to the nearest light day in the same month. |
| 02-14 | 6 conspect items, load score 9 | Move one broad semicolon group to the nearest light day in the same month. |

## Heaviest Days

| Date | Schedule rows | Conspect items | Limited rows | Load score | Topics |
|---|---:|---:|---:|---:|---|
| 03-05 | 2 | 15 | 0 | 17 | `base mvc razor views example,tempdata viewdata viewbag, cache tag helper; tag helpers razor,partial;injecting into razor;viewcomponent;view discovery conventions;editor,display templates;return url implementation razor;istringlocalizer iviewlocalizer;jquery dynamic form validation;RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX`<br>`;default values of funcs, how to call, rest params in funcs;never type, exhaustion check with discriminated union;type narrowing;index sign, keyof, type assertions, records to solve index sign issues;type aliases, unions,iterfaces` |
| 03-07 | 4 | 10 | 2 | 12 | `filters`<br>`ef has conversion, value converte,comparer`<br>`cookie auth, antiforgery;jwt auth;antiforgerytoken;cors vs anti forgery;usesyncexternalstore`<br>`usecontext;utility types;ctor type and instance type` |
| 03-10 | 2 | 10 | 0 | 12 | `hashing;url save base 64 for db, hex string; adddataprotection, encryption, password recovery;account activation;content disposition header;donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable`<br>`promise.all;textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream;uintarray,blob, arraybuffer,dataview,endianness;semaphoreslim for ts js, pending promise without resolve` |
| 04-16 | 1 | 9 | 0 | 10 | `principles,practises,patterns;events,delegaates,action;conventions;claimstransformation;ef migrations, dotnet-counters;keyless entity type;composite key;alternate key;ef core performance, diagnostics , compiled linq, batching, n + 1` |
| 03-06 | 3 | 8 | 1 | 10 | `- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger`<br>`explicit interface inplementation;lazy loading`<br>`redux;zustand;useReducer;react state and rerenders, store subscriptions` |
| 04-04 | 2 | 8 | 0 | 10 | `set js;splice;not`<br>`return new ();headers;basic auth;server resources,multipleinstances,microservices; ascii;` |
| 02-15 | 4 | 6 | 0 | 10 | `HEAD REQUEST; ROUTE NESTING`<br>`ETAG, e tag;last modified header, implementation, expirational model`<br>`PUT,PATCH`<br>`BEM` |
| 02-19 | 4 | 7 | 2 | 9 | `vary header;cache control headers and response caching`<br>`streaming`<br>`async processing of multiple calls,parallelism`<br>`"cancellation,async"; valuetask;membernotnull attribute,NULL` |
| 03-11 | 2 | 7 | 0 | 9 | `google recapcha and recapchas;mfa;identity;totp, summary,theory;creating base32 secret;`<br>`pipethrough,transformstream,pipeto,writablestream, readablestream;js yield, asyncenumerable, finally of generator` |
| 02-14 | 4 | 6 | 1 | 9 | `BINDING SOURCE ATTRIBUTES; ROUTE PARAMS,QUERY STRING BASICS;ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED`<br>`REST API BASICS`<br>`CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT`<br>`scroll block` |
| 03-19 | 1 | 7 | 0 | 8 | `linq to sql;assplitquery;returning most specific passing most generic;encapsulating dbcontext;abstraction and encapsulation; linq join groupjoin groupby selectmany,selectmany second callback;query syntax` |
| 03-08 | 2 | 6 | 0 | 8 | `authenticaiton ticket, properties, context.User (claimsprincipal); AUTH EVENTS; AUTHORIZATION`<br>`xhr;iframe,cross window communication,target;memory vs localstorage vs sessionstorage, session storage and local storage api methods` |
| 03-12 | 2 | 6 | 0 | 8 | `manual account lockout,ratelimiter middleware, idatabase vs idist cache; redis,multiplexer,redis lock; working with bytes, streams to bytes, to array readexactly,readatleast;event source browser;`<br>`SVH DVH LVH;react strict mode;` |
| 04-01 | 2 | 6 | 0 | 8 | `pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el; useref, when need to have ref from obj created in useeffect + when need to access someting inside effect without incl into dep array`<br>`interlocked,interlocked.read; objectpool,arraypool,memorypool;dbcontextpool, queryfilter;query filters ef core;` |
| 04-17 | 3 | 6 | 1 | 8 | `indexes, onmodel indexes;views, idexed views;searching impl, ef core, full text search,sql server;`<br>`computed columns;sqlserver,efcore, bulk,sqlbulkcopy;`<br>`- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger` |
| 02-10 | 4 | 5 | 1 | 8 | `owned entity`<br>`automatic problem details from modelstate,apicontroller filter invalidmodelstateresponsefactory`<br>`modelstate`<br>`flex,centering etc;flex item ,flex shrinking` |
| 03-04 | 3 | 5 | 0 | 8 | `imemorycache; idistributedcache;hybrydcache`<br>`options pattern`<br>`react router` |
| 03-16 | 2 | 6 | 1 | 7 | `randomnumbergenerator;encoding, utf8, chunk processing,;returning iqueryable,problems when returning ienumerable without tolist, async enumerable problems,yield;hexadecimal base16 how to convert to bytes easily;decoding, bytes memory, start of x byte character`<br>`ETAG, e tag` |
| 04-14 | 1 | 6 | 0 | 7 | `binary primitives;utf8 string literal;implicit operators explicit operators;actiondescriptor,controlleractiondescriptor,endpoint,metadata, route or endpoint name, iapiendpointmetadata, ordered metadata;apibehavioroptions;xss, csp` |
| 02-04 | 2 | 5 | 0 | 7 | `string join;parse string to int, convert char;find index array string`<br>`map and weakmap js;set js;` |
| 02-16 | 3 | 5 | 1 | 7 | `options requ;IVALIDATABLE OBJECT, VALIDATION ATTRIBUTES;FILTERING AND SEARCHING`<br>`REST API BASICS`<br>`SORTING,MAPPING SERVICE` |
| 03-13 | 2 | 5 | 0 | 7 | `OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties; produces, consumes, input output formatters 406 415, vary accept,;windows auth`<br>`useTransition full flow, usedebounce, useDefferedvalue;usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions` |
| 02-23 | 4 | 5 | 3 | 6 | `"when need to add content type, encoding";compression,decompression,request,response;`<br>`ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer`<br>`httpcontent,custom one, readasstream buffering, compression directly to network`<br>`streaming` |
| 03-21 | 1 | 5 | 0 | 6 | `returning iqueryable,problems when returning ienumerable without tolist, async enumerable problems,yield;hashcode;equality;records;ref in out` |
| 04-03 | 2 | 5 | 1 | 6 | `inset vs size,margins,formula;`<br>`REFLECTION;time;problem2; jsondocument, jsonnode, jsonelement, utf8jsonwriter` |
| 04-09 | 1 | 5 | 0 | 6 | `proxy, server, vite dev server proxy; sheet hashset; sheet dict; cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS;outputcache layers, to use or not,locking, outputcache vs cdn` |

## Light Days

- 02-08
- 02-11
- 02-18
- 02-21
- 03-14
- 03-15
- 03-17
- 03-18
- 03-23
- 03-24
- 03-25
- 04-05
- 04-06
- 04-07
- 04-10
- 04-11
- 04-12
- 04-13

## Rows With Details Or Block

| Month | Day | Topic note | Details | Block |
|---|---:|---|---|---|
| 02 | 7 | `middleware, writeasjson` | some basics of middleware, what u can capture in ctore from di as services? invoke method arguments di for middleware methods |  |
| 02 | 8 | `allocations` | what they mat cause for asp.net core app server |  |
| 02 | 8 | `filters` | basics of filters, order,ordering,types of filters, what need to register in di and when, what filter classes can use and how they differ, interfaces vs specific filter classes |  |
| 02 | 9 | `scopes and idisposable` | basics, without deep dive into finalizers |  |
| 02 | 10 | `modelstate` | some basics, methods,properties, prefix explaination |  |
| 02 | 12 | `actiondescriptor,controlleractiondescriptor,endpoint,metadata, route or endpoint name, iapiendpointmetadata, ordered metadata` | iendpointnamemetadata iroutenamemetadata | iendpointnamemetadata iroutenamemetadata |
| 02 | 13 | `ef has conversion, value converte,comparer` | here without QUERING WITH LIST OF PRIMITIVES |  |
| 02 | 14 | `REST API BASICS` |  | FULL OVERVIEW OF METHODS; some basic things;some general base things;method safety/ idempotency |
| 02 | 16 | `REST API BASICS` |  | Validation;PATCH VALIDATION PROBLEM DET LOWER;PROBLEM DETAILS, |
| 02 | 19 | `streaming` |  | streaming objects;"ASYNCENUMERABLE, WHY" ;NDJSON,FLUSHASYNC FOR STREAMING OBJECTS,EXPLAINATION OF PLAIN ARRAY STREAMING VS NDJSON STREAMING BENEFITS AND USECASES WITH PLAIN ARRAY, |
| 02 | 19 | `async processing of multiple calls,parallelism` |  | Sumary -whole block with border |
| 02 | 22 | `ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer` |  | httpclient part - types, contenttype headers on content type not requestmessage, when reading response |
| 02 | 23 | `"when need to add content type, encoding";compression,decompression,request,response;` |  | everything but only high level of block: handling multiple encodings (rarely implemented) is needed |
| 02 | 23 | `ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer` |  | httpclient part - sending json ;memorystream + stream content vs jsoncontent.create; new buffering sheet when you generally buffer full bytes of response using httpclient when you dont buffer full response and process as stream; buffering; using delegate handler to fix streaming issues + retries; jsoncontent.create/content-length issue transfer-encoding: chuncked; |
| 02 | 23 | `streaming` |  | streaming bytes;different types of byte streams and usecases |
| 02 | 25 | `streaming` |  | SSE; sse examples body + event heartbeat; sse writer возможно стоит распределить лучше по дням из за неравномерности |
| 03 | 6 | `- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger` |  | so rep shit |
| 03 | 7 | `filters` |  | exception filter; result after exec vs resource after action |
| 03 | 7 | `ef has conversion, value converte,comparer` |  | QUERING WITH LIST OF PRIMITIVES |
| 03 | 16 | `ETAG, e tag` |  | e tag for aggregate;etag flow, can browser store for later use or it needs to get etag on each response from server?;if match at client |
| 03 | 18 | `- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger` |  | entities shit;nullable relationships;some onmodel creat hshit |
| 03 | 20 | `- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger` |  | transactions;transaction patterns |
| 04 | 3 | `REFLECTION;time;problem2; jsondocument, jsonnode, jsonelement, utf8jsonwriter` |  | without utf8jsonwriter part |
| 04 | 7 | `filters` |  | what wasnt covered before |
| 04 | 7 | `- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger` |  | db exceptions concur;different sql server error codes, what can do with each;db/sql shit |
| 04 | 11 | `ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer` |  | server - trying to inprove performance /memory through streams/pipes in server endpoint for plain json;writing;async enumerable type of optimisation without some ndjson or someting just a very big amount of objects;reading;stream reader;pipereader;sequencereader;stream writer;pipewriter;IBufferwriter, arraybufferwriter note: some duplication in server writing to the left bottom of it, but it shows logical branching to stream writer and pipewriter |
| 04 | 11 | `jsondocument, jsonnode, jsonelement, utf8jsonwriter` |  | utf8jsonwriter |
| 04 | 17 | `- EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger` |  | db invariant handling strategies;uniqueindex on computed column;handle invariants with triggers note: make sure that at this point there is no unnoticed and unprocessed data left in all given conspects, at this point we should have all conspects fully processed into questions and everything, this part was the last one when big conspect could have some unprocessed area |

## Conspects Existing But Not In Current PDF Plan

These are local/master conspects that are not scheduled by the current four-PDF combined plan. This does not mean they are bad or unnecessary; it means they need either a separate review cycle or insertion into light days.

| Key | Folders | Rows | SVGs |
|---|---|---|---|
| `any in exists` | `any in exists` | 8, workspace | `any in exists.svg` |
| `balancing groups net` | `BALANCING GROUPS .NET` | 166, workspace | `BALANCING GROUPS .NET.svg` |
| `bitwise checking for all combinations` | `Bitwise checking for all combinations` | 168, workspace | `Bitwise checking for all combinations.svg` |
| `case insens collate` | `CASE INSENS,collate` | 85, workspace | `CASE INSENS,collate.svg` |
| `concatenate mult rows as aggr stuff string agg` | `CONCATENATE MULT ROWS AS AGGR,STUFF,STRING_AGG` | 174, workspace | `CONCATENATE MULT ROWS AS AGGR,STUFF,STRING_AGG.svg` |
| `contains startswith endswith` | `CONTAINS STARTSWITH ENDSWITH` | 175, workspace | `CONTAINS STARTSWITH ENDSWITH.svg` |
| `context` | `context` | 128, workspace | `context.svg` |
| `date` | `date` | 71, workspace | `date.svg` |
| `delete` | `delete` | 124, workspace | `delete.svg` |
| `enumerable static methods` | `Enumerable static methods` | 190, workspace | `Enumerable static methods.svg` |
| `exaustiveness check with sicr union for enums classes with inher` | `exaustiveness check with sicr union for enums,classes with inher` | 129, workspace | `exaustiveness check with sicr union for enums,classes with inher.svg` |
| `expandoobject` | `expandoobject` | 194, workspace | `expandoobject.svg` |
| `expression trees` | `EXPRESSION TREES` | 61, workspace | `EXPRESSION TREES.svg` |
| `formatting numeric formatting what can be formatted` | `formatting, numeric formatting, what can be formatted` | 200, workspace | `formatting, numeric formatting, what can be formatted.svg` |
| `in any exist some` | `in any exist, some` | 26, workspace | `in any exist, some.svg` |
| `inline flags sharp` | `inline flags sharp` | 209, workspace | `inline flags sharp.svg` |
| `jagged arr multidim arr cast boxing unboxing enumerable vs generic` | `jagged arr,multidim arr,cast boxing unboxing enumerable vs generic` | 212, workspace | `jagged arr,multidim arr,cast boxing unboxing enumerable vs generic.svg` |
| `js loops for for of entries index for in` | `js loops, for, for of, entries, index, for in` | 116, workspace | `js loops, for, for of, entries, index, for in.svg` |
| `js regex` | `js regex` | 215, workspace | `js regex.svg` |
| `js url safe encodeuri` | `js url safe, encodeuri` | 45, workspace | `js url safe, encodeuri.svg` |
| `last element` | `last element` | 220, workspace | `last element.svg` |
| `last element sharp` | `last element sharp` | 120, workspace | `last element sharp.svg` |
| `openjson` | `openjson` | extra-001, workspace | `openjson.svg` |
| `pagination offset take` | `pagination offset take` | extra-004, workspace | `pagination offset take.svg` |
| `parse string to int float double` | `parse string to int,float,double` | extra-005, workspace | `parse string to int,float,double.svg` |
| `pivot unpivot` | `pivot unpivot` | 94, workspace | `pivot unpivot.svg` |
| `protocol` | `protocol` | workspace |  |
| `range operations on list` | `range operations on list` | extra-016, workspace | `range operations on list.svg` |
| `react query rerenders setting and getting data from cache outside of react` | `react query rerenders + setting and getting data from cache outside of react` | 105, workspace | `react query rerenders + setting and getting data from cache outside of react.svg` |
| `regex reusing compiled` | `regex, reusing, compiled` | 1, workspace | `regex, reusing, compiled.svg` |
| `remove from arr copy` | `remove from arr, copy` | 91, workspace | `remove from arr, copy.svg` |
| `replace` | `REPLACE` | 95, workspace | `REPLACE.svg` |
| `router and redirect tests` | `router and redirect tests` | 49, workspace | `router and redirect tests.svg` |
| `scroll block css` | `scroll block css` | 36, workspace | `scroll block css.svg` |
| `sharp regex options cond replace` | `sharp regex options  + COND REPLACE` | extra-033, workspace | `sharp regex options  + COND REPLACE.svg` |
| `sheet exec order` | `sheet exec order` | 106, workspace | `sheet exec order.svg` |
| `sheet get last` | `sheet get last` | extra-034, workspace | `sheet get last.svg` |
| `sheet regex sharp` | `sheet regex sharp` | extra-036, workspace | `sheet regex sharp.svg` |
| `string case conversion tolower toupper invariant` | `STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT` | extra-042, workspace | `STRING CASE CONVERSION, TOLOWER,TOUPPER,INVARIANT.svg` |
| `string format interpolation` | `STRING FORMAT,INTERPOLATION` | extra-043, workspace | `STRING FORMAT,INTERPOLATION.svg` |
| `string index` | `STRING INDEX` | extra-044, workspace | `STRING INDEX.svg` |
| `string padding` | `STRING PADDING` | extra-046, workspace | `STRING PADDING.svg` |
| `string remove insert` | `STRING REMOVE INSERT` | extra-047, workspace | `STRING REMOVE INSERT.svg` |
| `string sort` | `STRING SORT` | extra-048, workspace | `STRING SORT.svg` |
| `string split` | `STRING SPLIT` | extra-049, workspace | `STRING SPLIT.svg` |
| `string to char list` | `string to char list` | extra-050, workspace | `string to char list.svg` |
| `string trim` | `STRING  TRIM` | extra-041, workspace | `STRING  TRIM.svg` |
| `stringbuilder` | `STRINGBUILDER` | extra-051, workspace | `STRINGBUILDER.svg` |
| `stringcomparer compare strings case insens` | `STRINGCOMPARER,compare strings case insens` | extra-052, workspace | `STRINGCOMPARER,compare strings case insens.svg` |
| `struct span` | `struct span` | extra-054, workspace | `struct span.svg` |
| `substring` | `SUBSTRING` | 28, workspace | `SUBSTRING.svg` |
| `svg` | `svg` | 68, workspace | `svg.svg` |
| `symbol` | `symbol` | extra-057, workspace | `symbol.svg` |
| `typescript any unknown` | `typescript any unknown` | extra-061, workspace | `typescript any unknown.svg` |
| `typescript ctor shortcut inheritance statics getters setters prop definite assertion` | `typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion` | 22, workspace | `typescript ctor shortcut, inheritance, statics, getters,setters, prop! - definite assertion.svg` |
| `typescript explicit type annotations vs satisfies` | `typescript explicit type annotations vs satisfies` | 125, workspace | `typescript explicit type annotations vs satisfies.svg` |
| `typescript generic get prop from aray of users k extends keyof t` | `typescript generic get prop from aray of users, k extends keyof T` | 44, workspace | `typescript generic get prop from aray of users, k extends keyof T.svg` |
| `typescript generics default type arguments` | `typescript generics default type arguments` | extra-062, workspace | `typescript generics default type arguments.svg` |
| `uselocation` | `uselocation` | 127, workspace | `uselocation.svg` |
| `vitest mocking` | `vitest mocking` | 37, workspace | `vitest mocking.svg` |
| `vitest test errors` | `vitest test errors` | 99, workspace | `vitest test errors.svg` |
| `vitst existance assert test` | `viTst existance assert test` | 103, workspace | `viTst existance assert test.svg` |
| `window funcs` | `window funcs` | 52, workspace | `window funcs.svg` |
| `xor operator` | `xor operator` | 62, workspace | `xor operator.svg` |
