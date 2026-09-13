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

- [ ] Create networks `front/back` in Portainer → attach nginx to front, postgres to back, test `ping` via exec
- [ ] `docker network inspect front`

!!! success "✅ Validation"
    Can draw bridge isolation. Notes: ___

## Day 8 — Dockerfile build

- [ ] `mkdir app && echo "<h1>hi</h1>" > app/index.html` + `Dockerfile FROM nginx:alpine + COPY`
- [ ] `docker build -t my-web:v1 ./app && docker run -d -p 8081:80 my-web:v1`

!!! success "✅ Validation"
    Custom image runs in Portainer. Notes: ___

## Day 9 — Compose / Stacks

- [ ] Write `stacks/my-web/compose.yaml` for Day 8, deploy as Portainer Stack, then `docker compose down/up` via CLI

!!! success "✅ Validation"
    Same stack works UI+CLI. Notes: ___

## Day 10 — Registries + Limits + Prune

- [ ] Tag/push `my-web:v1` to Docker Hub/GHCR, add registry in Portainer
- [ ] Set limits `256m/0.5 cpu`, `docker system df`, `docker image prune -a -f`

!!! success "✅ Validation"
    Pushed + limits set. Notes: ___

## Day 11-12 — Project 1: Versioned site + backup

- [ ] Build `my-site:v1,v2`, deploy v2, rollback to v1 via Portainer
- [ ] Backup: `docker run --rm -v portainer_data:/src -v $(pwd):/dst alpine tar czf /dst/portainer-backup.tgz /src`

!!! success "✅ Validation"
    Rollback <2min, backup.tgz exists. Notes: ___

## Day 13 — Destroy/rebuild drill

- [ ] `docker compose down -v` test apps → rebuild only from git, zero manual clicks

!!! success "✅ Validation"
    Rebuild <10min. Notes: ___

## Day 14 — Review

- [ ] Update `README.md` with diagram + commands, self-quiz lifecycle/volumes/networks/compose

!!! success "✅ Validation"
    Ready for homelab. Notes: ___
