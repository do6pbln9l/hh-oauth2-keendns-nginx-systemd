# Changelog

Все значимые изменения документируются в этом файле.
Формат основан на Keep a Changelog. Версии — Semantic Versioning.

## [1.0.0] - 25-10-2025
### Added
- Конфигурация nginx reverse-proxy для KeenDNS Cloud (SSL termination)
- systemd timer для автообновления токенов (ежедневно в 17:00)
- Скрипт безопасной ротации токенов `scripts/hh-token-refresh.sh`
- Тестовый HTTP-сервер `scripts/test-8000.py` для проверки инфраструктуры
- Подробный README и раздел безопасности
- Документация `docs/oauth-flow.md` с архитектурной схемой
- MIT License
