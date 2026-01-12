#!/bin/bash

# This modifies the Hyprland bindings configurstion


# Set variables
CONFIG_FILE="$HOME/.config/hypr/bindings.conf"
OLD_TERMINAL_CMD="SUPER, RETURN"
NEW_TERMINAL_CMD="SUPER, T"

TILING_CONFIG_FILE="$HOME/.local/share/omarchy/default/hypr/bindings/tiling-v2.conf"

NEW_CLOSE_WINDOW_CMD="bindd = SUPER, W, Close window, killactive"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
  echo "Error: COnfig file not found at $CONFIG_FILE"
  exit 1
fi

# Replace the binding with sed

# changes terminal keybind to SUPER + T
sed -i "s/bindd = SUPER, RETURN, Terminal/bindd = SUPER, T, Terminal/" "$CONFIG_FILE"

# changes SUPER + T keybind to empty in omarchy tiling-v2.conf
sed -i '8d' "$TILING_CONFIG_FILE"

# SUPER + W keybind to empty in omarchy tiling-v2.conf
sed -i '2d' "$TILING_CONFIG_FILE"
# Add new SUPER + W cmd to bindings.conf
#

# Check if change was made: terminal NEW_TERMINAL_CMD
if grep -q "s/bindd = SUPER, T, Terminal" "$CONFIG_FILE"; then
  echo "Successfully changed terminal hotkey to SUPER + T"
else
  echo "Warning: Could not find the binding to change"
fi

if grep -q "bindd = SUPER, T, Toggle window floating/tiling, toggleFloating," "$CONFIG_FILE"; then
  echo "Warning: Couldnt find keybinding"
else
  echo "Successfully removed previous T keybinding"
fi

if grep -q "$NEW_CLOSE_WINDOW_CMD" "$CONFIG_FILE"; then
  echo "Binding already exists!"
else
  echo "$NEW_CLOSE_WINDOW_CMD" >> "$CONFIG_FILE"
  echo "Successfully changed window close hotkey to SUPER + Q"
fi

echo ""
echo "Done! Press SUPER + SHIFT + R to reload Hyprland Config"
