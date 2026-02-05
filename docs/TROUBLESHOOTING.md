# Troubleshooting

Common issues and solutions.

## Installation Issues

### Shell not changed to Zsh

**Problem:** Default shell is still Bash after installation.

**Solution:**

```bash
chsh -s $(which zsh)
```

Then restart terminal and verify:

```bash
echo $SHELL
# Should output: /usr/bin/zsh
```

### Symlinks not working

**Problem:** Dotfiles not being sourced in shell.

**Solution:**

```bash
# Check if symlinks were created
ls -la ~/.zshrc
ls -la ~/.config/nvim
ls -la ~/.tmux.conf

# If they show as regular files instead of symlinks (->), reinstall:
cd ~/.dotfiles
./install.sh
```

### Permission denied on scripts

**Problem:** Can't run install.sh or other scripts.

**Solution:**

```bash
chmod +x ~/.dotfiles/*.sh
chmod +x ~/.dotfiles/scripts/*.sh
chmod +x ~/.dotfiles/languages/*.sh
```

## Tmux Issues

### Tmux plugins not installing

**Problem:** TPM not installing plugins when pressing `Ctrl-a I`.

**Solution:**

1. Verify TPM is installed:
   ```bash
   ls -la ~/.tmux/plugins/tpm
   ```

2. If not, install manually:
   ```bash
   git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
   ```

3. In tmux, press `Ctrl-b I` (capital I):
   ```bash
   tmux
   # Inside tmux press: Ctrl-b I
   ```

### Tmux colors not working

**Problem:** Colors look wrong in tmux.

**Solution:**

Check your terminal colors:

```bash
# Inside tmux
echo $TERM
# Should be: screen-256color

# Check color support
tmux list-colors
```

If not working, add to ~/.tmux.conf:

```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",xterm-256color:RGB"
```

### Mouse not working

**Problem:** Mouse copy/paste not working in tmux.

**Solution:**

Ensure mouse is enabled in tmux.conf:

```bash
set -g mouse on
```

Then reload:

```bash
tmux source-file ~/.tmux.conf
```

## Neovim Issues

### Plugins not installing

**Problem:** LazyVim plugins not available.

**Solution:**

Open Nvim and let it auto-install:

```bash
nvim
# Wait for plugins to install
# Check :checkhealth for diagnostics
:Lazy
```

If still failing:

```bash
rm -rf ~/.local/share/nvim
nvim
```

### LSP not working

**Problem:** Language servers not providing completions.

**Solution:**

1. Check health:
   ```vim
   :checkhealth
   ```

2. Install language servers:
   - Python: `pip install python-lsp-server`
   - Node: `npm install -g typescript-language-server`
   - Rust: `rustup component add rust-analyzer`
   - Go: `go install golang.org/x/tools/gopls@latest`

3. Verify LSP status:
   ```vim
   :LspInfo
   ```

### Slow startup

**Problem:** Neovim takes too long to start.

**Solution:**

1. Check what's slow:
   ```vim
   :Lazy
   # Look for plugins marked as slow
   ```

2. Disable slow plugins temporarily in `nvim/lua/plugins/`

3. Profile startup:
   ```bash
   nvim --startuptime /tmp/startup.log +quit
   cat /tmp/startup.log
   ```

## Python Issues

### Virtual environment not activating

**Problem:** `venv activate` function not working.

**Solution:**

```bash
# Manual activation
source .venv/bin/activate

# Or use the function directly
venv_activate .venv
```

### pip command not found

**Problem:** pip3 installed but not in PATH.

**Solution:**

```bash
# Add to shell/exports.sh
export PATH="$HOME/.local/bin:$PATH"

# Source exports
source ~/.dotfiles/shell/exports.sh
```

### Python LSP not responding

**Problem:** Python completions not working.

**Solution:**

```bash
# Reinstall Python language server
pipx uninstall python-lsp-server
pipx install python-lsp-server
pipx install pylsp-mypy
pipx install pylsp-rope
```

## Node/Svelte Issues

### npm permission denied

**Problem:** Global npm installs require sudo.

**Solution:**

Fix npm permissions (without using sudo):

```bash
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH=~/.npm-global/bin:$PATH
```

Add to `shell/exports.sh`:

```bash
export PATH="$HOME/.npm-global/bin:$PATH"
```

### pnpm not found

**Problem:** pnpm installed but not in PATH.

**Solution:**

```bash
# Reinstall
npm install -g pnpm

# Or verify PATH
echo $PATH | grep npm-global
```

## Rust Issues

### cargo not found

**Problem:** Rust installed but cargo not available.

**Solution:**

Source cargo environment:

```bash
source $HOME/.cargo/env

# Add to shell/exports.sh
export PATH="$HOME/.cargo/bin:$PATH"
```

### rust-analyzer not working

**Problem:** Neovim not finding rust-analyzer.

**Solution:**

```bash
rustup component add rust-analyzer
# Verify installation
rustup component list | grep rust-analyzer
```

## Go Issues

### go not found

**Problem:** Go installed but not in PATH.

**Solution:**

```bash
export PATH="/usr/local/go/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
```

Add to `shell/exports.sh`.

## Git Issues

### Git config not being used

**Problem:** Git config not sourced.

**Solution:**

```bash
# Check symlink
ls -la ~/.gitconfig
# Should show: ~/.gitconfig -> ~/.dotfiles/git/gitconfig

# If not, reinstall
cd ~/.dotfiles
./install.sh
```

## Keyboard (ZMK) Issues

### Build fails

**Problem:** `west build` command fails.

**Solution:**

1. Ensure ZMK environment is installed:
   ```bash
   west --version
   ```

2. If not, install:
   ```bash
   pip install west
   cd ~/zmk
   west init -l app/
   west update
   ```

3. Verify zmk-config exists:
   ```bash
   ls ~/zmk-config
   ```

### Firmware won't flash

**Problem:** Can't copy firmware to keyboard.

**Solution:**

1. Put keyboard in bootloader mode:
   - Hold both outer keys
   - Plug in USB
   - Should see GLOVE80_LH or GLOVE80_RH drive

2. Check mount point:
   ```bash
   lsblk
   # or
   mount | grep -i glove
   ```

3. Copy firmware:
   ```bash
   cp ~/zmk-config/build/left/zephyr/zmk.uf2 /media/*/GLOVE80_LH/
   ```

## General Issues

### Outdated config causing errors

**Problem:** Old config conflicts with new system.

**Solution:**

Backup and reinstall:

```bash
cd ~/.dotfiles
# Backup current links
mkdir -p ~/.dotfiles-backup
mv ~/.zshrc ~/.dotfiles-backup/ 2>/dev/null
mv ~/.tmux.conf ~/.dotfiles-backup/ 2>/dev/null
mv ~/.config/nvim ~/.dotfiles-backup/ 2>/dev/null

# Reinstall
./install.sh
```

### Permission issues

**Problem:** Can't access dotfiles directory.

**Solution:**

```bash
# Fix ownership
sudo chown -R $(whoami) ~/.dotfiles

# Fix permissions
chmod -R u+rwX ~/.dotfiles
```

## Getting Help

If issues persist:

1. Check logs:
   ```bash
   # Neovim health check
   nvim +checkhealth

   # Tmux debug
   tmux -v

   # Shell debug
   zsh -x
   ```

2. Check system:
   ```bash
   make health-check
   ```

3. Consult documentation:
   - Neovim/LazyVim: https://www.lazyvim.org/
   - Tmux: https://github.com/tmux/tmux/wiki
   - ZMK: https://zmk.dev/docs/

4. Create an issue in the dotfiles repo with:
   - OS version: `uname -a`
   - Tool versions: `nvim --version`, `tmux -V`, `zsh --version`
   - Relevant error messages
   - Steps to reproduce
