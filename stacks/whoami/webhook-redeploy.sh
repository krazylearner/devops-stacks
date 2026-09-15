#!/bin/bash
# webhook-redeploy.sh - Day 35-37 Portainer webhook equivalent
# Real flow: curl -X POST $PORTAINER_WEBHOOK_WHOAMI -> Portainer pulls main + recreates
# Fallback (no Portainer token yet): git pull + compose up -d (same effect, <60s proven)
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$DIR/../.." && pwd)"
URL="${PORTAINER_WEBHOOK_WHOAMI:-}"
START=$(date +%s)
if [ -n "$URL" ]; then
  echo "[webhook] POST $URL (masked: ${URL:0:40}...)"
  curl -sS -X POST "$URL" -o /dev/null -w "http=%{http_code} time=%{time_total}s\n"
else
  echo "[webhook-sim] no URL set, doing git pull + compose up (Portainer polling does same)"
  git -C "$ROOT" pull --ff-only | tail -n 3
  docker compose -f "$DIR/compose.yaml" up -d
fi
END=$(date +%s)
echo "done in $((END-START))s (target <60s)"
docker inspect whoami --format '{{range .Config.Env}}{{println .}}{{end}}' | grep PHASE || true
