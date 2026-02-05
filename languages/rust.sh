#!/bin/bash
set -e

echo "=== Rust Development Setup ==="

# Install rustup if not present
if ! command -v rustup &> /dev/null; then
    echo "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
fi

echo "✓ Rust version: $(rustc --version)"
echo "✓ Cargo version: $(cargo --version)"

# Update Rust
echo "Updating Rust toolchain..."
rustup update

# Install useful components
echo "Installing Rust components..."

rustup component add \
    rust-analyzer \
    rust-src \
    clippy \
    rustfmt

# Install useful tools
echo "Installing Rust tools..."

cargo install \
    cargo-watch \
    cargo-expand \
    cargo-edit \
    cargo-outdated \
    cargo-deny

echo "✓ Rust tools installed"
echo ""
echo "New Rust project:"
echo "  cargo new my_project"
echo "  cd my_project"
echo "  cargo run"
echo ""
echo "Useful commands:"
echo "  cargo watch -x run       # Auto-rebuild on file change"
echo "  cargo fmt                # Format code"
echo "  cargo clippy             # Lint"
echo "  cargo test               # Run tests"
echo ""
