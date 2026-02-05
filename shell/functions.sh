#!/bin/bash
# Utility functions

# ============================================================================
# Development
# ============================================================================

# Create and activate Python virtual environment
venv_create() {
    local venv_name="${1:-.venv}"
    python3 -m venv "$venv_name"
    echo "Virtual environment created: $venv_name"
}

venv_activate() {
    local venv_name="${1:-.venv}"
    source "$venv_name/bin/activate"
}

# Quick python project setup
py_setup() {
    venv_create
    venv_activate
    pip install --upgrade pip
    [ -f requirements.txt ] && pip install -r requirements.txt
    echo "Python project ready!"
}

# ============================================================================
# Tmux
# ============================================================================

# Create new tmux session with sensible defaults
tmux_new() {
    local session_name="${1:-main}"
    tmux new-session -d -s "$session_name" -x 200 -y 50
    tmux send-keys -t "$session_name" "cd $(pwd)" Enter
    tmux attach-session -t "$session_name"
}

# Create project-specific tmux session (nvim + shell)
tmux_project() {
    local project_name="${1:-.}"
    [ "$project_name" = "." ] && project_name=$(basename "$PWD")

    tmux new-session -d -s "$project_name" -c "$PWD"
    tmux send-keys -t "$project_name" "nvim" Enter
    tmux new-window -t "$project_name" -n shell -c "$PWD"
    tmux select-window -t "$project_name:0"
    tmux attach-session -t "$project_name"
}

# ============================================================================
# Navigation
# ============================================================================

# Directory bookmark
bmk() {
    local name="${1:-.}"
    echo "$PWD" > ~/.bookmarks/"$name"
}

# Jump to bookmark
jump() {
    local name="${1:-.}"
    [ -f ~/.bookmarks/"$name" ] && cd "$(cat ~/.bookmarks/"$name")"
}

# Show bookmarks
bookmarks() {
    [ -d ~/.bookmarks ] || return
    echo "Directory bookmarks:"
    for f in ~/.bookmarks/*; do
        echo "  $(basename "$f") -> $(cat "$f")"
    done
}

# ============================================================================
# Build & Development
# ============================================================================

# Build ZMK firmware
zmk_build() {
    [ -f "$DOTFILES_DIR/scripts/build-zmk.sh" ] && bash "$DOTFILES_DIR/scripts/build-zmk.sh"
}

# Quick health check
health() {
    bash "$DOTFILES_DIR/scripts/check-health.sh"
}

# Update all dotfiles
update_dotfiles() {
    echo "Updating dotfiles..."
    cd "$DOTFILES_DIR"
    bash scripts/update-all.sh
    cd -
}

# ============================================================================
# System
# ============================================================================

# Show disk usage
disk() {
    du -sh ./* 2>/dev/null | sort -h
}

# Kill process by name
killp() {
    local proc="${1}"
    pkill -f "$proc" && echo "Killed $proc" || echo "No process found: $proc"
}

# Extract archive
extract() {
    case "$1" in
        *.tar.bz2)   tar xjf "$1"   ;;
        *.tar.gz)    tar xzf "$1"   ;;
        *.bz2)       bunzip2 "$1"   ;;
        *.rar)       unrar x "$1"   ;;
        *.gz)        gunzip "$1"    ;;
        *.tar)       tar xf "$1"    ;;
        *.tbz2)      tar xjf "$1"   ;;
        *.tgz)       tar xzf "$1"   ;;
        *.zip)       unzip "$1"     ;;
        *.Z)         uncompress "$1";;
        *.7z)        7z x "$1"      ;;
        *)           echo "Unknown archive type: $1" ;;
    esac
}

# ============================================================================
# Git
# ============================================================================

# Fuzzy git checkout branch
gco_fzf() {
    git branch | fzf | xargs git checkout
}

# Git add + commit + push
git_quick() {
    local msg="${1:-Update}"
    git add .
    git commit -m "$msg"
    git push
}

# ============================================================================
# Local functions (machine-specific)
# ============================================================================

[ -f ~/.functions.local ] && source ~/.functions.local
