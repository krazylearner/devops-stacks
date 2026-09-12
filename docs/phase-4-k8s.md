# Phase 4 — Kubernetes (Day 53-72)

## Day 53-55 — k3s + Portainer env

- [ ] `curl -sfL https://get.k3s.io | sh -` + `kubectl get nodes`
- [ ] Add K8s env in Portainer via `/etc/rancher/k3s/k3s.yaml`

!!! success "✅ Validation"
    K8s visible in Portainer + kubectl. Notes: ___

## Day 56-58 — First manifests

- [ ] `k8s-manifests/whoami/{ns,deploy(2 repl),svc,ingress}.yaml` via Portainer Manifest + `kubectl scale 2→3`

!!! success "✅ Validation"
    Both scale paths work. Notes: ___

## Day 59-62 — Project 7: Prod-grade nginx

- [ ] Probes, limits `128Mi/250m`, ConfigMap, `kubectl rollout restart/undo` v1→v2

!!! success "✅ Validation"
    Zero-downtime. Notes: ___

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
