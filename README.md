# devops — Phase 1 Docker Core Done (Day 4-14)

> Portainer-first: GUI to learn → CLI to cement. Everything in git, rebuild from git only, pin versions.

## School Map (who lives where)

```
Internet -> Caddy https://portainer.aalpha.media -> 127.0.0.1:9443 portainer (portainer_network)
                                                          :8000
Visitors:
  :8080 my-nginx (nginx:alpine) --front--> isolated, cannot ping back
  :8081 my-web (my-web:v1, 256m/0.5) --my-web_default
  :8082 whoami (traefik/whoami FOO=bar, always) --whoami_default
  :8083 my-site (my-site:v1 rollback from v2 in 3.6s) --my-site_default
Secrets:
  pg-day6 (postgres:16, pgdata:/var/lib/postgresql/data) --back--> isolated
Networks: front (172.21) has my-nginx, back (172.22) has pg-day6, ping fails=good
Volumes: portainer_data (28K backup tgz), pgdata (t=1 survives rm, not -v)
```

## Magic Words (cheatsheet)

```bash
docker ps --filter name=my-nginx
docker images nginx:alpine
docker logs my-nginx --tail 20
docker exec my-nginx sh -c 'ps; cat /etc/os-release'
docker stop/start/rm my-nginx; docker run -d --name my-nginx -p 8080:80 --restart always nginx:alpine
docker network create front back; docker network connect front my-nginx; docker network connect back pg-day6
docker network inspect front
docker volume inspect pgdata
docker build -t my-web:v1 ./app; docker run -d -p 8081:80 my-web:v1
docker compose -f stacks/my-web/compose.yaml up -d; docker compose -f stacks/my-web/compose.yaml down
docker stats --no-stream my-web; docker system df; docker image prune -f
docker run --rm -v portainer_data:/src -v $(pwd):/dst alpine tar czf /dst/portainer-backup.tgz /src
# rebuild all from git (10s):
docker run -d --name my-nginx -p 8080:80 --restart always nginx:alpine
docker compose -f stacks/whoami/compose.yaml up -d
docker compose -f stacks/postgres/compose.yaml up -d
docker compose -f stacks/my-web/compose.yaml up -d
docker compose -f stacks/my-site/compose.yaml up -d
```

## Quiz Answers (Day 14)

- lifecycle: image=photo, container=tiffin=image+state; create/start/stop/rm/run proven Day 4
- volumes: named pgdata=labeled box survives rm, bind=home bag, anon=nameless plastic; drill Day 6 select 1 ok
- networks: bridge front/back isolation, front=my-nginx, back=pg-day6, ping bad address=good Day 7
- compose: stacks/my-web down/up twice same hi v1, UI paste same file Day 9; limits 256m/0.5 Day 10; rollback v2->v1 3.6s Day 11-12; rebuild 10.3s all 200 Day 13
- registry todo: need docker login / GHCR_PAT then push + Portainer Registries Add (tag demo done Day 10)
```
