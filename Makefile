.PHONY: install update sync health-check help clean

DOTFILES_DIR := $(shell cd "$(dirname "$(lastword $(MAKEFILE_LIST))")" && pwd)

help:
	@echo "Available targets:"
	@echo "  make install       - Install/symlink all dotfiles"
	@echo "  make sync          - Update all plugins and configurations"
	@echo "  make health-check  - Verify system setup"
	@echo "  make clean         - Remove backup files"
	@echo ""
	@echo "Language setup:"
	@echo "  make setup-python  - Setup Python development environment"
	@echo "  make setup-node    - Setup Node/Svelte environment"
	@echo "  make setup-rust    - Setup Rust toolchain"
	@echo "  make setup-go      - Setup Go environment"

install:
	@bash $(DOTFILES_DIR)/install.sh

sync: install
	@echo "Updating plugins..."
	@bash $(DOTFILES_DIR)/scripts/update-all.sh

health-check:
	@bash $(DOTFILES_DIR)/scripts/check-health.sh

setup-python:
	@bash $(DOTFILES_DIR)/languages/python.sh

setup-node:
	@bash $(DOTFILES_DIR)/languages/svelte.sh

setup-rust:
	@bash $(DOTFILES_DIR)/languages/rust.sh

setup-go:
	@bash $(DOTFILES_DIR)/languages/go.sh

build-zmk:
	@bash $(DOTFILES_DIR)/scripts/build-zmk.sh

edit-nvim:
	@nvim $(DOTFILES_DIR)/nvim

edit-tmux:
	@nvim $(DOTFILES_DIR)/tmux/tmux.conf

edit-zsh:
	@nvim $(DOTFILES_DIR)/shell/zshrc

clean:
	@find ~ -name "*.backup.*" -type f -mtime +7 -delete
	@echo "Old backup files cleaned"

.SILENT: help
