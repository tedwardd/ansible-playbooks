ANSIBLE    := ansible-playbook
PLAYBOOKS  := servers.yaml workstations.yaml external_servers.yaml mail.yaml chiafarm.yaml
EXTRA_ARGS ?=

# Generic targets — set PLAYBOOK=, and optionally LIMIT= and/or TAGS=
.PHONY: run check
run:
	$(ANSIBLE) $(PLAYBOOK) \
	  $(if $(LIMIT),--limit $(LIMIT),) \
	  $(if $(TAGS),--tags $(TAGS),) \
	  $(EXTRA_ARGS)

check:
	$(ANSIBLE) $(PLAYBOOK) --check \
	  $(if $(LIMIT),--limit $(LIMIT),) \
	  $(if $(TAGS),--tags $(TAGS),) \
	  $(EXTRA_ARGS)

# ── Per-playbook targets ───────────────────────────────────────────────────────
.PHONY: servers servers-check
servers:
	$(ANSIBLE) servers.yaml $(EXTRA_ARGS)

servers-check:
	$(ANSIBLE) servers.yaml --check $(EXTRA_ARGS)

.PHONY: workstations workstations-check
workstations:
	$(ANSIBLE) workstations.yaml $(EXTRA_ARGS)

workstations-check:
	$(ANSIBLE) workstations.yaml --check $(EXTRA_ARGS)

.PHONY: external external-check
external:
	$(ANSIBLE) external_servers.yaml $(EXTRA_ARGS)

external-check:
	$(ANSIBLE) external_servers.yaml --check $(EXTRA_ARGS)

.PHONY: mail mail-check
mail:
	$(ANSIBLE) mail.yaml $(EXTRA_ARGS)

mail-check:
	$(ANSIBLE) mail.yaml --check $(EXTRA_ARGS)

# ── Per-host targets ───────────────────────────────────────────────────────────
.PHONY: jumpstar jumpstar-check
jumpstar:
	$(ANSIBLE) servers.yaml --limit jumpstar $(EXTRA_ARGS)

jumpstar-check:
	$(ANSIBLE) servers.yaml --check --limit jumpstar $(EXTRA_ARGS)

.PHONY: jupiter jupiter-check
jupiter:
	$(ANSIBLE) servers.yaml --limit jupiter $(EXTRA_ARGS)

jupiter-check:
	$(ANSIBLE) servers.yaml --check --limit jupiter $(EXTRA_ARGS)

.PHONY: ministar ministar-check
ministar:
	$(ANSIBLE) servers.yaml --limit ministar $(EXTRA_ARGS)

ministar-check:
	$(ANSIBLE) servers.yaml --check --limit ministar $(EXTRA_ARGS)

.PHONY: xbook2 xbook2-check
xbook2:
	$(ANSIBLE) workstations.yaml --limit xbook2 $(EXTRA_ARGS)

xbook2-check:
	$(ANSIBLE) workstations.yaml --check --limit xbook2 $(EXTRA_ARGS)

# ── Utility targets ────────────────────────────────────────────────────────────
.PHONY: galaxy
galaxy:
	ansible-galaxy install -r requirements.yaml

.PHONY: syntax-check
syntax-check:
	$(foreach pb,$(PLAYBOOKS),$(ANSIBLE) --syntax-check $(pb);)

.PHONY: list-hosts
list-hosts:
	ansible all --list-hosts

.PHONY: help
help:
	@echo "Playbook targets:"
	@echo "  servers          workstations       external           mail"
	@echo "  servers-check    workstations-check external-check     mail-check"
	@echo ""
	@echo "Per-host targets:"
	@echo "  jumpstar   jumpstar-check"
	@echo "  jupiter    jupiter-check"
	@echo "  ministar   ministar-check"
	@echo "  xbook2     xbook2-check"
	@echo ""
	@echo "Generic targets (set PLAYBOOK=, optionally LIMIT= and/or TAGS=):"
	@echo "  run    e.g. make run PLAYBOOK=servers.yaml LIMIT=jumpstar TAGS=nginx"
	@echo "  check  e.g. make check PLAYBOOK=servers.yaml LIMIT=jumpstar"
	@echo ""
	@echo "Utility:"
	@echo "  galaxy        Install roles/collections from requirements.yaml"
	@echo "  syntax-check  Syntax-check all playbooks"
	@echo "  list-hosts    List all hosts in inventory"
	@echo ""
	@echo "Append EXTRA_ARGS='...' to any target to pass extra flags to ansible-playbook"
