#!/bin/bash
# Aliases

# ============================================================================
# Navigation
# ============================================================================

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias dotfiles='cd ~/.dotfiles'

# ============================================================================
# List
# ============================================================================

alias ls='ls --color=auto'
alias l='ls -lhA'
alias ll='ls -lh'
alias la='ls -lhA'

# ============================================================================
# Git
# ============================================================================

alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -10'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'
alias gr='git rebase'

# ============================================================================
# Editors
# ============================================================================

alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# ============================================================================
# Development
# ============================================================================

# Python
alias py='python3'
alias venv='python3 -m venv'
alias pip='pip3'

# Node
alias n='npm'
alias ni='npm install'
alias nr='npm run'

# Rust
alias c='cargo'
alias cb='cargo build'
alias cr='cargo run'
alias ct='cargo test'
alias cc='cargo check'
alias cf='cargo fmt'

# Go
alias go='go'
alias gb='go build'
alias gr='go run'
alias gt='go test'

# ============================================================================
# Tmux
# ============================================================================

alias tm='tmux'
alias tma='tmux attach'
alias tms='tmux new-session -s'
alias tmls='tmux list-sessions'

# ============================================================================
# System
# ============================================================================

alias clear='clear && printf "\e[3J"'  # Clear including scrollback
alias reload='exec $SHELL'
alias sudo='sudo '                     # Allow aliases with sudo
alias tree='tree -L 2'

# ============================================================================
# Quick access to dotfiles
# ============================================================================

alias edit-nvim='nvim ~/.config/nvim'
alias edit-tmux='nvim ~/.dotfiles/tmux/tmux.conf'
alias edit-zsh='nvim ~/.dotfiles/shell/zshrc'
alias edit-aliases='nvim ~/.dotfiles/shell/aliases.sh'

# ============================================================================
# Local aliases (machine-specific)
# ============================================================================

[ -f ~/.aliases.local ] && source ~/.aliases.local
