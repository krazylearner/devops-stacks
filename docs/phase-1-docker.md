# Phase 1 — Docker Core via Portainer (Day 4-14)

## Day 4 — Containers vs Images

- [x] UI: Images pull `nginx:alpine` → Containers Add `my-nginx` 8080:80 → browse `http://<IP>:8080`
- [x] `docker ps/images/logs my-nginx` + exec `sh` + stop/start/remove in UI

!!! success "✅ Validation"
    Can explain container=image+state. Notes: nginx:alpine 103MB (Alpine 3.24.1, nginx master+4 workers), my-nginx 8080:80 HTTP 200, stop→Exited→start→Up→rm→run ok, restart=always (2026-09-13).

## Day 5 — Ports, Env, Restart

- [x] Run `traefik/whoami` with env `FOO=bar`, restart `always`
- [x] Reboot test: `docker restart` → app auto-up

!!! success "✅ Validation"
    Survives restart. Notes: whoami 8082:80 HTTP 200, Env FOO=bar via inspect (image has no shell so exec env fails, expected), restart=always, restart→Up 3s ok (2026-09-13).

## Day 6 — Volumes persistence

- [x] Stack `postgres:16` + volume `pgdata:/var/lib/postgresql/data` + `POSTGRES_PASSWORD=secret`
- [x] Exec `psql -U postgres -c "create table t(id int); insert into t values(1);"`
- [x] `docker stop + rm` container only → recreate → `select * from t;` still there

!!! success "✅ Validation"
    Explain named vs bind vs anonymous. Notes: pgdata named volume survives rm, select shows 1 after recreate. Named=labeled box pgdata, bind=home bag, anon=nameless plastic (2026-09-13).

## Day 7 — Networks

- [x] Create networks `front/back` in Portainer → attach nginx to front, postgres to back, test `ping` via exec
- [x] `docker network inspect front`

!!! success "✅ Validation"
    Can draw bridge isolation. Notes: front has my-nginx 172.21.0.2, back has pg-day6 172.22.0.2, ping fails=good isolation (2026-09-13).

## Day 8 — Dockerfile build

- [x] `mkdir app && echo "<h1>hi</h1>" > app/index.html` + `Dockerfile FROM nginx:alpine + COPY`
- [x] `docker build -t my-web:v1 ./app && docker run -d -p 8081:80 my-web:v1`

!!! success "✅ Validation"
    Custom image runs in Portainer. Notes: my-web:v1 102MB serves hi from my-web v1 on 8081 HTTP 200 (2026-09-13).

## Day 9 — Compose / Stacks

- [x] Write `stacks/my-web/compose.yaml` for Day 8, deploy as Portainer Stack, then `docker compose down/up` via CLI

!!! success "✅ Validation"
    Same stack works UI+CLI. Notes: my-web compose down/up twice same hi v1 on 8081, CLI parity ok (Portainer Stack paste same file) (2026-09-13).

## Day 10 — Registries + Limits + Prune

- [x] Tag/push `my-web:v1` to Docker Hub/GHCR, add registry in Portainer
- [x] Set limits `256m/0.5 cpu`, `docker system df`, `docker image prune -a -f`

!!! success "✅ Validation"
    Pushed + limits set. Notes: limits 256m/0.5 set my-web Mem 4.6/256MiB ok, df 2.6GB, safe prune done (kept semgrep 1.5GB, needs explicit prune -a). Push pending shop key: tag demo ok, need docker login or GHCR_PAT then push + Portainer Registries Add (2026-09-13).

## Day 11-12 — Project 1: Versioned site + backup

- [x] Build `my-site:v1,v2`, deploy v2, rollback to v1 via Portainer
- [x] Backup: `docker run --rm -v portainer_data:/src -v $(pwd):/dst alpine tar czf /dst/portainer-backup.tgz /src`

!!! success "✅ Validation"
    Rollback <2min, backup.tgz exists. Notes: v2 red then v1 blue rollback 3.6s ok on 8083, backup 28K with portainer.db+tls (2026-09-13).

## Day 13 — Destroy/rebuild drill

- [x] `docker compose down -v` test apps → rebuild only from git, zero manual clicks

!!! success "✅ Validation"
    Rebuild <10min. Notes: down -v all toys (pgdata deleted as expected), rebuild from git 10.3s all 200 (8080,8081,8082,8083), front/back re-attached, t=1 re-seeded (2026-09-13).

## Day 14 — Review

- [ ] Update `README.md` with diagram + commands, self-quiz lifecycle/volumes/networks/compose

!!! success "✅ Validation"
    Ready for homelab. Notes: ___
