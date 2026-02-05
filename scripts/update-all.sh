#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "=== Updating All Components ==="
echo ""

# Update system packages
echo "📦 Updating system packages..."
sudo apt update
sudo apt upgrade -y

# Update Tmux plugins
echo "📦 Updating Tmux plugins..."
~/.tmux/plugins/tpm/bin/update_plugins all

# Update Neovim plugins (LazyVim)
echo "📦 Updating Neovim plugins..."
nvim --headless "+Lazy! sync" +qa

# Update language tools
echo "📦 Updating language tools..."

# Python
if command -v pipx &> /dev/null; then
    echo "  Updating Python tools..."
    pipx upgrade-all || true
fi

# Node
if command -v npm &> /dev/null; then
    echo "  Updating npm packages..."
    npm update -g || true
fi

# Rust
if command -v rustup &> /dev/null; then
    echo "  Updating Rust..."
    rustup update
fi

# Go
if command -v go &> /dev/null; then
    echo "  Updating Go tools..."
    go get -u ./...  || true
fi

echo ""
echo "✓ All components updated!"
