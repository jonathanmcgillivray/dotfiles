#!/bin/bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
FIRMWARE_FILE="glove80.uf2"
# Patterns for bootloader drives (LHBOOT = left half, RHBOOT = right half)
BOOT_PATTERNS=("GLV80.*LHBOOT" "GLV80.*RHBOOT")
BOOT_NAMES=("Left" "Right")
TIMEOUT=60
CHECK_INTERVAL=1

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1" >&2
}

log_success() {
    echo -e "${GREEN}✓${NC} $1" >&2
}

log_error() {
    echo -e "${RED}✗${NC} $1" >&2
}

log_warn() {
    echo -e "${YELLOW}!${NC} $1" >&2
}

# Find mount point for a drive pattern
find_mount_point() {
    local pattern=$1

    # Use mount command (works more reliably than lsblk)
    mount 2>/dev/null | grep -iE "$pattern" | awk '{print $3}' | head -1 || true
}

# Wait for drive to appear
wait_for_drive() {
    local pattern=$1
    local side_name=$2
    local elapsed=0

    log_info "Waiting for $side_name side bootloader drive..."
    {
        echo
        echo "  Steps to enter bootloader mode:"
        echo "  1. Power OFF the $side_name side"
        echo "  2. Hold Magic key (C6R6, bottom-left) + C3R3 (F key)"
        echo "  3. While holding both, switch power ON"
        echo "  4. Look for slow-pulsing RED LED"
        echo
    } >&2

    while [ $elapsed -lt $TIMEOUT ]; do
        mount_point=$(find_mount_point "$pattern")
        if [ -n "$mount_point" ]; then
            log_success "Found bootloader drive at $mount_point"
            echo "$mount_point"
            return 0
        fi

        sleep $CHECK_INTERVAL
        elapsed=$((elapsed + CHECK_INTERVAL))
        printf "." >&2
    done

    echo >&2
    log_error "Timeout waiting for $side_name bootloader drive matching $pattern"
    log_info "Current mounted drives:"
    mount 2>/dev/null | grep -i glv >&2 || echo "  (no GLV80 drives found)" >&2
    return 1
}

# Flash firmware to drive
flash_drive() {
    local mount_point=$1
    local pattern=$2
    local side_name=$3

    if [ ! -f "$FIRMWARE_FILE" ]; then
        log_error "$FIRMWARE_FILE not found. Run ./build.sh first"
        exit 1
    fi

    log_info "Copying $FIRMWARE_FILE to $side_name side..."
    if cp "$FIRMWARE_FILE" "$mount_point/"; then
        log_success "Firmware copied successfully"
    else
        log_error "Failed to copy firmware"
        return 1
    fi

    # Wait for drive to disappear (indicates reboot)
    log_info "Waiting for $side_name side to reboot..."
    local elapsed=0
    while [ $elapsed -lt 30 ]; do
        mount_point=$(find_mount_point "$pattern")
        if [ -z "$mount_point" ]; then
            log_success "$side_name side flashed and rebooted"
            sleep 1
            return 0
        fi
        sleep 1
        elapsed=$((elapsed + 1))
        printf "."
    done

    echo
    log_warn "Drive still present, but flash may have succeeded"
    return 0
}

# Main script
main() {
    echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║      Glove80 Firmware Flasher          ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
    echo

    # Check if firmware file exists
    if [ ! -f "$FIRMWARE_FILE" ]; then
        log_error "$FIRMWARE_FILE not found"
        log_info "Run './build.sh' first to build the firmware"
        exit 1
    fi

    log_success "Found $FIRMWARE_FILE"
    echo

    # Flash both sides
    for i in 0 1; do
        pattern="${BOOT_PATTERNS[$i]}"
        side_name="${BOOT_NAMES[$i]}"

        echo -e "${YELLOW}═══════════════════════════════════════${NC}"
        echo -e "${YELLOW}Flashing $side_name Side${NC}"
        echo -e "${YELLOW}═══════════════════════════════════════${NC}"
        echo

        # Wait for drive
        mount_point=$(wait_for_drive "$pattern" "$side_name") || {
            log_error "Failed to find $side_name side bootloader"
            exit 1
        }
        echo

        # Flash
        flash_drive "$mount_point" "$pattern" "$side_name" || {
            log_error "Failed to flash $side_name side"
            exit 1
        }
        echo

        if [ $i -eq 0 ]; then
            log_info "Left side complete. Ready for right side."
            echo
        fi
    done

    echo -e "${GREEN}╔════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║     ✓ Both sides flashed successfully! ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════╝${NC}"
    echo
    log_info "Your Glove80 is ready to use!"
    log_info "Test by holding the right thumb NAV key and pressing NEIU"
}

main "$@"
