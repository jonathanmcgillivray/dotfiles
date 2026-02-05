#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "=== System Health Check ==="
echo ""

check_command() {
    local cmd=$1
    local name=${2:-$cmd}
    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $name"
        return 0
    else
        echo -e "${RED}✗${NC} $name"
        return 1
    fi
}

check_file() {
    local file=$1
    local name=${2:-$file}
    if [ -e "$file" ]; then
        echo -e "${GREEN}✓${NC} $name"
        return 0
    else
        echo -e "${RED}✗${NC} $name"
        return 1
    fi
}

echo "Core Tools:"
check_command zsh "Zsh shell"
check_command nvim "Neovim"
check_command tmux "Tmux"

echo ""
echo "Version Control:"
check_command git "Git"

echo ""
echo "Languages:"
check_command python3 "Python3"
check_command node "Node.js"
check_command cargo "Rust (cargo)"
check_command go "Go"

echo ""
echo "Development Tools:"
check_command npm "npm"
check_command pnpm "pnpm"
check_command docker "Docker" || true

echo ""
echo "Dotfiles Configuration:"
check_file ~/.zshrc "Zsh config"
check_file ~/.tmux.conf "Tmux config"
check_file ~/.config/nvim "Neovim config"
check_file ~/.dotfiles "Dotfiles directory"

echo ""
echo "Tmux Plugins:"
check_file ~/.tmux/plugins/tpm "Tmux Plugin Manager"

echo ""
echo "Shell Configuration:"

# Check if zshrc sources dotfiles
if grep -q "DOTFILES_DIR" ~/.zshrc 2>/dev/null; then
    echo -e "${GREEN}✓${NC} Dotfiles sourced in zshrc"
else
    echo -e "${YELLOW}!${NC} Dotfiles not sourced in zshrc"
fi

# Check if default shell is zsh
if [ "$SHELL" = "$(which zsh)" ]; then
    echo -e "${GREEN}✓${NC} Default shell is Zsh"
else
    echo -e "${YELLOW}!${NC} Default shell is not Zsh: $SHELL"
fi

echo ""
echo "=== Health Check Complete ==="
