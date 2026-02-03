#!/bin/bash

# Uninstall agents from ~/.claude/agents/
# Usage: ./scripts/uninstall-agents.sh <agent-name> [agent-name...]
# Example: ./scripts/uninstall-agents.sh code-reviewer log-analyzer

set -e

INSTALL_DIR="$HOME/.claude/agents"

if [ $# -eq 0 ]; then
    echo "Usage: $0 <agent-name> [agent-name...]"
    echo ""
    echo "Installed agents:"
    if [ -d "$INSTALL_DIR" ]; then
        agent_count=$(ls -1 "$INSTALL_DIR" 2>/dev/null | grep -v "^\.gitkeep$" | wc -l | tr -d ' ')
        if [ "$agent_count" -gt 0 ]; then
            ls -1 "$INSTALL_DIR" 2>/dev/null | grep -v "^\.gitkeep$" | sed 's/^/  - /'
        else
            echo "  (none)"
        fi
    else
        echo "  (none)"
    fi
    echo ""
    echo "Example: $0 code-reviewer log-analyzer"
    exit 1
fi

# Function to uninstall a single agent
uninstall_agent() {
    local agent_name="$1"
    local agent_target="$INSTALL_DIR/$agent_name"

    if [ ! -e "$agent_target" ]; then
        echo "Warning: Agent '$agent_name' is not installed"
        return 0
    fi

    echo "Uninstalling agent '$agent_name'..."
    rm -rf "$agent_target"
    echo "✓ Agent '$agent_name' uninstalled successfully"
}

# Uninstall each specified agent
for agent_name in "$@"; do
    uninstall_agent "$agent_name"
done

echo ""
echo "Uninstallation complete!"
