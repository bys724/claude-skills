#!/bin/bash

# Update official Anthropic skills submodule to latest version
# Usage: ./scripts/update-official.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$REPO_ROOT"

echo "Updating official skills submodule..."
git submodule update --remote vendor/official

echo ""
echo "✓ Official skills updated to latest version"
echo ""
echo "To commit this update, run:"
echo "  git add vendor/official"
echo "  git commit -m 'Update official skills to latest version'"
