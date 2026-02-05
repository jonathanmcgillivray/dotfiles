# Setup Guide

Complete setup instructions for the dotfiles repository.

## Initial Installation

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/dotfiles ~/.dotfiles
cd ~/.dotfiles
```

### 2. Run Install Script

```bash
chmod +x install.sh
./install.sh
```

The script will:
- Backup existing configuration files (with `.backup.<timestamp>` suffix)
- Create symlinks for all dotfiles
- Install Tmux Plugin Manager (TPM)
- Change default shell to Zsh (prompts for password)

### 3. Restart Terminal

```bash
exec zsh
```

## Post-Installation Setup

### 4. Verify Installation

```bash
make health-check
```

This checks that all tools are properly installed and configured.

### 5. Setup Language Environments

Install development tools for your primary languages:

```bash
# Python
bash languages/python.sh

# Node/Svelte
bash languages/svelte.sh

# Rust
bash languages/rust.sh

# Go
bash languages/go.sh
```

### 6. Tmux Setup

Install Tmux plugins:

```bash
tmux
# Inside tmux, press: Ctrl+b then I (capital I)
# This installs plugins from tmux.conf
```

### 7. Neovim Setup

Open Neovim to install plugins:

```bash
nvim
# LazyVim will auto-install plugins on first launch
```

Exit with `:q` after plugins finish installing.

## Configuration

### Machine-Specific Settings

For machine-specific overrides, create local files:

- `~/.zshrc.local` — Zsh overrides (sourced at end of zshrc)
- `~/.aliases.local` — Additional aliases
- `~/.functions.local` — Additional functions
- `~/.gitconfig.local` — Git overrides (user, email, etc.)

Example `~/.gitconfig.local`:

```ini
[user]
	name = Jonathan Smith
	email = jonathan@company.com
```

### Customize Colors

Edit the theme in:
- **Nvim:** `nvim/lua/config/options.lua` (colorscheme)
- **Tmux:** `tmux/tmux.conf` (status bar colors)
- **Zsh:** `shell/zshrc` (prompt colors)

### Add Neovim Plugins

Edit `nvim/lua/plugins/` to add/remove plugins. LazyVim uses lazy.nvim for plugin management.

Example new plugin in `nvim/lua/plugins/custom.lua`:

```lua
return {
  { "author/plugin-name", config = function() require("plugin-name").setup() end }
}
```

## Maintenance

### Update Everything

```bash
make sync
```

This updates:
- System packages
- Tmux plugins
- Neovim plugins
- Language tools (pip, npm, cargo, go)

### Update Individual Components

```bash
# Update Neovim plugins
nvim --headless "+Lazy! sync" +qa

# Update Tmux plugins
~/.tmux/plugins/tpm/bin/update_plugins all

# Update Python tools
pipx upgrade-all

# Update npm tools
npm update -g
```

## Troubleshooting

See `TROUBLESHOOTING.md` for common issues.

## ZMK Keyboard Setup

See `KEYBOARD.md` for Glove80 keyboard configuration and building firmware.

## Directory Bookmarks

Save frequent directories for quick access:

```bash
# Bookmark current directory
bmk myproject

# Jump to bookmark
jump myproject

# List bookmarks
bookmarks
```

## Project Session Templates

Create a tmux session with editor + shell:

```bash
tmux_project my_project
```

This creates:
- Window 1: Neovim
- Window 2: Shell

## Shell Functions

The `shell/functions.sh` file provides many utilities:

```bash
venv_activate              # Activate Python venv
tmux_project project_name  # Create project tmux session
disk                       # Show disk usage
extract archive.tar.gz     # Extract any archive type
git_quick "message"        # git add + commit + push
```

See `shell/functions.sh` for the full list.

## Notes

- All shell scripts use `bash` shebang (portable across systems)
- Dotfiles are symlinked (not copied) for easy updates
- LazyVim is a modern Nvim distribution with sensible defaults
- Tmux plugins auto-save/restore sessions
- Use `make` for common tasks (see `make help`)
