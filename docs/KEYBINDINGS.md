# Keybindings Reference

Keybindings for Neovim (LazyVim) and Tmux.

## Neovim (LazyVim)

LazyVim comes with sensible defaults. Key bindings are in `nvim/lua/config/keymaps.lua`.

### Motion (Colemak Mod-DH)

Standard Vim motions work on Colemak, but hjkl navigation is different:

```
Qwerty hjkl:  h j k l (left down up right)
Colemak hjkl: h n e i (left down up right)
```

Recommended approaches:
1. **Use Vim's native motions:** `w b e` (word motions), line motions, search
2. **Remap to arrow keys:** in `keymaps.lua`, bind arrow keys to navigation
3. **Use custom motions:** LazyVim allows customizing this

### Core Commands

| Action | Keys | Notes |
|--------|------|-------|
| **Navigation** |
| Next file | `<Space>e` | File explorer (LazyVim default) |
| Find file | `<Space>ff` | Telescope find files |
| Recent files | `<Space>fr` | Telescope recent |
| Search text | `<Space>fg` | Telescope live grep |
| **Editing** |
| Save | `<Ctrl-s>` or `:w` | |
| Quit | `:q` | |
| Quit all | `:qa` | |
| Force quit | `:q!` | |
| **Buffers** |
| Next buffer | `]b` | |
| Prev buffer | `[b` | |
| Close buffer | `<Space>bd` | |
| **Windows** |
| Split vertical | `<Ctrl-w>v` | |
| Split horizontal | `<Ctrl-w>s` | |
| Close window | `<Ctrl-w>c` | |
| Navigate | `<Ctrl-w><hjkl>` | Move between windows |
| **LSP** |
| Go to definition | `gd` | Jump to definition |
| Hover docs | `K` | Show docs |
| Format | `<Space>cf` | Format document |
| Rename | `<Space>cr` | Rename symbol |
| Code actions | `<Space>ca` | Code actions |
| Diagnostics | `<Space>cd` | Diagnostics |

### LazyVim Defaults

See `~/.config/nvim/lua/config/keymaps.lua` for the full list.

Key patterns:
- `<Space>` leader key
- `<Ctrl>` for window/buffer operations
- `g` prefix for "go to" (gd, gh, gi, etc.)
- `[` and `]` for previous/next (buffers, diagnostics, etc.)

## Tmux

Prefix: `Ctrl-b` (can be changed in `tmux/tmux.conf`)

### Core Navigation

| Action | Keys | Notes |
|--------|------|-------|
| New window | `Prefix c` | Create new window |
| Next window | `Prefix n` | Navigate to next window |
| Prev window | `Prefix p` | Navigate to previous window |
| Split vertical | `Prefix \|` | Split right |
| Split horizontal | `Prefix -` | Split down |
| **Pane Navigation** |
| Move left | `Prefix h` | (Vim keys) |
| Move down | `Prefix j` | (Vim keys) |
| Move up | `Prefix k` | (Vim keys) |
| Move right | `Prefix l` | (Vim keys) |
| **Pane Resize** |
| Resize left | `Prefix H` | (Hold shift, repeat for multiple) |
| Resize down | `Prefix J` | |
| Resize up | `Prefix K` | |
| Resize right | `Prefix L` | |
| Zoom pane | `Prefix z` | Toggle full-screen pane |
| **Session** |
| List sessions | `Prefix s` | Or `tmux list-sessions` |
| Rename window | `Prefix ,` | |
| Kill pane | `Prefix x` | |
| Kill window | `Prefix X` | |
| **Misc** |
| Copy mode | `Prefix v` | Enter copy mode |
| Paste buffer | `Prefix ]` | |
| Reload config | `Prefix r` | |

### Copy Mode

| Action | Keys |
|--------|------|
| Enter copy mode | `Prefix v` |
| Select text | `v` (then move) |
| Copy selection | `y` |
| Exit copy mode | `Esc` |
| Paste | `Prefix ]` |

## Integration: Nvim + Tmux

Common workflow:

```
1. Create tmux session: tmux new-session -s work
2. Create window: Prefix c
3. Open Nvim: nvim
4. Open terminal in split: :TermOpen
5. Navigate between Nvim splits and tmux panes seamlessly
```

### Tmux Integration Plugins

The configured plugins provide:
- **tmux-yank:** Copy to system clipboard (Prefix Y)
- **tmux-resurrect:** Save/restore sessions
- **tmux-continuum:** Auto-save every 15 minutes

## Customizing Keybindings

### Neovim

Edit `nvim/lua/config/keymaps.lua`:

```lua
-- Add custom keybinding
vim.keymap.set('n', '<Space>mz', ':!make build<CR>', { noremap = true })
```

### Tmux

Edit `tmux/tmux.conf`:

```bash
# Add custom binding
bind-key M-n send-keys -t project "make build" Enter
```

## Tips

1. **Prefix alternatives:** If Ctrl-b is uncomfortable, change in tmux.conf:
   ```bash
   set -g prefix C-a
   unbind C-b
   bind C-a send-prefix
   ```

2. **Vi-mode copy:** Already configured in `tmux.conf` with vim-like `v` and `y`

3. **Colemak considerations:**
   - Vim navigation (hjkl) feels natural on Colemak once muscle memory develops
   - Or remap arrow keys for navigation
   - Tmux hjkl pane navigation also feels natural

4. **Learning path:**
   - Start with LazyVim defaults
   - Add Tmux gradually (window splitting, pane navigation)
   - Customize only when you hit a workflow pain point
