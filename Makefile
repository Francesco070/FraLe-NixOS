# Makefile

# Standard-Target
.PHONY: rebuild

rebuild:
	@if [ -z "$(USER)" ]; then \
		echo "Bitte gib den Benutzernamen an: make rebuild USER=<username>"; \
		exit 1; \
	fi
	sudo rm -r /etc/nixos/hardware-configuration.nix
	sudo nixos-generate-config
	cp /etc/nixos/hardware-configuration.nix /home/$(USER)/FraLe-NixOS/hosts/$(USER)-nixos/hardware-configuration.nix
	sudo nixos-rebuild switch --flake .#$(USER)-nixos
	$(eval GIT_VERSION := $(shell nix-env -q | grep "^git-" | awk '{print $$1}'))
	@if [ -n "$(GIT_VERSION)" ]; then \
		nix-env -e $(GIT_VERSION); \
	else \
		echo "Keine Git-Version gefunden."; \
	fi
