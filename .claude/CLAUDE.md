# Dotfiles Repository

Personal development environment for Linux, optimized for Python/Svelte/Rust/Go development with Neovim, Tmux, and Zsh.

## Architecture

```mermaid
graph TD
    A[dotfiles] --> B[nvim/]
    A --> C[tmux/]
    A --> D[shell/]
    A --> E[git/]
    A --> F[zmk/]

    B --> B1[LazyVim + LSP]
    B --> B2[Treesitter]
    B --> B3[Plugins]

    C --> C1[Tmux TPM]
    C --> C2[Keybindings]

    D --> D1[Zsh + Plugins]
    D --> D2[Aliases/Functions]

    E --> E1[gitconfig]
    E --> E2[gitignore_global]

    F --> F1[Glove80 Keymap]
```

## Design Philosophy

**Symlink-based**: All configs symlinked from repo → transparent, version-controlled, no magic.

**Modular**: Update tools independently. No monolithic config file.

**Reproducible**: `./install.sh` on fresh system → instant dev environment.

## Key Components

### Neovim (`nvim/`)
LazyVim distribution with language servers for Python, Svelte, Rust, Go. Configured via:
- `init.lua` - Bootstrap
- `lua/config/` - Options, keymaps, autocmds
- `lua/plugins/` - Plugin specs (lazy-loaded)
- `lua/plugins/dotfiles.lua` - Shows `.env`, `.claude/` in explorer

### Tmux (`tmux/`)
Session management with vim-style navigation, plugin manager (TPM), and custom theme.

### Shell (`shell/`)
Zsh configuration split into:
- `zshrc` - Main config with Aerometrix-branded prompt
- `aliases.sh` - Command shortcuts
- `exports.sh` - Environment variables
- `functions.sh` - Shell utilities

### Git (`git/`)
Global config with:
- User settings (name, email, GPG)
- Default branch: `main`
- Refined `.gitignore_global` - ignores build artifacts, allows lockfiles

### ZMK (`zmk/`)
Glove80 Colemak Mod-DH keymap build integration.

## Installation Flow

```mermaid
sequenceDiagram
    participant User
    participant install.sh
    participant System

    User->>install.sh: ./install.sh
    install.sh->>System: Backup existing configs
    install.sh->>System: Symlink dotfiles
    install.sh->>System: Install TPM (Tmux)
    install.sh->>System: Set zsh as default shell
    install.sh->>User: Restart terminal
    User->>System: make health-check
```

## Development Workflow

1. **Clone & Install**: `git clone <repo> ~/.dotfiles && cd ~/.dotfiles && ./install.sh`
2. **Language Setup**: `bash languages/python.sh` (or svelte/rust/go)
3. **Health Check**: `make health-check`
4. **Updates**: `make sync` (pulls latest + updates plugins)

## Git Commit Guidelines

**NO `Co-Authored-By` lines in commits.** Keep commits concise, imperative mood:

```
Add feature X to improve Y

- Detail 1
- Detail 2
```

## File Visibility

Dotfiles (`.env`, `.claude/`) are visible in Neovim by default via `lua/plugins/dotfiles.lua`. This configures `snacks.nvim` pickers to show hidden files.

## Maintenance

- **Update plugins**: `make sync`
- **Check health**: `make health-check`
- **Add language**: Create `languages/<lang>.sh` script
- **Customize keybinds**: Edit `nvim/lua/config/keymaps.lua` or `tmux/tmux.conf`
