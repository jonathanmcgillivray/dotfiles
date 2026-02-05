# Glove80 ZMK Keyboard Setup

Configuration for Glove80 keyboard with Colemak Mod-DH layout.

## Overview

- **Keyboard:** Glove80 (split mechanical keyboard)
- **Layout:** Colemak Mod-DH (ergonomic alternative to QWERTY)
- **Firmware:** ZMK (https://zmk.dev)
- **Config Repo:** Separate `zmk-config` repository

## ZMK Configuration

ZMK configuration is managed in a separate repository (not in dotfiles):

```bash
git clone https://github.com/yourusername/zmk-config ~/zmk-config
```

The dotfiles includes:
- Build scripts to compile firmware
- Keymap reference documentation
- Integration with Neovim keybindings

## Colemak Mod-DH Layout

Colemak Mod-DH is an ergonomic variant of Colemak:

```
Qwerty:  Q W E R T Y U I O P
Colemak: Q W F P B J L U Y ;

Qwerty:  A S D F G H J K L
Colemak: A R S T G M N E I O

Qwerty:  Z X C V B N M , .
Colemak: Z X C D V K H , . /
```

Key differences from standard Colemak:
- Home row: A R S T G M N E I O (more frequent keys on home row)
- D and H moved to middle for alternate hand use

## Building Firmware

### Prerequisites

Install ZMK build environment:

```bash
git clone https://github.com/zmkfirmware/zmk.git ~/zmk
cd ~/zmk
west init -l app/
west update
west zephyr-export
pip install -r zephyr/scripts/requirements.txt
```

### Build Glove80 Firmware

```bash
# Left half
make build-zmk

# Or manually:
cd ~/zmk-config
west build -b glove80_lh_v0_1 -d build/left -- -DKEYMAP_EXTRA_BINDINGS=1
west build -b glove80_rh_v0_1 -d build/right -- -DKEYMAP_EXTRA_BINDINGS=1
```

Firmware will be in:
- `~/zmk-config/build/left/zephyr/zmk.uf2`
- `~/zmk-config/build/right/zephyr/zmk.uf2`

## Flashing Firmware

### 1. Put Glove80 in Bootloader Mode

**Left Half:**
- Hold both outer keys while plugging in USB
- Should mount as GLOVE80_LH drive

**Right Half:**
- Hold both outer keys while plugging in USB
- Should mount as GLOVE80_RH drive

### 2. Copy Firmware

```bash
# For left half
cp ~/zmk-config/build/left/zephyr/zmk.uf2 /media/*/GLOVE80_LH/

# For right half
cp ~/zmk-config/build/right/zephyr/zmk.uf2 /media/*/GLOVE80_RH/
```

The keyboard will auto-reset and start using the new firmware.

## Keymap Structure

Typical Glove80 ZMK keymap with Colemak Mod-DH:

```
Base Layer (Colemak Mod-DH):
┌─────┬─────┬─────┬─────┬─────┐   ┌─────┬─────┬─────┬─────┬─────┐
│  `  │  1  │  2  │  3  │  4  │   │  5  │  6  │  7  │  8  │  9  │
├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
│ TAB │  Q  │  W  │  F  │  P  │   │  B  │  J  │  L  │  U  │  Y  │
├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
│CTRL │  A  │  R  │  S  │  T  │   │  G  │  M  │  N  │  E  │  I  │
├─────┼─────┼─────┼─────┼─────┤   ├─────┼─────┼─────┼─────┼─────┤
│SHFT │  Z  │  X  │  C  │  D  │   │  V  │  K  │  H  │  ,  │  .  │
└─────┴─────┴─────┴─────┴─────┘   └─────┴─────┴─────┴─────┴─────┘

Thumb Clusters:
Left:  [ALT] [GUI] [SPC] [DEL]
Right: [BSPC] [ENT] [GUI] [ALT]
```

## Modifying the Keymap

Edit `~/zmk-config/config/glove80.keymap`:

```devicetree
/ {
    keymap {
        compatible = "zmk,keymap";

        base_layer {
            bindings = <
                &kp GRAVE &kp N1 &kp N2 &kp N3 &kp N4    &kp N5 &kp N6 &kp N7 &kp N8 &kp N9
                &kp TAB &kp Q &kp W &kp F &kp P    &kp B &kp J &kp L &kp U &kp Y
                // ... rest of layout
            >;
        };
    };
};
```

Common keycodes:
- `&kp KEY` — Regular key
- `&mo N` — Momentary layer N
- `&lt N KEY` — Layer tap: hold for layer N, tap for KEY
- `&mt MOD KEY` — Mod tap: hold for MOD, tap for KEY
- `&kp LC(X)` — Ctrl+X combination

## Integration with Neovim

Keybindings reference: See `KEYBINDINGS.md`

Some considerations for Colemak on Vim:
- `hjkl` navigation is different on Colemak (hnei in Colemak)
- Consider binding arrow keys or custom navigation
- Colemak-specific Neovim setup available in `nvim/lua/plugins/`

## Resources

- **ZMK Docs:** https://zmk.dev/docs/
- **Colemak Layout:** https://colemak.com/
- **Colemak Mod-DH:** https://colemakmods.github.io/mod-dh/
- **Glove80 Docs:** https://www.moergo.com/
