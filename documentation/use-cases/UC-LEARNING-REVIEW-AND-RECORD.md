# UC-LEARNING-REVIEW-AND-RECORD — Провести и зарегистрировать повторение

## Situation

Есть overdue/due Knowledge ID, ещё не откалиброванный unit первой волны, первый review нового материала или целевой follow-up. Учащийся готов провести реальное активное вспоминание.

## Result

Вспоминание выполнено до чтения unit, пробелы памяти отделены от дефектов источника, а history, state, вопросы и следующая дата отражают фактический результат.

## Process

1. Использовать [принципы работы с репозиторием](../repository-work-principles.md) для границ файлов и [REPETITION_POLICY](../../_ai-conspects/_repetition/REPETITION_POLICY.md) для отбора, оценки, интервалов и state. Для выдачи учебной сессии применить [агентский контракт](../../_ai-conspects/_repetition/STUDY_SESSION_AGENT_PROMPT.md).
2. Выбрать работу по текущему порядку из REPETITION_POLICY и REPETITION_INDEX: due/overdue reviews, первую проверку batch, затем допустимую initial-wave calibration или follow-up. Если сейчас требуется D+2 materialization, её ведёт [UC-KNOWLEDGE-CREATE-OR-CHANGE](UC-KNOWLEDGE-CREATE-OR-CHANGE.md), а не фиктивный recall. Перед повторением выдать учащемуся только название, work type и кликабельную ссылку, без содержания unit.
3. Получить фактическое воспроизведение до раскрытия текста. Если его ещё нет, остановиться на подготовке сессии: не записывать оценку, историю или «завершённый» review за учащегося.
4. После ответа сравнить recall с unit и нужным источником. Зафиксировать provisional/final score на основании памяти, отдельно отметить MEMORY_GAP, SOURCE_GAP и NEW_QUESTION. При source defect использовать SOURCE_REPAIR, а не штраф памяти.
5. Неблокирующий вопрос записать в [QUESTIONS_BACKLOG](../../_ai-conspects/_repetition/QUESTIONS_BACKLOG.md) с Knowledge ID и нужной датой/статусом; не превращать его автоматически в новый claim.
6. Вычислить следующий gap/date по фактической дате и политике. Дополнить историю unit, обновить REPETITION_STATE.csv и соответствующий dashboard/batch status. Проверить согласованность IDs, дат, history и обоснование ручного override.
