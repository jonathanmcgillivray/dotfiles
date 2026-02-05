#!/bin/bash
set -e

echo "=== Go Development Setup ==="

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo "Go not found. Installing..."

    # Get latest Go version
    latest_go=$(curl -s https://go.dev/VERSION?m=text)
    go_version="${latest_go#go}"

    echo "Downloading Go $go_version..."
    cd /tmp
    wget "https://go.dev/dl/go${go_version}.linux-amd64.tar.gz"
    sudo tar -C /usr/local -xzf "go${go_version}.linux-amd64.tar.gz"
    rm "go${go_version}.linux-amd64.tar.gz"
    cd -
fi

echo "✓ Go version: $(go version)"

# Create Go workspace if needed
mkdir -p ~/go/{bin,pkg,src}

# Install useful tools
echo "Installing Go development tools..."

go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/gopls@latest

echo "✓ Go tools installed in ~/go/bin"
echo ""
echo "New Go project:"
echo "  mkdir my_project"
echo "  cd my_project"
echo "  go mod init github.com/username/my_project"
echo "  go run main.go"
echo ""
echo "Useful commands:"
echo "  go build                 # Build binary"
echo "  go test ./...            # Run tests"
echo "  go fmt ./...             # Format code"
echo "  golangci-lint run        # Lint"
echo ""
