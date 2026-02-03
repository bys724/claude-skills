#!/bin/bash

# List all available skills
# Usage: ./scripts/list.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CUSTOM_DIR="$REPO_ROOT/custom"
MODIFIED_DIR="$REPO_ROOT/modified"
OFFICIAL_DIR="$REPO_ROOT/vendor/official/skills"
INSTALL_DIR="$HOME/.claude/skills"

echo "=== Custom Skills (순수 커스텀) ==="
if [ -d "$CUSTOM_DIR" ]; then
    found_any=false
    for skill_path in "$CUSTOM_DIR"/*; do
        if [ -d "$skill_path" ] && [ "$(basename "$skill_path")" != "README.md" ]; then
            found_any=true
            skill_name=$(basename "$skill_path")
            # Check if installed
            if [ -e "$INSTALL_DIR/$skill_name" ]; then
                echo "  ✓ $skill_name (installed)"
            else
                echo "    $skill_name"
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
echo "=== Modified Skills (공식 스킬 수정본) ==="
if [ -d "$MODIFIED_DIR" ]; then
    found_any=false
    for skill_path in "$MODIFIED_DIR"/*; do
        if [ -d "$skill_path" ] && [ "$(basename "$skill_path")" != "README.md" ]; then
            found_any=true
            skill_name=$(basename "$skill_path")
            # Check if installed
            if [ -e "$INSTALL_DIR/$skill_name" ]; then
                echo "  ✓ $skill_name (installed)"
            else
                echo "    $skill_name"
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
echo "=== Official Skills (공식 원본) ==="
if [ -d "$OFFICIAL_DIR" ]; then
    for skill_path in "$OFFICIAL_DIR"/*; do
        if [ -d "$skill_path" ]; then
            skill_name=$(basename "$skill_path")
            # Check if installed
            if [ -e "$INSTALL_DIR/$skill_name" ]; then
                echo "  ✓ $skill_name (installed)"
            else
                echo "    $skill_name"
            fi
        fi
    done
else
    echo "  (submodule not initialized)"
    echo "  Run: git submodule update --init --recursive"
fi

echo ""
echo "=== Installed Skills (~/.claude/skills/) ==="
if [ -d "$INSTALL_DIR" ]; then
    ls -1 "$INSTALL_DIR" 2>/dev/null | grep -v "^\.gitkeep$" | sed 's/^/  ✓ /' || echo "  (none)"
else
    echo "  (none)"
fi

echo ""
echo "To install custom skills: ./scripts/install.sh"
echo "To install official skills: ./scripts/install-official.sh <skill-name>"
