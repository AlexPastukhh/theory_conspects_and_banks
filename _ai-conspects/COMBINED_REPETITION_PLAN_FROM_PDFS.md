# Combined Repetition Plan From PDFs

Generated: 2026-07-23

Source PDFs:
- asp area note 02.pdf
- area 03 asp.pdf
- topic nots asp 4.pdf
- react or client.js.css area.pdf

Notes:
- Original `Topic note` names are preserved as extracted from the PDFs.
- Rows where a PDF had `day` without a number inherit the previous numbered day in the same source PDF.
- `react or client.js.css area.pdf` contains several month-like parts: Part 1 is merged into month 02, Part 2 into month 03, Part 3 into month 04.
- Each row keeps its source PDF so ASP and React/client/CSS items can be distinguished after merging.

## Month 02

### Day 4

- string join;parse string to int, convert char;find index array string
  - source: react or client.js.css area.pdf
  - source part: 1
- map and weakmap js;set js;
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 5

- js sorting;js iterate, index;create array, fixed length;
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 6

- interseption observer; react render + useEffect; decorator;
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 7

- middleware, writeasjson
  - details: some basics of middleware, what u can capture in ctore from di as services? invoke method arguments di for middleware methods
  - source: asp area note 02.pdf
- block scroll;FLAT FLATMAP
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 8

- allocations
  - details: what they mat cause for asp.net core app server
  - source: asp area note 02.pdf
- filters
  - details: basics of filters, order,ordering,types of filters, what need to register in di and when, what filter classes can use and how they differ, interfaces vs specific filter classes
  - source: asp area note 02.pdf
### Day 9

- scopes and idisposable
  - details: basics, without deep dive into finalizers
  - source: asp area note 02.pdf
- routing,route params tech info, custom constraints,router matching
  - source: asp area note 02.pdf
- svg * ( fw_react)
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 10

- owned entity
  - source: asp area note 02.pdf
- automatic problem details from modelstate,apicontroller filter invalidmodelstateresponsefactory
  - source: asp area note 02.pdf
- modelstate
  - details: some basics, methods,properties, prefix explaination
  - source: asp area note 02.pdf
- flex,centering etc;flex item ,flex shrinking
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 11

- stacking contexts, zindex
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 12

- actiondescriptor,controlleractiondescriptor,endpoint,metadata, route or endpoint name, iapiendpointmetadata, ordered metadata
  - details: iendpointnamemetadata iroutenamemetadata
  - block: iendpointnamemetadata iroutenamemetadata
  - source: asp area note 02.pdf
- prog inline styles css;animation keyframes
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 13

- fluent validation
  - source: asp area note 02.pdf
- ef has conversion, value converte,comparer
  - details: here without QUERING WITH LIST OF PRIMITIVES
  - source: asp area note 02.pdf
- header max width, sticky,fixed
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 14

- BINDING SOURCE ATTRIBUTES; ROUTE PARAMS,QUERY STRING BASICS;ROUTING,ROUTE DESIGN, RESOURCES,ROUTING ALL GOOD PRACT IN GENERAL EXPLAINED
  - source: asp area note 02.pdf
- REST API BASICS
  - block: FULL OVERVIEW OF METHODS; some basic things;some general base things;method safety/ idempotency
  - source: asp area note 02.pdf
- CREATION REQUEST,POST REQUEST,LOCACTION HEADER,CREATED AT
  - source: asp area note 02.pdf
- scroll block
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 15

- HEAD REQUEST; ROUTE NESTING
  - source: asp area note 02.pdf
- ETAG, e tag;last modified header, implementation, expirational model
  - source: asp area note 02.pdf
- PUT,PATCH
  - source: asp area note 02.pdf
- BEM
  - source: react or client.js.css area.pdf
  - source part: 1
### Day 16

- options requ;IVALIDATABLE OBJECT, VALIDATION ATTRIBUTES;FILTERING AND SEARCHING
  - source: asp area note 02.pdf
- REST API BASICS
  - block: Validation;PATCH VALIDATION PROBLEM DET LOWER;PROBLEM DETAILS,
  - source: asp area note 02.pdf
- SORTING,MAPPING SERVICE
  - source: asp area note 02.pdf
### Day 17

- PAGING;data shaping,expando;root document
  - source: asp area note 02.pdf
- hateoas
  - source: asp area note 02.pdf
### Day 18

- CONTENT NEGOTIATION RES API,FORMATTERS, XML,JSON
  - source: asp area note 02.pdf
- FULL CONTENT NEG + VALIDATION FLOW
  - source: asp area note 02.pdf
### Day 19

- vary header;cache control headers and response caching
  - source: asp area note 02.pdf
- streaming
  - block: streaming objects;"ASYNCENUMERABLE, WHY" ;NDJSON,FLUSHASYNC FOR STREAMING OBJECTS,EXPLAINATION OF PLAIN ARRAY STREAMING VS NDJSON STREAMING BENEFITS AND USECASES WITH PLAIN ARRAY,
  - source: asp area note 02.pdf
- async processing of multiple calls,parallelism
  - block: Sumary -whole block with border
  - source: asp area note 02.pdf
- "cancellation,async"; valuetask;membernotnull attribute,NULL
  - source: asp area note 02.pdf
### Day 20

- problem details; FILTER,MIDDLEWARE CANCELLATION,REQUEST ABORTED; QS PREFERENCE WITH MULTIPLE ACCEPT HEADER VALUES HELPER
  - source: asp area note 02.pdf
### Day 21

- httpclient,summary,theory,base usage,jsonoptions wrapper,handlers
  - source: asp area note 02.pdf
- MEDIA TYPES OF REQUESTS
  - source: asp area note 02.pdf
### Day 22

- statuscodepages; EXCEPTION HANDLERS ,
  - source: asp area note 02.pdf
- ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer
  - block: httpclient part - types, contenttype headers on content type not requestmessage, when reading response
  - source: asp area note 02.pdf
### Day 23

- "when need to add content type, encoding";compression,decompression,request,response;
  - block: everything but only high level of block: handling multiple encodings (rarely implemented) is needed
  - source: asp area note 02.pdf
- ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer
  - block: httpclient part - sending json ;memorystream + stream content vs jsoncontent.create; new buffering sheet when you generally buffer full bytes of response using httpclient when you dont buffer full response and process as stream; buffering; using delegate handler to fix streaming issues + retries; jsoncontent.create/content-length issue transfer-encoding: chuncked;
  - source: asp area note 02.pdf
- httpcontent,custom one, readasstream buffering, compression directly to network
  - source: asp area note 02.pdf
- streaming
  - block: streaming bytes;different types of byte streams and usecases
  - source: asp area note 02.pdf
### Day 24

- httpcontext items and features;Lazy;link generator;jsonconverter;
  - source: asp area note 02.pdf
### Day 25

- problem2; event source browser
  - source: asp area note 02.pdf
- streaming
  - block: SSE; sse examples body + event heartbeat; sse writer возможно стоит распределить лучше по дням из за неравномерности
  - source: asp area note 02.pdf
## Month 03

### Day 1

- STRINGREADER; SYSTEM.TEXT.JSON SER SER;CUSTOM ROUTE CONSTRAINT;
  - source: area 03 asp.pdf
- FETCH,FETCH AXIOS COMP, getch reader, httpclient comparison
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 2

- shared polly,cheat sheet,production ready verions, exceptions from pipeline and handling
  - source: area 03 asp.pdf
- react root error, trigger useeffect on route change;axios
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 3

- outputcache, response cache comparison
  - source: area 03 asp.pdf
- Rhf react hook form;zod
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 4

- imemorycache; idistributedcache;hybrydcache
  - source: area 03 asp.pdf
- options pattern
  - source: area 03 asp.pdf
- react router
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 5

- base mvc razor views example,tempdata viewdata viewbag, cache tag helper; tag helpers razor,partial;injecting into razor;viewcomponent;view discovery conventions;editor,display templates;return url implementation razor;istringlocalizer iviewlocalizer;jquery dynamic form validation;RAZOR PARTIAL UPDATES FOR VIEWCOMPONENT HTMX,AJAX
  - source: area 03 asp.pdf
- ;default values of funcs, how to call, rest params in funcs;never type, exhaustion check with discriminated union;type narrowing;index sign, keyof, type assertions, records to solve index sign issues;type aliases, unions,iterfaces
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 6

- - EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger
  - block: so rep shit
  - source: area 03 asp.pdf
- explicit interface inplementation;lazy loading
  - source: area 03 asp.pdf
- redux;zustand;useReducer;react state and rerenders, store subscriptions
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 7

- filters
  - block: exception filter; result after exec vs resource after action
  - source: area 03 asp.pdf
- ef has conversion, value converte,comparer
  - block: QUERING WITH LIST OF PRIMITIVES
  - source: area 03 asp.pdf
- cookie auth, antiforgery;jwt auth;antiforgerytoken;cors vs anti forgery;usesyncexternalstore
  - source: area 03 asp.pdf
- usecontext;utility types;ctor type and instance type
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 8

- authenticaiton ticket, properties, context.User (claimsprincipal); AUTH EVENTS; AUTHORIZATION
  - source: area 03 asp.pdf
- xhr;iframe,cross window communication,target;memory vs localstorage vs sessionstorage, session storage and local storage api methods
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 9

- authentication,, oidc, flows , handlers , forwarding auth events; authorization flow,autorization options, framework, authorizationmiddlewareresulthandler
  - source: area 03 asp.pdf
- react query,rquery
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 10

- hashing;url save base 64 for db, hex string; adddataprotection, encryption, password recovery;account activation;content disposition header;donwloading files, blob,window.location,signed uri, showsavefilepicker createwritable
  - source: area 03 asp.pdf
- promise.all;textdecoder, encoder, streaming and processing chunks, textdecoderstream of transformstream;uintarray,blob, arraybuffer,dataview,endianness;semaphoreslim for ts js, pending promise without resolve
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 11

- google recapcha and recapchas;mfa;identity;totp, summary,theory;creating base32 secret;
  - source: area 03 asp.pdf
- pipethrough,transformstream,pipeto,writablestream, readablestream;js yield, asyncenumerable, finally of generator
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 12

- manual account lockout,ratelimiter middleware, idatabase vs idist cache; redis,multiplexer,redis lock; working with bytes, streams to bytes, to array readexactly,readatleast;event source browser;
  - source: area 03 asp.pdf
- SVH DVH LVH;react strict mode;
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 13

- OIDC,OAUTH, IDENTITY SERVER,BFF,authtoken, authproperties; produces, consumes, input output formatters 406 415, vary accept,;windows auth
  - source: area 03 asp.pdf
- useTransition full flow, usedebounce, useDefferedvalue;usetransition,cancelling queries of rquery,cant cancel suspence query, batching transitions
  - source: react or client.js.css area.pdf
  - source part: 2
### Day 14

- websockets;useRef to avoid including into deps array, to avoid rerenders or bad recreations
  - source: area 03 asp.pdf
### Day 15

- processing data as stream in dif situations, httpclient,endpoint,browser,websockets;
  - source: area 03 asp.pdf
### Day 16

- randomnumbergenerator;encoding, utf8, chunk processing,;returning iqueryable,problems when returning ienumerable without tolist, async enumerable problems,yield;hexadecimal base16 how to convert to bytes easily;decoding, bytes memory, start of x byte character
  - source: area 03 asp.pdf
- ETAG, e tag
  - block: e tag for aggregate;etag flow, can browser store for later use or it needs to get etag on each response from server?;if match at client
  - source: area 03 asp.pdf
### Day 17

- changetracker;
  - source: area 03 asp.pdf
### Day 18

- partially initialized antipattern and possible partial inits inside repositories;
  - source: area 03 asp.pdf
- - EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger
  - block: entities shit;nullable relationships;some onmodel creat hshit
  - source: area 03 asp.pdf
### Day 19

- linq to sql;assplitquery;returning most specific passing most generic;encapsulating dbcontext;abstraction and encapsulation; linq join groupjoin groupby selectmany,selectmany second callback;query syntax
  - source: area 03 asp.pdf
### Day 20

- transaction, isolation;ef core retry, savepoints
  - source: area 03 asp.pdf
- - EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger
  - block: transactions;transaction patterns
  - source: area 03 asp.pdf
### Day 21

- returning iqueryable,problems when returning ienumerable without tolist, async enumerable problems,yield;hashcode;equality;records;ref in out
  - source: area 03 asp.pdf
### Day 22

- channel; lock, monitor ; semaphoreslim vs channel
  - source: area 03 asp.pdf
### Day 23

- primary httphandler optoins, socket;
  - source: area 03 asp.pdf
### Day 24

- dbcontext interseptors savechanges , dbcommand;dbset fromsql fromsqlraw fromsqlinterpolated and LINQ executeupdateasync and executedelete async,database.executesql executeraw,fromsqlquery
  - source: area 03 asp.pdf
### Day 25

- span,memory,stackalloc,stackoverflow,calculate bytes, unmanaged types
  - source: area 03 asp.pdf
## Month 04

### Day 1

- pseudoel, pseudo with parents stacking context, darp popup on full screen pseudo el; useref, when need to have ref from obj created in useeffect + when need to access someting inside effect without incl into dep array
  - source: react or client.js.css area.pdf
  - source part: 3
- interlocked,interlocked.read; objectpool,arraypool,memorypool;dbcontextpool, queryfilter;query filters ef core;
  - source: topic nots asp 4.pdf
### Day 2

- persistance, zustand,rquery,redux
  - source: react or client.js.css area.pdf
  - source part: 3
- stored procedures;rawconnections,dbconnection,sqlconnection,commands
  - source: topic nots asp 4.pdf
### Day 3

- inset vs size,margins,formula;
  - source: react or client.js.css area.pdf
  - source part: 3
- REFLECTION;time;problem2; jsondocument, jsonnode, jsonelement, utf8jsonwriter
  - block: without utf8jsonwriter part
  - source: topic nots asp 4.pdf
### Day 4

- set js;splice;not
  - source: react or client.js.css area.pdf
  - source part: 3
- return new ();headers;basic auth;server resources,multipleinstances,microservices; ascii;
  - source: topic nots asp 4.pdf
### Day 5

- CORS
  - source: topic nots asp 4.pdf
### Day 6

- ef core context.database, transaction object, savechanges, dbconnection,dbtransaction
  - source: topic nots asp 4.pdf
### Day 7

- filters
  - block: what wasnt covered before
  - source: topic nots asp 4.pdf
- - EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger
  - block: db exceptions concur;different sql server error codes, what can do with each;db/sql shit
  - source: topic nots asp 4.pdf
### Day 8

- server browser threads,memory, webworkers , runtime vs compiler , es;pointers; redis, idatabase,iserver;implicit operators explicit operators;
  - source: topic nots asp 4.pdf
### Day 9

- proxy, server, vite dev server proxy; sheet hashset; sheet dict; cache control header,directives, PUBLIC PRIVATE CACHE , RESPONSE CACHE TYPES , E TAG CACHE FLOWS;outputcache layers, to use or not,locking, outputcache vs cdn
  - source: topic nots asp 4.pdf
### Day 10

- SQL SERVER MARS;
  - source: topic nots asp 4.pdf
### Day 11

- ALL ABOUT REQ RES ,,,,,,,TYPES OF REQUEST CONTENT httpclient part, server part, pipereader pipewriter stream reader stream writer
  - block: server - trying to inprove performance /memory through streams/pipes in server endpoint for plain json;writing;async enumerable type of optimisation without some ndjson or someting just a very big amount of objects;reading;stream reader;pipereader;sequencereader;stream writer;pipewriter;IBufferwriter, arraybufferwriter note: some duplication in server writing to the left bottom of it, but it shows logical branching to stream writer and pipewriter
  - source: topic nots asp 4.pdf
- jsondocument, jsonnode, jsonelement, utf8jsonwriter
  - block: utf8jsonwriter
  - source: topic nots asp 4.pdf
### Day 12

- sql syntax. sql server
  - source: topic nots asp 4.pdf
### Day 13

- onmodelcreating
  - source: topic nots asp 4.pdf
### Day 14

- binary primitives;utf8 string literal;implicit operators explicit operators;actiondescriptor,controlleractiondescriptor,endpoint,metadata, route or endpoint name, iapiendpointmetadata, ordered metadata;apibehavioroptions;xss, csp
  - source: topic nots asp 4.pdf
### Day 15

- cookies, general theo, plain cookie options,;cookies vs tokens sheet jswt in cookies;usecookiepolicy;cookies auth ON REDIRECT probmem details returning
  - source: topic nots asp 4.pdf
### Day 16

- principles,practises,patterns;events,delegaates,action;conventions;claimstransformation;ef migrations, dotnet-counters;keyless entity type;composite key;alternate key;ef core performance, diagnostics , compiled linq, batching, n + 1
  - source: topic nots asp 4.pdf
### Day 17

- indexes, onmodel indexes;views, idexed views;searching impl, ef core, full text search,sql server;
  - source: topic nots asp 4.pdf
- computed columns;sqlserver,efcore, bulk,sqlbulkcopy;
  - source: topic nots asp 4.pdf
- - EF CORE GENERAL repo shit entity shit onmodelcreat shit transactions shit dbexceptions db level invariants,protection, trigger
  - block: db invariant handling strategies;uniqueindex on computed column;handle invariants with triggers note: make sure that at this point there is no unnoticed and unprocessed data left in all given conspects, at this point we should have all conspects fully processed into questions and everything, this part was the last one when big conspect could have some unprocessed area
  - source: topic nots asp 4.pdf
