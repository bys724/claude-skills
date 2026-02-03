#!/bin/bash

# Install official Anthropic skills to ~/.claude/skills/
# Usage: ./scripts/install-official.sh <skill-name> [skill-name...]
# Example: ./scripts/install-official.sh pdf xlsx pptx

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
OFFICIAL_DIR="$REPO_ROOT/vendor/official/skills"
INSTALL_DIR="$HOME/.claude/skills"

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <skill-name> [skill-name...]"
    echo ""
    echo "Available official skills:"
    ls -1 "$OFFICIAL_DIR" 2>/dev/null | sed 's/^/  - /'
    echo ""
    echo "Example: $0 pdf xlsx pptx"
    exit 1
fi

# Function to install a single skill
install_skill() {
    local skill_name="$1"
    local skill_source="$OFFICIAL_DIR/$skill_name"
    local skill_target="$INSTALL_DIR/$skill_name"

    if [ ! -d "$skill_source" ]; then
        echo "Error: Official skill '$skill_name' not found"
        echo "Run '$0' without arguments to see available skills"
        return 1
    fi

    # Remove existing installation
    if [ -e "$skill_target" ]; then
        echo "Removing existing installation of '$skill_name'..."
        rm -rf "$skill_target"
    fi

    # Create symbolic link
    echo "Installing '$skill_name' to ~/.claude/skills/..."
    ln -s "$skill_source" "$skill_target"
    echo "✓ '$skill_name' installed successfully"
}

# Install each specified skill
for skill_name in "$@"; do
    install_skill "$skill_name"
done

echo ""
echo "Installation complete! Skills are now available in Claude Code."
echo "Location: $INSTALL_DIR"
