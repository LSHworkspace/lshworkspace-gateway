#!/bin/sh
set -e

echo "[entrypoint] Starting Nginx..."

# 외부 설정 존재 여부 확인 및 override
if [ -f /etc/nginx/nginx.external.conf ]; then
  echo "[entrypoint] External nginx.conf detected, applying override."
  cp /etc/nginx/nginx.external.conf /etc/nginx/nginx.conf
else
  echo "[entrypoint] Using built-in nginx.conf"
fi

exec nginx -g "daemon off;"
