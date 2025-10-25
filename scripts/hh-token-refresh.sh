#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

ENV_FILE="${ENV_FILE:-/opt/job-search/telegram-bot/.env}"
[[ -f "$ENV_FILE" ]] || { logger -t hh-token-refresh "env file not found: $ENV_FILE"; exit 3; }
STATE_DIR="/var/lib/hh-token"
CUR="${STATE_DIR}/token.json"
NEW="${STATE_DIR}/token.json.new"
LOG_TAG="hh-token-refresh"
THRESHOLD=$((72*3600))   # 72 часа до истечения

mkdir -p "$STATE_DIR"
chmod 700 "$STATE_DIR"

set -a
# shellcheck source=/dev/null
. "$ENV_FILE"
set +a

if [[ ! -f "$CUR" ]]; then
  logger -t "$LOG_TAG" "token.json отсутствует — требуется первичная авторизация"
  exit 1
fi

NOW=$(date +%s)
EXP=$(jq -r '.expires_in // 0' "$CUR")
MTIME=$(stat -c %Y "$CUR" 2>/dev/null || echo "$NOW")
LEFT=$(( MTIME + EXP - NOW ))

if (( LEFT > THRESHOLD )); then
  logger -t "$LOG_TAG" "обновление не требуется, осталось ${LEFT} сек ($(( LEFT / 3600 )) ч)"
  exit 0
fi

REFRESH=$(jq -r '.refresh_token // empty' "$CUR")
if [[ -z "$REFRESH" ]]; then
  logger -t "$LOG_TAG" "нет refresh_token — требуется повторная авторизация"
  exit 2
fi

curl -sS -X POST https://hh.ru/oauth/token \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=refresh_token" \
  -d "refresh_token=${REFRESH}" \
  -o "$NEW"

if jq -e '.access_token and .expires_in' "$NEW" >/dev/null 2>&1; then
  chmod 600 "$NEW"
  mv -f "$NEW" "$CUR"
  NEW_EXP=$(jq -r '.expires_in' "$CUR")
  logger -t "$LOG_TAG" "токен обновлён успешно, expires_in=${NEW_EXP} сек ($(( NEW_EXP / 3600 )) ч)"
else
  ERR=$(jq -r '.error // "unknown"' "$NEW" 2>/dev/null || echo "unknown")
  ERR_DESC=$(jq -r '.error_description // ""' "$NEW" 2>/dev/null || echo "")
  logger -t "$LOG_TAG" "ошибка обновления: ${ERR} ${ERR_DESC}"
  exit 3
fi
