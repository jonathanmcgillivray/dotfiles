#!/bin/bash
set -e

echo "=== Python Development Setup ==="

# Check if python3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python3 not found. Installing..."
    sudo apt update
    sudo apt install -y python3 python3-pip python3-venv
fi

echo "✓ Python3 version: $(python3 --version)"

# Install pipx for global CLI tools
if ! command -v pipx &> /dev/null; then
    echo "Installing pipx..."
    pip3 install --user pipx
    export PATH="$PATH:$HOME/.local/bin"
fi

echo "Installing Python development tools..."

# Core tools
pipx install black --force           # Code formatter
pipx install isort --force           # Import sorter
pipx install ruff --force            # Fast linter
pipx install mypy --force            # Type checker
pipx install pytest --force          # Testing
pipx install ipython --force         # Interactive shell

# Language servers
pipx install python-lsp-server --force
pipx install pylsp-mypy --force
pipx install pylsp-rope --force

# Scientific/Web tools
pipx install jupyter --force
pipx install httpx --force
pipx install rich --force

echo "✓ Python tools installed in ~/.local/bin"
echo ""
echo "Quick setup for a project:"
echo "  1. cd /path/to/project"
echo "  2. python3 -m venv .venv"
echo "  3. source .venv/bin/activate"
echo "  4. pip install -r requirements.txt"
echo ""
echo "Recommended: Add to requirements.txt:"
echo "  black"
echo "  ruff"
echo "  mypy"
echo "  pytest"
echo ""
