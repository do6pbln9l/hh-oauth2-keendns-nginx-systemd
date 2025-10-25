# Contributing to HH OAuth2 Infrastructure

Спасибо за интерес к улучшению проекта! Вот руководство по внесению вклада.

## Как внести вклад

---
<details close>
  <summary> 1. Сообщение об ошибках (Bug Reports)</summary>
  
    # Перед созданием issue убедитесь, что:
    # - Проблема ещё не зарегистрирована
    # - Используете последнюю версию из `main`
    
    # Шаблон issue для багов:
    # - Описание проблемы:
    # - Краткое описание
    
    # Шаги для воспроизведения:
    # - Запустить...
    # - Выполнить...
    # - Наблюдать ошибку...
    
    # Ожидаемое поведение:
    # - Что должно было произойти
    
    # Окружение:
    # OS: Ubuntu 22.04
    # Bash: 5.1.16
    # nginx: 1.22.1
    # systemd: 249
    
    # Логи:
    # [приложите логи journalctl]

</details>

<details close>
  <summary> 2. Предложения улучшений (Feature Requests)</summary>
  
    # Перед предложением:
    # - Проверьте открытые issues
    # - Убедитесь, что функция соответствует scope проекта (инфраструктура OAuth2)
    
    # Формат предложения:
    # - Описание проблемы, которую решает фича
    # - Предлагаемое решение
    # - Альтернативные варианты
    
</details>

<details close>
  <summary> 3. Pull Requests</summary>

    
    # !!! Требования !!!
    # Для скриптов:
    # - Используйте `#!/usr/bin/env bash`
    # - Включите `set -euo pipefail`
    # - Пройдите проверку ShellCheck (без ошибок)
    # - Добавьте комментарии к нетривиальному коду
    
    # Для конфигураций:
    # - nginx конфиги должны проходить `nginx -t`
    # - systemd unit файлы должны быть валидными
    
    # Для документации:
    # - Markdown должен быть корректным
    # - Обновите CHANGELOG.md
    
    # !!! Процесс !!!
    # 1. Fork репозитория
    `git clone https://github.com/YOUR_USERNAME/hh-oauth2-keendns-nginx-systemd.git`
    `cd hh-oauth2-keendns-nginx-systemd`
    
    # 2. Создайте feature branch
    `git checkout -b feature/your-feature-name`
    
    # 3. Внесите изменения
    - Следуйте code style проекта
    - Добавьте комментарии
    - Обновите документацию


    # 4. Проверьте локально</summary>
    ShellCheck для скриптов
    `shellcheck scripts/*.sh`
    
    nginx validation
    `sudo nginx -t -c nginx/nginx.conf`


    # 5. Commit с conventional commits</summary>
    `git commit -m "feat: add token refresh retry logic"`
    `git commit -m "fix: correct nginx proxy timeout"`
    `git commit -m "docs: update README smoke test section"`
    
    # Типы коммитов:
    - `feat:` — новая функция
    - `fix:` — исправление бага
    - `docs:` — изменения в документации
    - `refactor:` — рефакторинг без изменения функциональности
    - `test:` — добавление тестов
    - `chore:` — обновление зависимостей, CI


    # 6. Push и создайте PR
    `git push origin feature/your-feature-name`
    # Откройте Pull Request в веб-интерфейсе GitHub

    !!! Критерии принятия PR !!!
    
    - ✅ CI проходит успешно (ShellCheck + nginx validation)
    - ✅ Код соответствует стилю проекта
    - ✅ Документация обновлена
    - ✅ CHANGELOG.md обновлён (для feat/fix)
    - ✅ Нет конфликтов с `main`

</details>

<details close>
  <summary> 4. Code Style</summary>

    # !!! Bash скрипты: !!!
    # - Используйте 2 пробела для отступов
    # - Переменные в верхнем регистре для констант: `STATE_DIR="/var/lib/hh-token"`
    # - Локальные переменные в нижнем регистре
    # - Всегда цитируйте переменные: `"$VAR"` вместо `$VAR`
    
    # !!! Пример: !!! 
    ```bash
    #!/usr/bin/env bash
    set -euo pipefail
    
    readonly STATE_DIR="/var/lib/hh-token"
    local_var="example"
    
    if [[ -f "$STATE_DIR/token.json" ]]; then
    echo "Token exists"
    fi
    ```
    
    # nginx конфигурация:
    # - 4 пробела для отступов
    # - Комментарии на английском
    # - Группировка директив по назначению

</details>

<details close>
  <summary> 5. Тестирование</summary>

    # Локальное тестирование:
    
    # Запустите smoke test после изменений
    `docker run -d --name test -p 8000:8000 ghcr.io/do6pbln9l/hh-oauth2-infra:latest`
    `curl -I http://localhost:8000/`
    `docker stop test && docker rm test`  
    
    # CI автоматически проверит:
    # - ShellCheck для всех .sh файлов
    # - nginx -t для конфигов

</details>

<details close>
  <summary> 6. Вопросы и обсуждения</summary>

    # Используйте GitHub Discussions для:
    # - Вопросов по использованию
    # - Предложений архитектурных изменений
    # - Обсуждения лучших практик

</details>

## Лицензия

Внося вклад, вы соглашаетесь, что ваш код будет лицензирован под MIT License этого проекта.

---

**Благодарим за вклад в проект!** 🎉
