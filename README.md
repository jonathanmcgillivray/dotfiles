# Dotfiles

Personal development environment configuration for Linux/Ubuntu.

**Tools:** Neovim (LazyVim) • Tmux • Zsh • ZMK (Glove80 Colemak Mod-DH)

**Languages:** Python • Svelte • Rust • Go

## Quick Start

```bash
# Clone and install
git clone <your-repo> ~/.dotfiles
cd ~/.dotfiles
./install.sh

# Or use make
make install
```

## Structure

- **nvim/** — Neovim LazyVim config with LSP for Python/Svelte/Rust/Go
- **tmux/** — Tmux configuration with keybindings and theme
- **shell/** — Zsh configuration, aliases, functions, completions
- **zmk/** — ZMK build integration and Glove80 keymap reference
- **scripts/** — Development utility scripts
- **languages/** — Language-specific setup (Python, Node, Rust, Go)
- **git/** — Global git config and hooks
- **install/** — OS-specific installation helpers
- **docs/** — Documentation and setup guides

## Installation

### Fresh System

```bash
make install      # Install everything
make health-check # Verify setup
```

### Update

```bash
make sync         # Update all plugins and configs
```

### Language Environments

```bash
# Python development
source shell/exports.sh && bash languages/python.sh

# Node/Svelte
bash languages/svelte.sh

# Rust
bash languages/rust.sh

# Go
bash languages/go.sh
```

## ZMK Glove80

Build ZMK firmware:

```bash
./scripts/build-zmk.sh
```

See `docs/KEYBOARD.md` for keymap details.

## Keybindings Reference

See `docs/KEYBINDINGS.md` for Neovim and Tmux keybindings.

## Troubleshooting

See `docs/TROUBLESHOOTING.md` for common issues.

## Notes

- Symlink-based installation (transparent, debuggable)
- Modular structure: update individual tools independently
- Language-aware: Python venv, npm, cargo, go all supported
- Machine-agnostic (easily extended for Darwin/macOS)
