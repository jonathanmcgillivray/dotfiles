#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZMK_CONFIG_REPO="${ZMK_CONFIG_REPO:-$HOME/zmk-config}"

echo "=== Building ZMK Firmware ==="
echo ""

# Check if zmk-config repo exists
if [ ! -d "$ZMK_CONFIG_REPO" ]; then
    echo "Error: ZMK config repo not found at $ZMK_CONFIG_REPO"
    echo "Set ZMK_CONFIG_REPO environment variable or clone to ~/zmk-config"
    exit 1
fi

echo "ZMK Config Repo: $ZMK_CONFIG_REPO"

# Check if zmk-config has a valid build setup
if [ ! -f "$ZMK_CONFIG_REPO/.github/workflows/build.yml" ] && [ ! -f "$ZMK_CONFIG_REPO/build.sh" ]; then
    echo "Warning: Could not find build configuration in zmk-config"
    echo "Using west build..."
fi

# Option 1: Using west (official ZMK build tool)
if command -v west &> /dev/null; then
    echo "Building with west..."
    cd "$ZMK_CONFIG_REPO"
    west build -b glove80_lh_v0_1 -d build/left -- -DKEYMAP_EXTRA_BINDINGS=1
    west build -b glove80_rh_v0_1 -d build/right -- -DKEYMAP_EXTRA_BINDINGS=1
    echo "✓ Build complete!"
    echo "Firmware files:"
    ls -lh build/left/*.uf2 build/right/*.uf2 2>/dev/null || echo "  (Check build/ directory)"
    cd - > /dev/null
else
    echo "Error: west not found. Install ZMK Build Environment"
    echo "See: https://zmk.dev/docs/development/setup"
    exit 1
fi

echo ""
echo "Next steps:"
echo "  1. Connect Glove80 (hold space while plugging in)"
echo "  2. Copy firmware to /media/*/GLOVE80/ (or similar)"
echo ""
echo "Firmware files are in: $ZMK_CONFIG_REPO/build/"
