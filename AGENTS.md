# Работа с репозиторием ai-conspects

- Начинай с `README.md` и `documentation/use-case-registry.md`. Открывай Process только выбранного Use Case и применимые principle-файлы.
- Различай слои: `_ai-conspects/_knowledge/` — учебные units и индексы, `_ai-conspects/_repetition/` — состояние повторения, остальные именованные source workspaces — evidence и provenance.
- Для обычной задачи ограничивай поиск выбранным topic, Knowledge ID или source workspace. Не читай все конспекты и не запускай сканирование всего дерева без задачи на общий аудит.
- В выбранном source workspace сначала проверь `CURRENT_SOURCE_OF_TRUTH.md`; `KNOWLEDGE_REGISTRY.md` и сводные counts не заменяют проверку authoritative содержания.
- Папки `_batch*`, `_batches`, `_bundles`, `_source-svg-repair-audits`, `protocol`, `tmp_pdf_extract` и корневые `APPLY_*` — служебные или исторические материалы. Открывай их, когда к ним ведёт конкретная задача или ссылка.
- Настройки `.obsidian/` меняют только представление. Локальные source workspaces и SVG/PNG исключены из Git: в другом клоне их может не быть. Перед чтением source или визуальной проверкой подтверждай фактическую доступность файлов.
- Не перемещай и не удаляй массово source workspaces ради навигации: их пути используются в Sources, registries и скриптах. Для переноса сначала составь карту затронутых ссылок и проверок.
- Commit и push выполняй только по отдельному явному запросу пользователя.
