# Rollback — my-app prod → prev-stable (Day 46-48, <5min proven 15s)

Prev-stable: `ghcr.io/krazylearner/devops-stacks/my-app:3ecddb0` (prod prod-stable, :8092).
Proven: bad TAG pull fails safe 4s, `stop` outage → recovery 15s.

## CLI (fastest)
```bash
# 1. confirm broke (000 / 500)
curl -s -m 5 http://127.0.0.1:8092/ || echo "BROKE"
# 2. redeploy prev-stable
TAG=3ecddb0 APP_VERSION=prod GIT_SHA=prod-stable CONTAINER_NAME=my-app-prod HOST_PORT=8092 \
docker compose -p my-app-prod -f stacks/my-app/compose.yaml -f stacks/my-app/compose.prod.yaml up -d
# 3. verify
sleep 3; curl -s http://127.0.0.1:8092/
# expect {"app":"my-app","version":"prod","sha":"prod-stable"}
```

## Portainer Custom Template (IDP-lite, no CLI)
- Custom Templates → Add: name `my-app-prev-stable`, repo `https://github.com/krazylearner/devops-stacks.git`, compose path `stacks/my-app/compose.yaml`
- Env preset: `TAG=3ecddb0, APP_VERSION=prod, GIT_SHA=prod-stable, CONTAINER_NAME=my-app-prod, HOST_PORT=8092`
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
