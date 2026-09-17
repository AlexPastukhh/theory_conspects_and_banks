# Location header semantics

Knowledge ID: `http.location-header`

Topic: `http`

## Core model

The meaning of `Location` depends on the response status. It can identify a newly created resource:

```http
HTTP/1.1 201 Created
Location: /orders/123
```

It can also provide the target of a redirect:

```http
HTTP/1.1 302 Found
Location: https://example.com/new-path
```

`Location` alone does not mean redirect. Redirect behavior also depends on the status code and request method, and clients may follow different redirect statuses differently.

## What should be recallable

- What does `Location` mean with `201 Created`?
- What does it mean with a redirect status?
- Why can the header not be interpreted without the response status?
- What else influences client redirect behavior?

## Sources

- Workspace: `_ai-conspects/headers/`
- Integrated source: `FINAL_TRANSCRIPT.md`, section 6
- Regional evidence: `regions/R01-location-origin-exposed-response-headers-and-cross-origin-visibility.md`
- Original SVG: `source/headers.svg`
