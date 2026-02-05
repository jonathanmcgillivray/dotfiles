# Glove80 + Tmux + Neovim Integration Guide

This guide provides best practices and configurations for using your Glove80 keyboard efficiently with tmux and neovim.

## Overview

The Glove80 is an ergonomic split keyboard that pairs well with a modal text editor and terminal multiplexer workflow. This setup focuses on:
- Minimizing hand movement
- Using layers for efficiency
- Creating a seamless tmux/vim/system integration
- Leveraging the Glove80's ergonomic advantages

## Current Configuration

### Tmux
- **Prefix Key**: Space (ergonomic for split keyboards)
- **Window Numbering**: Starts at 1, auto-renumbers on window close
- **Navigation**: hjkl for pane selection (vim-like)
- **Splits**: `|` for vertical, `-` for horizontal
- **Clipboard**: System clipboard integration via tmux-yank
- **Smart Navigation**: Ctrl+hjkl navigates between tmux panes AND vim splits seamlessly

### Neovim
- **Clipboard**: `unnamedplus` (synced with system clipboard)
- **Navigation**: Ctrl+hjkl navigates between vim splits (and tmux panes via vim-tmux-navigator)
- **Layout**: LazyVim with sensible defaults

### Colemak Mod-DH
- Optimized for home-row ergonomics
- Better hand alternation than standard QWERTY/Colemak

## Recommended Glove80 Layer Configuration

### Base Layer (Colemak Mod-DH)
Keep your base layer as standard Colemak Mod-DH. The thumb clusters are key:
- **Left Thumbs**: ALT, GUI, SPACE, DELETE (or BACKSPACE)
- **Right Thumbs**: BACKSPACE, ENTER, GUI, ALT

### Symbol Layer (Priority: HIGH)
This layer should be highly accessible - recommend as a thumb key:

```
Symbols needed for tmux/vim:
│ ─ | : ; [ ] { } ( ) / \ @ # $ % ^ & * + = - _
```

Make pipe `|` and minus `-` one-key access since they're used for tmux splits.

**Recommendation**: Use **one-shot symbol layer** thumb key for quick access to these characters without holding.

### Number Layer
Keep accessible for terminal work but secondary priority.

### Navigation Layer (Priority: MEDIUM)
Place on easily accessible key (home row or thumb):

```
hjkl for vim motions
Arrow keys as backup
Home/End/PgUp/PgDn
```

## Recommended Layer Modifications (ZMK Configuration)

### 1. One-Shot Keys (Highly Recommended)
One-shot modifiers reduce hand fatigue on split keyboards:

```zmk
// Enable one-shot behavior
&sk {
    release-after-ms = <1000>;
    quick-release;
};

// In your keymap:
// Left thumb: One-shot Shift, One-shot Ctrl, One-shot Alt
OS(LSHIFT), OS(LCTRL), OS(LALT), [space]
// Right thumb: [space], ENTER, OS(RALT), OS(RGUI)
```

**Benefits**:
- Reduces chord stretching (CTRL+C becomes one-shot CTRL, tap C)
- Especially useful for frequently used modifiers
- Perfect for terminal work (less hand strain)

### 2. Home-Row Mods (Optional but Powerful)
Enables modifier keys on home row with tap-hold:

```zmk
// Requires defining tap-hold behavior
// Example:
// A (tap) → A key
// A (hold) → SHIFT modifier

// For Colemak Mod-DH home row:
// LSHIFT: A-key
// LCTRL: R-key
// LALT: S-key
// LCTRL: T-key

// Mirror on right:
// RCTRL: M-key
// RALT: N-key
// RSHIFT: E-key
// [other]: I-key
```

**Benefits**:
- Fast modifier combinations without reaching
- Reduces need for thumb-based modifiers
- Feels natural if already using touch typing

### 3. Custom Combos (Optional)
Consider adding combos for frequent actions:

```zmk
// Example combos:
// Hold Space + H → TMUX prefix (Space)
// Hold Space + I → Split right (|)
// Hold Space + O → Split down (-)

// Or for terminal:
// D + F → CTRL+D (EOF)
// Z + X → CTRL+Z (suspend)
```

## Tmux Keybindings Reference

All tmux commands use **Space** as prefix:

```
Space h/j/k/l     : Navigate panes (or use Ctrl+hjkl from anywhere)
Space |           : Split vertically
Space -           : Split horizontally
Space c           : New window
Space x           : Kill pane
Space X           : Kill window
Space n/p         : Next/previous window
Space v           : Enter copy mode
Space y           : Yank to clipboard
Space r           : Reload config
Space z           : Zoom pane
```

**Workflow Tip**: Since navigation uses `Ctrl+hjkl`, you often don't need the prefix:
- Use `Ctrl+h/j/k/l` directly to move around
- Use `Space` prefix only for splits, new windows, and special commands

## Neovim Navigation

```
Ctrl+h/j/k/l      : Navigate vim splits (seamlessly navigates to tmux panes too!)
Ctrl+\            : Go to previous pane/split
```

## Clipboard Workflow

### Copy/Paste Within Tmux
```
Space v            : Enter copy mode
v                  : Start selection
y                  : Yank to clipboard
Ctrl+V             : Paste (outside tmux)
```

### Copy/Paste Between Vim and System
```
# In vim (normal mode):
y                  : Yank to system clipboard (via unnamedplus)
p                  : Paste from system clipboard

# In tmux copy mode:
Space v            : Enter copy mode
v                  : Select
y                  : Copy to system clipboard
```

### Troubleshooting Clipboard
If clipboard isn't working:

1. **Check xclip/xsel installed**:
   ```bash
   which xclip  # or xsel
   ```
   Install if missing: `sudo apt-get install xclip`

2. **Verify tmux-yank plugin loaded**:
   ```bash
   tmux list-plugins
   ```

3. **Test neovim clipboard**:
   ```vim
   :echo has("clipboard")  " should output 1
   ```

4. **Manually test**:
   ```bash
   # In tmux, copy something, then:
   xclip -selection clipboard -o
   # Should show copied content
   ```

## Workflow Patterns

### Pattern 1: Project Layout
```
Session: myproject
├─ Window 1 (main)
│  ├─ Pane 1: vim (main editor)
│  ├─ Pane 2: terminal (build/tests)
│  └─ Pane 3: terminal (git/tools)
├─ Window 2 (docs)
│  └─ Pane 1: vim (documentation)
└─ Window 3 (monitoring)
   └─ Pane 1: logs/status monitor
```

Navigation: `Ctrl+hjkl` between panes in Window 1, `Space np` to switch windows.

### Pattern 2: Modal Workflow
1. Work in vim (edit code)
2. `Ctrl+J` to pane below
3. Run tests/build
4. `Ctrl+K` back to vim
5. Repeat

All without leaving home position! (This is where Glove80 shines)

### Pattern 3: Multi-Project Setup
```
# Start tmux with sessions
tmux new-session -s work
tmux new-session -s monitor
tmux new-session -s side-project

# Switch between:
Space :switch-client -t work
Space :switch-client -t monitor
```

## Performance Optimization Tips

### 1. Reduce Tmux Overhead
```tmux
# Already optimized in your config:
set -s escape-time 0          # No ESC wait
set -g mouse on               # Mouse support for less clicking
```

### 2. Neovim Startup
```vim
# Enable lazy loading in plugins
# Verify with: nvim --startuptime /tmp/nvim_startup.txt
```

### 3. Key Repeat Rate
Adjust your system key repeat (useful for Glove80):
```bash
# Linux X11
xset r rate 200 40            # 200ms delay, 40ms repeat

# Or add to ~/.xinitrc or ~/.config/sway/config for persistence
```

## Troubleshooting Common Issues

### Issue: Ctrl+hjkl not navigating between tmux/vim
**Solution**: Ensure vim-tmux-navigator plugin loaded:
```vim
:LzyHealth      " Check plugin status
:checkhealth    " General health check
```

### Issue: Space prefix conflicts with other apps
**Solution**:
- Use inside tmux session only (doesn't affect outside apps)
- If issues, can rebind to `C-Space` instead

### Issue: Slow pane switching
**Solution**: Already handled in config:
```tmux
set -s escape-time 0          # No ESC wait
```

### Issue: Splits feel cluttered
**Solution**: Use the zoom pane function:
```tmux
Space z                       # Toggle pane zoom
```

## Future Enhancements

### 1. Session Management
Consider: `tmux-resurrect` + `tmux-continuum` (already in your config!)
- Auto-saves sessions every 10 minutes
- Auto-restore on tmux restart

### 2. Search/Selection Enhancements
```tmux
# Consider adding to your tmux config:
bind -T copy-mode-vi '/' send-keys -X search-forward
bind -T copy-mode-vi '?' send-keys -X search-backward
```

### 3. Glove80-Specific: Smart Prefix
On your Glove80, consider a combo for frequently used prefix sequences:
```zmk
# Combo: Space + I = Space | (split right, common action)
combo split_right {
  timeout-ms = <50>;
  key-positions = <0 8>;  // Space + I
  bindings = <&kp SPACE &kp PIPE>;
};
```

## Resources

- **Glove80 ZMK Docs**: https://zmk.dev/docs
- **Tmux Man Page**: `man tmux`
- **Vim-tmux-navigator**: https://github.com/christoomey/vim-tmux-navigator
- **Colemak Layout**: https://colemak.com/
- **Neovim Clipboard**: `:help clipboard`

## Quick Reference Card

```
┌─ NAVIGATION (Ctrl+hjkl) ──────────────┐
│ Can navigate vim↔tmux seamlessly      │
└──────────────────────────────────────┘

┌─ TMUX PREFIX (Space) ─────────────────┐
│ Space + |      Split vertical         │
│ Space + -      Split horizontal       │
│ Space + c      New window             │
│ Space + x      Kill pane              │
│ Space + z      Zoom pane              │
│ Space + n/p    Next/prev window       │
└──────────────────────────────────────┘

┌─ COPY/PASTE ──────────────────────────┐
│ Space + v      Enter copy mode        │
│ v              Begin selection        │
│ y              Yank (copy)            │
│ Ctrl+V         Paste (outside tmux)   │
└──────────────────────────────────────┘

┌─ VIM SPLITS ──────────────────────────┐
│ Ctrl+hjkl      Navigate splits        │
│ (same binds work in tmux!)            │
└──────────────────────────────────────┘
```

---

**Next Steps**:
1. Install dependencies: `xclip` for clipboard
2. Test tmux with: `tmux`
3. Configure your Glove80 ZMK with recommended layers
4. Enjoy efficient, ergonomic text editing! 🎹
