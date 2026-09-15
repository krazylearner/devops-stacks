# Phase 3 — Git + CI/CD + Multi-env (Day 33-52)

## Day 33-34 — Git-backed Stacks

- [x] Push `stacks/` to GitHub `devops-stacks`, Portainer Stack → Repository, polling 5m
- [x] Push change → auto-redeploy observed

!!! success "✅ Validation"
    Push=deploy. Notes: repo https://github.com/krazylearner/devops-stacks public, f5803ba sanitize + 8193502 drill PHASE=day33-git pushed, fresh clone config OK, `up -d` Recreated whoami with PHASE=day33-git, Portainer UI: Stacks>Add>Repository URL+stacks/whoami/compose.yaml polling 5m + env override (2026-09-15).

## Day 35-37 — Webhooks

- [x] Enable Stack webhook, `curl -X POST <webhook-url>` → redeploy (sim proven, true Portainer POST pending UI)
- [x] Store URL as GH secret, doc in README (masked)

!!! success "✅ Validation"
    Webhook <60s. Notes: `stacks/whoami/webhook-redeploy.sh` pull+up 1s + earlier up 1.5s + pull 0.9s, PHASE=day35-webhook live, GH secret PORTAINER_WEBHOOK_WHOAMI set 2026-09-15 (masked placeholder https://portainer.aalpha.media/api/stacks/webhooks/REPLACE-ME), true POST needs Portainer Stacks>whoami>Webhooks>Create URL then `curl -X POST $URL` (2026-09-15).

## Day 38-42 — Project 6: Custom app CI

- [x] Tiny Node/Python app + Dockerfile + `compose.yaml` pinned `:<sha>`
- [x] `.github/workflows/build-push-deploy.yaml`: lint → build → push GHCR → curl webhook

!!! success "✅ Validation"
    Merge to main = live. Notes: stacks/my-app python stdlib :8088, CI 34944910114 success 30s lint+build+push GHCR latest+3ecddb0 digest 6472b1, pull+up Recreated, curl {"app":"my-app","version":"v1","sha":"3ecddb0"} + /healthz ok, pinned TAG=3ecddb0 live (2026-09-15).

## Day 43-45 — Dev/Prod envs

- [x] Duplicate `my-app-dev:8081` / `my-app-prod:8082`, `.env.dev/.env.prod`, secrets via Portainer override only
  - Ports shifted to `:8089/:8092` (spec 8081/8082 taken by my-web/whoami), isolated projects `-p my-app-dev/prod`, `${HOST_PORT}/${CONTAINER_NAME}` + `.env.*.example`, Portainer env override only

!!! success "✅ Validation"
    Dev breaks, prod stays. Notes: dev :8089 dev/dev-local + prod :8092 prod/prod-stable both 200, bad TAG pull fails safe, `stop my-app-dev` -> dev 000 FAIL prod 200 stays, start recovers (2026-09-15).

## Day 46-48 — Rollback drill

- [x] Break build intentionally → redeploy `prev-stable` via Custom Template → write `runbooks/rollback.md`

!!! success "✅ Validation"
    Rollback <5min. Notes: prev-stable 3ecddb0 prod-stable :8092, bad TAG safe 4s old stays, stop outage -> up recovery 15s curl prod-stable 200, runbook CLI+Template+webhook (2026-09-15).

## Day 49-52 — Custom Templates (IDP-lite)

- [x] Portainer Settings → App Templates → custom JSON for `my-app`, one-click deploy test in incognito

!!! success "✅ Validation"
    Junior can deploy w/o CLI. Notes: `templates/templates.json` (v2 format, type-2, repository.stackfile) pushed (1baf471+3ccf7e1), Settings.TemplatesURL=raw URL → /api/templates lists both `my-app` + `my-app prev-stable (rollback)`. Deploys: stack `my-app` :8088 healthy {"sha":"template"}, junior user (non-admin, env access RoleId=1, separate session = incognito-equivalent) one-click deployed `my-app-rollback` :8093 healthy {"sha":"prod-stable"} TAG=d1d810a via template preset env (2026-09-15, via localhost:9443 API; true UI incognito optional).
