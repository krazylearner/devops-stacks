# Phase 5 — Platform: IaC, GitOps, Observability, Security (Day 73-86)

## Day 73-75 — Project 8: Terraform + Ansible

- [ ] Terraform VM (Hetzner/AWS `t3.small`) + Ansible `docker + portainer-agent` → 2nd env in Portainer

!!! success "✅ Validation"
    2 envs in one UI. Notes: ___

## Day 76-78 — Project 9: ArgoCD GitOps

- [ ] Install ArgoCD, App-of-Apps → `k8s-manifests/`, auto-sync, Portainer for RBAC/logs only

!!! success "✅ Validation"
    Git push = sync. Notes: ___

## Day 79-81 — Project 10: LGTM

- [ ] `prometheus + grafana + loki + promtail`, `node-exporter/cadvisor`, LogQL, alert `CPU>80% 5m`

!!! success "✅ Validation"
    Dashboard + alert. Notes: ___

## Day 82-84 — Security

- [ ] Teams/Roles admin/operator/viewer test, OIDC if avail, Trivy `fail HIGH` in CI, private registry auth

!!! success "✅ Validation"
    Viewer cannot delete. Notes: ___

## Day 85-86 — Backup/DR

- [ ] Cron `tar portainer_data + pg_dump → S3/rclone`, restore on fresh VM, `runbooks/restore.md` with RTO/RPO

!!! success "✅ Validation"
    Restore verified. Notes: ___
