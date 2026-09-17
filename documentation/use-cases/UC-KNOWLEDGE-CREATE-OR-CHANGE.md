# UC-KNOWLEDGE-CREATE-OR-CHANGE — Создать или изменить knowledge-конспект

## Situation

Есть проверенный текстовый источник, созревший learning batch, source-grounded correction или новый содержательный claim для повторения, который не требует полной миграции workspace.

## Result

Новый либо существующий knowledge unit самостоятельно учит проверенное содержание, имеет точный provenance и обнаруживается через topic index; связанный learning batch/повторение остаётся согласованным.

## Process

1. Проверить допустимость источника и его точные границы по [принципам knowledge-конспектов](../knowledge-conspect-principles.md). Непроверенный raw dump или модельный ответ не становится автоматически источником фактов.
2. Найти существующие units и topics. Выбрать новый unit только при отдельной устойчивой смысловой границе; иначе содержательно дополнить существующий, сохранив прежние Sources.
3. Сохранить причинность, механику, важные примеры, caveats и ограничения. Проверить, что каждый recall item подтверждён body, а каждый новый claim — указанным источником.
4. Обновить точный Sources, affected topic index и, лишь при новом topic, root knowledge index. Не создавать фиктивный source workspace или миграционный registry для прямого текста.
5. Если материал пришёл из дневного batch, отметить фактическую materialization и затронутые IDs/sections в [LEARNING_INBOX](../../_ai-conspects/_repetition/LEARNING_INBOX.md); дальнейшую первую проверку и изменения state определяет [REPETITION_POLICY](../../_ai-conspects/_repetition/REPETITION_POLICY.md).
6. Проверить IDs, ссылки, provenance и отсутствие потери/несourced расширения. Не выдумывать прошлые reviews, оценки или интервалы.

Полное распределение authoritative source workspace, включая claim-level registry, принадлежит [UC-KNOWLEDGE-MIGRATE-WORKSPACE](UC-KNOWLEDGE-MIGRATE-WORKSPACE.md).
