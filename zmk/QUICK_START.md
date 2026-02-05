# Quick Start: Navigation Layer Setup

## Your Setup

✅ **Base Layer**: Colemak Mod-DH
✅ **Navigation Layer**: NEIU mapping on right thumb hold
✅ **Integration**: Ready for tmux + neovim

## What You Have

### Right Thumb NAV Key (Hold to Activate)

```
When you hold it:
  U = UP arrow
N E I = LEFT, DOWN, RIGHT arrows
Tap = SPACE
```

### Full Workflow Example

```bash
# In terminal/vim with your setup:
Hold NAV + E    → Move down
Hold NAV + I    → Move right
Hold NAV + N    → Move left
Hold NAV + U    → Move up

# Combined with tmux (your Space prefix config):
Space | → Split right
Space - → Split down
Ctrl+hjkl → Navigate between vim splits and tmux panes
```

## Build & Flash

### Quick Method (Automated)
```bash
cd ~/dev/dotfiles/zmk
./build.sh        # Build firmware
./flash.sh        # Auto-detects keyboard and flashes both sides
```

The script will:
1. Wait for you to enter bootloader mode on the left side
2. Flash it automatically
3. Prompt you to enter bootloader mode on the right side
4. Flash the right side
5. Done!

### Manual Method (If Needed)

**Step 1: Build**
```bash
cd ~/dev/dotfiles/zmk
./build.sh
```

**Step 2: Flash Left Side**
1. Power off the left half
2. Hold down **Magic key (C6R6, bottom-left)** and **C3R3 (F on this layout)**
3. While holding both keys, switch power ON
4. Look for a **slow-pulsing red LED** - this confirms bootloader mode
5. When you see "GLV80LBOOT" drive:
   ```bash
   cp glove80.uf2 /path/to/GLV80LBOOT/
   ```
6. Wait for keyboard to reboot (~5 seconds)

**Step 3: Flash Right Side**
1. Power off the right half
2. Hold down **Magic key (C6R6, bottom-left)** and **C3R3 (F on this layout)**
3. While holding both keys, switch power ON
4. Look for a **slow-pulsing red LED** - this confirms bootloader mode
5. When you see "GLV80RBOOT" drive:
   ```bash
   cp glove80.uf2 /path/to/GLV80RBOOT/
   ```
6. Done! Test by holding the right thumb NAV key

## Test It

```bash
# Test navigation layer
# Hold right thumb NAV key and press:
# e = you should see DOWN arrow behavior
# i = you should see RIGHT arrow behavior
# n = you should see LEFT arrow behavior
# u = you should see UP arrow behavior

# In vim, type :set number then use NAV+hjkl to move around

# In tmux, use NAV for arrows while in copy mode
```

## Customize

Edit: `config/glove80.keymap`

Look for the `nav_layer` section to change which keys do what.

For detailed customization guide, see: `ZMK_SETUP.md`

## Common Issues

**"Can't find GLV80LBOOT?"**
- The keyboard needs to be in bootloader mode
- Try: Hold ESC while plugging in

**"Navigation keys not working?"**
- Hold the NAV key for ~200ms (not a tap)
- Make sure you see both keyboard sides flash
- Rebuild: `zmk-cli build -b glove80 --clean`

**"Keys typing wrong characters?"**
- Your system is probably on QWERTY instead of Colemak
- Switch your OS to Colemak to match your keyboard config

## Next Steps

1. ✅ Build firmware
2. ✅ Flash both sides
3. ✅ Test navigation layer
4. ✅ Verify tmux/vim integration works
5. 🎉 Enjoy!

---

Need help? See: `ZMK_SETUP.md` for detailed info
