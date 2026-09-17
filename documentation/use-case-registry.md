# Реестр Use Cases — работа с конспектами и повторением

Status: current functional entry for this repository.

Сопоставьте текущую ситуацию с краткими Situation / Result. Откройте только подходящие owner-файлы и следуйте их Process; может подойти несколько Use Cases. Просмотр реестра не запускает работу и не даёт разрешения на commit, push или изменение источника.

| ID | Use Case | Situation summary | Result summary | Owner |
|---|---|---|---|---|
| UC-REPO-CHECK-FORM | Проверить форму репозитория | структура, ссылки или cross-layer состояние могли разойтись | проверенная в указанной области форма либо конкретные находки и границы проверки | [UC-REPO-CHECK-FORM](use-cases/UC-REPO-CHECK-FORM.md) |
| UC-SOURCE-CREATE-CONSPECT | Создать source-конспект | текстовый или визуальный источник нужно сохранить как проверяемое представление | source-preserving workspace с честной authority и coverage, либо явной незавершённостью | [UC-SOURCE-CREATE-CONSPECT](use-cases/UC-SOURCE-CREATE-CONSPECT.md) |
| UC-KNOWLEDGE-MIGRATE-WORKSPACE | Мигрировать source workspace | готовый authoritative source workspace нужно распределить по knowledge units | claim-level no-loss partition, registry и связанные индексы | [UC-KNOWLEDGE-MIGRATE-WORKSPACE](use-cases/UC-KNOWLEDGE-MIGRATE-WORKSPACE.md) |
| UC-KNOWLEDGE-CREATE-OR-CHANGE | Создать или изменить knowledge-конспект | проверенный текст, материал дня или уточнение должны стать материалом для повторения | самостоятельный source-grounded unit или дополнение существующего | [UC-KNOWLEDGE-CREATE-OR-CHANGE](use-cases/UC-KNOWLEDGE-CREATE-OR-CHANGE.md) |
| UC-LEARNING-COLLECT-DAY | Собрать материал дня | в течение дня накопились сведения, ещё не готовые к семантическому разбору | сохранённый raw batch с provenance и сроком последующей обработки | [UC-LEARNING-COLLECT-DAY](use-cases/UC-LEARNING-COLLECT-DAY.md) |
| UC-LEARNING-REVIEW-AND-RECORD | Провести и зарегистрировать повторение | есть due item, первоначальная волна или целевой follow-up | реальный recall проверен, история и дальнейшее состояние согласованы | [UC-LEARNING-REVIEW-AND-RECORD](use-cases/UC-LEARNING-REVIEW-AND-RECORD.md) |

Реестр — только функциональная навигация. Канонические Situation / Result / Process находятся в owner-файлах. При существенном изменении ситуации выбор Use Case пересматривается; повторно читать неизменившиеся файлы без причины не требуется.
