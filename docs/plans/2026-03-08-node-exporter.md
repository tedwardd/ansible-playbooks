# Node Exporter Installation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Install prometheus node_exporter on all server hosts via the linux_common role using the prometheus.prometheus community collection.

**Architecture:** Add defaults, a thin task wrapper invoking `prometheus.prometheus.node_exporter` via `include_role`, and wire it into the linux_common task orchestrator. Gate on `node_exporter_enabled` and `host_type == 'server'`.

**Tech Stack:** Ansible, prometheus.prometheus collection (v0.28.0, already installed), systemd

---

### Task 1: Add node_exporter defaults

**Files:**
- Modify: `roles/linux_common/defaults/main.yaml`

**Step 1: Add defaults**

Append to `roles/linux_common/defaults/main.yaml`:

```yaml
node_exporter_enabled: true
node_exporter_version: "1.9.0"
node_exporter_web_listen_address: "0.0.0.0:9100"
```

**Step 2: Syntax check**

```bash
ansible-playbook servers.yaml --syntax-check
```
Expected: `playbook: servers.yaml` with no errors.

**Step 3: Commit**

```bash
git add roles/linux_common/defaults/main.yaml
git commit -m "feat(linux_common): add node_exporter defaults"
```

---

### Task 2: Create node_exporter task file

**Files:**
- Create: `roles/linux_common/tasks/node_exporter.yaml`

**Step 1: Create the task file**

```yaml
---
- name: Install node_exporter
  ansible.builtin.include_role:
    name: prometheus.prometheus.node_exporter
  when: node_exporter_enabled | bool and host_type == 'server'
```

Note: `include_role` is used instead of `import_role` because `when` on `import_role` only gates the tasks but still evaluates the role's vars/defaults unconditionally. `include_role` fully skips the role when the condition is false.

**Step 2: Syntax check**

```bash
ansible-playbook servers.yaml --syntax-check
```
Expected: no errors.

**Step 3: Commit**

```bash
git add roles/linux_common/tasks/node_exporter.yaml
git commit -m "feat(linux_common): add node_exporter task file"
```

---

### Task 3: Wire node_exporter into linux_common main task

**Files:**
- Modify: `roles/linux_common/tasks/main.yaml`

**Step 1: Append import to main.yaml**

Add after the existing `ebpf-net-exporter` block:

```yaml
- name: Install node_exporter
  ansible.builtin.import_tasks: node_exporter.yaml
  become: true
```

The full file should now end with:

```yaml
- name: Install ebpf-net-exporter
  ansible.builtin.import_tasks: ebpf_net_exporter.yaml
  become: true

- name: Install node_exporter
  ansible.builtin.import_tasks: node_exporter.yaml
  become: true
```

**Step 2: Syntax check**

```bash
ansible-playbook servers.yaml --syntax-check
```
Expected: no errors.

**Step 3: Check mode dry-run**

```bash
ansible-playbook servers.yaml --check --limit jumpstar
```
Expected: tasks run in check mode, `Install node_exporter` tasks appear in output, no failures.

**Step 4: Commit**

```bash
git add roles/linux_common/tasks/main.yaml
git commit -m "feat(linux_common): wire node_exporter into main tasks"
```

---

### Task 4: Verify live installation (manual)

This task requires SSH access to the servers.

**Step 1: Run against one server first**

```bash
ansible-playbook servers.yaml --limit jumpstar --tags node_exporter
```

If `--tags` doesn't filter to just node_exporter tasks (community role may not tag), run the full playbook:

```bash
ansible-playbook servers.yaml --limit jumpstar
```

Expected: node_exporter tasks complete with `changed` or `ok` status, no failures.

**Step 2: Verify service is running on the target**

```bash
ansible jumpstar -m shell -a "systemctl is-active node_exporter && curl -s localhost:9100/metrics | head -5"
```

Expected: `active` and prometheus metrics output.

**Step 3: Run against all servers**

```bash
ansible-playbook servers.yaml
```

Expected: no failures across jupiter and jumpstar.
