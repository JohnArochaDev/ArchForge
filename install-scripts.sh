#!/bin/bash

# Parent script to run all custom scripts

echo "============================"
echo "Arch-Forge  - Starting      "
echo "============================"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_FOLDER="$SCRIPT_DIR/scripts"

# Check if scripts folder exists
if [ ! -d "$SCRIPTS_FOLDER" ]; then
    echo "Error: scripts folder not found at $SCRIPTS_FOLDER"
    exit 1
fi

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Don't run as root!"
    exit 1
fi

# Run each script
echo "Step 1: Updating keybindings..."
bash "$SCRIPTS_FOLDER/update-keybinds.sh"
# Check if the script failed ($? = exit code of last command, 0 = success, non-zero = failure)
if [ $? -ne 0 ]; then
    echo "✗ Keybinds script failed!"
    exit 1
fi
echo ""

echo "Step 2: Removing bloatware..."
bash "$SCRIPTS_FOLDER/remove-bloat.sh"
if [ $? -ne 0 ]; then
    echo "✗ Bloat removal script failed!"
    exit 1
fi

echo "Step 3: Removing desktop app bloatware..."
bash "$SCRIPTS_FOLDER/delete-desktop-apps.sh"
if [ $? -ne 0 ]; then
    echo "✗ Bloat removal script failed!"
    exit 1
fi

echo "Step 4: Adding fastfetch..."
bash "$SCRIPTS_FOLDER/add-fastfetch.sh"
if [ $? -ne 0 ]; then
    echo "✗ Fastfetch addition script failed!"
    exit 1
fi

echo "Step 5: Configuring terminal..."
bash "$SCRIPTS_FOLDER/edit-fastfetch.sh"
if [ $? -ne 0 ]; then
    echo "✗ Fastfetch configuration script failed!"
    exit 1
fi

echo "Step 6: Installing Darkened State theme..."
bash "$SCRIPTS_FOLDER/theme-darkened-state.sh"
if [ $? -ne 0 ]; then
    echo "✗ Failed to install theme!"
    exit 1
fi

echo "Step 6: Installing Pixelated theme..."
bash "$SCRIPTS_FOLDER/theme-pixelated.sh"
if [ $? -ne 0 ]; then
    echo "✗ Failed to install theme!"
    exit 1
fi


echo ""
echo "============================"
echo "Arch-Forge  - Complete      "
echo "============================"
echo ""
echo "Reload Hyprland with SUPER+SHIFT+R"