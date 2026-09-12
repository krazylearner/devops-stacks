# Phase 2 — Homelab Services (Day 15-32)

## Day 15-17 — Project 2: Reverse proxy + HTTPS

- [ ] Stack `jc21/nginx-proxy-manager:2` ports `81:81 80:80 443:443` + volumes `npm_data/letsencrypt`
- [ ] Proxy `whoami` → `whoami.<IP>.nip.io`, test `X-Real-IP` header
- [ ] Day 17 alt: repeat with `traefik:v3.1` + labels

!!! success "✅ Validation"
    Routing works. Notes: ___

## Day 18-21 — Project 3: WordPress + MySQL

- [ ] Stack `wordpress:6.6 + mysql:8.4`, volumes `wp_data/db_data`, env secrets, behind NPM
- [ ] Create `backup-wp.sh` (mysqldump + tar), test restore

!!! success "✅ Validation"
    Survives down/up + backup ok. Notes: ___

## Day 22-24 — Project 4: Wiki/Media (pick one)

- [ ] `lscr.io/linuxserver/bookstack` or `nextcloud + postgres + redis`, custom net, healthcheck, limits

!!! success "✅ Validation"
    Healthcheck green. Notes: ___

## Day 25-27 — Project 5: Monitoring lite

- [ ] Stack `louislam/uptime-kuma + beszel/beszel + beszel-agent`, add all URLs, webhook to Discord/Slack
- [ ] Stop a container → alert fires

!!! success "✅ Validation"
    Alert <2min. Notes: ___

## Day 28-29 — Logs + Maintenance

- [ ] `docker logs --tail 100 --since 1h`, set `max-size=10m max-file=3`, `docker system df`, cron weekly prune

!!! success "✅ Validation"
    Disk doc + cron set. Notes: ___

## Day 30-32 — Hardening

- [ ] `ufw allow 22,80,443,9443 && ufw enable`, `fail2ban`, unattended-upgrades, nightly `portainer_data` cron to `/backup`
- [ ] Reboot test: all `restart:always` up

!!! success "✅ Validation"
    Reboot green. Notes: ___
