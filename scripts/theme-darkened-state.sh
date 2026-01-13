#!/bin/bash

# Script to install custom theme

echo "Installing theme..."
echo ""

# Get the directory where THIS script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Go up one level, then into themes folder
THEME_SOURCE="$SCRIPT_DIR/../themes/darkenedstate"
THEME_DEST="$HOME/.config/omarchy/themes/darkenedstate"

# Check if source theme exists
if [ ! -d "$THEME_SOURCE" ]; then
    echo "✗ Error: Theme not found at $THEME_SOURCE"
    exit 1
fi

# Check if theme already exists at destination
if [ -d "$THEME_DEST" ]; then
    echo "⊘ Theme already exists at $THEME_DEST, skipping"
    exit 0
fi

# Copy theme to destination
cp -r "$THEME_SOURCE" "$THEME_DEST"

if [ $? -eq 0 ]; then
    echo "✓ Theme installed to $THEME_DEST"
else
    echo "✗ Failed to copy theme"
    exit 1
fi

echo ""
echo "Done! Select your theme with Super + Ctrl + Shift + Space"