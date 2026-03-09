# Design: Prometheus Node Exporter via linux_common Role

## Summary

Install `prometheus.prometheus.node_exporter` on all server hosts via the `linux_common` role, using the existing `prometheus.prometheus` Ansible collection already present in the project.

## Approach

Use the `prometheus.prometheus.node_exporter` community role (from the same collection already used for the prometheus server on jupiter) via `include_role`. This handles user creation, binary download, architecture detection, and systemd service management automatically.

## Components

### New file: `roles/linux_common/tasks/node_exporter.yaml`

Thin wrapper that calls the community role, gated on a feature flag and host type:

```yaml
- name: Install node_exporter
  ansible.builtin.include_role:
    name: prometheus.prometheus.node_exporter
  when: node_exporter_enabled and host_type == 'server'
```

### Updated: `roles/linux_common/defaults/main.yaml`

Add defaults for node_exporter:

```yaml
node_exporter_enabled: true
node_exporter_version: "1.9.0"
node_exporter_web_listen_address: "0.0.0.0:9100"
```

### Updated: `roles/linux_common/tasks/main.yaml`

Add import at the end:

```yaml
- name: Install node_exporter
  ansible.builtin.import_tasks: node_exporter.yaml
  become: true
```

## Gate Condition

`when: node_exporter_enabled and host_type == 'server'`

- `node_exporter_enabled` — feature flag in defaults, can be overridden per host/group
- `host_type == 'server'` — set via group vars in hosts.yaml; guards against future workstation use of linux_common

## What the Community Role Handles

- Creates dedicated `node_exporter` system user/group
- Downloads correct binary for host architecture (amd64/arm64)
- Installs and enables the systemd service on port 9100
- Version pinning via `node_exporter_version`

## Hosts Affected

- `jupiter` (servers group)
- `jumpstar` (servers group)
