#!/bin/bash

# Uninstall skills from ~/.claude/skills/
# Usage: ./scripts/uninstall.sh <skill-name> [skill-name...]
# Example: ./scripts/uninstall.sh pdf paper-summary

set -e

INSTALL_DIR="$HOME/.claude/skills"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <skill-name> [skill-name...]"
    echo ""
    echo "Installed skills:"
    ls -1 "$INSTALL_DIR" 2>/dev/null | grep -v "^\.gitkeep$" | sed 's/^/  - /' || echo "  (none)"
    echo ""
    echo "Example: $0 pdf paper-summary"
    exit 1
fi

# Function to uninstall a single skill
uninstall_skill() {
    local skill_name="$1"
    local skill_target="$INSTALL_DIR/$skill_name"

    if [ ! -e "$skill_target" ]; then
        echo "Warning: Skill '$skill_name' is not installed"
        return 0
    fi

    echo "Uninstalling '$skill_name'..."
    rm -rf "$skill_target"
    echo "✓ '$skill_name' uninstalled successfully"
}

# Uninstall each specified skill
for skill_name in "$@"; do
    uninstall_skill "$skill_name"
done

echo ""
echo "Uninstallation complete!"
