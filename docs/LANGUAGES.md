# Language Development Environments

Quick setup guides for each language.

## Python

### Quick Start

```bash
bash languages/python.sh
```

This installs:
- `black` — Code formatter
- `ruff` — Fast linter
- `mypy` — Type checker
- `pytest` — Testing framework
- `ipython` — Enhanced REPL
- `python-lsp-server` — Language server
- Additional LSP plugins

### Project Setup

```bash
# Create virtual environment
python3 -m venv .venv

# Activate
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install dev tools
pip install black ruff mypy pytest
```

### Neovim Integration

- **Completion:** nvim-cmp with Python LSP
- **Formatting:** conform.nvim (uses black/ruff)
- **Linting:** ruff
- **Testing:** pytest through terminal

### Recommended Tools in requirements.txt

```txt
# Web frameworks
fastapi
django
flask

# Data science
pandas
numpy
jupyter

# Testing & Quality
pytest
pytest-cov
black
ruff
mypy

# Development
ipython
rich
```

## Node.js / Svelte

### Quick Start

```bash
bash languages/svelte.sh
```

This installs:
- `pnpm` — Fast package manager (recommended for monorepos)
- `eslint` — Linter
- `prettier` — Code formatter
- `typescript` — Type safety
- `@sveltejs/kit` — Framework
- `vite` — Build tool

### Project Setup

```bash
# Create new SvelteKit project
npm create svelte@latest my-app
cd my-app

# Install dependencies
npm install

# Development server
npm run dev

# Build for production
npm run build
npm run preview
```

### Monorepo (pnpm workspaces)

```bash
# Install workspace dependencies
pnpm install

# Run scripts in all packages
pnpm -r run build

# Install in specific package
pnpm add -r typescript
```

### Neovim Integration

- **Completion:** LSP with TypeScript server
- **Formatting:** Prettier
- **Linting:** ESLint
- **Framework:** Svelte language server

## Rust

### Quick Start

```bash
bash languages/rust.sh
```

This installs:
- `rustup` — Rust version manager
- `rust-analyzer` — Language server
- `cargo-watch` — Auto-rebuild on file change
- `cargo-edit` — Edit Cargo.toml
- `clippy` — Linter
- `rustfmt` — Code formatter

### Project Setup

```bash
# Create new project
cargo new my_project
cd my_project

# Run
cargo run

# Run with watch
cargo watch -x run

# Run tests
cargo test

# Check code
cargo check

# Format
cargo fmt

# Lint
cargo clippy
```

### Build Modes

```bash
# Debug (fast to build, slow to run)
cargo build

# Release (slow to build, fast to run)
cargo build --release

# Optimize for size
cargo build --release -Z build-std=core,alloc --target x86_64-unknown-linux-gnu
```

### Neovim Integration

- **Completion:** rust-analyzer LSP
- **Formatting:** rustfmt
- **Linting:** clippy
- **Testing:** cargo test through terminal
- **Debugging:** rust-gdb available

## Go

### Quick Start

```bash
bash languages/go.sh
```

This installs:
- Latest Go version
- `golangci-lint` — Comprehensive linter
- `goimports` — Import management
- `delve` — Debugger
- `gopls` — Language server

### Project Setup

```bash
# Create new project
mkdir my_project
cd my_project
go mod init github.com/username/my_project

# Create main.go
echo 'package main
func main() {
    println("Hello, Go!")
}' > main.go

# Run
go run main.go

# Build binary
go build

# Run tests
go test ./...

# Format
go fmt ./...

# Lint
golangci-lint run

# Get dependencies
go get github.com/user/package@latest
```

### Project Structure

```
my_project/
├── go.mod
├── go.sum
├── main.go
├── cmd/
│   └── cli/
│       └── main.go
├── pkg/
│   ├── config/
│   ├── db/
│   └── api/
└── tests/
```

### Neovim Integration

- **Completion:** gopls LSP
- **Formatting:** goimports
- **Linting:** golangci-lint
- **Testing:** go test through terminal
- **Debugging:** delve available

## Multi-Language Development

### Typical Workflow

1. **Start tmux session:**
   ```bash
   tmux_project my_project
   ```

2. **In window 1:** Open Neovim
   ```bash
   nvim src/main.py
   ```

3. **In window 2:** Run commands
   ```bash
   # Python
   python -m pytest

   # JavaScript
   npm run dev

   # Rust
   cargo watch -x run

   # Go
   go run main.go
   ```

### LSP Configuration

Each language server is auto-configured in Neovim:

```bash
# Check which servers are active
nvim +LspInfo

# Manually start server for Python
:LspStart pylsp
```

### Import Aliases (per language)

**Python:**
```python
import sys
sys.path.insert(0, '/path/to/project')
from mymodule import function
```

**JavaScript/TypeScript:** (via tsconfig.json)
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
}
```

**Go:**
```go
import "github.com/user/project/internal/pkg"
```

**Rust:** (via Cargo.toml)
```toml
[dependencies]
mylib = { path = "../mylib" }
```

## Language-Specific Tips

### Python
- Always use virtual environments (`.venv`)
- Use `pip-tools` for reproducible dependencies
- Black + isort for consistent formatting
- Type hints optional but recommended

### JavaScript/Svelte
- Use `pnpm` for faster installs and monorepo support
- Configure ESLint + Prettier in `.eslintrc` and `.prettierrc`
- Svelte 5: Use Runes (`$state`, `$props`)
- Consider Tailwind for styling

### Rust
- Ownership system is the learning curve
- Cargo handles most build/test needs
- cargo-edit: `cargo add` for quick dependency additions
- Use `#[cfg(test)]` for tests in same file

### Go
- Package organization is directory-based
- `go mod` handles versioning and dependencies
- Interfaces are implicit (structural typing)
- Error handling: explicit `if err != nil` pattern

## IDE Features in Neovim

All languages benefit from:
- **Completion:** From LSP, press `<Ctrl-x><Ctrl-o>`
- **Hover docs:** Press `K` in normal mode
- **Jump to definition:** `gd`
- **Find references:** `gr`
- **Rename:** `<Space>cr`
- **Format:** `<Space>cf`
- **Code actions:** `<Space>ca`

## Debugging

### Python
```bash
# In terminal
python -m pdb script.py

# Or use breakpoint()
breakpoint()
```

### JavaScript
```bash
# Debug mode
node --inspect app.js

# Or in DevTools/IDE
npm run debug
```

### Rust
```bash
# Using rust-gdb
rust-gdb target/debug/my_project
(gdb) run
(gdb) break main
```

### Go
```bash
# Using Delve
dlv debug ./cmd/cli
(dlv) break main
(dlv) continue
```
