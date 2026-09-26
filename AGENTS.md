# Работа с репозиторием ai-conspects / Personal Knowledge System

## Обязательный порядок чтения

Для нового snapshot сначала прочитай:

1. `README.md`;
2. `documentation/README.md`;
3. `documentation/migration/CURRENT-MIGRATION-STATE.md`;
4. `documentation/use-case-registry.md` и выбранный Use Case;
5. применимые current principle/policy/domain-map files.

`documentation/validation/` и `documentation/proposals/` по умолчанию являются evidence/history, а не semantic authority. Старый файл с более подробной таблицей не отменяет current owner.

## Текущая semantic boundary

- Различай Sources/Evidence, Knowledge, Questions/Coverage/Expansion и Memory/Repetition. Не превращай один слой в authority другого.
- Knowledge ID — стабильная идентичность; физический `_knowledge/<topic>/` path не определяет canonical Area.
- Для Software Engineering текущий logical map — `documentation/domains/software-engineering/KNOWLEDGE-MAP.md`; machine-readable current assignment — `documentation/validation/software-engineering-semantic-hierarchy-v3.csv`.
- В hierarchy v3 используй current `area/nested_area_path/concept_label/owner_kind/status` columns; `v1_*`, `v2_*` и audit/change columns — provenance, а не альтернативные current placements.
- `Subarea` — разговорное имя для nested `Area`, а не отдельный тип. Вложенность Areas рекурсивна и не имеет фиксированной глубины.
- `Concept` и coverage `responsibility` — не одно и то же. Responsibility описывает, что область должна объяснять; она не обязана автоматически становиться Area, Concept, Question или Knowledge Unit.
- Один Unit может иметь Engineering Area/nested-Area path для coverage/navigation и при этом подпадать под Technology Core ownership exception. Area path не доказывает физический/technology owner.

## Как читать coverage

Не смешивай четыре разных поверхности:

1. `COVERAGE_STATE.csv` — coarse Area roll-up;
2. `SUBAREA_COVERAGE_STATE.csv` — broad nested-Area **primary occupancy** (`HAS_PRIMARY_EVIDENCE / NO_PRIMARY_EVIDENCE`), не semantic coverage и не доказательство полноты;
3. `RESPONSIBILITY_COVERAGE.csv` — основной responsibility-first semantic gap checklist;
4. `MANIFESTATION_COVERAGE.csv` — ограниченная cross-runtime projection для выбранного baseline, не полный Technology curriculum.

Статусы:

- `PARTIAL` = есть durable evidence по explicit scope, но полнота не доказана;
- `MISSING` = текущего durable evidence недостаточно для explicit scope; это не значит «нет рядом файлов»;
- `COVERED` = достаточность явно проверена относительно scope/Key Questions; не выводи её автоматически из количества Units;
- `NOT_APPLICABLE` = manifestation на этом technology/layer не имеет смысла; это не gap.

Broad Subarea может иметь `0` primary-owned Units, но ответственность из этой области всё равно иметь `PARTIAL` evidence из Units с другим primary home. Это не автоматически противоречие: ownership и evidential support — разные отношения.

Cross-technology gap discovery идёт от общей engineering responsibility к relevant manifestations. Не создавай искусственные `.NET ↔ Python ↔ Node` аналоги для каждого framework/tool; `NO_USEFUL_DIRECT_EQUIVALENT` допустим.

## Technology Core

Technology Core — ownership exception для defining language/runtime/framework models. В текущих migration tables значение `TECHNOLOGY_CORE_CANDIDATE` означает: Unit прошёл boundary classification как вероятный defining technology model, но физическая Technology Core representation ещё не материализована/не является требованием текущего этапа. Не перемещай файл и не дублируй объяснение только из-за этого label.

## Repetition transition

Existing `_ai-conspects/_repetition/` state/policy/dashboard files остаются transitional implementation до CS5.

- Не выводи `ACTIVE/STABLE`, Retention Class или Recall State из legacy state автоматически.
- Legacy `NOT_REVIEWED` не означает target `ACTIVE`.
- Не переписывай `REPETITION_STATE.csv` и не придумывай recall history до явного cutover.

## Repository/source safety

- Для source workspace сначала проверяй declared authority (`CURRENT_SOURCE_OF_TRUTH.md` и применимые specialized rules). Registry/counts не заменяют проверку содержимого.
- Historical commands, старые local paths/branches/ZIP apply flows не являются текущей execution authority без повторной валидации.
- `APPLY_*`, `MANIFEST_*`, audits и generated artifacts не становятся semantic owners из-за наличия в репозитории.
- Commit и push выполняй только по отдельному явному запросу пользователя.
