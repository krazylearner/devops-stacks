# Phase 0 — Foundations + Install (Day 1-3)

## Day 1 — Linux + Git refresh

- [x] `uname -a && lsb_release -a && df -h && free -h && ss -tlnp`
- [x] `git config --global user.name/email && ssh-keygen -t ed25519`
- [x] `git init /root/dev/devops && echo "# devops" > README.md && git add . && git commit -m "init"`
- [x] Practice: `nano/vim, chmod 600, systemctl status, journalctl -xe | head`

!!! success "✅ Validation"
    Can explain file perms + systemd + commit/push. Notes: Ubuntu 24.04 noble, SSH ed25519 exists (600), git krazylearner <ankurbansal0562@gmail.com>, main @ 3928b78 init, branch renamed master→main, .gitignore covers .venv/site.

## Day 2 — Install Docker Engine (official, not snap)

- [x] `snap list | grep -i docker || echo "no snap docker"`
- [x] Install keyring + repo:
    ```bash
    apt-get update && apt-get install -y ca-certificates curl gnupg
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" | tee /etc/apt/sources.list.d/docker.list
    apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
    ```
- [x] `docker --version && docker compose version && docker run hello-world && docker run --rm nginx:alpine nginx -v`

!!! success "✅ Validation"
    Both version cmds + hello-world ok. Notes: Docker 29.8.0, Compose v5.5.1, hello-world ok, nginx:alpine 1.31.5 ok (2026-09-12).

## Day 3 — Install Portainer CE LTS

- [x] Create `portainer-compose.yaml`:
    ```yaml
    services:
      portainer:
        container_name: portainer
        image: portainer/portainer-ce:lts
        restart: always
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock
          - portainer_data:/data
        ports:
          - 127.0.0.1:8000:8000
          - 127.0.0.1:9443:9443
    volumes:
      portainer_data:
        name: portainer_data
    networks:
      default:
        name: portainer_network
    ```
- [x] `docker volume create portainer_data && docker compose -f portainer-compose.yaml up -d`
- [x] `docker ps | grep portainer && docker logs portainer --tail 20`
- [x] Open `https://<IP>:9443` → create admin (12+ chars, <15min or get token via logs) → Home → local → Containers

!!! success "✅ Validation"
    Portainer lists its own container. Notes: 2.45.0 lts, admin krazylearner via API + X-Setup-Token, proxied at https://portainer.aalpha.media via Caddy (trusted TLS), ports localhost-only (125f966).
