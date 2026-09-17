# Horizontal scaling, shared state, and downstream capacity

Knowledge ID: `architecture.horizontal-scaling-and-state`

Topic: `architecture`

## Scale up and scale out

Vertical scaling gives one machine more CPU, RAM, disk/network performance, or platform limits. It is operationally simple but has a ceiling and retains one main failure domain.

Horizontal scaling adds application instances behind a load balancer. Multiple full copies of one monolith are a scaled-out monolith, not microservices.

Concrete source examples make the two axes explicit:

```text
scale up:  1 server, 8 cores -> 32 cores
scale out: 1 server -> 2 servers -> 5 servers
```

The compute unit that runs an application copy may be called a server, host, node, instance, VM, container instance, or pod in Kubernetes. Those words are not exact synonyms; the shared idea in this model is one unit running one application copy.

## State across instances

Any request may reach another instance, so correctness cannot depend on process-local or local-disk state. Risks include in-memory sessions, correctness-critical local caches, temporary upload state, local files, and background jobs implicitly owned by one process.

Use shared or durable storage where required: a database, distributed cache, object/file storage, broker, or durable queue. Sticky sessions can ease migration but do not remove the single-instance-state problem and make failover harder.

## Shared dependencies do not multiply automatically

More application instances increase database and Redis connections, broker consumers, third-party calls, and network traffic. Scale-out helps when the application tier is the bottleneck, or when shared dependencies are also scaled and protected. It can worsen pressure when a downstream limit is already saturated.

## What should be recallable

- Scale-up versus scale-out, their limits, and why replicated monoliths remain monoliths.
- Which local state breaks multi-instance correctness and which shared/durable replacements fit.
- Why sticky sessions are incomplete and why downstream capacity must be included in scale-out planning.

## Sources

- Workspace: `_ai-conspects/server resources,multipleinstances,microservices/`
- Processed source: `01-final-transcript.md`, R02
- Original SVG: `source/server resources,multipleinstances,microservices(1).svg`
- Workspace: `_ai-conspects/server-resources-multipleinstances-microservices/`
- Processed source: `regions/SRM03-scale-up-scale-out-and-microservices-v001.md`, S-025–S-028
- Original SVG: `assets/raw/full.svg`
