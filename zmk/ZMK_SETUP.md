# Glove80 ZMK Configuration Setup

This directory contains your customized ZMK configuration for the Glove80 keyboard with Colemak Mod-DH layout and a dedicated navigation layer.

## What's Included

- **Base Layer**: Colemak Mod-DH with standard key mappings
- **Lower Layer**: Media controls, numbers, and function keys
- **NAV Layer**: Navigation layer activated by holding the right thumb key
  - **n** = LEFT arrow
  - **e** = DOWN arrow
  - **i** = RIGHT arrow
  - **u** = UP arrow
- **Magic Layer**: RGB, Bluetooth, and bootloader controls

## Navigation Layer Usage

The NAV layer is accessed by **holding the right thumb key (labeled "NAV" in your keymap)**:

```
When held:
  u = UP
n e i = LEFT, DOWN, RIGHT
```

Examples:
- Hold NAV + E = Move down
- Hold NAV + I = Move right
- Tap NAV (without holding) = Insert SPACE character

This is perfect for vim, terminal navigation, and arrow key access while keeping your hands on the home row!

## Building and Flashing

### Prerequisites

1. **Install ZMK CLI** (Recommended - easiest method):
   ```bash
   pip install zmk-cli
   ```

2. **Or use GitHub Actions** (Web-based, no setup needed):
   - Push your config to a GitHub fork of glove80-zmk-config
   - GitHub Actions automatically builds your firmware
   - Download the `.uf2` files from the Actions artifacts

### Method 1: Building Locally with Docker (Easiest)

```bash
# Navigate to your zmk config directory
cd ~/dev/dotfiles/zmk

# Build the firmware
./build.sh

# This will create glove80.uf2 in the current directory
```

(Requires Docker: `sudo apt install docker.io` and add yourself to the docker group)

### Method 2: Using GitHub Actions (Recommended for First Time)

1. Fork: https://github.com/moergo-sc/glove80-zmk-config
2. Replace the `config/` directory with your config
3. Push to GitHub
4. GitHub Actions automatically builds
5. Download artifacts from the Actions tab

### Method 3: Using MoErgo Web Editor

Visit: https://glove80.com/
- Upload your config or build through their web interface

## Flashing the Firmware

Once you have the `.uf2` files:

1. **Enter Bootloader Mode**:
   - Power off the keyboard half
   - Hold down **C6R6 (Magic key, bottom-left)** and **C3R3** (F on this layout)
   - While holding both keys, switch power ON
   - Look for a **slow-pulsing red LED** to confirm bootloader mode
   - Plug in via USB
   - Your keyboard should show up as a removable drive (GLV80LBOOT or GLV80RBOOT)

2. **Copy Firmware**:
   ```bash
   # Flash the same glove80.uf2 to both sides
   # For left side
   cp glove80.uf2 /path/to/GLV80LBOOT/

   # Unplug left, power it off
   # Then repeat for right side
   cp glove80.uf2 /path/to/GLV80RBOOT/
   ```

3. **Verification**:
   - Keyboard should reboot automatically
   - Test the navigation layer by holding the NAV thumb key

## Customizing Your Layout

### To Change Navigation Keys

Edit `config/glove80.keymap` and find the `nav_layer` section:

```zmk
nav_layer {
    bindings = <
    // ... earlier rows ...
    // Home row with navigation:
    &trans  &trans  &trans  &trans  &trans  &trans
                                             &trans  &kp LEFT &kp DOWN  &kp RIGHT &trans  &trans
    // ...
    >;
};
```

Replace the arrow keys with whatever you want:
- `&kp LEFT`, `&kp RIGHT`, `&kp UP`, `&kp DOWN`
- `&kp HOME`, `&kp END`, `&kp PG_UP`, `&kp PG_DN`
- `&kp ENTER`, `&kp BSPC`, etc.

### To Change the NAV Layer Activation Key

Edit the `default_layer` section and find the right thumb cluster. Replace:

```zmk
&nav_hold_tap NAV SPACE    // Hold = NAV layer, Tap = SPACE
```

With a different key position or behavior.

### To Add More Navigation Keys

In the `nav_layer`, replace `&trans` with your key binding on any row:

```zmk
// Example: Add more keys
&kp HOME    &kp PG_UP      &kp PG_DN    &kp END     // top navigation
&trans      &kp LEFT       &kp DOWN     &kp RIGHT   // arrow keys (home row)
```

## Useful ZMK References

- **Key Codes**: https://zmk.dev/docs/codes/
- **Behaviors**: https://zmk.dev/docs/behaviors/
- **Hold-Tap**: https://zmk.dev/docs/behaviors/hold-tap/
- **Tap-Dance**: https://zmk.dev/docs/behaviors/tap-dance/
- **Combos**: https://zmk.dev/docs/features/combos/

## Troubleshooting

### "Cannot find GLV80LBOOT"

The keyboard needs to be in bootloader mode:
1. Power off the keyboard half
2. Hold down **C6R6 (Magic key, bottom-left)** and **C3R3** (F on this layout)
3. While holding both keys, switch power ON
4. Watch for a **slow-pulsing red LED** - this indicates bootloader mode
5. Then plug in via USB
6. A new drive should appear

### Navigation not working

1. Ensure you're holding the right thumb NAV key long enough (~200ms)
2. Check that the NAV layer is correctly built into your firmware
3. Try rebuilding: `zmk-cli build -b glove80 --clean`

### Some keys typing wrong characters

This is likely a keycode mismatch between your system layout and ZMK. Make sure you're using Colemak at the OS level too.

## Next Steps

1. **Build the firmware**: `zmk-cli build -b glove80`
2. **Flash both sides** of your keyboard
3. **Test the navigation layer**: Hold right thumb NAV key + NEIU
4. **Test integration**: In vim or terminal, use nav layer with Ctrl+hjkl for tmux/vim panes

## Integration with Tmux + Neovim

Your ZMK NAV layer pairs perfectly with:
- **Tmux**: Uses vim motions (hjkl → NEIU in nav layer)
- **Neovim**: Works with vim-tmux-navigator (Ctrl+hjkl)
- **Terminal**: Arrow keys work everywhere with the NAV layer

Example workflow:
```
Hold NAV + NEIU = Navigate in terminal/vim
Space + | = Split tmux vertically (with your tmux config)
Ctrl+hjkl = Navigate between tmux panes and vim splits
```

## Files Structure

```
zmk/
├── config/
│   ├── glove80.keymap    # Main keymap file (edit this!)
│   ├── glove80.conf      # ZMK settings
│   └── info.json         # Keyboard layout info
├── build.sh              # Build script (Linux/Mac)
├── build.bat             # Build script (Windows)
├── Dockerfile            # Docker build environment
└── README.md             # Original MoErgo README
```

## Support

- **ZMK Documentation**: https://zmk.dev/
- **MoErgo Support**: https://docs.moergo.com/
- **GitHub Issues**: https://github.com/moergo-sc/glove80-zmk-config/issues

---

Happy hacking! 🎹
