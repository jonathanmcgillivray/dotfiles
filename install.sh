#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}=== Dotfiles Installation ===${NC}"
echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# Backup existing configs
backup_existing() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local backup="${file}.backup.$(date +%s)"
        echo -e "${YELLOW}Backing up $file to $backup${NC}"
        mv "$file" "$backup"
    fi
}

# Create symlink
symlink() {
    local src=$1
    local dest=$2

    if [ -L "$dest" ]; then
        # Remove old symlink
        rm "$dest"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo -e "${GREEN}✓${NC} $dest"
}

# Main installation
echo -e "${YELLOW}Step 1: Symlinking configuration files${NC}"

# Zsh
backup_existing ~/.zshrc
symlink "$DOTFILES_DIR/shell/zshrc" ~/.zshrc

# Tmux
backup_existing ~/.tmux.conf
symlink "$DOTFILES_DIR/tmux/tmux.conf" ~/.tmux.conf

# Neovim (entire config directory)
backup_existing ~/.config/nvim
symlink "$DOTFILES_DIR/nvim" ~/.config/nvim

# Git
backup_existing ~/.gitconfig
symlink "$DOTFILES_DIR/git/gitconfig" ~/.gitconfig

backup_existing ~/.gitignore_global
symlink "$DOTFILES_DIR/git/gitignore_global" ~/.gitignore_global

echo ""
echo -e "${YELLOW}Step 2: Checking system dependencies${NC}"

# Check for required packages
check_command() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}✓${NC} $1 found"
        return 0
    else
        echo -e "${RED}✗${NC} $1 not found"
        return 1
    fi
}

check_command zsh || echo -e "${YELLOW}  Install with: sudo apt install zsh${NC}"
check_command tmux || echo -e "${YELLOW}  Install with: sudo apt install tmux${NC}"
check_command nvim || echo -e "${YELLOW}  Install with: sudo apt install neovim${NC}"

echo ""
echo -e "${YELLOW}Step 3: Setting up Tmux Plugin Manager${NC}"

TMUX_PLUGINS_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TMUX_PLUGINS_DIR" ]; then
    echo "Cloning TPM..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGINS_DIR"
    echo -e "${GREEN}✓${NC} TPM installed"
else
    echo -e "${GREEN}✓${NC} TPM already installed"
fi

echo ""
echo -e "${YELLOW}Step 4: Setting up shell${NC}"

# Change shell to zsh if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
    echo -e "${GREEN}✓${NC} Shell changed to zsh (restart terminal to take effect)"
else
    echo -e "${GREEN}✓${NC} Already using zsh"
fi

echo ""
echo -e "${YELLOW}Step 5: Installing language environments${NC}"

# Create marker file so shell sources know dotfiles is installed
mkdir -p ~/.config/dotfiles
touch ~/.config/dotfiles/.installed

echo ""
echo -e "${GREEN}=== Installation Complete ===${NC}"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. Run: make health-check"
echo "  3. Setup languages: bash languages/python.sh (etc.)"
echo "  4. See docs/SETUP.md for detailed instructions"
echo ""
