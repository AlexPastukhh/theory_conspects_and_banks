# Конспекты и Personal Knowledge System

Этот репозиторий хранит source/evidence, durable Knowledge Units, Coverage/Questions/Expansion state и repetition state. Текущая универсальная методология Personal Knowledge System находится в `documentation/`; существующий corpus мигрируется к ней поэтапно.

## Начать работу с snapshot

Для нового чата/агента правильный порядок чтения:

1. [`AGENTS.md`](AGENTS.md) — operational reading contract и запреты на неверные выводы;
2. [`documentation/README.md`](documentation/README.md) — карта текущих semantic owners;
3. [`documentation/migration/CURRENT-MIGRATION-STATE.md`](documentation/migration/CURRENT-MIGRATION-STATE.md) — что уже мигрировано и что всё ещё transitional;
4. [`documentation/use-case-registry.md`](documentation/use-case-registry.md) — functional entry;
5. domain-specific current map, если задача относится к конкретному Domain.

Не восстанавливай текущее состояние по старым validation/proposal-файлам, если current owner уже указан в navigation/current-state документах.

## Repository layers

- `documentation/` — current methodology, current domain maps, repository guidance and migration control;
- `_ai-conspects/_knowledge/` — current physical Knowledge Unit corpus and indexes;
- `_ai-conspects/_planning/` — current Coverage / Questions / Expansion operational projection;
- `_ai-conspects/_repetition/` — current physical repetition storage/legacy operational artifacts; schema/policy remain transitional until CS5 cutover;
- `_ai-conspects/<source-workspace>/` — local source-preserving evidence/provenance where available.

The physical topic layout under `_knowledge/` is not the canonical semantic ontology. All 576 current Knowledge IDs already have a current logical Software Engineering Area/nested-Area assignment in the hierarchy v3 evidence, while files intentionally remain in their existing physical paths.

## Coverage interpretation

Do not equate folder/node occupancy with semantic completeness.

- hierarchy answers **where knowledge belongs**;
- responsibility coverage answers **what the domain is expected to explain**;
- manifestation coverage asks **how a responsibility is represented in relevant technologies/ecosystems**;
- repetition answers **what existing knowledge should be retained/reconstructed**.

`MISSING` is always relative to an explicit coverage scope. It does not mean that a file was lost, that no related file exists, or that a one-to-one analogue must exist in every technology.

## Proposal / validation provenance

`documentation/proposals/personal-knowledge-system-v11/` and earlier `documentation/validation/*v1/v2*` artifacts are retained as provenance/history. They are not current semantic owners merely because they contain older complete-looking maps or tables. Follow `documentation/README.md` and `CURRENT-MIGRATION-STATE.md` for current authority.

## Local evidence boundary

Source workspaces and some visual assets are excluded by `.gitignore`. A Git clone may therefore contain Knowledge/Memory layers without all local source evidence. Do not treat a path reference as proof that the underlying source was physically rechecked.
