# Конспекты и повторение

Это отдельный репозиторий для исходных конспектов, проверяемых knowledge units и повторения. Для выбора работы начните с [реестра Use Cases](documentation/use-case-registry.md): его краткие Situation / Result помогают выбрать нужный процесс, не открывая все инструкции подряд.

## Структура

- [documentation/](documentation/) — текущие принципы работы и Use Cases. [Принципы работы с репозиторием](documentation/repository-work-principles.md) задают форму и границы authority.
- [_ai-conspects/](./_ai-conspects/) — содержимое системы: локальные source workspaces, knowledge layer, repetition layer и унаследованные материалы обработки.
- [_ai-conspects/_knowledge/INDEX.md](_ai-conspects/_knowledge/INDEX.md) — навигация по topics; сами units лежат в каталогах topics.
- [_ai-conspects/_repetition/REPETITION_INDEX.md](_ai-conspects/_repetition/REPETITION_INDEX.md) — навигация по состоянию повторения. Численные правила и интервалы принадлежат [REPETITION_POLICY.md](_ai-conspects/_repetition/REPETITION_POLICY.md).

README описывает расположение и ответственность областей, а не заменяет правила или Process выбранного Use Case. Текстовый источник не обязан проходить визуальную транскрипцию. Для изображения действуют [отдельные принципы](documentation/image-conspect-principles.md).

Source workspaces, SVG и PNG исключены текущим .gitignore из публикуемого Git-снимка и остаются на этой машине. В новом клоне будут knowledge и repetition layers, но не исходные конспекты и визуальное evidence. Указанный в knowledge unit локальный source workspace нельзя считать доступным или повторно проверенным по одному пути или registry.
