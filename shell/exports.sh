#!/bin/bash
# Environment variables

# Dotfiles directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Editor
export EDITOR=nvim
export VISUAL=nvim

# Language defaults
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Python
export PYTHONUNBUFFERED=1           # No buffering for python output
export PYTHONDONTWRITEBYTECODE=1    # Don't create .pyc files

# Node
export NODE_ENV=development

# Go
export GOPATH="$HOME/go"
export GOPROXY=direct
export GOSUMDB=off

# Rust
export RUSTFLAGS="-C target-cpu=native"

# Cargo
export CARGO_INCREMENTAL=1          # Faster rebuilds

# FZF (if using)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# Tmux
export TERM=screen-256color
