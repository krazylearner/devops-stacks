# Rollback — my-app prod → prev-stable (Day 46-48, <5min proven 15s)

Prev-stable: `ghcr.io/krazylearner/devops-stacks/my-app:d1d810a` (prod prod-stable, :8092, healthy).
Prior stable `3ecddb0` kept as fallback. Healthfix: `127.0.0.1` not `localhost` (IPv6 ::1 refused).
Proven: bad TAG pull fails safe 4s, `stop` outage → recovery 15s.

## CLI (fastest)
```bash
# 1. confirm broke (000 / 500)
curl -s -m 5 http://127.0.0.1:8092/ || echo "BROKE"
# 2. redeploy prev-stable
TAG=d1d810a APP_VERSION=prod GIT_SHA=prod-stable CONTAINER_NAME=my-app-prod HOST_PORT=8092 \
docker compose -p my-app-prod -f stacks/my-app/compose.yaml -f stacks/my-app/compose.prod.yaml up -d
# 3. verify
sleep 3; curl -s http://127.0.0.1:8092/
# expect {"app":"my-app","version":"prod","sha":"prod-stable"}
```

## Portainer Custom Template (IDP-lite, no CLI)
- Custom Templates → Add: name `my-app-prev-stable`, repo `https://github.com/krazylearner/devops-stacks.git`, compose path `stacks/my-app/compose.yaml`
- Env preset: `TAG=d1d810a, APP_VERSION=prod, GIT_SHA=prod-stable, CONTAINER_NAME=my-app-prod, HOST_PORT=8092`
- **Day 49-52 proven (2026-09-15)**: `templates/templates.json` (Settings→Custom Templates→URL=raw.githubusercontent raw URL, pushed main 3ccf7e1) — template `my-app prev-stable (rollback)` one-click deployed by non-admin user `junior` → stack `my-app-rollback` :8093 healthy `{"sha":"prod-stable"}` TAG=d1d810a, 5s. Junior has env access RoleId=1 only; delete/re-pwd `junior` post-drill if done.
- Stacks → my-app-prod → Update → select template version → Rollback → verify :8092 200

## Webhook emergency (no UI login)
```bash
export PORTAINER_WEBHOOK_MYAPP=<GH secret PORTAINER_WEBHOOK_MYAPP>
curl -X POST $PORTAINER_WEBHOOK_MYAPP
# else fallback: ./stacks/whoami/webhook-redeploy.sh pattern for my-app
```

## Record
- Note broke TAG + time, stable TAG, `ROLLBACK_TOOK` (<300s target).
- `gh run list --repo krazylearner/devops-stacks` to confirm last good CI SHA.
