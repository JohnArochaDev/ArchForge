#!/bin/bash
# Script to add app configurations to tile manager

# Get the directory where THIS script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source files (relative to script location)
GODOT_SRC="$SCRIPT_DIR/../files/godot.conf"
ASEPRITE_SRC="$SCRIPT_DIR/../files/aseprite.conf"
STEAM_SRC="$SCRIPT_DIR/../files/steam.conf"

# Destination directory
DEST_DIR="$HOME/.local/share/omarchy/default/hypr/apps"

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Copy files, overriding if they exist (-f flag forces overwrite)
cp -f "$GODOT_SRC" "$DEST_DIR/godot.conf"
cp -f "$ASEPRITE_SRC" "$DEST_DIR/aseprite.conf"
cp -f "$STEAM_SRC" "$DEST_DIR/steam.conf"

echo "Configuration files copied to $DEST_DIR"
