# UC-KNOWLEDGE-MIGRATE-WORKSPACE — Мигрировать source workspace

## Situation

У source workspace есть физически доступное и достаточно проверенное authoritative содержание, которое нужно разделить или внести в существующие knowledge units без потери meaningful learning claims.

## Result

Learning content workspace представлен в knowledge layer с проверяемым claim-level распределением, честными unresolved claims, актуальными индексами и без переписывания source/evidence.

## Process

1. Применить [принципы knowledge-конспектов](../knowledge-conspect-principles.md) и специализированные [правила миграции](../../_ai-conspects/KNOWLEDGE_LAYER_RULES.md). Разрешить CURRENT_SOURCE_OF_TRUTH.md, каждый заявленный authoritative файл и фактическую степень closure.
2. Если транскрипция вовсе не началась или источник не позволяет составить meaningful claim inventory, не создавать KNOWLEDGE_REGISTRY.md ради статуса MIGRATED. Передать незавершённую работу в [UC-SOURCE-CREATE-CONSPECT](UC-SOURCE-CREATE-CONSPECT.md).
3. Прочитать authoritative material полностью и составить claim inventory: модели, механика, причинность, caveats, примеры, ошибки и границы. Найти semantic overlaps с уже существующими units.
4. Разрезать по смысловым границам; создать новые units или содержательно дополнить существующие. Для каждого изменения сохранить точный provenance и обновить нужные topic indexes; root index меняется лишь при новом topic.
5. Создать claim-level KNOWLEDGE_REGISTRY.md только после реального распределения. MAPPED и MERGED должны вести к физическим destinations с нужным содержимым; NON_LEARNING не скрывает спорные claims, UNRESOLVED означает конкретный содержательный вопрос, а не целиком необработанный workspace.
6. Провести source-to-destination loss audit, проверить recall contracts, IDs, links, counts и отсутствие случайных source/evidence правок. Обновить производный migration status только после проверки registry; статусная строка не доказывает качество.
