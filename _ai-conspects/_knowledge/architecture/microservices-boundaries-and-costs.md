# Microservice boundaries, benefits, and distributed-system costs

Knowledge ID: `architecture.microservices-boundaries-and-costs`

Topic: `architecture`

Microservices are defined by decomposition into focused, separately deployable services with explicit communication boundaries—not by machine count. Instance count and service decomposition are separate dimensions, and each service may itself have multiple instances.

Typical properties include independent deployment and scaling decisions, clear ownership and bounded responsibility, network communication, independent failure modes, and explicit data/API contracts.

Benefits can include scaling only a hot service, independent release cadence, team ownership boundaries, fault isolation, and justified per-service technology choices.

The costs are distributed-system complexity: network latency and partial failure, discovery, observability/tracing, versioned contracts, distributed consistency, orchestration, service-to-service authentication, and more infrastructure.

Adding a server addresses capacity or availability; splitting services addresses ownership and deployment boundaries. A scaled monolith is often simpler until independent deployment or domain boundaries justify the added cost.

The source contrasts the deployment shapes directly:

```text
scaled-out monolith             microservices
load balancer                   load balancer
  -> full app copy #1             -> API service
  -> full app copy #2             -> Auth service
                                  -> Search service
```

The left side duplicates one deployment unit. The right side separates deployment units by responsibility, so the services may be scaled independently.

## What should be recallable

- The distinction between replicated application instances and independently deployable services.
- The characteristic boundaries and potential benefits of microservices.
- The distributed-system costs and why a scaled monolith may remain the correct architecture.

## Sources

- Workspace: `_ai-conspects/server resources,multipleinstances,microservices/`
- Processed source: `01-final-transcript.md`, R03
- Original SVG: `source/server resources,multipleinstances,microservices(1).svg`
- Workspace: `_ai-conspects/server-resources-multipleinstances-microservices/`
- Processed source: `regions/SRM03-scale-up-scale-out-and-microservices-v001.md`, S-029–S-030
- Original SVG: `assets/raw/full.svg`
