# Phase 2 — Homelab Services (Day 15-32)

## Day 15-17 — Project 2: Reverse proxy + HTTPS

- [x] Stack `jc21/nginx-proxy-manager:2` ports `8181:81 8085:80 8443:443` + volumes `npm_data/letsencrypt` (alt ports because Caddy uses 80/443)
- [x] Proxy `whoami` → `whoami.<IP>.nip.io`, test `X-Real-IP` header
- [ ] Day 17 alt: repeat with `traefik:v3.1` + labels

!!! success "✅ Validation"
    Routing works. Notes: npm Up 8085->80,8181->81,8443->443, proxy host id=1 whoami.173.249.42.241.nip.io -> whoami:80, curl Host header returns Hostname 9e17095d93c7 with X-Real-Ip + X-Forwarded-For, npm joined whoami_default (2026-09-14).

## Day 18-21 — Project 3: WordPress + MySQL

- [x] Stack `wordpress:6.6 + mysql:8.4`, volumes `wp_data/db_data`, env secrets, behind NPM
- [x] Create `backup-wp.sh` (mysqldump + tar), test restore

!!! success "✅ Validation"
    Survives down/up + backup ok. Notes: wp-web 8086:80 302 installer, wp-db healthy 8.4.11, volumes wordpress_wp_data/db_data, gate wp.173.249.42.241.nip.io id=2 -> wp-web:80 302 ok, backup sql 1.3K + tgz 24M, down/up 302 survives, npm stays on wordpress_default (2026-09-14).

## Day 22-24 — Project 4: Wiki/Media (pick one)

- [x] `lscr.io/linuxserver/bookstack` + `mariadb:11`, custom net `bookstack_default`, healthcheck, limits 512m
- [x] Behind NPM `books.<IP>.nip.io` id=3, direct + gate 200

!!! success "✅ Validation"
    Healthcheck green. Notes: bs-web healthy 200 /login, bs-db healthy 11.8.9, APP_KEY generated, DB_USERNAME/PASSWORD fix + config wipe, volumes bookstack_bs_config/db_data, gate books.173.249.42.241.nip.io -> bs-web:80 200, mem 52M/512M + 112M/512M ok (2026-09-14).

## Day 25-27 — Project 5: Monitoring lite

- [x] Stack `louislam/uptime-kuma + beszel/beszel + beszel-agent`, add all URLs, webhook to Discord/Slack
- [x] Stop a container → alert fires

!!! success "✅ Validation"
    Alert <2min. Notes: kuma 8090->3001 healthy 302 setup, beszel 8091->8090 200, agent Up :45876 with ed25519 key (HUB_URL paired in UI), gate kuma.173.249.42.241.nip.io id=4 -> kuma:3001 302, drill my-nginx 200 -> stop 000 FAIL -> start 200, add monitors in Kuma UI for 8080,8081,8082,8083,8086,8087 + webhook Discord/Slack in Settings>Notifications (2026-09-14).

## Day 28-29 — Logs + Maintenance

- [x] `docker logs --tail 100 --since 1h`, set `max-size=10m max-file=3`, `docker system df`, cron weekly prune
- [x] Disk doc + cron set in `/etc/cron.weekly/docker-prune` + `/etc/docker/daemon.json`

!!! success "✅ Validation"
    Disk doc + cron set. Notes: logs my-nginx tail shows 404 scans, wp-web empty since 1h ok, df Images 18/8.35GB reclaim 1.6GB Volumes 11/504MB, daemon.json max-size 10m max-file 3 proof kuma {} -> recreate -> {max-file 3 max-size 10m}, restart docker all 14 Up, cron weekly image+builder prune until 168h no volumes test exit 0 (2026-09-14).

## Day 30-32 — Hardening

- [x] `ufw allow 22,80,443,9443 && ufw enable`, `fail2ban`, unattended-upgrades, nightly `portainer_data` cron to `/backup`
- [x] Reboot test: all `restart:always` up (docker daemon restart proof, host reboot ready)

!!! success "✅ Validation"
    Reboot green. Notes: ufw active deny incoming allow outgoing, 22 ssh +80 caddy +443 caddy +9443 plan, toys still 200/302 Docker bypasses ufw, fail2ban sshd 9904 failed 1164 banned 1 now, unattended-upgrades 20auto-upgrades 1/1 already on, /backup/portainer-2026-09-14.tgz 62K + /etc/cron.daily/portainer-backup keep 7d exit 0, all 14 restart=always verified + daemon restart all Up (2026-09-14).
