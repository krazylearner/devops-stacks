# Phase 4 — Kubernetes (Day 53-72)

## Day 53-55 — k3s + Portainer env

- [x] `curl -sfL https://get.k3s.io | sh -` + `kubectl get nodes`
- [x] Add K8s env in Portainer via Portainer Agent (agent LB :9001)

!!! success "✅ Validation"
    K8s visible in Portainer + kubectl. Notes: Ready v1.36.4+k3s1; agent skaffold endpoint `k3s` (id 5, type 6); traefik svc switched LB→NodePort (hostPorts 80/443 freed for Caddy); agent manifest ce2-45 lb (portainer ns, SA clusteradmin).

## Day 56-58 — First manifests

- [x] `k8s-manifests/whoami/{ns,deploy(2 repl),svc,ingress}.yaml` via Portainer Manifest + `kubectl scale 2→3`

!!! success "✅ Validation"
    Both scale paths work. Notes: deployed via kubeconfig (manifests git-hosted); ingress via traefik NodePort :32432; scale 2→3 both pods Serving; round-robin across replicas via ingress.

## Day 59-62 — Project 7: Prod-grade nginx

- [x] Probes, limits `128Mi/250m`, ConfigMap, `kubectl rollout restart/undo` v1→v2

!!! success "✅ Validation"
    Zero-downtime. Notes: `k8s-manifests/prod-nginx/` (conf + html ConfigMaps, probes, 128Mi/250m caps, maxUnavailable=0); v1→v2 via cm+annotation revision, curl never 5xx (mix v1/v2 during roll); `rollout undo` rev3→v1 template; content rollback via cm v2→v1; restart clean. image imported `docker save → k3s ctr images import` (my-web:v1).

## Day 63-66 — Helm

- [ ] Helm `kube-prometheus-stack + grafana` via Portainer, values override, upgrade/rollback

!!! success "✅ Validation"
    Grafana dashboards. Notes: ___

## Day 67-69 — Storage + TLS

- [ ] `local-path` PVC postgres StatefulSet + `cert-manager + letsencrypt-staging`
- [ ] Delete pod → data survives

!!! success "✅ Validation"
    PVC + cert ok. Notes: ___

## Day 70-72 — K8s rebuild drill

- [ ] `k3s-uninstall.sh` → reinstall from git only, record time-to-green

!!! success "✅ Validation"
    Rebuild <30min. Notes: ___
