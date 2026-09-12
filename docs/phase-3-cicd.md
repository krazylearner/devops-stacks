# Phase 3 — Git + CI/CD + Multi-env (Day 33-52)

## Day 33-34 — Git-backed Stacks

- [ ] Push `stacks/` to GitHub `devops-stacks`, Portainer Stack → Repository, polling 5m
- [ ] Push change → auto-redeploy observed

!!! success "✅ Validation"
    Push=deploy. Notes: ___

## Day 35-37 — Webhooks

- [ ] Enable Stack webhook, `curl -X POST <webhook-url>` → redeploy
- [ ] Store URL as GH secret, doc in README (masked)

!!! success "✅ Validation"
    Webhook <60s. Notes: ___

## Day 38-42 — Project 6: Custom app CI

- [ ] Tiny Node/Python app + Dockerfile + `compose.yaml` pinned `:<sha>`
- [ ] `.github/workflows/build-push-deploy.yaml`: lint → build → push GHCR → curl webhook

!!! success "✅ Validation"
    Merge to main = live. Notes: ___

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
