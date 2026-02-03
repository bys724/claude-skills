#!/bin/bash

# List all available agents
# Usage: ./scripts/list-agents.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CUSTOM_DIR="$REPO_ROOT/agents/custom"
MODIFIED_DIR="$REPO_ROOT/agents/modified"
INSTALL_DIR="$HOME/.claude/agents"

echo "=== Custom Agents (순수 커스텀) ==="
if [ -d "$CUSTOM_DIR" ]; then
    found_any=false
    for agent_path in "$CUSTOM_DIR"/*; do
        if [ -d "$agent_path" ] && [ "$(basename "$agent_path")" != "README.md" ]; then
            found_any=true
            agent_name=$(basename "$agent_path")
            # Check if installed
            if [ -e "$INSTALL_DIR/$agent_name" ]; then
                echo "  ✓ $agent_name (installed)"
            else
                echo "    $agent_name"
            fi
        fi
    done
    if [ "$found_any" = false ]; then
        echo "  (none)"
    fi
else
    echo "  (none)"
fi

echo ""
echo "=== Modified Agents (수정된 에이전트) ==="
if [ -d "$MODIFIED_DIR" ]; then
    found_any=false
    for agent_path in "$MODIFIED_DIR"/*; do
        if [ -d "$agent_path" ] && [ "$(basename "$agent_path")" != "README.md" ]; then
            found_any=true
            agent_name=$(basename "$agent_path")
            # Check if installed
            if [ -e "$INSTALL_DIR/$agent_name" ]; then
                echo "  ✓ $agent_name (installed)"
            else
                echo "    $agent_name"
            fi
        fi
    done
    if [ "$found_any" = false ]; then
        echo "  (none)"
    fi
else
    echo "  (none)"
fi

echo ""
echo "=== Installed Agents (~/.claude/agents/) ==="
if [ -d "$INSTALL_DIR" ]; then
    agent_count=$(ls -1 "$INSTALL_DIR" 2>/dev/null | grep -v "^\.gitkeep$" | wc -l | tr -d ' ')
    if [ "$agent_count" -gt 0 ]; then
        ls -1 "$INSTALL_DIR" 2>/dev/null | grep -v "^\.gitkeep$" | sed 's/^/  ✓ /'
    else
        echo "  (none)"
    fi
else
    echo "  (none)"
fi

echo ""
echo "To install agents: ./scripts/install-agents.sh"
echo "To create a new agent: see agents/custom/README.md"
