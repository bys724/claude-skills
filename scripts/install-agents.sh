#!/bin/bash

# Install custom and modified agents to ~/.claude/agents/
# Usage: ./scripts/install-agents.sh [agent-name]
# If no agent name is provided, all custom and modified agents will be installed
# Priority: modified/ > custom/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CUSTOM_DIR="$REPO_ROOT/agents/custom"
MODIFIED_DIR="$REPO_ROOT/agents/modified"
INSTALL_DIR="$HOME/.claude/agents"

# Create install directory if it doesn't exist
mkdir -p "$INSTALL_DIR"

# Function to install a single agent
install_agent() {
    local agent_name="$1"
    local agent_source=""
    local source_type=""

    # Priority: modified/ > custom/
    if [ -d "$MODIFIED_DIR/$agent_name" ]; then
        agent_source="$MODIFIED_DIR/$agent_name"
        source_type="modified"
    elif [ -d "$CUSTOM_DIR/$agent_name" ]; then
        agent_source="$CUSTOM_DIR/$agent_name"
        source_type="custom"
    else
        echo "Error: Agent '$agent_name' not found in agents/custom/ or agents/modified/"
        return 1
    fi

    local agent_target="$INSTALL_DIR/$agent_name"

    # Remove existing installation
    if [ -e "$agent_target" ]; then
        echo "Removing existing installation of '$agent_name'..."
        rm -rf "$agent_target"
    fi

    # Create symbolic link
    echo "Installing agent '$agent_name' from agents/$source_type/ to ~/.claude/agents/..."
    ln -s "$agent_source" "$agent_target"
    echo "✓ Agent '$agent_name' installed successfully"
}

# Main logic
if [ $# -eq 0 ]; then
    # Install all custom and modified agents
    echo "Installing all custom and modified agents..."

    installed_count=0

    # Install from custom/
    if [ -d "$CUSTOM_DIR" ]; then
        for agent_path in "$CUSTOM_DIR"/*; do
            if [ -d "$agent_path" ] && [ "$(basename "$agent_path")" != "README.md" ]; then
                agent_name=$(basename "$agent_path")
                install_agent "$agent_name"
                installed_count=$((installed_count + 1))
            fi
        done
    fi

    # Install from modified/ (will override if same name exists)
    if [ -d "$MODIFIED_DIR" ]; then
        for agent_path in "$MODIFIED_DIR"/*; do
            if [ -d "$agent_path" ] && [ "$(basename "$agent_path")" != "README.md" ]; then
                agent_name=$(basename "$agent_path")
                install_agent "$agent_name"
                installed_count=$((installed_count + 1))
            fi
        done
    fi

    if [ $installed_count -eq 0 ]; then
        echo "No agents found to install."
        echo "Create agents in agents/custom/ to get started."
        echo "See agents/custom/README.md for guide."
    fi
else
    # Install specified agent
    install_agent "$1"
fi

echo ""
echo "Installation complete! Agents are now available in Claude Code."
echo "Location: $INSTALL_DIR"
echo ""
echo "Agents will be automatically available for Task tool delegation."
