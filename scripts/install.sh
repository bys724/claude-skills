#!/bin/bash

# Install custom and modified skills to ~/.claude/skills/
# Usage: ./scripts/install.sh [skill-name]
# If no skill name is provided, all custom and modified skills will be installed
# Priority: modified/ > custom/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CUSTOM_DIR="$REPO_ROOT/custom"
MODIFIED_DIR="$REPO_ROOT/modified"
INSTALL_DIR="$HOME/.claude/skills"

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Function to install a single skill
install_skill() {
    local skill_name="$1"
    local skill_source=""
    local source_type=""

    # Priority: modified/ > custom/
    if [ -d "$MODIFIED_DIR/$skill_name" ]; then
        skill_source="$MODIFIED_DIR/$skill_name"
        source_type="modified"
    elif [ -d "$CUSTOM_DIR/$skill_name" ]; then
        skill_source="$CUSTOM_DIR/$skill_name"
        source_type="custom"
    else
        echo "Error: Skill '$skill_name' not found in custom/ or modified/"
        return 1
    fi

    local skill_target="$INSTALL_DIR/$skill_name"

    # Remove existing installation
    if [ -e "$skill_target" ]; then
        echo "Removing existing installation of '$skill_name'..."
        rm -rf "$skill_target"
    fi

    # Create symbolic link
    echo "Installing '$skill_name' from $source_type/ to ~/.claude/skills/..."
    ln -s "$skill_source" "$skill_target"
    echo "✓ '$skill_name' installed successfully"
}

# Main logic
if [ $# -eq 0 ]; then
    # Install all custom and modified skills
    echo "Installing all custom and modified skills..."

    # Install from custom/
    for skill_path in "$CUSTOM_DIR"/*; do
        if [ -d "$skill_path" ] && [ "$(basename "$skill_path")" != "README.md" ]; then
            skill_name=$(basename "$skill_path")
            install_skill "$skill_name"
        fi
    done

    # Install from modified/ (will override if same name exists)
    for skill_path in "$MODIFIED_DIR"/*; do
        if [ -d "$skill_path" ] && [ "$(basename "$skill_path")" != "README.md" ]; then
            skill_name=$(basename "$skill_path")
            install_skill "$skill_name"
        fi
    done
else
    # Install specified skill
    install_skill "$1"
fi

echo ""
echo "Installation complete! Skills are now available in Claude Code."
echo "Location: $INSTALL_DIR"
