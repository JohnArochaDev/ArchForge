#!/bin/bash

# Script to remove unwanted pre-installed software from Omarchy

echo "Removing unwanted software..."
echo ""

# List of packages to remove
PACKAGES_TO_REMOVE=(
    # System info display
    "neofetch"
    
    # Modern CLI tools, replacements for cat, ls, find, grep, cd. (I like old fashoned cmds)
    "bat"           # Better cat with syntax highlighting
    "eza"           # Better ls with colors/icons
    "fd"            # Better find command
    "ripgrep"       # Better grep for searching
    "fzf"           # Fuzzy finder for interactive search
    "zoxide"        # Smart cd command
    
    # Terminal emulators (not using, using ghostty)
    "alacritty"
    
    # Communication & productivity apps
    "signal-desktop"    # Messenger
    "obsidian"          # Note-taking app
    "typora"            # Markdown editor
    
    # Media editing (heavy apps)
    "kdenlive"          # Video editor (~500MB)
    
    # Password management
    "1password-beta"
    "1password-cli"
    
    # Input methods (Asian language support)
    "fcitx5"
    "fcitx5-gtk"
    "fcitx5-qt"
    
    # Misc/unknown
    "aether"            # P2P forum software
)

# Check if running as root
if [ "$EUID" -eq 0 ]; then
    echo "Don't run as root!"
    exit 1
fi

# Remove each package
for package in "${PACKAGES_TO_REMOVE[@]}"; do
    if pacman -Qi "$package" &> /dev/null; then
        echo "Removing $package..."
        sudo pacman -Rns --noconfirm "$package"
        echo "✓ Removed $package"
    else
        echo "⊘ $package not installed, skipping"
    fi
    echo ""
done

# Clean up orphaned packages
echo "Cleaning up orphaned dependencies..."
sudo pacman -Rns --noconfirm $(pacman -Qtdq) 2>/dev/null

echo ""
echo "Done! Removed unwanted software."
echo "Run 'pacman -Qe' to see what's still installed."