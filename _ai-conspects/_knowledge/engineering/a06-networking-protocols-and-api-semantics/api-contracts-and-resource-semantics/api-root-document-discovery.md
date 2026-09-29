# API root document and link discovery

Knowledge ID: `http.api-root-document-discovery`

Topic: `http`

A root document is a stable API entry point containing a small set of starting links. A client still knows one bootstrap URL such as `GET /api`, but no longer hard-codes collection/controller routes whose templates may change.

Name the root and linked routes so URLs are framework-generated. Return consistent link objects with semantic relation, target URL, and HTTP method. Typical relations include `self`, collection GET (`authors`), and collection POST (`create-author`). Advertise only transitions the current client may or should use.

The client fetches the root, looks up relations by stable semantic name rather than parsing paths, and navigates to collections/commands while decoupled from route layout.

The root is discoverability metadata, not a dump of every route. Keep relation names and link representation stable, and version the contract deliberately when relation meaning changes.

A root document does not remove the need for one documented bootstrap URL and does not by itself implement full HATEOAS state transitions.

## What should be recallable

- The initial hard-coded-route problem and stable bootstrap solution.
- Named/generated links, relation/URL/method representation, and conditional advertisement.
- Client navigation by semantic relation and contract-versioning rules.
- Why a root document is neither every route nor complete HATEOAS.

## Sources

- Workspace: `_ai-conspects/root document/`
- Processed source: `02-full-combined-final-transcript.md`, R01
- Original SVG: `source/root document.svg`
- Workspace: `_ai-conspects/REST API BASICS/`
- Authoritative processed source: `regions/R04-data-shaping-hateoas-content-negotiation.md`, root-document claims
- Original SVG: `source/REST API BASICS.svg`
