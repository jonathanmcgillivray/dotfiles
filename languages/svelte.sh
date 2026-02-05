#!/bin/bash
set -e

echo "=== Node.js / Svelte Development Setup ==="

# Check if Node is installed, if not install nvm
if ! command -v node &> /dev/null; then
    echo "Node not found. Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi

echo "✓ Node version: $(node --version)"
echo "✓ npm version: $(npm --version)"

# Update npm
echo "Updating npm..."
npm install -g npm@latest

# Install useful global tools
echo "Installing Node development tools..."

npm install -g \
    pnpm@latest \
    eslint \
    prettier \
    typescript \
    @sveltejs/kit \
    vite

echo "✓ Global tools installed"
echo ""
echo "Svelte project setup:"
echo "  npm create svelte@latest my-app"
echo "  cd my-app"
echo "  npm install"
echo "  npm run dev"
echo ""
echo "For Aerometrix (pnpm):"
echo "  cd ~/.dotfiles"
echo "  pnpm install"
echo "  pnpm dev"
echo ""
