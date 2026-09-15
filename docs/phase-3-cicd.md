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

- [ ] Duplicate `my-app-dev:8081` / `my-app-prod:8082`, `.env.dev/.env.prod`, secrets via Portainer override only

!!! success "✅ Validation"
    Dev breaks, prod stays. Notes: ___

## Day 46-48 — Rollback drill

- [ ] Break build intentionally → redeploy `prev-stable` via Custom Template → write `runbooks/rollback.md`

!!! success "✅ Validation"
    Rollback <5min. Notes: ___

## Day 49-52 — Custom Templates (IDP-lite)

- [ ] Portainer Settings → App Templates → custom JSON for `my-app`, one-click deploy test in incognito

!!! success "✅ Validation"
    Junior can deploy w/o CLI. Notes: ___
